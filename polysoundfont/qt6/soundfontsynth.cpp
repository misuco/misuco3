// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

#include "soundfontsynth.h"

#include <QDebug>
#include <QFile>
#include <QFileInfo>
#include <QMutexLocker>

#include <algorithm>
#include <cmath>
#include <cstdio>

#include <fluidsynth.h>

namespace {

// Soundfont file access through QFile instead of stdio, so that qrc
// resources and android content uris can be loaded as well.

void *sfOpen(const char *filename)
{
    QFile *file = new QFile(QString::fromUtf8(filename));
    if(!file->open(QIODevice::ReadOnly)) {
        qWarning() << "SoundFontSynth: cannot open" << filename << file->errorString();
        delete file;
        return nullptr;
    }
    return file;
}

int sfRead(void *buf, fluid_long_long_t count, void *handle)
{
    QFile *file = static_cast<QFile *>(handle);
    char *dst = static_cast<char *>(buf);
    while(count>0) {
        const qint64 n = file->read(dst, count);
        if(n<=0) {
            return FLUID_FAILED;
        }
        dst += n;
        count -= n;
    }
    return FLUID_OK;
}

int sfSeek(void *handle, fluid_long_long_t offset, int origin)
{
    QFile *file = static_cast<QFile *>(handle);
    qint64 pos = offset;
    if(origin==SEEK_CUR) {
        pos += file->pos();
    } else if(origin==SEEK_END) {
        pos += file->size();
    }
    return file->seek(pos) ? FLUID_OK : FLUID_FAILED;
}

fluid_long_long_t sfTell(void *handle)
{
    return static_cast<QFile *>(handle)->pos();
}

int sfClose(void *handle)
{
    delete static_cast<QFile *>(handle);
    return FLUID_OK;
}

QString urlToPath(const QUrl &url)
{
    if(url.isLocalFile()) {
        return url.toLocalFile();
    }
    if(url.scheme()==QLatin1String("qrc")) {
        return QLatin1Char(':') + url.path();
    }
    // plain paths and android content uris are passed on as they are
    return url.toString();
}

} // namespace

SoundFontSynth::SoundFontSynth(QObject *parent) : QObject(parent)
{
}

SoundFontSynth::~SoundFontSynth()
{
    Engine old;
    {
        QMutexLocker controlLock(&m_controlMutex);
        std::lock_guard<std::mutex> renderLock(m_renderMutex);
        std::swap(old, m_engine);
    }
    deleteEngine(old);
}

SoundFontSynth::Engine SoundFontSynth::createEngine(int sampleRate, const QString &soundFontPath) const
{
    Engine e;
    e.settings = new_fluid_settings();
    fluid_settings_setnum(e.settings, "synth.sample-rate", std::clamp(sampleRate, 8000, 96000));
    fluid_settings_setint(e.settings, "synth.midi-channels", VoiceCount);
    fluid_settings_setint(e.settings, "synth.polyphony", 64);
    fluid_settings_setint(e.settings, "synth.cpu-cores", 1);
    fluid_settings_setnum(e.settings, "synth.gain", m_gain);
    fluid_settings_setint(e.settings, "synth.reverb.active", m_reverb ? 1 : 0);
    fluid_settings_setint(e.settings, "synth.chorus.active", m_chorus ? 1 : 0);

    e.synth = new_fluid_synth(e.settings);
    if(!e.synth) {
        qWarning() << "SoundFontSynth: cannot create fluidsynth instance";
        delete_fluid_settings(e.settings);
        e.settings = nullptr;
        return e;
    }

    // the loader is owned by the synth and tried before the built in ones
    fluid_sfloader_t *loader = new_fluid_defsfloader(e.settings);
    fluid_sfloader_set_callbacks(loader, sfOpen, sfRead, sfSeek, sfTell, sfClose);
    fluid_synth_add_sfloader(e.synth, loader);

    for(int ch=0;ch<VoiceCount;ch++) {
        // no drum channel, all channels play the selected preset
        fluid_synth_set_channel_type(e.synth, ch, CHANNEL_TYPE_MELODIC);
        fluid_synth_pitch_wheel_sens(e.synth, ch, BendRange);
    }

    if(!soundFontPath.isEmpty()) {
        e.sfontId = fluid_synth_sfload(e.synth, soundFontPath.toUtf8().constData(), 0);
    }

    return e;
}

