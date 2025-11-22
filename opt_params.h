#ifndef OPT_PARAMS_H
#define OPT_PARAMS_H

#include <QObject>

class OptimizationParams : public QObject
{
    Q_OBJECT

    Q_PROPERTY(quint32 iterMax READ iterMax WRITE setIterMax NOTIFY iterMaxChanged)
    Q_PROPERTY(quint32 wolfCount READ wolfCount WRITE setWolfCount NOTIFY wolfCountChanged)
    Q_PROPERTY(quint32 mMax READ mMax WRITE setMMax NOTIFY mMaxChanged)
    Q_PROPERTY(double lambda READ lambda WRITE setLambda NOTIFY lambdaChanged)
    Q_PROPERTY(double mu READ mu WRITE setMu NOTIFY muChanged)
    Q_PROPERTY(double r READ r WRITE setR NOTIFY rChanged)
    Q_PROPERTY(double c READ c WRITE setC NOTIFY cChanged)
public:
    explicit OptimizationParams(QObject *parent = nullptr) : QObject{parent} {}

    quint32 iterMax() const { return m_maxIter; }
    void setIterMax(quint32 v) { if (m_maxIter != v) { m_maxIter = v; emit iterMaxChanged(); } }

    quint32 wolfCount() const { return m_wolfCount; }
    void setWolfCount(quint32 v) { if (m_wolfCount != v) { m_wolfCount = v; emit wolfCountChanged(); } }

    quint32 mMax() const { return m_mMax; }
    void setMMax(quint32 v) { if (m_mMax != v) { m_mMax = v; emit mMaxChanged(); } }

    double lambda() const { return m_lambda; }
    void setLambda(double v) { if (m_lambda != v) { m_lambda = v; emit lambdaChanged(); } }

    double mu() const { return m_mu; }
    void setMu(double v) { if (m_mu != v) { m_mu = v; emit muChanged(); } }

    double r() const { return m_r; }
    void setR(double v) { if (m_r != v) { m_r = v; emit rChanged(); } }

    double c() const { return m_c; }
    void setC(double v) { if (m_c != v) { m_c = v; emit cChanged(); } }

signals:
    void iterMaxChanged();
    void wolfCountChanged();
    void mMaxChanged();
    void lambdaChanged();
    void muChanged();
    void rChanged();
    void cChanged();
private:
    quint32 m_maxIter{200}, m_wolfCount{20}, m_mMax{100};;
    double m_lambda{60.0}, m_mu{2.0}, m_r{10}, m_c{2.0};
};

#endif // OPT_PARAMS_H
