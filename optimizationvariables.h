#ifndef OPTIMIZATIONVARIABLES_H
#define OPTIMIZATIONVARIABLES_H

#include <QObject>

class OptimizationVariables : public QObject
{
    Q_OBJECT

    Q_PROPERTY(double lambda READ lambda WRITE set_lambda NOTIFY lambda_changed)
    Q_PROPERTY(double mu READ mu WRITE set_mu NOTIFY muChanged)
    Q_PROPERTY(double n READ n WRITE set_M NOTIFY m_changed)
    Q_PROPERTY(double n READ n WRITE set_n NOTIFY n_changed)
    Q_PROPERTY(double r READ r WRITE setR NOTIFY r_changed)
    Q_PROPERTY(double c1 READ c1 WRITE setC1 NOTIFY c1_changed)
    Q_PROPERTY(double c2 READ c2 WRITE setC2 NOTIFY c2_changed)
    Q_PROPERTY(double iter READ iter WRITE set_iter NOTIFY iter_changed)
    Q_PROPERTY(double numwolfs READ numwolfs WRITE set_numwolfs NOTIFY numwolfs_changed)

public:
    explicit OptimizationVariables(QObject *parent = nullptr);

signals:

private:
    double m_lambda = 60.0;
    double m_mu = 2.0;
    double m_m = 5;
    double m_n = 10;
    double m_r = 0.8;
    double m_c1 = 2.0;
    double m_c2 = 1.0;
};

#endif // OPTIMIZATIONVARIABLES_H
