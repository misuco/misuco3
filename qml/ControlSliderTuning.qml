// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls
import misuco3

Slider {
    id: controlSlider

    required property var controller
    required property MasterSender sender

    property double elementRadius: 5
    property int voiceId

    property int index
    readonly property int offsetMidiChamberTone: 3
    readonly property int tuningPreviewOctave: 4
    readonly property double f: 6.875 * Math.pow( 2 , ((index + tuningPreviewOctave*12 + offsetMidiChamberTone) * 100 + value) / 1200)

    property color bgColor
    property color fgColor

    from: -100
    to: 100
    value: 0
    snapMode: Slider.SnapAlways
    stepSize: 1
    orientation: Qt.Vertical

    onValueChanged: {
        console.log("updateSlider index: " + controlSlider.index + " f: " + controlSlider.f + " pitch: " + controlSlider.value)
        controller.tuningUpdated(index,value)
        controlSlider.sender.pitch(controlSlider.voiceId,controlSlider.f,controlSlider.index+1,controlSlider.value)
    }

    onPressedChanged: {
        if(controlSlider.pressed) {
            pressSlider()
        } else {
            releaseSlider()
        }
    }

    function pressSlider() {
        console.log("pressedSlider index: " + controlSlider.index + " f: " + controlSlider.f)
        controlSlider.voiceId=controlSlider.sender.noteOn(controlSlider.f,controlSlider.index+1,controlSlider.value,127)
    }

    function releaseSlider() {
        console.log("releaseSlider index: " + controlSlider.index + " f: " + controlSlider.f + " pitch: " + controlSlider.value)
        controlSlider.sender.noteOff(controlSlider.voiceId)
    }

    background: ControlEmboss {
        x: controlSlider.leftPadding + controlSlider.availableWidth / 2 - width / 2
        y: controlSlider.topPadding
        implicitHeight: 200
        height: controlSlider.availableHeight
        width: controlSlider.width
        radius: controlSlider.elementRadius
        bgColor: controlSlider.pressed ? controlSlider.fgColor : controlSlider.bgColor
    }

    handle: ControlEmboss {
        x: controlSlider.leftPadding + controlSlider.availableWidth / 2 - width / 2
        y: controlSlider.topPadding + controlSlider.visualPosition * (controlSlider.availableHeight - height)
        implicitHeight: controlSlider.width
        width: controlSlider.width
        down: false
        radius: controlSlider.width / 2
        bgColor: controlSlider.fgColor
    }
}
