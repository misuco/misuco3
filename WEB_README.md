# MISUCO3 Web Version
## Microtonal Surface Controller - HTML5/JavaScript Edition

A complete browser-based translation of the MISUCO3 microtonal synthesizer from QML/C++ to HTML5/JavaScript using the Web Audio API.

---

## 🎵 Features

### Core Synthesis
- **Polyphonic Synthesis**: Up to 16 simultaneous voices (configurable)
- **Multiple Waveforms**: Sine, Square, Sawtooth, Triangle
- **Dynamic Filtering**: Low-pass, High-pass, Band-pass filters with resonance control
- **ADSR Envelope**: Configurable Attack and Release times
- **Pitch Bend**: Vertical touch movement for real-time pitch modulation
- **Portamento**: Smooth pitch gliding between notes

### Microtonal Capabilities
- **Chromatic Scale** (12-tone equal temperament)
- **Quarter-tone** (24-tone)
- **Sixth-tone** (18-tone)
- **Third-tone** (36-tone)
- **Custom Scales**: Configure any scale size and tuning system
- **Per-Note Tuning**: Independent tuning offset for each note class in cents

### Touch & Input
- **Multi-touch Support**: Up to 10 simultaneous touches
- **Touch Indicators**: Real-time visual feedback for active touch points
- **Mouse Support**: Desktop testing with mouse input
- **Hold Mode**: Lock notes to sustain without continuous touch
- **Arpeggiator**: Optional arpeggio mode for rhythmic patterns

### Performance Monitoring
- **Peak Level Meter**: Real-time audio level visualization
- **Clipping Detection**: Visual alert when audio clips
- **Voice Counter**: Monitor active voice count

---

## 🚀 Getting Started

### Prerequisites
- Modern web browser with Web Audio API support:
  - Chrome/Chromium 50+
  - Firefox 57+
  - Safari 14.1+
  - Edge 79+

### Running Locally

1. **Clone or download the repository**
   ```bash
   git clone https://github.com/misuco/misuco3.git
   cd misuco3
   git checkout web-html5-version
   ```

2. **Start a local web server**
   ```bash
   # Using Python 3
   python -m http.server 8000
   
   # Using Python 2
   python -m SimpleHTTPServer 8000
   
   # Using Node.js (http-server)
   npx http-server
   ```

3. **Open in browser**
   ```
   http://localhost:8000
   ```

### Online Demo
(Deploy to GitHub Pages, Netlify, or similar)

---

## 🎮 Usage Guide

### Basic Operation

1. **Click "Start Audio"** in the Audio tab to enable Web Audio
2. **Touch/Click the Play Area** to play notes
3. **Move vertically** to bend pitch up or down
4. **Use the Tabs** to access different controls

### Control Tabs

#### Audio Device
- **Start Audio**: Initialize/resume audio playback
- **Sample Rate**: Display current sample rate
- **Buffer Size**: Display current buffer configuration

#### Scale Configuration
- **Preset Selection**: Choose from predefined microtonal scales
- **Scale Size**: Number of keys to display
- **Start Note**: MIDI note number for the lowest key
- **Scale Editor**: Visual display of current scale notes

#### Tuning System
- **Per-Note Tuning**: Adjust tuning offset (in cents) for each of the 12 note classes
- Real-time updates to playing notes

#### Parameters
- **Polyphony**: Maximum simultaneous voices (1-64)
- **Portamento Time**: Pitch glide speed (0-1 second)

#### Oscillator
- **Oscillator Type**: Waveform selection (Sine, Square, Sawtooth, Triangle)
- **Detune**: Fine-tune oscillator frequency in cents

#### Modulation
- **Filter Type**: Low-pass, High-pass, or Band-pass
- **Cutoff Frequency**: Filter frequency (20 Hz - 20 kHz)
- **Resonance (Q)**: Filter peak emphasis (0-30)
- **Attack Time**: Envelope attack phase (0-2s)
- **Release Time**: Envelope release phase (0-2s)

### Top Controls

- **Hold Switch**: Enable/disable note hold mode
- **Arp Switch**: Enable/disable arpeggiator
- **Peak Level Meter**: Green bar showing current audio level
- **Clip Indicator**: Red box appears when audio clips
- **Master Gain**: Overall output volume

---

## 📁 File Structure

```
web-html5-version/
├── index.html              # Main HTML document
├── styles.css              # Complete styling and layout
├── js/
│   ├── app.js             # Main application controller
│   ├── synth-engine.js    # Web Audio API synthesizer
│   ├── touch-handler.js   # Multi-touch input management
│   ├── ui-controller.js   # UI event handling
│   └── color-palette.js   # Color themes
└── WEB_README.md          # This file
```

---

## 🔧 Architecture

### SynthesizerEngine
- Manages polyphonic voice allocation
- Controls oscillators, filters, and envelopes
- Monitors audio output for clipping and peak levels
- Handles parameter updates in real-time

### SynthVoice
- Individual voice with oscillator, filter, and envelope
- Supports frequency modulation and portamento
- Independent parameter control

