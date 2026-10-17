// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Item {
    id: root

    property double rasterWidth: 50
    property double elementSpace: 5
    property double elementRadius: rasterWidth / 12
    property bool portrait: false

    property string fontFamily
    property double fontPixelSize: 10

    readonly property double elementWidth: width - 2*elementSpace
    readonly property double elementHeight: rasterWidth - (portrait ? 2 : 3)*elementSpace

    property alias attackSlider: attackSlider
    property alias decaySlider: decaySlider
    property alias sustainSlider: sustainSlider
    property alias releaseSlider: releaseSlider

    ControlArea {
        width: root.width
        height: root.height
        fontFamily: root.fontFamily
        fontPixelSize: root.fontPixelSize

        text: "Filter Envelope"

        Column {
            y: 2*root.elementSpace

            padding: root.elementSpace
            spacing: root.elementSpace

            ControlSlider {
                id: attackSlider
                width: root.elementWidth
                height: root.elementHeight
                fontFamily: root.fontFamily
                fontPixelSize: root.fontPixelSize
                text: "Attack"
                from: 1
                to: 160000
                value: 10
                stepSize: 1
            }

            ControlSlider {
                id: decaySlider
                width: root.elementWidth
                height: root.elementHeight
                fontFamily: root.fontFamily
                fontPixelSize: root.fontPixelSize
                text: "Decay"
                from: 1
                to: 160000
                value: 100
                stepSize: 1
            }

            ControlSlider {
                id: sustainSlider
                width: root.elementWidth
                height: root.elementHeight
                fontFamily: root.fontFamily
                fontPixelSize: root.fontPixelSize
                text: "Sustain"
                from: 0.0
                to: 1.0
                value: 0.8
                stepSize: 0.01
            }

            ControlSlider {
                id: releaseSlider
                width: root.elementWidth
                height: root.elementHeight
                fontFamily: root.fontFamily
                fontPixelSize: root.fontPixelSize
                text: "Release"
                from: 1
                to: 160000
                value: 300
                stepSize: 1
            }
        }
    }
}
