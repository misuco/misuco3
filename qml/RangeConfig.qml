// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

RangeConfigForm {
    id: root

    signal baseNoteUpdated(int n)
    signal lowOctaveUpdated(int o)
    signal highOctaveUpdated(int o)

    function baseButtonPressed(caller) {
        console.log("pressed " + caller.text)
        root.baseNoteIndex=caller.index
        root.baseNoteUpdated(caller.index)
    }

    // Connect base note buttons
    Connections {
        target: root.baseButton_C
        function onPressed() { root.baseButtonPressed(root.baseButton_C) }
    }
    Connections {
        target: root.baseButton_Cs
        function onPressed() { root.baseButtonPressed(root.baseButton_Cs) }
    }
    Connections {
        target: root.baseButton_D
        function onPressed() { root.baseButtonPressed(root.baseButton_D) }
    }
    Connections {
        target: root.baseButton_Ds
        function onPressed() { root.baseButtonPressed(root.baseButton_Ds) }
    }
    Connections {
        target: root.baseButton_E
        function onPressed() { root.baseButtonPressed(root.baseButton_E) }
    }
    Connections {
        target: root.baseButton_F
        function onPressed() { root.baseButtonPressed(root.baseButton_F) }
    }
    Connections {
        target: root.baseButton_Fs
        function onPressed() { root.baseButtonPressed(root.baseButton_Fs) }
    }
    Connections {
        target: root.baseButton_G
        function onPressed() { root.baseButtonPressed(root.baseButton_G) }
    }
    Connections {
        target: root.baseButton_Gs
        function onPressed() { root.baseButtonPressed(root.baseButton_Gs) }
    }
    Connections {
        target: root.baseButton_A
        function onPressed() { root.baseButtonPressed(root.baseButton_A) }
    }
    Connections {
        target: root.baseButton_As
        function onPressed() { root.baseButtonPressed(root.baseButton_As) }
    }
    Connections {
        target: root.baseButton_B
        function onPressed() { root.baseButtonPressed(root.baseButton_B) }
    }
    
    // Connect octave range slider
    Connections {
        target: root.octaveRangeSlider.first
        function onValueChanged() {
            console.log("set_low_octave " + root.octaveRangeSlider.first.value)
            root.lowOctaveUpdated(root.octaveRangeSlider.first.value)
        }
    }
    Connections {
        target: root.octaveRangeSlider.second
        function onValueChanged() {
            console.log("set_high_octave " + root.octaveRangeSlider.second.value)
            root.highOctaveUpdated(root.octaveRangeSlider.second.value)
        }
    }
}
