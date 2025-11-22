#ifndef ANALYSIS_PARAMS_H
#define ANALYSIS_PARAMS_H

#include <QObject>

class AnalysisParams : public QObject
{
    Q_OBJECT

    Q_PROPERTY(quint32 m READ m WRITE setM NOTIFY mChanged)
    Q_PROPERTY(quint32 pLB READ pLB WRITE setPLB NOTIFY pLBChanged)
    Q_PROPERTY(quint32 pUB READ pUB WRITE setPUB NOTIFY pUBChanged)
    Q_PROPERTY(bool calcProb READ calcProb WRITE setCalcProb NOTIFY calcProbChanged)
    Q_PROPERTY(double lambda READ lambda WRITE setLambda NOTIFY lambdaChanged)
    Q_PROPERTY(double mu READ mu WRITE setMu NOTIFY muChanged)
    Q_PROPERTY(double r READ r WRITE setR NOTIFY rChanged)
    Q_PROPERTY(double c READ c WRITE setC NOTIFY cChanged)
public:
    explicit AnalysisParams(QObject *parent = nullptr) : QObject{parent} {}

    quint32 m() const { return m_M; }
    void setM(quint32 v) { if (m_M != v) { m_M = v; emit mChanged(); } }

    quint32 pLB() const { return m_pLB; }
    void setPLB(quint32 v) { if (m_pLB != v) { m_pLB = v; emit pLBChanged(); } }

    quint32 pUB() const { return m_pUB; }
    void setPUB(quint32 v) { if (m_pUB != v) { m_pUB = v; emit pUBChanged(); } }

    bool calcProb() const { return m_calcProb; }
    void setCalcProb(bool v) { if (m_calcProb != v) { m_calcProb = v; emit calcProbChanged(); } }

    double lambda() const { return m_lambda; }
    void setLambda(double v) { if (m_lambda != v) { m_lambda = v; emit lambdaChanged(); } }

    double mu() const { return m_mu; }
    void setMu(double v) { if (m_mu != v) { m_mu = v; emit muChanged(); } }

    double r() const { return m_r; }
    void setR(double v) { if (m_r != v) { m_r = v; emit rChanged(); } }

    double c() const { return m_c; }
    void setC(double v) { if (m_c != v) { m_c = v; emit cChanged(); } }

signals:
    void mChanged();
    void pUBChanged();
    void pLBChanged();
    void calcProbChanged();
    void lambdaChanged();
    void muChanged();
    void rChanged();
    void cChanged();
private:
    bool m_calcProb{false};
    quint32 m_M{20}, m_pLB{1}, m_pUB{3};
    double m_lambda{60.0}, m_mu{2.0}, m_r{10}, m_c{2.0};
};

#endif // ANALYSIS_PARAMS_H
