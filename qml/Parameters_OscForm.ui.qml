// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Item {
    id: root
    property int wave
    property int octave
    
    property alias levelSlider: levelSlider
    property alias wave0Button: wave0Button
    property alias wave1Button: wave1Button
    property alias wave2Button: wave2Button
    property alias wave3Button: wave3Button
    property alias wave4Button: wave4Button
    property alias octave0Button: octave0Button
    property alias octave1Button: octave1Button
    property alias octave2Button: octave2Button
    property alias octave3Button: octave3Button
    property alias octave4Button: octave4Button

    ControlArea {
        x:10
        y:10
        height: 170
        text: "OSC1"

        ControlSlider {
            id: levelSlider
            x:10
            y:10
            text: "Level"
            from: 0
            to: 1
            value: 0.5
        }

        ControlButton {
            id: wave0Button
            x:10
            y:60
            text: "Wave 0"
            selected: root.wave===0
        }

        ControlButton {
            id: wave1Button
            x:70
            y:60
            text: "Wave 1"
            selected: root.wave===1
        }

        ControlButton {
            id: wave2Button
            x:130
            y:60
            text: "Wave 2"
            selected: root.wave===2
        }

        ControlButton {
            id: wave3Button
            x:190
            y:60
            text: "Wave 3"
            selected: root.wave===3
        }

        ControlButton {
            id: wave4Button
            x:250
            y:60
            text: "Wave 4"
            selected: root.wave===4
        }

        ControlButton {
            id: octave0Button
            x:10
            y:120
            text: "0"
            selected: root.octave===0
        }

        ControlButton {
            id: octave1Button
            x:70
            y:120
            text: "1"
            selected: root.octave===1
        }

        ControlButton {
            id: octave2Button
            x:130
            y:120
            text: "2"
            selected: root.octave===2
        }

        ControlButton {
            id: octave3Button
            x:190
            y:120
            text: "3"
            selected: root.octave===3
        }

        ControlButton {
            id: octave4Button
            x:250
            y:120
            text: "4"
            selected: root.octave===4
        }
    }
}
