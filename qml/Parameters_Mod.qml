// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Parameters_ModForm {
    id: root

    required property XYModAssign modAssign

    Connections {
        target: root.amountSlider
        function onValueChanged() {
            root.modAssign.setBaseValue(1,root.amountSlider.value)
            console.log("set_modulation_amount " + root.amountSlider.value)
        }
    }

    Connections {
        target: root.freqSlider
        function onValueChanged() {
            root.synthesizer.set_modulation_frequency(root.freqSlider.value)
            console.log("set_modulation_frequency " + root.freqSlider.value)
        }
    }

    Connections {
        target: root.sourceSquareButton
        function onPressed() {
            root.synthesizer.set_modulation_source(0)
            root.source=0
        }
    }

    Connections {
        target: root.sourceTriButton
        function onPressed() {
            root.synthesizer.set_modulation_source(1)
            root.source=1
        }
    }

    Connections {
        target: root.sourceSawButton
        function onPressed() {
            root.synthesizer.set_modulation_source(2)
            root.source=2
        }
    }

    Connections {
        target: root.sourceRevsawButton
        function onPressed() {
            root.synthesizer.set_modulation_source(3)
            root.source=3
        }
    }

    Connections {
        target: root.destWaveButton
        function onPressed() {
            root.synthesizer.set_modulation_destination(0)
            root.destination=0
        }
    }

    Connections {
        target: root.destPitchButton
        function onPressed() {
            root.synthesizer.set_modulation_destination(1)
            root.destination=1
        }
    }

    Connections {
        target: root.destFilterButton
        function onPressed() {
            root.synthesizer.set_modulation_destination(2)
            root.destination=2
        }
    }
}
