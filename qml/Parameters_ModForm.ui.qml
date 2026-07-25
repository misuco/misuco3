// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12

Item {
    id: root
    required property var synthesizer
    property int source
    property int destination
    
    property alias amountSlider: amountSlider
    property alias freqSlider: freqSlider
    property alias sourceSquareButton: sourceSquareButton
    property alias sourceTriButton: sourceTriButton
    property alias sourceSawButton: sourceSawButton
    property alias sourceRevsawButton: sourceRevsawButton
    property alias destWaveButton: destWaveButton
    property alias destPitchButton: destPitchButton
    property alias destFilterButton: destFilterButton

    ControlArea {
        x:10
        y:10
        height: 240
        text: "MOD"

        ControlSlider {
            id: amountSlider
            x:10
            y:10
            text: "Amount"
            from: 0
            to: 1
            value: 0.5
        }

        ControlSlider {
            id: freqSlider
            x:10
            y:60
            text: "Freq"
            from: 0
            to: 20
            value: 2
        }

        ControlButton {
            id: sourceSquareButton
            x:10
            y:120
            text: "SQUARE"
            selected: root.source===0
        }

        ControlButton {
            id: sourceTriButton
            x:70
            y:120
            text: "TRI"
            selected: root.source===1
        }

        ControlButton {
            id: sourceSawButton
            x:130
            y:120
            text: "SAW"
            selected: root.source===2
        }

        ControlButton {
            id: sourceRevsawButton
            x:190
            y:120
            text: "REVSAW"
            selected: root.source===3
        }

        ControlButton {
            id: destWaveButton
            x:10
            y:180
            text: "WAVE"
            selected: root.destination===0
        }

        ControlButton {
            id: destPitchButton
            x:70
            y:180
            text: "PITCH"
            selected: root.destination===1
        }

        ControlButton {
            id: destFilterButton
            x:130
            y:180
            text: "FILTER"
            selected: root.destination===2
        }
    }
}
