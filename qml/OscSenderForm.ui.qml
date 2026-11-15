// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls
import misuco3

Item {
    id: root

    property alias enableSwitch: enableSwitch
    property alias formatSelect: formatSelect
    property alias protocolSelect: protocolSelect
    property alias hostField: hostField
    property alias portField: portField
    property alias channelSelect: channelSelect

    property OscControl osc

    property double rasterWidth: 50
    property double elementSpace: 5
    property double elementRadius: 5
    property bool portrait: false
    property string fontFamily
    property double fontPixelSize: 10

    // SuperCollider has no midi channel
    readonly property bool midiFormat: osc.format !== 2
    readonly property double contentWidth: width - 2*elementSpace
    readonly property double buttonSize: rasterWidth - 3*elementSpace
    readonly property double labelWidth: rasterWidth * 0.75
    readonly property double formatWidth: rasterWidth * 2.5
    readonly property double protocolWidth: rasterWidth * 1.5
    // host 3, port 1.5, channel 1.5 units
    readonly property double fieldUnit: portrait ? (contentWidth - 2*labelWidth - 4*elementSpace) / 4.5
                                                 : (contentWidth - 3*labelWidth - 6*elementSpace) / 6

    component FieldLabel: Text {
        width: root.labelWidth
        height: root.buttonSize
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        color: "White"
        font {
            family: root.fontFamily
            pixelSize: root.fontPixelSize
            bold: true
        }
    }

    ControlArea {
        width: root.width
        height: root.height
        fontFamily: root.fontFamily
        fontPixelSize: root.fontPixelSize
        text: "OSC / " + root.osc.statusText

        Column {
            y: 2*root.elementSpace
            spacing: root.elementSpace
            padding: root.elementSpace

            Row {
                spacing: root.elementSpace

                ControlButton {
                    id: enableSwitch
                    width: root.rasterWidth
                    height: root.buttonSize
                    text: "on"
                    selected: root.osc.enabled
                    bgColor: selected ? "Orange" : "Gray"
                    fgColor: "White"
                }

                ComboBox {
                    id: formatSelect
                    width: root.formatWidth
                    height: root.buttonSize
                    model: root.osc.formatNames
                    font.family: root.fontFamily
                    font.pixelSize: root.fontPixelSize
                }

                ComboBox {
                    id: protocolSelect
                    width: root.protocolWidth
                    height: root.buttonSize
                    enabled: !root.osc.enabled
                    model: ["UDP", "TCP"]
                    font.family: root.fontFamily
                    font.pixelSize: root.fontPixelSize
                }
            }

            Flow {
                width: root.contentWidth
                spacing: root.elementSpace

                FieldLabel {
                    text: "Host"
                }

                TextField {
                    id: hostField
                    width: 3*root.fieldUnit
                    height: root.buttonSize
                    enabled: !root.osc.enabled
                    placeholderText: "IP address"
                    inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText | Qt.ImhUrlCharactersOnly
                    font.family: root.fontFamily
                    font.pixelSize: root.fontPixelSize
                }

                FieldLabel {
                    text: "Port"
                }

                TextField {
                    id: portField
                    width: 1.5*root.fieldUnit
                    height: root.buttonSize
                    enabled: !root.osc.enabled
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: IntValidator {
                        bottom: 1
                        top: 65535
                    }
                    font.family: root.fontFamily
                    font.pixelSize: root.fontPixelSize
                }

                FieldLabel {
                    text: "CH"
                    visible: root.midiFormat
                }

                ComboBox {
                    id: channelSelect
                    width: 1.5*root.fieldUnit
                    height: root.buttonSize
                    visible: root.midiFormat
                    model: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
                    font.family: root.fontFamily
                    font.pixelSize: root.fontPixelSize
                }
            }
        }
    }
}
