// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Item {
    id: root

    property alias arpeggioSamplesSlider: arpeggioSamplesSlider
    property alias arpeggioOctavesSlider: arpeggioOctavesSlider
    property alias arpeggioStepSlider: arpeggioStepSlider
    property alias filterCutoffSlider: filterCutoffSlider
    property alias filterResonanceSlider: filterResonanceSlider

    ControlArea {
        x:10
        y:10
        height: 180
        text: "Arpeggio"

        ControlSlider {
            id: arpeggioSamplesSlider
            x:10
            y:10
            text: "Samples"
            from: 1000
            to: 200000
            value: 48000
        }

        ControlSlider {
            id: arpeggioOctavesSlider
            x:10
            y:70
            text: "Octaves"
            from: 1
            to: 5
            value: 2
        }

        ControlSlider {
            id: arpeggioStepSlider
            x:10
            y:120
            text: "Step"
            from: 0
            to: 4
            value: 1
        }
    }

    ControlArea {
        x:10
        y:210
        height: 120
        text: "Filter"

        ControlSlider {
            id: filterCutoffSlider
            x:10
            y:10
            text: "Cutoff"
            from: 1
            to: 1000
            value: 1
        }

        ControlSlider {
            id: filterResonanceSlider
            x:10
            y:60
            text: "Resonance"
            from: 0.0
            to: 1.0
            value: 0.1
        }
    }

}
