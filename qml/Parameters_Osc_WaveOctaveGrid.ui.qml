// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Grid {
    id: root

    property int wave
    property int octave

    property double elementSpace: 5
    property bool portrait: false
    property double buttonSize

    property color bgColor: "Gray"
    property color bgColorActive: "Orange"
    property color fgColor: "Black"

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

    rows: 2
    columns: root.portrait ? 6 : 12
    spacing: root.elementSpace

    ControlButton {
        id: wave0Button
        width: root.buttonSize
        height: root.buttonSize
        bgColor: selected ? root.bgColorActive : root.bgColor
        fgColor: root.fgColor
        text: ""
        icon {
            width: parent.width
            height: parent.height
            color: root.fgColor
            source: "qrc:/qt/qml/misuco3/qml/icons/wave-sine.svg"
        }
        antialiasing: true
        selected: root.wave===0
    }

    ControlButton {
        id: wave1Button
        width: root.buttonSize
        height: root.buttonSize
        bgColor: selected ? root.bgColorActive : root.bgColor
        fgColor: root.fgColor
        text: ""
        icon {
            width: parent.width
            height: parent.height
            color: root.fgColor
            source: "qrc:/qt/qml/misuco3/qml/icons/wave-square.svg"
        }
        antialiasing: true
        selected: root.wave===1
    }

    ControlButton {
        id: wave2Button
        width: root.buttonSize
        height: root.buttonSize
        bgColor: selected ? root.bgColorActive : root.bgColor
        fgColor: root.fgColor
        text: ""
        icon {
            width: parent.width
            height: parent.height
            color: root.fgColor
            source: "qrc:/qt/qml/misuco3/qml/icons/wave-tri.svg"
        }
        antialiasing: true
        selected: root.wave===2
    }

    ControlButton {
        id: wave3Button
        width: root.buttonSize
        height: root.buttonSize
        bgColor: selected ? root.bgColorActive : root.bgColor
        fgColor: root.fgColor
        text: ""
        icon {
            width: parent.width
            height: parent.height
            color: root.fgColor
            source: "qrc:/qt/qml/misuco3/qml/icons/wave-saw.svg"
        }
        antialiasing: true
        selected: root.wave===3
    }

    ControlButton {
        id: wave4Button
        width: root.buttonSize
        height: root.buttonSize
        bgColor: selected ? root.bgColorActive : root.bgColor
        fgColor: root.fgColor
        text: ""
        icon {
            width: parent.width
            height: parent.height
            color: root.fgColor
            source: "qrc:/qt/qml/misuco3/qml/icons/wave-saw-rev.svg"
        }
        antialiasing: true
        selected: root.wave===4
    }

    Item {
        id: spacer
        width: root.buttonSize
        height: root.buttonSize
    }

    ControlButton {
        id: octave0Button
        width: root.buttonSize
        height: root.buttonSize
        bgColor: selected ? root.bgColorActive : root.bgColor
        fgColor: root.fgColor
        text: "0"
        font.pixelSize: height * 0.8
        selected: root.octave===0
    }

    ControlButton {
        id: octave1Button
        width: root.buttonSize
        height: root.buttonSize
        bgColor: selected ? root.bgColorActive : root.bgColor
        fgColor: root.fgColor
        text: "1"
        font.pixelSize: height * 0.8
        selected: root.octave===1
    }

    ControlButton {
        id: octave2Button
        width: root.buttonSize
        height: root.buttonSize
        bgColor: selected ? root.bgColorActive : root.bgColor
        fgColor: root.fgColor
        text: "2"
        font.pixelSize: height * 0.8
        selected: root.octave===2
    }

    ControlButton {
        id: octave3Button
        width: root.buttonSize
        height: root.buttonSize
        bgColor: selected ? root.bgColorActive : root.bgColor
        fgColor: root.fgColor
        text: "3"
        font.pixelSize: height * 0.8
        selected: root.octave===3
    }

    ControlButton {
        id: octave4Button
        width: root.buttonSize
        height: root.buttonSize
        bgColor: selected ? root.bgColorActive : root.bgColor
        fgColor: root.fgColor
        text: "4"
        font.pixelSize: height * 0.8
        selected: root.octave===4
    }
}
