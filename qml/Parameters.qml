// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls
import misuco3
import "./"

ParametersForm {
    id: root

    required property XYModAssign modAssign
    property MobileSynth synthesizer

    Connections {
        target: root.arpeggioSamplesSlider
        function onValueChanged() {
            root.synthesizer.set_arpeggio_samples(root.arpeggioSamplesSlider.value)
            console.log("set_arpeggio_samples " + root.arpeggioSamplesSlider.value)
        }
    }

    Connections {
        target: root.arpeggioOctavesSlider
        function onValueChanged() {
            root.synthesizer.set_arpeggio_octaves(root.arpeggioOctavesSlider.value)
            console.log("set_arpeggio_octaves " + root.arpeggioOctavesSlider.value)
        }
    }

    Connections {
        target: root.arpeggioStepSlider
        function onValueChanged() {
            root.synthesizer.set_arpeggio_step(root.arpeggioStepSlider.value)
            console.log("set_arpeggio_step " + root.arpeggioStepSlider.value)
        }
    }

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
