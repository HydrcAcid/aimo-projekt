#ifndef INTERMEDIATE_H
#define INTERMEDIATE_H

#include <cmath>
#include <qdebug.h>
#include <qlogging.h>
#include <qtypes.h>

double factorial(int n) {
    if (n <= 1) return 1.0;
    return n * factorial(n - 1);
}

double calculateP0(int m, double rho) {
    double sum{0.0};
    for(int s{0}; s < m + 1; ++s) {
        sum += std::pow(rho, s) / factorial(s);
    }

    return 1 / sum;
}

double calculatePj(int j, double rho, double p0) {
    return std::pow(rho, j) / factorial(j) * p0;
}

double objectiveFunction(quint32 m, double rho, double c, double r) {
    double pm = 1.0;
    for (int i = 1; i <= m; ++i) {
        pm = (rho * pm) / (i + rho * pm);
    }
    return (r * rho * (1.0 - pm) - c * m);
}

double systemAnalysis(quint32 m, double r, double c, double n_mean) {
    return r * n_mean - c * m;
}

#endif // INTERMEDIATE_H
