# MISUCO3

**Microtonal Surface Controller** — a touch instrument for phones, tablets and desktops.

[![Android Build](https://github.com/misuco/misuco3/actions/workflows/qt68_android.yml/badge.svg)](https://github.com/misuco/misuco3/actions/workflows/qt68_android.yml)

MISUCO3 turns the screen into a playing surface. You choose a scale, a root note and
an octave range, and the surface shows exactly those notes as keys. Every note of the
scale can be tuned in cents, so the instrument is not tied to equal temperament.
Sliding a finger across a key modulates the sound.

It is the successor of [misuco2](https://github.com/misuco/misuco2), rewritten for Qt 6 and QML.

## Features

- **Play area**: multi-touch keys for the notes of the selected scale, with hold mode.
- **Scales and range**: any combination of the twelve scale steps, root note, lowest and highest octave.
- **Microtuning**: every note can be detuned individually.
- **X/Y modulation**: assign the horizontal and vertical finger position on a key to a sound parameter.
- **Built-in synthesizer**: 16 voices, two oscillators (sine, triangle, saw, reverse saw, square),
  filter with cutoff and resonance, volume and filter envelopes, modulation and arpeggiator.
- **SoundFont player**: plays the presets of SoundFont 2 (`.sf2`) files in the same tuning as the
  synthesizer. A small soundfont is included, others can be loaded from a file.
- **Presets**: factory sounds and your own, stored on the device.
- **OSC output**: notes, pitch and controllers are also sent as OSC messages to the local network
  (UDP port 3150), to play other instruments.
- **Audio settings**: output device, buffer size and a level meter with clip indicator.

## Getting the source

The sound engines are git submodules:

```sh
git clone https://github.com/misuco/misuco3.git
cd misuco3
git submodule update --init
git -C fluidsynth submodule update --init gcem
```

## Building

You need Qt 6.10 or newer with the Multimedia module, CMake 3.16 or newer and a C++17 compiler.
There are no other dependencies: FluidSynth is built from the submodule as a static library.

### Desktop

```sh
cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/path/to/Qt/6.x.y/gcc_64
cmake --build build
./build/MISUCO3
```

### Android

Use the tool versions that belong to your Qt version, see
[Qt for Android prerequisites](https://doc.qt.io/qt-6/android-configure-dev-environment.html).
`android/build.gradle` is the template of Qt 6.11, which needs JDK 21, NDK 27.2.12479018,
SDK platform `android-36` and build-tools 36.0.0.

```sh
/path/to/Qt/6.11.3/android_arm64_v8a/bin/qt-cmake -S . -B build-android -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DQT_HOST_PATH=/path/to/Qt/6.11.3/gcc_64 \
    -DANDROID_SDK_ROOT=/path/to/android/sdk \
    -DANDROID_NDK_ROOT=/path/to/android/sdk/ndk/27.2.12479018
cmake --build build-android --target apk
```

The result is an unsigned release APK in `build-android/android-build/build/outputs/apk/release/`.

Every push to `main` is built by the
[Android Build](https://github.com/misuco/misuco3/actions/workflows/qt68_android.yml) workflow.
Its artifact is an APK signed with a key made for that run only: it can be installed for
testing, but not updated over a build of another run.

## Repository layout

| Path | Content |
|---|---|
| `main.cpp`, `src/` | Application start, preset store |
| `qml/` | User interface |
| `misulib/` | Senders that pass notes and controllers on to the sound engines and to OSC (submodule) |
| `polymobilesynth/` | The built-in synthesizer and the audio output (submodule) |
| `polysoundfont/` | SoundFont player, a Qt wrapper around FluidSynth |
| `fluidsynth/` | FluidSynth (submodule) |
| `android/` | Android manifest, Gradle file and resources |
| `docs/` | Notes on the frequency formula and the MIDI controller numbers |

## Credits

- The built-in synthesizer is based on [mobilesynth](https://github.com/allenporter/mobilesynth) by Allen Porter.
- The SoundFont player uses [FluidSynth](https://www.fluidsynth.org/) (LGPL-2.1).
- The included soundfont is *Vintage Dreams Waves v2* by Ian Wilson, see `fluidsynth/sf2/COPYRIGHT.txt`.
- The font is *Alpha Prota*, see `qml/fonts/alpha-prota/License.txt`.
- Built with [Qt](https://www.qt.io/).

## License

MISUCO3 is free software, published under the [GNU General Public License v3](LICENSE).

Copyright (C) 2009-2026 c1audio.com / Claudio Zopfi
