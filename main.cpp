#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <polymobilesynth/qt6/mobilesynth.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    //mobileSynthQT68 synth;
    AudioOutput synth;

    QQmlApplicationEngine engine;

    QQmlContext* ctx = engine.rootContext();
    ctx->setContextProperty("synth", &synth);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("misuco3", "Main");

    return app.exec();
}
