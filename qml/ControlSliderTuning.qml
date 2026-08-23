// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Slider {
    id: controlSlider

    property var controller
    property int index
    property double elementRadius: 5

    property color bgColor
    property color fgColor

    x:10
    y:80
    height: 201
    from: -50
    to: 50
    value: 0
    snapMode: Slider.SnapAlways
    stepSize: 1
    orientation: Qt.Vertical

    onValueChanged: function() {
        controller.tuningUpdated(index,value)
    }

    background: Rectangle {
        //y: controlSlider.topPadding
        x: controlSlider.leftPadding + controlSlider.availableWidth / 2 - width / 2
        implicitHeight: 200
        implicitWidth: controlSlider.width
        height: controlSlider.availableHeight
        width: implicitWidth
        radius: controlSlider.elementRadius
        color: controlSlider.bgColor // "#bdbebf"

        Rectangle {
            height: controlSlider.visualPosition * parent.height
            width: parent.width
            color: "#21be2b"
            radius: 2
        }
    }

    handle: Rectangle {
        y: /*controlSlider.topPadding + */ controlSlider.visualPosition * (controlSlider.availableHeight - height)
        x: controlSlider.leftPadding + controlSlider.availableWidth / 2 - width / 2
        implicitHeight: controlSlider.width
        implicitWidth: controlSlider.width
        radius: controlSlider.width / 2
        color: controlSlider.fgColor
        border.color: "#bdbebf"
    }

    /*
    background: ControlEmboss {
        //x: controlSlider.leftPadding
        //y: controlSlider.topPadding + controlSlider.availableHeight / 2 - height / 2
        implicitWidth: controlSlider.height //200
        implicitHeight: controlSlider.availableWidth //20
        width: controlSlider.height //availableWidth
        height: controlSlider.availableWidth //height
        radius: controlSlider.elementRadius
        color: controlSlider.bgColor //"#bdbebf"

        Rectangle {
            y: controlSlider.height / 3
            width: controlSlider.visualPosition * parent.width
            height: controlSlider.height / 3
            color: "#21be2b"
            radius: controlSlider.elementRadius
        }
    }

    handle: ControlEmboss {
        property double size: controlSlider.width * 0.8
        //x: controlSlider.leftPadding + controlSlider.visualPosition * (controlSlider.availableWidth - width)
        //y: controlSlider.topPadding + controlSlider.availableHeight / 2 - height / 2
        down: false
        implicitWidth: size //controlSlider.width * 0.8
        implicitHeight: size //controlSlider.width * 0.8
        width: size
        height: size
        radius: size
        color: controlSlider.fgColor //root.fccontrolSlider.pressed ? "#f0f0f0" : "#f6f6f6"
        border.color: controlSlider.fgColor // "#bdbebf"
    }
    */

    /*
    Rectangle {
        anchors.fill: parent
        color: "Yellow" //root.bgColor
        border {
            width: 2
            color: "Black"
        }
    }
    */

    Rectangle {
        anchors.top: parent.bottom
        anchors.topMargin: 2
        width: parent.width
        height: 20
        color: controlSlider.bgColor
    }

    Text {
        anchors.top: parent.bottom
        anchors.topMargin: 2
        width: parent.width
        height: 20
        text: parent.value
        horizontalAlignment: Qt.AlignHCenter
        color: controlSlider.fgColor
    }
}
