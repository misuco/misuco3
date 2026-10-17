// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls
import misuco3

Parameters_Osc_1Form {
    id: root
    required property MobileSynth synthesizer

    Connections {
        target: root.levelSlider
        function onValueChanged() {
            root.synthesizer.set_osc1_level(root.levelSlider.value)
            console.log("set_osc1_level " + root.levelSlider.value)
        }
    }

    Connections {
        target: root.wave0Button
        function onPressed() {
            root.synthesizer.set_osc1_wave_type(0)
            root.wave=0
        }
    }

    Connections {
        target: root.wave1Button
        function onPressed() {
            root.synthesizer.set_osc1_wave_type(1)
            root.wave=1
        }
    }

    Connections {
        target: root.wave2Button
        function onPressed() {
            root.synthesizer.set_osc1_wave_type(2)
            root.wave=2
        }
    }

    Connections {
        target: root.wave3Button
        function onPressed() {
            root.synthesizer.set_osc1_wave_type(3)
            root.wave=3
        }
    }

    Connections {
        target: root.wave4Button
        function onPressed() {
            root.synthesizer.set_osc1_wave_type(4)
            root.wave=4
        }
    }

    Connections {
        target: root.octave0Button
        function onPressed() {
            root.synthesizer.set_osc1_octave(0)
            root.octave=0
        }
    }

    Connections {
        target: root.octave1Button
        function onPressed() {
            root.synthesizer.set_osc1_octave(1)
            root.octave=1
        }
    }

    Connections {
        target: root.octave2Button
        function onPressed() {
            root.synthesizer.set_osc1_octave(2)
            root.octave=2
        }
    }

    Connections {
        target: root.octave3Button
        function onPressed() {
            root.synthesizer.set_osc1_octave(3)
            root.octave=3
        }
    }

    Connections {
        target: root.octave4Button
        function onPressed() {
            root.synthesizer.set_osc1_octave(4)
            root.octave=4
        }
    }
}
