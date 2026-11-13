// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls
import misuco3

Parameters_FilterEnvelopeForm {
    id: root
    required property MobileSynth synthesizer

    Connections {
        target: root.attackSlider
        function onValueChanged() {
            root.synthesizer.set_filter_attack(Math.round(root.attackSlider.value))
            console.log("set_filter_attack " + root.attackSlider.value)
        }
    }

    Connections {
        target: root.decaySlider
        function onValueChanged() {
            root.synthesizer.set_filter_decay(Math.round(root.decaySlider.value))
            console.log("set_filter_decay " + root.decaySlider.value)
        }
    }

    Connections {
        target: root.sustainSlider
        function onValueChanged() {
            root.synthesizer.set_filter_sustain(root.sustainSlider.value)
            console.log("set_filter_sustain " + root.sustainSlider.value)
        }
    }

    Connections {
        target: root.releaseSlider
        function onValueChanged() {
            root.synthesizer.set_filter_release(Math.round(root.releaseSlider.value))
            console.log("set_filter_release " + root.releaseSlider.value)
        }
    }
}
