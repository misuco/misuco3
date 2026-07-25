// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <polymobilesynth/qt6/mobilesynth.h>
#include <misulib/comm/mastersender.h>
#include <misulib/comm/sendermobilesynth.h>
#include <misulib/comm/senderoscmidigeneric.h>

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

    QQmlContext* ctx = engine.rootContext();
    ctx->setContextProperty("synthContext", synth.get());
    ctx->setContextProperty("senderContext", &masterSender);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("misuco3", "Main");

    return app.exec();
}
