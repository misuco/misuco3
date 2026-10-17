#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <mobilesynth.h>
#include <mastersender.h>
#include <sendermobilesynth.h>
#include <senderoscmidigeneric.h>
#include "presetstore.h"

int main(int argc, char *argv[])
{
    // Styles: Basic | Fusion | Material | Universal
    qputenv("QT_QUICK_CONTROLS_STYLE", "Basic");

    QGuiApplication app(argc, argv);

    MasterSender masterSender;

    SenderMobileSynth senderMobileSynth;
    std::shared_ptr<MobileSynth> synth = senderMobileSynth.getSynthController();
    masterSender.addSenderThread(&senderMobileSynth,"MobileSynth");
    masterSender.onToggleSender("MobileSynth",true);

    SenderOscMidiGeneric senderOscMidi;
    masterSender.addSenderThread(&senderOscMidi,"OscSender");
    masterSender.onToggleSender("OscSender",true);

    QQmlApplicationEngine engine;

    engine.setInitialProperties({
        {"senderContext", QVariant::fromValue(&masterSender)},
        {"synthContext", QVariant::fromValue(synth.get())}
    });

    // Expose PresetStore to QML
    PresetStore *presetStore = new PresetStore(&engine);
    engine.rootContext()->setContextProperty("PresetStore", presetStore);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("misuco3", "Main");

    return app.exec();
}
