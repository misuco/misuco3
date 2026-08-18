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

    property double rasterWidth: 50
    property double elementSpace: 5
    property double elementRadius: 5
    property bool portrait: false

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

    readonly property double elementWidth: width/2 - 3*elementSpace
    readonly property double buttonSize: rasterWidth - 3*elementSpace

    ControlArea {
        width: root.width
        height: root.height

        text: root.title

        Column {
            y: root.elementSpace
            padding: root.elementSpace

            Grid {
                columns: 2
                rows: 2

                padding: root.elementSpace

                ComboBox {
                    id: modAssignSelect
                    model: root.assignables
                    width: root.elementWidth
                    height: root.buttonSize
                }

                ControlSlider {
                    id: modAmountSlider
                    width: root.elementWidth
                    height: root.buttonSize
                    elementRadius: root.elementRadius
                    text: "Amount"
                    from: 0
                    to: 1
                    value: 0.5
                }

                ControlSlider {
                    id: modMinSlider
                    width: root.elementWidth
                    height: root.buttonSize
                    elementRadius: root.elementRadius
                    text: "Min"
                    from: 0
                    to: 1
                    value: 0
                }

                ControlSlider {
                    id: modMaxSlider
                    width: root.elementWidth
                    height: root.buttonSize
                    elementRadius: root.elementRadius
                    text: "Max"
                    from: 0
                    to: 1
                    value: 1
                }
            }

            ControlBarRange {
                id: modBar
                width: root.width
                height: root.elementSpace
                minValue: modMinSlider.value
                maxValue: modMaxSlider.value
            }
        }
    }
}
