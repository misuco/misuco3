// ============================================================
// MISUCO3 Web Version - UI Controller
// Microtonal Surface Controller
// ============================================================

class UIController {
    constructor(synth, playArea) {
        this.synth = synth;
        this.playArea = playArea;
        this.setupTabSwitching();
        this.setupControls();
    }

    setupTabSwitching() {
        const tabButtons = document.querySelectorAll('.tab-button');
        const panels = document.querySelectorAll('.panel');

        tabButtons.forEach(button => {
            button.addEventListener('click', () => {
                const tabId = button.getAttribute('data-tab');

                // Remove active class from all tabs and panels
                tabButtons.forEach(btn => btn.classList.remove('active'));
                panels.forEach(panel => panel.classList.remove('active'));

                // Add active class to clicked tab and corresponding panel
                button.classList.add('active');
                document.getElementById(tabId).classList.add('active');
            });
        });
    }

    setupControls() {
        // Hold Switch
        document.getElementById('holdSwitch').addEventListener('change', (e) => {
            this.playArea.holdKeysEnabled = e.target.checked;
        });

        // Arp Switch
        document.getElementById('arpSwitch').addEventListener('change', (e) => {
            this.synth.setArpeggioEnabled(e.target.checked);
        });

        // Master Gain
        document.getElementById('masterGain').addEventListener('input', (e) => {
            const value = parseFloat(e.target.value);
            this.synth.setMasterGain(value);
        });

        // Audio Toggle
        document.getElementById('audioToggle').addEventListener('click', () => {
            this.toggleAudio();
        });

        // Oscillator Type
        document.getElementById('oscType').addEventListener('change', (e) => {
            this.synth.updateParameter('oscType', e.target.value);
        });

        // Oscillator Detune
        document.getElementById('oscDetune').addEventListener('input', (e) => {
            const value = parseInt(e.target.value);
            this.synth.updateParameter('detune', value);
            document.getElementById('oscDetuneValue').textContent = value + ' cents';
        });

        // Filter Type
        document.getElementById('filterType').addEventListener('change', (e) => {
            this.synth.updateParameter('filterType', e.target.value);
        });

        // Filter Cutoff
        document.getElementById('filterCutoff').addEventListener('input', (e) => {
            const value = parseInt(e.target.value);
            this.synth.updateParameter('filterCutoff', value);
            document.getElementById('filterCutoffValue').textContent = value + ' Hz';
        });

        // Filter Q
        document.getElementById('filterQ').addEventListener('input', (e) => {
            const value = parseFloat(e.target.value);
            this.synth.updateParameter('filterQ', value);
            document.getElementById('filterQValue').textContent = value.toFixed(1);
        });

        // Envelope Attack
        document.getElementById('envAttack').addEventListener('input', (e) => {
            const value = parseFloat(e.target.value);
            this.synth.parameters.envAttack = value;
            document.getElementById('envAttackValue').textContent = (value * 1000).toFixed(0) + 'ms';
        });

        // Envelope Release
        document.getElementById('envRelease').addEventListener('input', (e) => {
            const value = parseFloat(e.target.value);
            this.synth.parameters.envRelease = value;
            document.getElementById('envReleaseValue').textContent = (value * 1000).toFixed(0) + 'ms';
        });

        // Portamento
        document.getElementById('portamento').addEventListener('input', (e) => {
            const value = parseFloat(e.target.value);
            this.synth.updateParameter('portamento', value);
            document.getElementById('portamentoValue').textContent = (value * 1000).toFixed(0) + 'ms';
        });

        // Scale Configuration
        document.getElementById('scaleSize').addEventListener('change', (e) => {
            const size = parseInt(e.target.value);
            this.playArea.setScaleSize(size);
            this.updateScaleDisplay();
        });

        document.getElementById('startNote').addEventListener('change', (e) => {
            const note = parseInt(e.target.value);
            this.playArea.setStartNote(note);
            this.updateScaleDisplay();
        });

        // Tuning sliders
        this.updateTuningDisplay();

        // Update audio info
        this.updateAudioInfo();

        // Start monitoring
        this.startMonitoring();
    }

    toggleAudio() {
        const button = document.getElementById('audioToggle');
        if (this.synth.audioContext.state === 'running') {
            button.textContent = 'Start Audio';
        } else {
            this.synth.audioContext.resume().then(() => {
                button.textContent = 'Stop Audio';
            });
        }
    }

    updateAudioInfo() {
        document.getElementById('sampleRate').textContent = this.synth.audioContext.sampleRate.toLocaleString();
        document.getElementById('bufferSize').textContent = this.synth.audioContext.destination.maxChannelCount * 128;
    }

    updateScaleDisplay() {
        const container = document.getElementById('scaleNotes');
        container.innerHTML = '';

        this.playArea.keys.forEach((key, index) => {
            const item = document.createElement('div');
            item.className = 'scale-note-item';
            item.textContent = key.note;
            if (index === 0) item.classList.add('active');
            container.appendChild(item);
        });
    }

    updateTuningDisplay() {
        const container = document.getElementById('tuningSliders');
        container.innerHTML = '';

        for (let i = 0; i < 12; i++) {
            const item = document.createElement('div');
            item.className = 'tuning-slider-item';
            item.innerHTML = `
                <label>Note ${i}:</label>
                <input type="range" min="-100" max="100" step="1" value="0" class="tuning-slider" data-note="${i}">
                <span>0 cents</span>
            `;
            container.appendChild(item);

            const slider = item.querySelector('.tuning-slider');
            const valueSpan = item.querySelector('span');
            slider.addEventListener('input', (e) => {
                const cents = parseInt(e.target.value);
                valueSpan.textContent = cents + ' cents';
                this.playArea.setTuning(i, cents);
            });
        }
    }

    startMonitoring() {
        const peakBar = document.getElementById('peakLevel');
        const clipIndicator = document.getElementById('clipIndicator');
        const clipCount = document.getElementById('clipCount');

        setInterval(() => {
            const peak = this.synth.getPeakLevel();
            peakBar.style.width = (peak * 100) + '%';

            const clips = this.synth.getClipCount();
            if (clips > 0) {
                clipCount.textContent = clips;
                clipIndicator.style.display = 'flex';
            } else {
                clipIndicator.style.display = 'none';
            }
        }, 50);
    }
}

if (typeof module !== 'undefined' && module.exports) {
    module.exports = UIController;
}
