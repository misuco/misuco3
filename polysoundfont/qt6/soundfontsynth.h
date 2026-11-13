// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

#ifndef SOUNDFONTSYNTH_H
#define SOUNDFONTSYNTH_H

#include <QtQmlIntegration/qqmlintegration.h>

#include <QList>
#include <QMap>
#include <QMutex>
#include <QObject>
#include <QString>
#include <QStringList>
#include <QUrl>

#include <array>
#include <atomic>
#include <mutex>

#include <polymobilesynth/qt6/audiosource.h>

typedef struct _fluid_hashtable_t fluid_settings_t;
typedef struct _fluid_synth_t fluid_synth_t;

//! Polyphonic soundfont player based on FluidSynth
/*!
  Plays the presets of a SoundFont 2 file at arbitrary frequencies.

  Every voice gets its own MIDI channel, the frequency is mapped to the
  nearest key plus a pitch bend. That way each voice can be tuned and
  bent independently, the same way the voices of MobileSynth are.

  The class does not open an audio device. It is an AudioSource that is
  mixed into the output of MobileSynth (MobileSynth::addAudioSource).

  Threads:
  - properties, loadSoundFont() and setSampleRate() belong to the thread
    of the object (the gui thread)
  - noteOn(), noteOff(), pitch(), controlChange*() and allNotesOff()
    can be called from any thread
  - render() is called from the audio thread
*/
class SoundFontSynth : public QObject, public AudioSource
{
    Q_OBJECT

    Q_PROPERTY(bool enabled READ enabled WRITE setEnabled NOTIFY enabledChanged)
    Q_PROPERTY(bool loaded READ loaded NOTIFY soundFontChanged)
    Q_PROPERTY(QString soundFontName READ soundFontName NOTIFY soundFontChanged)
    Q_PROPERTY(QString errorString READ errorString NOTIFY soundFontChanged)
    Q_PROPERTY(QStringList presetList READ presetList NOTIFY soundFontChanged)
    Q_PROPERTY(int presetIndex READ presetIndex WRITE setPresetIndex NOTIFY presetIndexChanged)
    Q_PROPERTY(float gain READ gain WRITE setGain NOTIFY gainChanged)
    Q_PROPERTY(bool reverb READ reverb WRITE setReverb NOTIFY reverbChanged)
    Q_PROPERTY(bool chorus READ chorus WRITE setChorus NOTIFY chorusChanged)

    QML_ELEMENT
    QML_UNCREATABLE("Cannot instantiate SoundFontSynth")

public:
    explicit SoundFontSynth(QObject *parent = nullptr);
    ~SoundFontSynth();

    //! Number of voices that can sound at the same time (one MIDI channel each)
    static constexpr int VoiceCount = 16;

    //! Pitch wheel range in semitones, limits how far pitch() can bend a sounding voice
    static constexpr int BendRange = 24;

    //! Load a soundfont from a local file, a qrc resource or an android content uri
    /*!
      The currently loaded soundfont is kept if loading fails.
    */
    Q_INVOKABLE bool loadSoundFont(const QUrl &url);
    Q_INVOKABLE void allNotesOff();

    void noteOn(int voiceId, float f, int velocity);
    void noteOff(int voiceId);
    void pitch(int voiceId, float f);

    //! Send a midi controller (value 0..127) to the channel of one voice
    void controlChange(int voiceId, int cc, int value);
    //! Send a midi controller (value 0..127) to all voices, including future ones
    void controlChangeAllVoices(int cc, int value);

    bool enabled() const;
    void setEnabled(bool v);
    bool loaded() const;
    QString soundFontName() const;
    QString errorString() const;
    QStringList presetList() const;
    int presetIndex() const;
    void setPresetIndex(int index);
    float gain() const;
    void setGain(float v);
    bool reverb() const;
    void setReverb(bool v);
    bool chorus() const;
    void setChorus(bool v);

    // AudioSource
    void setSampleRate(int sampleRate) override;
    bool render(float *left, float *right, int frames) override;

signals:
    void enabledChanged();
    void soundFontChanged();
    void presetIndexChanged();
    void gainChanged();
    void reverbChanged();
    void chorusChanged();

private:
    struct Preset {
        QString name;
        int bank;
        int num;
    };

    struct Voice {
        int voiceId{0};
        int key{0};
        bool held{false};
        quint64 stamp{0};
    };

    struct Engine {
        fluid_settings_t *settings{nullptr};
        fluid_synth_t *synth{nullptr};
        int sfontId{-1};
    };

    Engine createEngine(int sampleRate, const QString &soundFontPath) const;
    static void deleteEngine(Engine &engine);
    static QList<Preset> readPresets(const Engine &engine);

    void selectPresetLocked();
    void releaseAllLocked(bool immediately);
    int channelOfVoiceLocked(int voiceId) const;
    static bool freqToKey(float f, double &exactKey);
    static int bendValue(double semitones);

    // m_controlMutex guards m_engine and the voice state between the
    // control threads. Replacing m_engine additionally requires
    // m_renderMutex, which the audio thread only ever tries to lock.
    QMutex m_controlMutex;
    std::mutex m_renderMutex;
    Engine m_engine;
    std::array<Voice, VoiceCount> m_voices;
    quint64 m_stamp{0};
    QMap<int, int> m_ccAllVoices;

    std::atomic<bool> m_enabled{false};

    // only used by the thread of the object
    int m_sampleRate{0};
    QString m_soundFontPath;
    QString m_soundFontName;
    QString m_errorString;
    QList<Preset> m_presets;
    int m_presetIndex{0};
    float m_gain{0.6f};
    bool m_reverb{true};
    bool m_chorus{false};
};

#endif // SOUNDFONTSYNTH_H
