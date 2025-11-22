#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "greywolfoptimizer.h"
#include "opt_params.h"
#include "analysis_params.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    OptimizationParams optParams;
    AnalysisParams nlsParams;
    GreyWolfOptimizer gwo(&optParams, &nlsParams);
    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("gwo", &gwo);
    engine.rootContext()->setContextProperty("opt_params", &optParams);
    engine.rootContext()->setContextProperty("nls_params", &nlsParams);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("aimo_projekt", "Main");

    return app.exec();
}
