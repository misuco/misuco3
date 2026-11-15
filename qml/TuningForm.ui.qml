// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls
import misuco3

Item {
    id: root

    required property MasterSender sender

    property alias storeSelect: storeSelect
    property alias tuningRepeater: tuningRepeater

    // the names of the built in tunings and the tunings of the user
    property var tuningNames: []
    property int builtInCount: 0
    // the faders have been moved, the tuning is not one of the list
    property bool edited: false

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

            StoreSelect {
                id: storeSelect
                // the row ends with the last fader
                width: root.contentWidth - root.elementSpace
                height: root.rasterWidth
                spacing: root.elementSpace
                names: root.tuningNames
                builtInCount: root.builtInCount
                edited: root.edited
                what: "tuning"
                buttonWidth: 1.5*root.rasterWidth
                fontFamily: root.fontFamily
                fontPixelSize: root.fontPixelSize
            }

            Row {
                id: tuningRow

                height: root.height - root.rasterWidth - 5*root.elementSpace
                spacing: root.elementSpace

                Repeater {
                    id: tuningRepeater
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
