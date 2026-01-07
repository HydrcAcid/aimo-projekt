#ifndef GREYWOLFOPTIMIZER_H
#define GREYWOLFOPTIMIZER_H

#include <QObject>


class OptimizationParams;
class AnalysisParams;

struct Wolf {
    double m, score;
};

class GreyWolfOptimizer : public QObject
{
    Q_OBJECT
public:
    explicit GreyWolfOptimizer(OptimizationParams* optParams, AnalysisParams* nlsParams, QObject *parent = nullptr);

    Q_INVOKABLE void startOptimization();
    Q_INVOKABLE void startAnalysis();

signals:
    void optimizationFinished(const QVariantMap& result);
    void analysisFinished(const QVariantMap& result);

private:
    QVariantMap gwo(quint32 max_iter, quint32 num_wolves, quint32 max_m,
        double lambda, double mu, double r, double c, bool calc_probability, quint32 p_lb = 0, quint32 p_ub = 0);
    QVariantMap analyze(quint32 m, double lambda, double mu,
        bool calc_probability, quint32 p_lb = 0, quint32 p_ub = 0);

    OptimizationParams* m_optParams{nullptr};
    AnalysisParams* m_nlsParams{nullptr};
};

#endif // GREYWOLFOPTIMIZER_H
