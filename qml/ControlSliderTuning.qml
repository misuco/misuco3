// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12
import QtQuick.Controls 2.12

Slider {
    property var controller
    property int index
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

    Text {
        anchors.top: parent.bottom
        width: parent.width
        height: 10
        text: parent.value
        horizontalAlignment: Qt.AlignHCenter
    }
}
