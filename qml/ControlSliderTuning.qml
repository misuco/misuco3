// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12
import QtQuick.Controls 2.12
import "ColorPalette.js" as Palette

Slider {
    property var controller
    property int index
    property int palette: 1
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
        color: Palette.bg(palette,index,true)
    }

    Rectangle {
        anchors.top: parent.bottom
        anchors.topMargin: 2
        width: parent.width
        height: 20
        color: Palette.bg(palette,index,true)
    }

    Text {
        anchors.top: parent.bottom
        anchors.topMargin: 2
        width: parent.width
        height: 20
        text: parent.value
        horizontalAlignment: Qt.AlignHCenter
        color: Palette.fg(palette,index)
    }
}
