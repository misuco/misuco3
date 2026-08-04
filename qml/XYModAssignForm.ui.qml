// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Item {
    id: root

    property alias xModAssignSelect: xModAssignSelect
    property alias xModAmountSlider: xModAmountSlider
    property alias yModAssignSelect: yModAssignSelect
    property alias yModAmountSlider: yModAmountSlider

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
        text: "XY-Mod-Assign"

        ComboBox {
            id: xModAssignSelect
            x:10
            y:20
            model: root.assignables
        }

        ControlSlider {
            id: xModAmountSlider
            x:10
            y:80
            text: "X-Mod Amount"
            from: 0
            to: 1
            value: 0.5
        }

        ComboBox {
            id: yModAssignSelect
            x:10
            y:140
            model: root.assignables
        }

        ControlSlider {
            id: yModAmountSlider
            x:10
            y:190
            text: "Y-Mod Amount"
            from: 0
            to: 1
            value: 0.5
        }

    }
}
