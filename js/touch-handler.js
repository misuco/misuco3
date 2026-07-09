// ============================================================
// MISUCO3 Web Version - Touch Handler
// Microtonal Surface Controller
// ============================================================

class TouchHandler {
    constructor(canvas, playArea, synth) {
        this.canvas = canvas;
        this.playArea = playArea;
        this.synth = synth;
        this.touchMap = new Map(); // Maps touch pointId to {keyIndex, voiceId}
        this.nextVoiceId = 1000;
        this.touchIndicators = new Map();

        // Canvas setup
        this.resizeCanvas();
        window.addEventListener('resize', () => this.resizeCanvas());

        // Touch events
        this.canvas.addEventListener('touchstart', (e) => this.handleTouchStart(e), false);
        this.canvas.addEventListener('touchmove', (e) => this.handleTouchMove(e), false);
        this.canvas.addEventListener('touchend', (e) => this.handleTouchEnd(e), false);
        this.canvas.addEventListener('touchcancel', (e) => this.handleTouchCancel(e), false);

        // Mouse events (for testing on desktop)
        this.canvas.addEventListener('mousedown', (e) => this.handleMouseDown(e), false);
        this.canvas.addEventListener('mousemove', (e) => this.handleMouseMove(e), false);
        this.canvas.addEventListener('mouseup', (e) => this.handleMouseUp(e), false);
        this.canvas.addEventListener('mouseleave', (e) => this.handleMouseLeave(e), false);

        this.isMousePressed = false;
        this.mousePointId = 'mouse';

        // Start render loop
        this.render();
    }

    resizeCanvas() {
        const rect = this.canvas.getBoundingClientRect();
        this.canvas.width = rect.width * window.devicePixelRatio;
        this.canvas.height = rect.height * window.devicePixelRatio;
        const ctx = this.canvas.getContext('2d');
        ctx.scale(window.devicePixelRatio, window.devicePixelRatio);
    }

    getKeyIndexFromPosition(x) {
        const keyWidth = this.canvas.width / this.playArea.keys.length / window.devicePixelRatio;
        return Math.floor(x / keyWidth);
    }

    getFrequencyFromKey(keyIndex) {
        if (keyIndex < 0 || keyIndex >= this.playArea.keys.length) return 0;
        const key = this.playArea.keys[keyIndex];
        return this.playArea.getFrequencyForKey(key);
    }

    handleTouchStart(event) {
        event.preventDefault();
        const touches = event.changedTouches;
        
        for (let i = 0; i < touches.length; i++) {
            const touch = touches[i];
            const rect = this.canvas.getBoundingClientRect();
            const x = touch.clientX - rect.left;
            const y = touch.clientY - rect.top;
            
            this.startNote(touch.identifier, x, y);
        }
    }

    handleTouchMove(event) {
        event.preventDefault();
        const touches = event.changedTouches;
        
        for (let i = 0; i < touches.length; i++) {
            const touch = touches[i];
            const rect = this.canvas.getBoundingClientRect();
            const x = touch.clientX - rect.left;
            const y = touch.clientY - rect.top;
            
            this.updateNote(touch.identifier, x, y);
        }
    }

    handleTouchEnd(event) {
        event.preventDefault();
        const touches = event.changedTouches;
        
        for (let i = 0; i < touches.length; i++) {
            const touch = touches[i];
            this.endNote(touch.identifier);
        }
    }

    handleTouchCancel(event) {
        event.preventDefault();
        const touches = event.changedTouches;
        
        for (let i = 0; i < touches.length; i++) {
            const touch = touches[i];
            this.endNote(touch.identifier);
        }
    }

    handleMouseDown(event) {
        this.isMousePressed = true;
        const rect = this.canvas.getBoundingClientRect();
        const x = event.clientX - rect.left;
        const y = event.clientY - rect.top;
        this.startNote(this.mousePointId, x, y);
    }

    handleMouseMove(event) {
        if (!this.isMousePressed) return;
        const rect = this.canvas.getBoundingClientRect();
        const x = event.clientX - rect.left;
        const y = event.clientY - rect.top;
        this.updateNote(this.mousePointId, x, y);
    }

    handleMouseUp(event) {
        this.isMousePressed = false;
        this.endNote(this.mousePointId);
    }

    handleMouseLeave(event) {
        if (this.isMousePressed) {
            this.isMousePressed = false;
            this.endNote(this.mousePointId);
        }
    }

    startNote(pointId, x, y) {
        const keyIndex = this.getKeyIndexFromPosition(x);
        if (keyIndex < 0 || keyIndex >= this.playArea.keys.length) return;

        const frequency = this.getFrequencyFromKey(keyIndex);
        const voiceId = this.nextVoiceId++;

        this.touchMap.set(pointId, {
            keyIndex,
            voiceId,
            startY: y,
            startFrequency: frequency
        });

        this.playArea.keyPressed(keyIndex);
        this.synth.noteOn(voiceId, frequency);

        // Create touch indicator
        this.touchIndicators.set(pointId, { x, y, keyIndex });
    }

    updateNote(pointId, x, y) {
        const touchData = this.touchMap.get(pointId);
        if (!touchData) return;

        const keyIndex = this.getKeyIndexFromPosition(x);
        const frequency = this.getFrequencyFromKey(keyIndex);

        // Handle key change
        if (keyIndex !== touchData.keyIndex) {
            this.playArea.keyReleased(touchData.keyIndex);
            this.playArea.keyPressed(keyIndex);
            touchData.keyIndex = keyIndex;
        }

        // Handle vertical pitch bend
        const pitchBend = (touchData.startY - y) * 0.5; // Cents per pixel
        const bendedFrequency = Math.max(10, frequency + pitchBend);

        this.synth.pitch(touchData.voiceId, bendedFrequency);

        // Update indicator
        this.touchIndicators.set(pointId, { x, y, keyIndex, bendedFrequency });
    }

    endNote(pointId) {
        const touchData = this.touchMap.get(pointId);
        if (!touchData) return;

        this.playArea.keyReleased(touchData.keyIndex);
        this.synth.noteOff(touchData.voiceId);
        this.touchMap.delete(pointId);
        this.touchIndicators.delete(pointId);
    }

    render() {
        const ctx = this.canvas.getContext('2d');
        const width = this.canvas.width / window.devicePixelRatio;
        const height = this.canvas.height / window.devicePixelRatio;

        // Draw background
        ctx.fillStyle = '#333333';
        ctx.fillRect(0, 0, width, height);

        // Draw keys
        this.playArea.renderKeys(ctx, width, height);

        // Draw touch indicators
        ctx.strokeStyle = '#ff8800';
        ctx.lineWidth = 2;
        ctx.fillStyle = 'rgba(255, 136, 0, 0.1)';

        this.touchIndicators.forEach((indicator, pointId) => {
            ctx.beginPath();
            ctx.arc(indicator.x, indicator.y, 50, 0, Math.PI * 2);
            ctx.fill();
            ctx.stroke();

            ctx.fillStyle = '#ff8800';
            ctx.font = '12px sans-serif';
            ctx.textAlign = 'center';
            ctx.textBaseline = 'middle';
            ctx.fillText(pointId, indicator.x, indicator.y);
            ctx.fillStyle = 'rgba(255, 136, 0, 0.1)';
        });

        requestAnimationFrame(() => this.render());
    }
}

if (typeof module !== 'undefined' && module.exports) {
    module.exports = TouchHandler;
}
