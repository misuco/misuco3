// ============================================================
// MISUCO3 Web Version - Color Palette
// Microtonal Surface Controller
// ============================================================

class ColorPalette {
    constructor(paletteIndex = 1) {
        this.paletteIndex = paletteIndex;
        this.palettes = [
            // Palette 0 - Dark mode
            {
                name: 'Dark',
                background: ['#1a1a1a', '#2a2a2a', '#3a3a3a', '#4a4a4a', '#5a5a5a', '#6a6a6a', '#7a7a7a', '#8a8a8a', '#9a9a9a', '#aaaaaa', '#bbbbbb', '#cccccc'],
                foreground: ['#ffffff', '#ffffff', '#ffffff', '#ffffff', '#ffffff', '#ffffff', '#cccccc', '#cccccc', '#aaaaaa', '#aaaaaa', '#888888', '#888888'],
                text: '#ffffff'
            },
            // Palette 1 - Colorful (default)
            {
                name: 'Colorful',
                background: [
                    '#ff6b6b', '#ff8e72', '#ffa366', '#ffb84d', '#ffcc33', '#e6d81b',
                    '#ccff00', '#99ff00', '#66ff00', '#33ff33', '#00ff66', '#00ff99'
                ],
                foreground: [
                    '#ffffff', '#ffffff', '#ffffff', '#000000', '#000000', '#000000',
                    '#000000', '#000000', '#000000', '#000000', '#000000', '#000000'
                ],
                text: '#ffffff'
            },
            // Palette 2 - Cool blues and purples
            {
                name: 'Cool',
                background: ['#001a4d', '#003366', '#004d80', '#0066b3', '#0080e6', '#1a94ff', '#4da6ff', '#80c3ff', '#b3d9ff', '#cce6ff', '#e6f2ff', '#f2f8ff'],
                foreground: ['#ffffff', '#ffffff', '#ffffff', '#ffffff', '#ffffff', '#000000', '#000000', '#000000', '#000000', '#000000', '#000000', '#000000'],
                text: '#ffffff'
            },
            // Palette 3 - Warm oranges and reds
            {
                name: 'Warm',
                background: ['#4d0000', '#800000', '#b30000', '#e60000', '#ff1a1a', '#ff4d4d', '#ff8080', '#ffb3b3', '#ffd9d9', '#ffe6e6', '#fff2f2', '#fff9f9'],
                foreground: ['#ffffff', '#ffffff', '#ffffff', '#ffffff', '#ffffff', '#000000', '#000000', '#000000', '#000000', '#000000', '#000000', '#000000'],
                text: '#ffffff'
            },
            // Palette 4 - High contrast B&W
            {
                name: 'B&W',
                background: ['#000000', '#1a1a1a', '#333333', '#4d4d4d', '#666666', '#808080', '#999999', '#b3b3b3', '#cccccc', '#e6e6e6', '#f2f2f2', '#ffffff'],
                foreground: ['#ffffff', '#ffffff', '#ffffff', '#ffffff', '#ffffff', '#000000', '#000000', '#000000', '#000000', '#000000', '#000000', '#000000'],
                text: '#ffffff'
            }
        ];
    }

    getCurrentPalette() {
        return this.palettes[this.paletteIndex % this.palettes.length];
    }

    getBackgroundColor(noteSymbol, isPressed = false) {
        const palette = this.getCurrentPalette();
        const index = noteSymbol % palette.background.length;
        const baseColor = palette.background[index];
        
        if (isPressed) {
            return this.brighten(baseColor, 0.2);
        }
        return baseColor;
    }

    getForegroundColor(noteSymbol) {
        const palette = this.getCurrentPalette();
        const index = noteSymbol % palette.foreground.length;
        return palette.foreground[index];
    }

    brighten(color, percent) {
        const num = parseInt(color.replace('#', ''), 16);
        const r = Math.min(255, (num >> 16) + Math.round(255 * percent));
        const g = Math.min(255, ((num >> 8) & 0x00FF) + Math.round(255 * percent));
        const b = Math.min(255, (num & 0x0000FF) + Math.round(255 * percent));
        return '#' + (0x1000000 + (r << 16) + (g << 8) + b).toString(16).substring(1);
    }

    setPalette(index) {
        this.paletteIndex = Math.max(0, Math.min(index, this.palettes.length - 1));
    }
}

if (typeof module !== 'undefined' && module.exports) {
    module.exports = ColorPalette;
}
