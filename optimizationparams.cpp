#include "optimizationparams.h"

OptimizationParams::OptimizationParams(QObject *parent)
    : QObject{parent}
{}

quint32 OptimizationParams::maxIter() const
{
    return m_maxIter;
}

void OptimizationParams::setMaxIter(quint32 newMaxIter)
{
    m_maxIter = newMaxIter;
}

quint32 OptimizationParams::wolfCount() const
{
    return m_wolfCount;
}

void OptimizationParams::setWolfCount(quint32 newWolfCount)
{
    m_wolfCount = newWolfCount;
}

quint32 OptimizationParams::mMax() const
{
    return m_mMax;
}

void OptimizationParams::setMMax(quint32 newMMax)
{
    m_mMax = newMMax;
}

quint32 OptimizationParams::nMax() const
{
    return m_nMax;
}

void OptimizationParams::setNMax(quint32 newNMax)
{
    m_nMax = newNMax;
}

double OptimizationParams::lambda() const
{
    return m_lambda;
}

void OptimizationParams::setLambda(double newLambda)
{
    m_lambda = newLambda;
}

double OptimizationParams::mu() const
{
    return m_mu;
}

void OptimizationParams::setMu(double newMu)
{
    m_mu = newMu;
}

double OptimizationParams::r() const
{
    return m_r;
}

void OptimizationParams::setR(double newR)
{
    m_r = newR;
}

double OptimizationParams::c1() const
{
    return m_c1;
}

void OptimizationParams::setC1(double newC1)
{
    m_c1 = newC1;
}

double OptimizationParams::c2() const
{
    return m_c2;
}

void OptimizationParams::setC2(double newC2)
{
    m_c2 = newC2;
}
