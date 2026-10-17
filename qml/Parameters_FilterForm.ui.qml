// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Item {
    id: root

    property double rasterWidth: 50
    property double elementSpace: 5
    property bool portrait: false

    property string fontFamily
    property double fontPixelSize: 10

    readonly property double elementWidth: width - 2*elementSpace
    readonly property double elementHeight: rasterWidth - (portrait ? 2 : 3)*elementSpace

    property alias filterCutoffSlider: filterCutoffSlider
    property alias filterResonanceSlider: filterResonanceSlider

    ControlArea {
        width: root.width
        height: root.height
        fontFamily: root.fontFamily
        fontPixelSize: root.fontPixelSize

        text: "Filter"

        Column {
            y: 2*root.elementSpace

            padding: root.elementSpace
            spacing: root.elementSpace

            ControlSlider {
                id: filterCutoffSlider
                width: root.elementWidth
                height: root.elementHeight
                fontFamily: root.fontFamily
                fontPixelSize: root.fontPixelSize
                text: "Cutoff"
                from: 0.0
                to: 1.0
                value: 0.5
                stepSize: 0.00001
            }

            ControlSlider {
                id: filterResonanceSlider
                width: root.elementWidth
                height: root.elementHeight
                fontFamily: root.fontFamily
                fontPixelSize: root.fontPixelSize
                text: "Resonance"
                from: 0.0
                to: 1.0
                value: 0.1
                stepSize: 0.0001
            }
        }
    }
}
