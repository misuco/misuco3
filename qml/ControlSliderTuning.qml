// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Slider {
    property var controller
    property int index

    property color bgColor
    property var fgColor

    id: root
    x:10
    y:80
    height: 201
    from: -100
    to: 100
    value: 0
    snapMode: Slider.SnapAlways
    stepSize: 1
    orientation: Qt.Vertical

    onValueChanged: function() {
        controller.tuningUpdated(index,value)
    }

    Rectangle {
        anchors.fill: parent
        color: root.bgColor
    }

    Rectangle {
        anchors.top: parent.bottom
        anchors.topMargin: 2
        width: parent.width
        height: 20
        color: root.bgColor
    }

    Text {
        anchors.top: parent.bottom
        anchors.topMargin: 2
        width: parent.width
        height: 20
        text: parent.value
        horizontalAlignment: Qt.AlignHCenter
        color: root.fgColor
    }
}
