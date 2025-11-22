#include "greywolfoptimizer.h"
#include "opt_params.h"
#include "analysis_params.h"

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
        QVariantMap result = analyze(m_nlsParams->m(), m_nlsParams->lambda(), m_nlsParams->mu(),
                                     m_nlsParams->r(), m_nlsParams->c(), m_nlsParams->calcProb(),
                                     m_nlsParams->pLB(), m_nlsParams->pUB());
        emit analysisFinished(result);
    });
}

// Do implementacji (a = lambda / mu)
double GreyWolfOptimizer::lossProbability(quint32 m, double a) {
    return 0.0;
}

// Do implementacji
double GreyWolfOptimizer::objectiveFunction(quint32 m, double lambda, double my, double r, double c) {
    return 0.0;
}

// Do dokończenia
QVariantMap GreyWolfOptimizer::analyze(quint32 m, double lambda, double mu, double r, double c, bool calc_probability, quint32 p_lb, quint32 p_ub) {

    // Podstawienie danych do funkcji celu

    // Póki co liczenie prawdopodobieństwa można pominąć
    if(calc_probability) {
        // Obliczenie prawdopodobieństwa dla zadanego prezdziału
    }

    /*
        Zwrócenie obliczonych danych:

        Wynik funkcji celu z podstawionymi wyliczonymi danymi ("f_obj")
        P0 ("p0")
        Prawdopodobieństwo odmowy obliczone z funkcji ("pm")
        Względna zdolnośc obsługi ("a")
        Względna zdolność obsługi ("q")
        Średnia liczba zgłoszeń w systemie ("n_mean")
        Średnia liczba kanałów obsługujących ("m_disp")
        Średnia liczba kanałów niezajętych ("m_empty")
    */

    QVariantMap result;
    result["p_lb"] = p_lb;
    result["p_lb"] = p_ub;

    return result;
}

// Do dokończenia
QVariantMap GreyWolfOptimizer::gwo(quint32 max_iter, quint32 num_wolves, quint32 max_m,
    double lambda, double mu, double r, double c) {

    // Optymalizacja w jednym wymiarze
    QVector<Wolf> wolves(num_wolves);
    for(auto &w : wolves) {
        w.m = (double)QRandomGenerator::global()->bounded(1U, max_m);
    }

    quint32 m_opt{0};

    // Główna pętla algorytmu
    for(quint32 i{0}; i < max_iter; i++) {

        // Aktualizacja progressbara
        emit optimizationProgressChanged(double(i+1) / max_iter);
    }

    /*
        Zwrócenie obliczonych danych:

        Wyliczone z gwo: optymalne m ("m_opt")
        Wynik funkcji celu z podstawionymi wyliczonymi danymi ("f_obj")
        P0 ("p0")


        Te dane przechodzą z metody analyze():

        Prawdopodobieństwo odmowy obliczone z funkcji ("pm")
        Względna zdolnośc obsługi ("a")
        Względna zdolność obsługi ("q")
        Średnia liczba zgłoszeń w systemie ("n_mean")
        Średnia liczba kanałów obsługujących ("m_disp")
        Średnia liczba kanałów niezajętych ("m_empty")
    */

    QVariantMap result{analyze(m_opt, lambda, mu, r, c, false)};
    result["f_obj"] = lambda; // Przykład, tu powinien być wynik z funkcji celu

    return result;
}
