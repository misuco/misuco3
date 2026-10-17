// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls
import "./"

Parameters_FilterForm {
    id: root

    required property XYAssignableParameter modAssign

    Connections {
        target: root.filterCutoffSlider
        function onValueChanged() {
            root.modAssign.setBaseValue(74,root.filterCutoffSlider.value)
            console.log("set_filter_cutoff " + root.filterCutoffSlider.value)
        }
    }

    Connections {
        target: root.filterResonanceSlider
        function onValueChanged() {
            root.modAssign.setBaseValue(71,root.filterResonanceSlider.value)
            console.log("set_filter_resonance " + root.filterResonanceSlider.value)
        }
    }
}
