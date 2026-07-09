// ============================================================
// MISUCO3 Web Version - Synthesizer Engine
// Microtonal Surface Controller
// ============================================================

class SynthesizerEngine {
    constructor(audioContext) {
        this.audioContext = audioContext;
        this.voices = new Map();
        this.maxVoices = 16;
        this.masterGain = audioContext.createGain();
        this.masterGain.gain.value = 0.7;
        this.masterGain.connect(audioContext.destination);

        // Synth parameters
        this.parameters = {
            oscType: 'sine',
            detune: 0,
            filterType: 'lowpass',
            filterCutoff: 10000,
            filterQ: 1,
            envAttack: 0.01,
            envRelease: 0.3,
            portamento: 0,
            arpeggio: false,
            arpRate: 8
        };

        // Performance monitoring
        this.peakLevel = 0;
        this.clipCount = 0;
        this.clipTimeout = null;
    }

    noteOn(voiceId, frequency) {
        if (this.voices.size >= this.maxVoices) {
            // Remove oldest voice
            const firstKey = this.voices.keys().next().value;
            this.noteOff(firstKey);
        }

        const voice = new SynthVoice(
            this.audioContext,
            this.masterGain,
            voiceId,
            frequency,
            this.parameters
        );

        this.voices.set(voiceId, voice);
        voice.start();
    }

    noteOff(voiceId) {
        const voice = this.voices.get(voiceId);
        if (voice) {
            voice.stop(() => {
                this.voices.delete(voiceId);
            });
        }
    }

    pitch(voiceId, frequency) {
        const voice = this.voices.get(voiceId);
        if (voice) {
            voice.setFrequency(frequency);
        }
    }

    updateParameter(paramName, value) {
        this.parameters[paramName] = value;
        
        // Update all active voices
        this.voices.forEach(voice => {
            voice.updateParameter(paramName, value);
        });
    }

    setMasterGain(gain) {
        this.masterGain.gain.setValueAtTime(gain, this.audioContext.currentTime);
    }

    setArpeggioEnabled(enabled) {
        this.parameters.arpeggio = enabled;
    }

    // Performance monitoring
    updatePeakLevel(level) {
        this.peakLevel = Math.max(this.peakLevel, level);
    }

    getPeakLevel() {
        const peak = this.peakLevel;
        this.peakLevel = 0;
        return Math.min(1, peak);
    }

    checkClipping(level) {
        if (level > 0.95) {
            this.clipCount++;
            clearTimeout(this.clipTimeout);
            this.clipTimeout = setTimeout(() => {
                this.clipCount = 0;
            }, 1000);
        }
    }

    getClipCount() {
        return this.clipCount;
    }
}

class SynthVoice {
    constructor(audioContext, masterGain, voiceId, frequency, parameters) {
        this.audioContext = audioContext;
        this.voiceId = voiceId;
        this.frequency = frequency;
        this.parameters = parameters;
        this.isActive = true;

        // Create oscillator
        this.oscillator = audioContext.createOscillator();
        this.oscillator.type = parameters.oscType;
        this.oscillator.frequency.value = frequency;
        this.oscillator.detune.value = parameters.detune;

        // Create filter
        this.filter = audioContext.createBiquadFilter();
        this.filter.type = parameters.filterType;
        this.filter.frequency.value = parameters.filterCutoff;
        this.filter.Q.value = parameters.filterQ;

        // Create envelope
        this.gainEnvelope = audioContext.createGain();
        this.gainEnvelope.gain.value = 0;

        // Create analyzer for peak monitoring
        this.analyzer = audioContext.createAnalyser();
        this.analyzer.fftSize = 256;

        // Connect audio graph
        this.oscillator.connect(this.filter);
        this.filter.connect(this.gainEnvelope);
        this.gainEnvelope.connect(this.analyzer);
        this.analyzer.connect(masterGain);

        // Frequency smoothing (portamento)
        this.targetFrequency = frequency;
    }

    start() {
        const now = this.audioContext.currentTime;
        this.gainEnvelope.gain.setValueAtTime(0, now);
        this.gainEnvelope.gain.linearRampToValueAtTime(
            0.8,
            now + this.parameters.envAttack
        );
        this.oscillator.start(now);
    }

    stop(callback) {
        const now = this.audioContext.currentTime;
        this.gainEnvelope.gain.setValueAtTime(this.gainEnvelope.gain.value, now);
        this.gainEnvelope.gain.linearRampToValueAtTime(
            0,
            now + this.parameters.envRelease
        );
        this.oscillator.stop(now + this.parameters.envRelease);
        this.isActive = false;

        setTimeout(() => {
            this.oscillator.disconnect();
            this.filter.disconnect();
            this.gainEnvelope.disconnect();
            this.analyzer.disconnect();
            if (callback) callback();
        }, (this.parameters.envRelease + 0.1) * 1000);
    }

    setFrequency(frequency) {
        this.targetFrequency = frequency;
        const portamentoTime = this.parameters.portamento || 0.05;
        const now = this.audioContext.currentTime;
        this.oscillator.frequency.linearRampToValueAtTime(
            frequency,
            now + portamentoTime
        );
    }

    updateParameter(paramName, value) {
        const now = this.audioContext.currentTime;
        
        switch (paramName) {
            case 'oscType':
                this.oscillator.type = value;
                break;
            case 'detune':
                this.oscillator.detune.setValueAtTime(value, now);
                break;
            case 'filterType':
                this.filter.type = value;
                break;
            case 'filterCutoff':
                this.filter.frequency.setValueAtTime(value, now);
                break;
            case 'filterQ':
                this.filter.Q.setValueAtTime(value, now);
                break;
        }
    }

    getPeakLevel() {
        const dataArray = new Uint8Array(this.analyzer.frequencyBinCount);
        this.analyzer.getByteFrequencyData(dataArray);
        const max = Math.max(...dataArray);
        return max / 255;
    }
}

if (typeof module !== 'undefined' && module.exports) {
    module.exports = { SynthesizerEngine, SynthVoice };
}
