// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12
import QtQuick.Controls 2.12

RangeSlider {
    property string text: "Control"
    id: controlSlider
    width: 400
    height: 50
    from: 1
    to: 10
    first.value: 2
    second.value: 9
    property int ruler: 10

    background: Rectangle {
        x: controlSlider.leftPadding
        y: controlSlider.topPadding + controlSlider.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 20
        width: controlSlider.availableWidth
        height: implicitHeight
        radius: 2
        color: "#bdbebf"

        Rectangle {
            x: controlSlider.first.visualPosition * parent.width
            width: (controlSlider.second.visualPosition - controlSlider.first.visualPosition) * parent.width
            height: parent.height
            color: "#21be2b"
            radius: 2
        }

        Repeater {
            model: controlSlider.ruler

            Rectangle {
                width: 1
                height: parent.height
                x: modelData*parent.width/controlSlider.ruler
                y: 0
            }
        }
    }

    first.handle: Rectangle {
        x: controlSlider.leftPadding + controlSlider.first.visualPosition * (controlSlider.availableWidth - width)
        y: controlSlider.topPadding + controlSlider.availableHeight / 2 - height / 2
        implicitWidth: 50
        implicitHeight: 50
        radius: 25
        color: controlSlider.first.pressed ? "#f0f0f0" : "#f6f6f6"
        border.color: "#bdbebf"
    }

    second.handle: Rectangle {
        x: controlSlider.leftPadding + controlSlider.second.visualPosition * (controlSlider.availableWidth - width)
        y: controlSlider.topPadding + controlSlider.availableHeight / 2 - height / 2
        implicitWidth: 50
        implicitHeight: 50
        radius: 25
        color: controlSlider.second.pressed ? "#f0f0f0" : "#f6f6f6"
        border.color: "#bdbebf"
    }

    Text {
        text: controlSlider.text
        anchors {
            bottom: parent.bottom
            right: parent.right
        }
    }
}
