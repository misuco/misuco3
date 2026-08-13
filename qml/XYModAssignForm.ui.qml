// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Item {
    id: root

    property alias modAssignSelect: modAssignSelect
    property alias modAmountSlider: modAmountSlider
    property alias modMinSlider: modMinSlider
    property alias modMaxSlider: modMaxSlider
    property alias modBar: modBar

    property string title: "Mod Assign"

    property list<string> assignables: [
        "-",
        "pitch",
        "mod",
        "mod freq",
        "filter freq",
        "filter reso",
        "osc1 level",
        "osc2 level",
        "osc2 shift"
    ]

    ControlArea {
        x:10
        y:10
        height: 310
        text: root.title

        ComboBox {
            id: modAssignSelect
            x:10
            y:20
            model: root.assignables
        }

        ControlSlider {
            id: modAmountSlider
            x:10
            y:80
            text: "Amount"
            from: 0
            to: 1
            value: 0.5
        }

        ControlSlider {
            id: modMinSlider
            x:10
            y:140
            text: "Min"
            from: 0
            to: 1
            value: 0
        }

        ControlSlider {
            id: modMaxSlider
            x:10
            y:200
            text: "Max"
            from: 0
            to: 1
            value: 1
        }

        ControlBarRange {
            id: modBar
            x:10
            y:260
            height: 20
            minValue: modMinSlider.value
            maxValue: modMaxSlider.value
        }
    }
}
