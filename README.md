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
- **MIDI over ethernet**: notes are sent as RTP-MIDI (AppleMIDI) to a Mac, Windows or Linux computer
  in the local network, see [MIDI over ethernet](#midi-over-ethernet).
- **Audio settings**: output device, buffer size and a level meter with clip indicator.

## MIDI over ethernet

MISUCO3 can play other instruments over the local network (ethernet or Wi-Fi). It sends the
notes as RTP-MIDI, also known as AppleMIDI or network MIDI. macOS and iOS have a receiver built
in, Windows and Linux need a small extra program. No cable and no MIDI interface is needed,
both devices only have to be in the same network.

### In the app

The fifth layout holds the network MIDI settings:

- **on**: starts and stops the session. The title line shows the state, the name of the
  other side and the measured latency.
- **connect to**: MISUCO3 connects to a session of the receiver. Press **search** to list the
  sessions found in the network and select one, or type the address into **Host** and **Port**.
- **wait for**: MISUCO3 opens its own session on **Port**, announces it under **Name** and
  waits. The receiver then finds MISUCO3 in its directory and connects.
- **CH**: the MIDI channel of the notes, 1 to 16.

A session uses two UDP ports: the given one (5004 by default) and the next one.

Microtuning is sent as pitch bend, so the receiving instrument must have a pitch bend range of
**2 semitones**, which is the default of most instruments. Pitch bend applies to the whole MIDI
channel: notes with different detuning that sound at the same time share the bend of the latest one.

### macOS

The receiver is part of the system.

1. Open **Audio MIDI Setup** (in Applications / Utilities).
2. Choose **Window > Show MIDI Studio** and click the network icon (the globe) in the toolbar.
   The **MIDI Network Setup** window opens.
3. Under **My Sessions** press **+** and tick the checkbox of the new session.
4. Set **Who may connect to me** to **Anyone**.
5. Now either
   - press **on** in MISUCO3 in *connect to* mode, after a search or with the address of the Mac
     and the port shown in the window, or
   - press **on** in MISUCO3 in *wait for* mode, select MISUCO3 in the **Directory** list of the
     Mac and press **Connect**.

MISUCO3 then shows up in the **Participants** list. In the music software on the Mac the session
is a MIDI input with the name of the session, by default *Network Session 1*.

### Windows

Windows has no network MIDI receiver built in. The free
[rtpMIDI](https://www.tobias-erichsen.de/software/rtpmidi.html) driver by Tobias Erichsen works
like the macOS one.

1. Install rtpMIDI. It needs Apple's Bonjour service to find and announce sessions, the
   installer tells you if it is missing.
2. Start rtpMIDI, press **+** under **My Sessions** and tick **Enabled**.
3. Set **Who may connect to me** to **Anyone**.
4. Connect as on macOS: from MISUCO3 in *connect to* mode, or with *wait for* mode and
   **Connect** in the **Directory** list of rtpMIDI.

The session is a MIDI input port with the name of the session in every Windows music software.
If nothing connects, allow rtpMIDI in the Windows firewall for private networks (UDP).

### Linux

[rtpmidid](https://github.com/davidmoreno/rtpmidid) is a daemon that connects RTP-MIDI to the
ALSA sequencer. It uses Avahi to find and announce sessions.

1. Install it, on Debian and Ubuntu with `sudo apt install rtpmidid`. For other distributions
   see the project page.
2. Start it: `sudo systemctl enable --now rtpmidid`. It listens on port 5004 and announces
   itself with the name of the computer.
3. *connect to* mode: press **search** and **on** in MISUCO3. The session appears as a port of
   the ALSA client `rtpmidid`.
4. *wait for* mode: press **on** in MISUCO3. rtpmidid finds MISUCO3 and adds a port with its
   name. The network connection is made when the port is connected to an instrument.
5. Connect the port to your instrument with `aconnect`, or with a patchbay like `qpwgraph`
   or `qjackctl`:

   ```sh
   aconnect -l                        # list the ports
   aconnect rtpmidid:MISUCO3 FLUID    # connect by client and port name
   ```

If a firewall is active, open the UDP ports 5004 and 5005 for the session and 5353 for the search.

## Getting the source

The sound engines are git submodules:

```sh
git clone https://github.com/misuco/misuco3.git
cd misuco3
git submodule update --init
git -C fluidsynth submodule update --init gcem
```

## Building

You need Qt 6.10 or newer with the Multimedia and Network modules, CMake 3.16 or newer and a C++17 compiler.
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
It has two artifacts: an APK signed with a key made for that run only, which can be
installed for testing but not updated over a build of another run, and an unsigned app
bundle (AAB) to be signed with the upload key for the play store.

## Repository layout

| Path | Content |
|---|---|
| `main.cpp`, `src/` | Application start, preset store |
| `qml/` | User interface |
| `misulib/` | Senders that pass notes and controllers on to the sound engines, to OSC and to network MIDI (submodule) |
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
