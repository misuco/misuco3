// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Item {
    id: root

    property double elementSpace: 5

    readonly property double elementWidth: width - 2*elementSpace
    readonly property double elementHeight: (height - 4*elementSpace) / 2

    property alias filterCutoffSlider: filterCutoffSlider
    property alias filterResonanceSlider: filterResonanceSlider

    ControlArea {
        width: root.width
        height: root.height
        text: "Filter"

        Column {
            y: 2*root.elementSpace

            leftPadding: root.elementSpace
            spacing: root.elementSpace

            ControlSlider {
                id: filterCutoffSlider
                width: root.elementWidth
                height: root.elementHeight
                text: "Cutoff"
                from: 1
                to: 1000
                value: 1
            }

            ControlSlider {
                id: filterResonanceSlider
                width: root.elementWidth
                height: root.elementHeight
                text: "Resonance"
                from: 0.0
                to: 1.0
                value: 0.1
            }
        }
    }
}