void SoundFontSynth::deleteEngine(Engine &engine)
{
    if(engine.synth) {
        delete_fluid_synth(engine.synth);
    }
    if(engine.settings) {
        delete_fluid_settings(engine.settings);
    }
    engine = Engine();
}

QList<SoundFontSynth::Preset> SoundFontSynth::readPresets(const Engine &engine)
{
    QList<Preset> presets;
    if(!engine.synth || engine.sfontId<0) {
        return presets;
    }
    fluid_sfont_t *sfont = fluid_synth_get_sfont_by_id(engine.synth, engine.sfontId);
    if(!sfont) {
        return presets;
    }
    fluid_sfont_iteration_start(sfont);
    while(fluid_preset_t *preset = fluid_sfont_iteration_next(sfont)) {
        presets.append({ QString::fromLatin1(fluid_preset_get_name(preset)).trimmed(),
                         fluid_preset_get_banknum(preset),
                         fluid_preset_get_num(preset) });
    }
    std::stable_sort(presets.begin(), presets.end(), [](const Preset &a, const Preset &b) {
        return a.bank!=b.bank ? a.bank<b.bank : a.num<b.num;
    });
    return presets;
}

void SoundFontSynth::setSampleRate(int sampleRate)
{
    if(sampleRate<=0 || (sampleRate==m_sampleRate && m_engine.synth)) {
        return;
    }
    qDebug() << "SoundFontSynth::setSampleRate" << sampleRate;
    m_sampleRate = sampleRate;

    // fluidsynth cannot change the sample rate of a running synth:
    // build a new one and swap it in
    Engine engine = createEngine(sampleRate, m_soundFontPath);
    const bool loadPending = !m_soundFontPath.isEmpty();
    if(loadPending) {
        // a soundfont requested before the first engine existed is loaded
        // now, a loaded one had to be read again for the new engine
        m_presets = readPresets(engine);
        if(m_presets.isEmpty()) {
            m_errorString = QStringLiteral("Cannot load %1").arg(m_soundFontName);
            m_soundFontPath.clear();
            m_soundFontName.clear();
        }
        if(m_presetIndex>=m_presets.size()) {
            m_presetIndex = 0;
        }
    }
    {
        QMutexLocker controlLock(&m_controlMutex);
        {
            std::lock_guard<std::mutex> renderLock(m_renderMutex);
            std::swap(engine, m_engine);
        }
        m_voices.fill(Voice());
        selectPresetLocked();
        for(auto it=m_ccAllVoices.constBegin();it!=m_ccAllVoices.constEnd();++it) {
            for(int ch=0;ch<VoiceCount;ch++) {
                fluid_synth_cc(m_engine.synth, ch, it.key(), it.value());
            }
        }
    }
    deleteEngine(engine);

    if(loadPending) {
        emit soundFontChanged();
        emit presetIndexChanged();
    }
}

bool SoundFontSynth::loadSoundFont(const QUrl &url)
{
    const QString path = urlToPath(url);
    const QString name = QFileInfo(url.path()).completeBaseName();
    qDebug() << "SoundFontSynth::loadSoundFont" << path;

    if(!m_engine.synth) {
        // no sample rate yet: loaded when the engine is created
        m_soundFontPath = path;
        m_soundFontName = name;
        m_presets.clear();
        return true;
    }

    // slow, but safe while the audio thread keeps rendering
    const int id = fluid_synth_sfload(m_engine.synth, path.toUtf8().constData(), 0);
    if(id==FLUID_FAILED) {
        m_errorString = QStringLiteral("Cannot load %1").arg(name);
        emit soundFontChanged();
        return false;
    }

    {
        QMutexLocker controlLock(&m_controlMutex);
        releaseAllLocked(true);
        if(m_engine.sfontId>=0) {
            fluid_synth_sfunload(m_engine.synth, m_engine.sfontId, 0);
        }
        m_engine.sfontId = id;
        m_presets = readPresets(m_engine);
        m_presetIndex = 0;
        selectPresetLocked();
    }
    m_soundFontPath = path;
    m_soundFontName = name;
    m_errorString.clear();

    emit soundFontChanged();
    emit presetIndexChanged();
    return true;
}

