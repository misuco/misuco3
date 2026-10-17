// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls
import misuco3

Item {
    id: root

    required property var controller
    required property MasterSender sender

    property double elementRadius: 5

    property int noteIndex

    property color bgColor
    property color fgColor

    readonly property double sliderHeight: height * 0.9
    readonly property double labelHeight: height * 0.1

    ControlSliderTuning {
        id: slider
        width: root.width
        height: root.sliderHeight
        controller: root.controller
        sender: root.sender
        elementRadius: root.elementRadius
        index: root.noteIndex
        bgColor: root.bgColor
        fgColor: root.fgColor
    }

    ControlLabelTuning {
        id: label
        width: root.width
        height: root.labelHeight
        anchors.top: slider.bottom
        sender: root.sender
        elementRadius: root.elementRadius
        index: root.noteIndex
        value: slider.value
        bgColor: root.bgColor
        fgColor: root.fgColor
    }
}
