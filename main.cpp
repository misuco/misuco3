#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <mobilesynth.h>
#include <mastersender.h>
#include <sendermobilesynth.h>
#include <senderoscmidigeneric.h>
#include <sendersoundfont.h>
#include <soundfontsynth.h>
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

    // The soundfont player shares the audio output of the mobile synth.
    // It is switched on in the SoundFont view.
    std::shared_ptr<SoundFontSynth> soundFontSynth = std::make_shared<SoundFontSynth>();
    synth->addAudioSource(soundFontSynth.get());
    soundFontSynth->loadSoundFont(QUrl("qrc:/qt/qml/misuco3/fluidsynth/sf2/VintageDreamsWaves-v2.sf2"));
    SenderSoundFont senderSoundFont(soundFontSynth);
    masterSender.addSenderThread(&senderSoundFont,"SoundFont");

    SenderOscMidiGeneric senderOscMidi;
    masterSender.addSenderThread(&senderOscMidi,"OscSender");
    masterSender.onToggleSender("OscSender",true);

    QQmlApplicationEngine engine;

    engine.setInitialProperties({
        {"senderContext", QVariant::fromValue(&masterSender)},
        {"synthContext", QVariant::fromValue(synth.get())},
        {"soundFontContext", QVariant::fromValue(soundFontSynth.get())}
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

    const int result = app.exec();

    // the audio output must not render the soundfont player while it is deleted
    synth->removeAudioSource(soundFontSynth.get());

    return result;
}
