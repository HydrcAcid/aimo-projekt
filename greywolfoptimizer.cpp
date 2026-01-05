#include "greywolfoptimizer.h"
#include "opt_params.h"
#include "analysis_params.h"
#include "intermediate.h"

#include <QVariant>
#include <QtConcurrent/QtConcurrent>
#include <QtLogging>


GreyWolfOptimizer::GreyWolfOptimizer(OptimizationParams* optParams, AnalysisParams* nlsParams, QObject *parent)
    : QObject{parent}, m_optParams(optParams), m_nlsParams(nlsParams)
{}

void GreyWolfOptimizer::startOptimization() {
    (void)QtConcurrent::run([=]() {
        QVariantMap result = gwo(m_optParams->iterMax(), m_optParams->wolfCount(), m_optParams->mMax(),
                                 m_optParams->lambda(), m_optParams->mu(), m_optParams->r(), m_optParams->c());
        emit optimizationFinished(result);
    });
}

void GreyWolfOptimizer::startAnalysis() {
    (void)QtConcurrent::run([=]() {
        QVariantMap result = analyze(m_nlsParams->m(), m_nlsParams->lambda(), m_nlsParams->mu(), m_nlsParams->calcProb(),
                                     m_nlsParams->pLB(), m_nlsParams->pUB());
        emit analysisFinished(result);
    });
}

// Do dokonczenia
QVariantMap GreyWolfOptimizer::analyze(quint32 m, double lambda, double mu, bool calc_probability, quint32 p_lb, quint32 p_ub) {
    QVariantMap result;
    double rho{lambda / mu};
    double p0{calculateP0(m, rho)};     // Prawdopodobienstwo stanu pustego
    double pm{calculatePj(m, rho, p0)}; // Prawdopodobienstwo odmowy

    // Obliczanie rozkladu prawdopodobienstw
    QVector<double> probs(p_ub - p_lb + 1);

    if(calc_probability) {
        for(quint32 j{0}; j < p_ub - p_lb + 1; j++) {
            probs[j] = calculatePj(j + p_lb, rho, p0);

            QString property_name = tr("p%1").arg(j + p_lb);
            result[property_name] = probs[j];
        }
    }

    // Obliczenie
    double q_eff = 1.0 - pm; // Wzgledna zdolnosc obslugi
    double lambda_eff = lambda * q_eff; // Bezwzgledna zdolnosc obslugi

    double n_mean = rho * q_eff;    // Srednia liczba zgłoszen w systemie
    double m0_mean = n_mean;        // Srednie obciazenie systemu
    double mnz_mean = m - n_mean;        // Srednia liczba niezajetych kanalow
    double ts = 1 / mu;             // Sredni czas przebywania w systemie

    // ZAPIS
    result["p0"] = p0;          // Prawdopodobieństwo stanu pustego
    result["pm"] = pm;          // Prawdopodobieństwo odmowy
    result["q"] = q_eff;        // Wzgledna przpustowosc stystemu
    result["A"] = lambda_eff;   // Bezwzgledna przpustowosc stystemu
    result["n_mean"] = n_mean;  // Srednia liczba zgloszen w systemie
    result["m0_mean"] = m0_mean;// Srednia liczba kanalow obslogojacych
    result["mnz_mean"] = mnz_mean;  // Srednia liczba kanalow niezajetych
    result["ts_mean"] = ts;     // Sredni czas przebywania w systemie

    return result;
}

// Do dokonczenia
QVariantMap GreyWolfOptimizer::gwo(quint32 max_iter, quint32 num_wolves, quint32 max_m,
    double lambda, double mu, double r, double c) {

    auto *rng = QRandomGenerator::global();

    // Optymalizacja w jednym wymiarze
    QVector<Wolf> wolves(num_wolves);
    for(auto &w : wolves) {
        w.m = (double)QRandomGenerator::global()->bounded(1U, max_m);
    }

    Wolf alpha{0,1e18}, beta{0,1e18}, delta{0,1e18};
    quint32 m_opt{0};
    double rho{lambda / mu};

    // Główna pętla algorytmu
    for(quint32 i{0}; i < max_iter; i++) {
        alpha.score = beta.score = delta.score = 1e18;

        for (auto &w : wolves) {
            w.m = std::clamp(w.m, 1.0, double(max_m));
            w.score = -objectiveFunction(w.m, rho, c, r);

            if (w.score < alpha.score) { delta = beta; beta = alpha; alpha = w; }
            else if (w.score < beta.score) { delta = beta; beta = w; }
            else if (w.score < delta.score) { delta = w; }
        }

        double a = 2.0 - 2.0 * double(i) / double(max_iter);

        // update
        for (auto &w : wolves) {
            auto update = [&](const Wolf &L){
                double r1 = rng->generateDouble();
                double r2 = rng->generateDouble();
                double A = 2 * a * r1 - a;
                double C = 2 * r2;
                double D = std::abs(C * L.m - w.m);
                return L.m - A * D;
            };

            w.m = (update(alpha) + update(beta) + update(delta)) / 3.0;
        }

        // Aktualizacja progressbara
        emit optimizationProgressChanged(double(i+1) / max_iter);
    }

    m_opt = static_cast<quint32>(std::round(alpha.m));
    QVariantMap result{analyze(m_opt, lambda, mu, false)};

    auto val_iter{result.find("n_mean")};
    double n_mean{val_iter->toDouble()};

    result["m_opt"] = m_opt;
    result["f_obj"] = systemAnalysis(m_opt, r, c, n_mean);

    return result;
}
