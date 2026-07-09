// ============================================================
// MISUCO3 Web Version - Main Application
// Microtonal Surface Controller
// ============================================================

class PlayArea {
    constructor() {
        this.keys = [{ note: 25 }];
        this.startNote = 25;
        this.scaleSize = 12;
        this.tunings = new Array(12).fill(0);
        this.keyStates = new Map();
        this.holdKeysEnabled = false;
        this.generateScale();
    }

    generateScale() {
        this.keys = [];
        for (let i = 0; i < this.scaleSize; i++) {
            this.keys.push({ note: this.startNote + i });
        }
    }

    setScaleSize(size) {
        this.scaleSize = Math.max(1, Math.min(128, size));
        this.generateScale();
    }

    setStartNote(note) {
        this.startNote = Math.max(0, Math.min(127, note));
        this.generateScale();
    }

    setTuning(noteIndex, cents) {
        this.tunings[noteIndex % 12] = cents;
    }

    getFrequencyForKey(key) {
        const noteSymbol = key.note % 12;
        const tuning = this.tunings[noteSymbol];
        return 6.875 * Math.pow(2, ((key.note + 3) * 100 + tuning) / 1200);
    }

    keyPressed(keyIndex) {
        this.keyStates.set(keyIndex, true);
    }

    keyReleased(keyIndex) {
        if (!this.holdKeysEnabled) {
            this.keyStates.delete(keyIndex);
        }
    }

    renderKeys(ctx, width, height) {
        const keyWidth = width / this.keys.length;
        const colorPalette = window.app.colorPalette;

        this.keys.forEach((key, index) => {
            const x = index * keyWidth;
            const noteSymbol = key.note % 12;
            const isPressed = this.keyStates.has(index);
            const bgColor = colorPalette.getBackgroundColor(noteSymbol, isPressed);
            const fgColor = colorPalette.getForegroundColor(noteSymbol);

            // Draw key
            ctx.fillStyle = bgColor;
            ctx.fillRect(x, 0, keyWidth, height);

            // Draw border
            ctx.strokeStyle = '#555555';
            ctx.lineWidth = 2;
            ctx.strokeRect(x, 0, keyWidth, height);

            // Draw text
            ctx.fillStyle = fgColor;
            ctx.font = '14px Arial';
            ctx.textAlign = 'center';
            ctx.textBaseline = 'middle';
            const freq = this.getFrequencyForKey(key).toFixed(2);
            ctx.fillText(key.note, x + keyWidth / 2, height / 2 - 10);
            ctx.fillText(freq + 'Hz', x + keyWidth / 2, height / 2 + 15);
        });
    }
}

class App {
    constructor() {
        // Initialize Web Audio API
        const AudioContext = window.AudioContext || window.webkitAudioContext;
        this.audioContext = new AudioContext();

        // Initialize components
        this.playArea = new PlayArea();
        this.colorPalette = new ColorPalette(1);
        this.synth = new SynthesizerEngine(this.audioContext);
        this.touchHandler = null;
        this.uiController = null;

        // Wait for DOM to be ready
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', () => this.init());
        } else {
            this.init();
        }
    }

    init() {
        const canvas = document.getElementById('playCanvas');
        this.touchHandler = new TouchHandler(canvas, this.playArea, this.synth);
        this.uiController = new UIController(this.synth, this.playArea);

        console.log('MISUCO3 Web Version initialized');
        console.log('Audio Context Sample Rate:', this.audioContext.sampleRate);
        console.log('Max Voices:', this.synth.maxVoices);
    }

    setScalePreset(preset) {
        const presets = {
            'chromatic': { size: 12, start: 25 },
            'quarter-tone': { size: 24, start: 25 },
            'sixth-tone': { size: 18, start: 25 },
            'third-tone': { size: 36, start: 25 }
        };

        if (presets[preset]) {
            const p = presets[preset];
            this.playArea.setScaleSize(p.size);
            this.playArea.setStartNote(p.start);
            document.getElementById('scaleSize').value = p.size;
            document.getElementById('startNote').value = p.start;
            this.uiController.updateScaleDisplay();
        }
    }
}

// Start the application when page loads
window.app = new App();
