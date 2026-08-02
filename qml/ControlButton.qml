// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Button {
    id: controlButton

    property bool selected: false
    property color bgColor: "White"
    property color fgColor: "Black"
    property int index: 0
    readonly property int effectOffset: controlButton.selected ? -2 : 2

    text: "Control"
    width: 50
    height: 50

    palette.buttonText: fgColor

    background: Rectangle {
        anchors.fill: parent
        border.width: 0
        color: "Transparent"
    }

    Emboss {
        anchors.fill: parent
        down: controlButton.selected
        bgColor: controlButton.bgColor
        radius: 10
    }
}
