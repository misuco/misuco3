// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls
import misuco3

Item {
    id: root

    required property MasterSender sender

    property double elementRadius: 5
    property int voiceId

    property int index
    property int pressed: 0

    readonly property int offsetMidiChamberTone: 3
    readonly property int tuningPreviewOctave: 4
    readonly property double f: 6.875 * Math.pow( 2 , ((index + tuningPreviewOctave*12 + offsetMidiChamberTone) * 100 + value) / 1200)

    property color bgColor
    property color fgColor

    property int value: 0

    MultiPointTouchArea {
        anchors.fill: parent
        maximumTouchPoints: 1
        onPressed: pressSlider()
        onCanceled: releaseSlider()
        onReleased: releaseSlider()
    }

    function pressSlider() {
        console.log("pressedSlider index: " + root.index + " f: " + root.f)
        root.pressed++
        root.voiceId=root.sender.noteOn(root.f,root.index+1,root.value,127)
    }

    function releaseSlider() {
        console.log("releaseSlider index: " + root.index + " f: " + root.f + " pitch: " + root.value)
        root.pressed--
        root.sender.noteOff(root.voiceId)
    }

    ControlEmboss {
        anchors.fill: parent
        width: root.width
        height: root.height
        bgColor: root.pressed > 0 ? root.fgColor : root.bgColor
    }

    Text {
        anchors.fill: parent
        width: root.width
        height: root.height
        text: root.value
        horizontalAlignment: Qt.AlignHCenter
        color: root.fgColor
    }
}
