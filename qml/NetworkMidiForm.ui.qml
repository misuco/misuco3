// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls
import misuco3

Item {
    id: root

    property alias enableSwitch: enableSwitch
    property alias modeSelect: modeSelect
    property alias searchButton: searchButton
    property alias sessionSelect: sessionSelect
    property alias hostField: hostField
    property alias portField: portField
    property alias channelSelect: channelSelect
    property alias nameField: nameField

    property RtpMidiControl rtpMidi

    property double rasterWidth: 50
    property double elementSpace: 5
    property double elementRadius: 5
    property bool portrait: false
    property string fontFamily
    property double fontPixelSize: 10

    readonly property bool connectMode: rtpMidi.mode === 0
    readonly property double contentWidth: width - 2*elementSpace
    readonly property double buttonSize: rasterWidth - 3*elementSpace
    readonly property double labelWidth: rasterWidth * 0.75
    readonly property double modeWidth: rasterWidth * 2
    // host 3, port 1.5, channel 1.5, name 2 units
    readonly property double fieldUnit: portrait ? (contentWidth - 2*labelWidth - 4*elementSpace) / 4.5
                                                 : (contentWidth - 4*labelWidth - 8*elementSpace) / 8

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
        text: "Network MIDI / " + root.rtpMidi.statusText +
              (root.rtpMidi.state === 3 && root.rtpMidi.latency >= 0
               ? " / " + root.rtpMidi.latency.toFixed(1) + " ms" : "") +
              (root.rtpMidi.state === 0 || root.rtpMidi.state === 5
               ? " / this device: " + root.rtpMidi.localAddresses : "")

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
                    selected: root.rtpMidi.enabled
                    bgColor: selected ? "Orange" : "Gray"
                    fgColor: "White"
                }

                ComboBox {
                    id: modeSelect
                    width: root.modeWidth
                    height: root.buttonSize
                    enabled: !root.rtpMidi.enabled
                    model: ["connect to", "wait for"]
                    font.family: root.fontFamily
                    font.pixelSize: root.fontPixelSize
                }

                ControlButton {
                    id: searchButton
                    width: root.rasterWidth
                    height: root.buttonSize
                    visible: root.connectMode
                    enabled: !root.rtpMidi.enabled
                    text: "search"
                    selected: root.rtpMidi.searching
                    bgColor: selected ? "Orange" : "Gray"
                    fgColor: "White"
                }

                ComboBox {
                    id: sessionSelect
                    width: root.contentWidth - 2*root.rasterWidth - root.modeWidth - 4*root.elementSpace
                    height: root.buttonSize
                    visible: root.connectMode
                    enabled: !root.rtpMidi.enabled && root.rtpMidi.sessions.length > 0
                    model: root.rtpMidi.sessions
                    displayText: root.rtpMidi.searching ? "searching..." :
                                 root.rtpMidi.sessions.length > 0 ? "found: " + root.rtpMidi.sessions.length + " / select" :
                                 "press search to find sessions"
                    font.family: root.fontFamily
                    font.pixelSize: root.fontPixelSize
                }
            }

            Flow {
                width: root.contentWidth
                spacing: root.elementSpace

                FieldLabel {
                    text: "Host"
                    visible: root.connectMode
                }

                TextField {
                    id: hostField
                    width: 3*root.fieldUnit
                    height: root.buttonSize
                    visible: root.connectMode
                    enabled: !root.rtpMidi.enabled
                    placeholderText: "IP / name"
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
                    enabled: !root.rtpMidi.enabled
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: IntValidator {
                        bottom: 1
                        top: 65534
                    }
                    font.family: root.fontFamily
                    font.pixelSize: root.fontPixelSize
                }

                FieldLabel {
                    text: "CH"
                }

                ComboBox {
                    id: channelSelect
                    width: 1.5*root.fieldUnit
                    height: root.buttonSize
                    model: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
                    font.family: root.fontFamily
                    font.pixelSize: root.fontPixelSize
                }

                FieldLabel {
                    text: "Name"
                }

                TextField {
                    id: nameField
                    width: 2*root.fieldUnit
                    height: root.buttonSize
                    enabled: !root.rtpMidi.enabled
                    placeholderText: "MISUCO3"
                    inputMethodHints: Qt.ImhNoPredictiveText
                    font.family: root.fontFamily
                    font.pixelSize: root.fontPixelSize
                }
            }
        }
    }
}