void SoundFontSynth::selectPresetLocked()
{
    if(!m_engine.synth || m_engine.sfontId<0 || m_presetIndex<0 || m_presetIndex>=m_presets.size()) {
        return;
    }
    const Preset &preset = m_presets.at(m_presetIndex);
    for(int ch=0;ch<VoiceCount;ch++) {
        fluid_synth_program_select(m_engine.synth, ch, m_engine.sfontId, preset.bank, preset.num);
    }
}

void SoundFontSynth::releaseAllLocked(bool immediately)
{
    for(Voice &voice : m_voices) {
        voice.held = false;
        voice.voiceId = 0;
    }
    if(!m_engine.synth) {
        return;
    }
    for(int ch=0;ch<VoiceCount;ch++) {
        if(immediately) {
            fluid_synth_all_sounds_off(m_engine.synth, ch);
        } else {
            fluid_synth_all_notes_off(m_engine.synth, ch);
        }
    }
}

void SoundFontSynth::allNotesOff()
{
    QMutexLocker controlLock(&m_controlMutex);
    releaseAllLocked(false);
}

int SoundFontSynth::channelOfVoiceLocked(int voiceId) const
{
    for(int ch=0;ch<VoiceCount;ch++) {
        if(m_voices[ch].held && m_voices[ch].voiceId==voiceId) {
            return ch;
        }
    }
    return -1;
}

bool SoundFontSynth::freqToKey(float f, double &exactKey)
{
    if(!(f>0)) {
        return false;
    }
    exactKey = 69.0 + 12.0 * std::log2(static_cast<double>(f) / 440.0);
    return true;
}

int SoundFontSynth::bendValue(double semitones)
{
    // The default pitch bend modulator of the SoundFont standard scales the
    // sensitivity by 1/128 instead of 1/127: a full bend of n semitones
    // results in n * 12700/128 cents.
    const double fullBendCents = BendRange * 12700.0 / 128.0;
    const long v = 8192 + std::lround(semitones * 100.0 * 8192.0 / fullBendCents);
    return static_cast<int>(std::clamp(v, 0L, 16383L));
}

void SoundFontSynth::noteOn(int voiceId, float f, int velocity)
{
    double exactKey;
    if(!m_enabled.load() || !freqToKey(f, exactKey)) {
        return;
    }

    QMutexLocker controlLock(&m_controlMutex);
    if(!m_engine.synth || m_engine.sfontId<0) {
        return;
    }

    int ch = channelOfVoiceLocked(voiceId);
    if(ch<0) {
        // Take the channel that has been silent for the longest time, its
        // release tail is the least likely to be still audible when the
        // pitch bend changes. If all are held the oldest note is stolen.
        bool chHeld = true;
        for(int i=0;i<VoiceCount;i++) {
            const Voice &v = m_voices[i];
            if(ch<0 || (chHeld && !v.held) || (chHeld==v.held && v.stamp<m_voices[ch].stamp)) {
                ch = i;
                chHeld = v.held;
            }
        }
    }

    Voice &voice = m_voices[ch];
    if(voice.held) {
        fluid_synth_noteoff(m_engine.synth, ch, voice.key);
    }

    voice.voiceId = voiceId;
    voice.key = std::clamp(static_cast<int>(std::lround(exactKey)), 0, 127);
    voice.held = true;
    voice.stamp = ++m_stamp;

    // reset the controllers a previous voice on this channel has changed
    for(auto it=m_ccAllVoices.constBegin();it!=m_ccAllVoices.constEnd();++it) {
        fluid_synth_cc(m_engine.synth, ch, it.key(), it.value());
    }
    fluid_synth_pitch_bend(m_engine.synth, ch, bendValue(exactKey - voice.key));
    fluid_synth_noteon(m_engine.synth, ch, voice.key, std::clamp(velocity, 1, 127));
}

void SoundFontSynth::noteOff(int voiceId)
{
    QMutexLocker controlLock(&m_controlMutex);
    const int ch = channelOfVoiceLocked(voiceId);
    if(ch<0 || !m_engine.synth) {
        return;
    }
    Voice &voice = m_voices[ch];
    fluid_synth_noteoff(m_engine.synth, ch, voice.key);
    voice.held = false;
    voice.stamp = ++m_stamp;
}

