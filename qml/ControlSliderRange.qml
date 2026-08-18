// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

RangeSlider {
    id: controlSlider

    property string text: "Control"
    property double elementRadius: 10

    width: 400
    height: 50
    from: 1
    to: 10
    first.value: 2
    second.value: 9

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
            x: controlSlider.first.visualPosition * parent.width + controlSlider.height * 0.2
            y: controlSlider.height / 3
            width: (controlSlider.second.visualPosition - controlSlider.first.visualPosition) * parent.width - controlSlider.height * 0.2
            height: controlSlider.height / 3
            color: "#21be2b"
            radius: controlSlider.elementRadius
        }
    }

    first.handle: ControlEmboss {
        x: controlSlider.leftPadding + controlSlider.first.visualPosition * (controlSlider.availableWidth - width)
        y: controlSlider.topPadding + controlSlider.availableHeight / 2 - height / 2
        down: false
        implicitWidth: controlSlider.height * 0.8
        implicitHeight: controlSlider.height * 0.8
        width: implicitWidth
        height: implicitHeight
        radius: implicitHeight
        bgColor: "#21be2b"
    }

    second.handle: ControlEmboss {
        x: controlSlider.leftPadding + controlSlider.second.visualPosition * (controlSlider.availableWidth - width)
        y: controlSlider.topPadding + controlSlider.availableHeight / 2 - height / 2
        down: false
        implicitWidth: controlSlider.height * 0.8
        implicitHeight: controlSlider.height * 0.8
        width: implicitWidth
        height: implicitHeight
        radius: implicitHeight
        bgColor: "#21be2b"
    }

    Text {
        text: controlSlider.text
        anchors {
            bottom: parent.bottom
            right: parent.right
        }
    }
}
