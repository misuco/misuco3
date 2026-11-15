// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls
import misuco3

Item {
    id: root

    required property MasterSender sender

    property alias tuningSelect: tuningSelect
    property alias nameField: nameField
    property alias saveButton: saveButton
    property alias deleteButton: deleteButton
    property alias tuningRepeater: tuningRepeater

    // the names of the built in tunings and the tunings of the user
    property var tuningNames: []
    // the faders have been moved, the tuning is not one of the list
    property bool edited: false
    // the name of a tuning is typed in
    property bool naming: false
    // the selected tuning is one of the user
    property bool userTuningSelected: false
    // the question that has to be answered with yes or no, empty if there is none
    property string confirmText: ""
    readonly property bool confirming: confirmText !== ""

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
    readonly property double buttonWidth: 1.5*rasterWidth
    // the row ends with the last fader
    readonly property double selectWidth: contentWidth - 2*buttonWidth - 3*elementSpace

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

            Row {
                height: root.rasterWidth
                spacing: root.elementSpace

                ComboBox {
                    id: tuningSelect
                    width: root.selectWidth
                    height: root.rasterWidth
                    visible: !root.naming && !root.confirming
                    model: root.tuningNames
                    displayText: root.edited ? "Custom (not saved)" : currentText
                    font.family: root.fontFamily
                    font.pixelSize: root.fontPixelSize
                }

                TextField {
                    id: nameField
                    width: root.selectWidth
                    height: root.rasterWidth
                    visible: root.naming && !root.confirming
                    placeholderText: "name of the tuning"
                    maximumLength: 40
                    font.family: root.fontFamily
                    font.pixelSize: root.fontPixelSize
                }

                Text {
                    width: root.selectWidth
                    height: root.rasterWidth
                    visible: root.confirming
                    text: root.confirmText
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                    color: "White"
                    font {
                        family: root.fontFamily
                        pixelSize: root.fontPixelSize
                        bold: true
                    }
                }

                ControlButton {
                    id: saveButton
                    width: root.buttonWidth
                    height: root.rasterWidth
                    text: root.confirming ? "yes" : root.naming ? "ok" : "save"
                    bgColor: root.naming || root.confirming ? "Orange" : "Gray"
                    fgColor: "White"
                    font.family: root.fontFamily
                    font.pixelSize: root.fontPixelSize
                }

                ControlButton {
                    id: deleteButton
                    width: root.buttonWidth
                    height: root.rasterWidth
                    enabled: root.naming || root.confirming || (root.userTuningSelected && !root.edited)
                    opacity: enabled ? 1 : 0.4
                    text: root.confirming ? "no" : root.naming ? "cancel" : "delete"
                    bgColor: "Gray"
                    fgColor: "White"
                    font.family: root.fontFamily
                    font.pixelSize: root.fontPixelSize
                }
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
