// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Parameters_Osc_2Form {
    id: root

    Connections {
        target: root.levelSlider
        function onValueChanged() {
            root.synthesizer.set_osc2_level(root.levelSlider.value)
            console.log("set_osc2_level " + root.levelSlider.value)
        }
    }

    Connections {
        target: root.waveSlider
        function onValueChanged() {
            root.synthesizer.set_osc2_wave_type(root.waveSlider.value)
            console.log("set_osc2_wave_type " + root.waveSlider.value)
        }
    }

    Connections {
        target: root.octaveSlider
        function onValueChanged() {
            root.synthesizer.set_osc2_octave(root.octaveSlider.value)
            console.log("set_osc2_octave " + root.octaveSlider.value)
        }
    }

    Connections {
        target: root.shiftSlider
        function onValueChanged() {
            root.synthesizer.set_osc2_shift(root.shiftSlider.value)
            console.log("set_osc2_shift " + root.shiftSlider.value)
        }
    }
}
