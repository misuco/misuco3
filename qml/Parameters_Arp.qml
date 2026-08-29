// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls
import misuco3
import "./"

Parameters_ArpForm {
    id: root

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
}
