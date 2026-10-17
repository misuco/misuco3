// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls
import misuco3

Item {
    id: root

    required property MasterSender sender

    property double rasterWidth: 50
    property double elementSpace: 10
    property double elementRadius: 5
    property bool portrait: false
    property string fontFamily
    property double fontPixelSize: 10

    property var bgColors: []
    property var bgColorsActive: []
    property var fgColors: []

    readonly property double contentWidth: width - 2*elementSpace
    readonly property double elementWidth: contentWidth/12 - elementSpace

    ControlArea {
        width: root.width
        height: root.height
        fontFamily: root.fontFamily
        fontPixelSize: root.fontPixelSize

        elementRadius: root.elementRadius

        text: "Tuning"

        Column {
            y: 2*root.elementSpace
            padding: root.elementSpace
            spacing: root.elementSpace

            ComboBox {
                width: root.contentWidth
                height: root.rasterWidth
                model: ["Equal", "Pure", "Well-tempered", "Custom"]
            }

            Row {
                id: tuningRow

                height: root.height - root.rasterWidth - 5*root.elementSpace
                spacing: root.elementSpace

                Repeater {
                    model: 12
                    delegate: ControlTuning {
                        id: control
                        required property int index
                        controller: root
                        sender: root.sender
                        width: root.elementWidth
                        height: tuningRow.height
                        noteIndex: control.index
                        bgColor: root.bgColors[control.index]
                        fgColor: root.fgColors[control.index]
                    }
                }
            }
        }
    }
}