### TouchHandler
- Manages multi-touch input from canvas
- Maps touch positions to musical keys
- Tracks vertical movement for pitch bending
- Provides visual feedback

### PlayArea
- Maintains the current scale configuration
- Calculates frequencies based on note numbers and tuning
- Manages visual representation of keys

### UIController
- Handles all UI events and parameter changes
- Manages tab switching and panel visibility
- Updates display values in real-time

### ColorPalette
- Provides multiple color schemes (Dark, Colorful, Cool, Warm, B&W)
- Generates colors for individual notes based on note class
- Supports pressed/unpressed state visualization

---

## 🎛️ Frequency Calculation

The microtonal frequency calculation uses the formula:

```
f = 6.875 × 2^((note + 3 × 100 + tuning_offset) / 1200)
```

Where:
- `note`: MIDI note number (0-127)
- `tuning_offset`: Per-note tuning adjustment in cents (-100 to +100)
- Base frequency of A0 ≈ 27.5 Hz
- Equal temperament: 1 octave = 1200 cents

---

## ⚙️ Configuration

### Adjusting Parameters

All synthesizer parameters can be modified through the UI. Key parameters:

| Parameter | Range | Unit | Default |
|-----------|-------|------|---------|
| Polyphony | 1-64 | voices | 16 |
| Portamento | 0-1 | seconds | 0 |
| Filter Cutoff | 20-20000 | Hz | 10000 |
| Filter Q | 0-30 | resonance | 1 |
| Attack | 0-2 | seconds | 0.01 |
| Release | 0-2 | seconds | 0.3 |
| Master Gain | 0-1 | linear | 0.7 |

### Browser Compatibility

| Feature | Chrome | Firefox | Safari | Edge |
|---------|--------|---------|--------|------|
| Web Audio API | ✓ | ✓ | ✓ | ✓ |
| Touch Events | ✓ | ✓ | ✓ | ✓ |
| Canvas 2D | ✓ | ✓ | ✓ | ✓ |
| CSS Grid | ✓ | ✓ | ✓ | ✓ |

---

## 🎯 Performance Considerations

### Optimization Tips
1. **Reduce Polyphony** if experiencing audio dropouts on lower-end devices
2. **Use Simpler Waveforms** (Sine) for lower CPU usage
3. **Disable Visual Indicators** if rendering is slow
4. **Close Other Applications** to free system resources

### Audio Quality
- **Sample Rate**: Typically 48 kHz or 44.1 kHz (browser-dependent)
- **Bit Depth**: 32-bit floating-point (Web Audio standard)
- **Latency**: 20-100ms depending on browser and device

---

## 🔊 Audio Output

The Web Audio API processes audio through a single output chain:

```
Oscillator → Filter → Gain Envelope → Master Gain → System Output
```

Audio is processed in real-time using the browser's audio worklet/script processor.

---

## 🐛 Troubleshooting

### No Sound
1. Check browser console for errors (F12 → Console)
2. Click "Start Audio" button
3. Verify system volume is not muted
4. Try a different browser

### Audio Crackles/Clicks
1. Reduce polyphony count
2. Increase buffer size (if available)
3. Close other applications
4. Reduce master gain

### Touch Not Working
1. Verify touch device support
2. Check browser permissions
3. Try mouse input as fallback
4. Clear browser cache

### UI Not Responsive
1. Hard refresh browser (Ctrl+Shift+R / Cmd+Shift+R)
2. Check console for JavaScript errors
3. Ensure JavaScript is enabled
4. Try different browser

---

## 📝 Differences from QML/C++ Version

### Improvements
- ✅ No installation required - works in browser
- ✅ Cross-platform (Windows, macOS, Linux, mobile browsers)
- ✅ Real-time Web Audio synthesis
- ✅ Responsive touch interface
- ✅ No external dependencies needed

### Limitations
- ⚠️ Slightly higher latency than native application
- ⚠️ Audio quality depends on browser/system
- ⚠️ No MIDI hardware support (could be added via Web MIDI API)
- ⚠️ No audio file recording (could be added with MediaRecorder)

---

## 🚀 Future Enhancements

Potential additions:
- [ ] Web MIDI API support for hardware controllers
- [ ] Audio recording via MediaRecorder API
- [ ] Preset saving/loading with localStorage
- [ ] WAAPI AudioWorklet for lower-latency synthesis
- [ ] Visual spectrum analyzer
- [ ] LFO (Low Frequency Oscillator) modulation
- [ ] Additional oscillator types (wavetable, FM)
- [ ] Multi-touch gesture recognition
- [ ] Mobile-optimized layout
- [ ] Accessibility improvements (ARIA labels)

---

## 📄 License

GNU General Public License v3.0 (GPL-3.0)

See the main LICENSE file for details.

---

## 👤 Author

Claudio Zopfi <c1audio@x21.ch>
c1audio.com

---

## 🤝 Contributing

To contribute to the web version:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📞 Support

For issues, questions, or suggestions:
- Open a GitHub Issue
- Check existing discussions
- Review documentation in this README

---

**Enjoy making microtonal music in your browser! 🎼**
