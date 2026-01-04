#ifndef DEFINICJE_H
#define DEFINICJE_H

#include <cmath>
#include <vector>
#include <QVariantMap>

// silnia
inline double factorial(int n) {
    if (n <= 1) return 1.0;
    return n * factorial(n - 1);
}

// funkcja obliczaj¹ca P0 (prawdopodobieñstwo, ¿e system jest pusty)
inline double calculateP0(int m, int N, double rho) {
    double sum = 0.0;

	// pierwsza suma (dla k < m)
    for (int k = 0; k < m; ++k) {
        sum += std::pow(rho, k) / factorial(k);
    }

	// druga suma (dla k >= m)
    double term2 = 0.0;
    for (int k = m; k <= N; ++k) {
        term2 += std::pow(rho, k) / (factorial(m) * std::pow(m, k - m));
    }

    return 1.0 / (sum + term2);
}

// FUNKCJA PRAWDOPODOBIEÑSTWA ODMOWY
inline double calculateLossProbability(double lambda, double mu, int m, int N) {
    double rho = lambda / mu;
    double p0 = calculateP0(m, N, rho);
    double pN = p0 * std::pow(rho, N) / (factorial(m) * std::pow(m, N - m));

    return pN;
}


// FUNKCJA CELU
inline double objectiveFunction(const std::vector<double>& position) {
    // Zak³o¿enie: position[0] = m (serwery), position[1] = N (pojemnoœæ ca³kowita)

    int m = std::round(position[0]);
    int N = std::round(position[1]);

    // zabezpieczenia, jeœli bêd¹ potrzebne (nie mo¿e byæ 0 serwerów, a N musi byæ >= m)
    if (m < 1) m = 1;
    if (N < m) N = m;

	// sta³e parametry systemu - do zmiany zapewne
    double lambda = 10.0; // intensywnoœæ przybyæ
    double mu = 4.0;      // intensywnoœæ obs³ugi

    // wagi kosztów
    double costPerServer = 100.0;      // koszt jednego stanowiska
    double costPerLostCustomer = 500.0;// koszt utraty klienta (kara)

    // prawdopodobieñstwo odmowy
    double pLoss = calculateLossProbability(lambda, mu, m, N);

    // liczba utraconych klientów na jednostkê czasu
    double lostCustomers = lambda * pLoss;

    // ca³kowity koszt
    double totalCost = (m * costPerServer) + (lostCustomers * costPerLostCustomer);

    return totalCost;
}

// ANALYZE
// zwraca mapê dla Qt
inline QVariantMap analyze(double lambda, double mu, int m, int N, int p_lb, int p_ub) {
    QVariantMap result;
    double rho = lambda / mu;
    double p0 = calculateP0(m, N, rho);

    // Obliczanie rozk³adu prawdopodobieñstw dla wszystkich stanów
    std::vector<double> probabilities(N + 1);
    probabilities[0] = p0;

    double avg_n = 0.0; // Œrednia liczba zg³oszeñ w systemie

    for (int k = 1; k <= N; ++k) {
        if (k < m) {
            probabilities[k] = probabilities[k - 1] * rho / k;
        }
        else {
            probabilities[k] = probabilities[k - 1] * rho / m;
        }

        avg_n += k * probabilities[k];
    }

    // Prawdopodobieñstwo w przedziale [p_lb; p_ub]
    double prob_in_range = 0.0;
    int start = std::max(0, p_lb);
    int end = std::min(N, p_ub);

    for (int k = start; k <= end; ++k) {
        prob_in_range += probabilities[k];
    }

    // Obliczenie
    double pLoss = probabilities[N];           // Prawdopodobieñstwo odmowy
    double lambda_eff = lambda * (1.0 - pLoss); // Efektywny strumieñ

    // Prawo Little
    double avg_ts = avg_n / lambda_eff;        // Œredni czas w systemie (W)
    double avg_q = 0.0;                        // Œrednia d³ugoœæ kolejki (Lq)

    // warunek -> kolejka tworzy siê dopiero gdy k > m
    for (int k = m + 1; k <= N; ++k) {
        avg_q += (k - m) * probabilities[k];
    }
    double avg_tf = avg_q / lambda_eff;        // Œredni czas w kolejce (Wq)

    // ZAPIS
    result["p_odmowa"] = pLoss;                // Prawdopodobieñstwo odmowy
    result["srednia_liczba_zgloszen"] = avg_n; // L (œrednio w systemie)
    result["srednia_dlugosc_kolejki"] = avg_q; // Lq (œrednio w kolejce)
    result["sredni_czas_w_systemie"] = avg_ts; // W (czas przebywania)
    result["sredni_czas_oczekiwania"] = avg_tf;// Wq (czas w kolejce)
    result["prob_in_range"] = prob_in_range;   // Prawdopodobieñstwo z przedzia³u
    result["przepustowosc"] = lambda_eff;      // Ile faktycznie obs³u¿ono
    result["obciazenie_systemu"] = rho / m;    // Wykorzystanie serwerów (0-1)

    return result;
}

#endif // DEFINICJE_H