void SoundFontSynth::pitch(int voiceId, float f)
{
    double exactKey;
    if(!freqToKey(f, exactKey)) {
        return;
    }
    QMutexLocker controlLock(&m_controlMutex);
    const int ch = channelOfVoiceLocked(voiceId);
    if(ch<0 || !m_engine.synth) {
        return;
    }
    fluid_synth_pitch_bend(m_engine.synth, ch, bendValue(exactKey - m_voices[ch].key));
}

void SoundFontSynth::controlChange(int voiceId, int cc, int value)
{
    QMutexLocker controlLock(&m_controlMutex);
    const int ch = channelOfVoiceLocked(voiceId);
    if(ch<0 || !m_engine.synth) {
        return;
    }
    fluid_synth_cc(m_engine.synth, ch, cc, std::clamp(value, 0, 127));
}

void SoundFontSynth::controlChangeAllVoices(int cc, int value)
{
    value = std::clamp(value, 0, 127);
    QMutexLocker controlLock(&m_controlMutex);
    m_ccAllVoices.insert(cc, value);
    if(!m_engine.synth) {
        return;
    }
    for(int ch=0;ch<VoiceCount;ch++) {
        fluid_synth_cc(m_engine.synth, ch, cc, value);
    }
}

bool SoundFontSynth::render(float *left, float *right, int frames)
{
    if(!m_enabled.load()) {
        return false;
    }
    // only fails while the engine is replaced
    std::unique_lock<std::mutex> renderLock(m_renderMutex, std::try_to_lock);
    if(!renderLock.owns_lock() || !m_engine.synth) {
        return false;
    }
    return fluid_synth_write_float(m_engine.synth, frames, left, 0, 1, right, 0, 1)==FLUID_OK;
}

bool SoundFontSynth::enabled() const
{
    return m_enabled.load();
}

void SoundFontSynth::setEnabled(bool v)
{
    if(m_enabled.exchange(v)==v) {
        return;
    }
    if(!v) {
        // rendering stops right away, drop the voices instead of freezing them
        QMutexLocker controlLock(&m_controlMutex);
        releaseAllLocked(true);
    }
    emit enabledChanged();
}

bool SoundFontSynth::loaded() const
{
    return !m_presets.isEmpty();
}

QString SoundFontSynth::soundFontName() const
{
    return m_soundFontName;
}

QString SoundFontSynth::errorString() const
{
    return m_errorString;
}

QStringList SoundFontSynth::presetList() const
{
    QStringList l;
    for(const Preset &preset : m_presets) {
        l.append(QStringLiteral("%1:%2 %3")
                     .arg(preset.bank, 3, 10, QLatin1Char('0'))
                     .arg(preset.num, 3, 10, QLatin1Char('0'))
                     .arg(preset.name));
    }
    return l;
}

int SoundFontSynth::presetIndex() const
{
    return m_presetIndex;
}

void SoundFontSynth::setPresetIndex(int index)
{
    if(index==m_presetIndex || index<0 || index>=m_presets.size()) {
        return;
    }
    {
        QMutexLocker controlLock(&m_controlMutex);
        m_presetIndex = index;
        selectPresetLocked();
    }
    emit presetIndexChanged();
}

float SoundFontSynth::gain() const
{
    return m_gain;
}

void SoundFontSynth::setGain(float v)
{
    v = std::clamp(v, 0.0f, 10.0f);
    if(v==m_gain) {
        return;
    }
    m_gain = v;
    if(m_engine.synth) {
        fluid_synth_set_gain(m_engine.synth, v);
    }
    emit gainChanged();
}

bool SoundFontSynth::reverb() const
{
    return m_reverb;
}

void SoundFontSynth::setReverb(bool v)
{
    if(v==m_reverb) {
        return;
    }
    m_reverb = v;
    if(m_engine.synth) {
        fluid_synth_reverb_on(m_engine.synth, -1, v ? 1 : 0);
    }
    emit reverbChanged();
}

bool SoundFontSynth::chorus() const
{
    return m_chorus;
}

void SoundFontSynth::setChorus(bool v)
{
    if(v==m_chorus) {
        return;
    }
    m_chorus = v;
    if(m_engine.synth) {
        fluid_synth_chorus_on(m_engine.synth, -1, v ? 1 : 0);
    }
    emit chorusChanged();
}
