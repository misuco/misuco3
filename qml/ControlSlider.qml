// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Slider {
    id: controlSlider

    property string text: "Control"
    property double elementSpace: 5
    property double elementRadius: 5

    property string fontFamily
    property double fontPixelSize: 10

    readonly property int decimalPlaces: Math.ceil(Math.log10(stepSize)*-1)

    implicitWidth: 400
    implicitHeight: 50

    from: 1
    to: 1000
    value: 1

    background: ControlEmboss {
        x: controlSlider.leftPadding
        y: controlSlider.topPadding + controlSlider.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 20
        width: controlSlider.availableWidth
        height: controlSlider.height
        radius: controlSlider.elementRadius
        color: "#bdbebf"

        Rectangle {
            y: controlSlider.height / 3
            width: controlSlider.visualPosition * parent.width
            height: controlSlider.height / 3
            color: "#21be2b"
            radius: controlSlider.elementRadius
        }
    }

    handle: ControlEmboss {
        x: controlSlider.leftPadding + controlSlider.visualPosition * (controlSlider.availableWidth - width)
        y: controlSlider.topPadding + controlSlider.availableHeight / 2 - height / 2
        down: false
        implicitWidth: controlSlider.height * 0.8
        implicitHeight: controlSlider.height * 0.8
        width: implicitWidth
        height: implicitHeight
        radius: implicitHeight
        color: controlSlider.pressed ? "#f0f0f0" : "#f6f6f6"
        border.color: "#bdbebf"
    }

    Text {
        z: 1000
        text: controlSlider.text
        anchors {
            top: controlSlider.top
            left: controlSlider.left
            leftMargin: controlSlider.elementSpace
        }
        font {
            family: controlSlider.fontFamily
            pixelSize: controlSlider.fontPixelSize
            bold: true
        }
    }

    Text {
        z: 2
        text: controlSlider.value.toFixed(controlSlider.decimalPlaces)
        anchors {
            top: controlSlider.top
            right: controlSlider.right
            rightMargin: controlSlider.elementSpace
        }
        font {
            family: controlSlider.fontFamily
            pixelSize: controlSlider.fontPixelSize
            bold: true
        }
    }
}
