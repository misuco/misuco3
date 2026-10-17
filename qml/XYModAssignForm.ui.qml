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
    property string fontFamily
    property double fontPixelSize: 10

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

    readonly property double contentWidth: width - 2*elementSpace
    readonly property double elementWidth: portrait ? contentWidth : (contentWidth - elementSpace) / 2
    readonly property double contentHeight: height - 2*elementSpace
    readonly property double elementHeight: portrait ? (contentHeight - 7*elementSpace) / 5  : (contentHeight - 4*elementSpace) / 2
    readonly property int gridRows: 4 //portrait ? 4 : 2
    readonly property int gridColumns: portrait ? 1 : 2

    ControlArea {
        width: root.width
        height: root.height
        fontFamily: root.fontFamily
        fontPixelSize: root.fontPixelSize

        text: root.title

        Column {
            y: 2*root.elementSpace

            padding: root.elementSpace
            spacing: root.elementSpace

            Grid {
                rows: root.gridRows
                columns: root.gridColumns
                spacing: root.elementSpace

                ComboBox {
                    id: modAssignSelect
                    model: root.assignables
                    width: root.elementWidth
                    height: root.elementHeight
                }

                ControlSlider {
                    id: modAmountSlider
                    width: root.elementWidth
                    height: root.elementHeight
                    elementRadius: root.elementRadius
                    fontFamily: root.fontFamily
                    fontPixelSize: root.fontPixelSize
                    text: "Amount"
                    from: 0
                    to: 1
                    value: 0.5
                    stepSize: 0.001
                }

                ControlSlider {
                    id: modMinSlider
                    width: root.elementWidth
                    height: root.elementHeight
                    elementRadius: root.elementRadius
                    fontFamily: root.fontFamily
                    fontPixelSize: root.fontPixelSize
                    text: "Min"
                    from: 0
                    to: 1
                    value: 0
                    stepSize: 0.001
                }

                ControlSlider {
                    id: modMaxSlider
                    width: root.elementWidth
                    height: root.elementHeight
                    elementRadius: root.elementRadius
                    fontFamily: root.fontFamily
                    fontPixelSize: root.fontPixelSize
                    text: "Max"
                    from: 0
                    to: 1
                    value: 1
                    stepSize: 0.001
                }
            }

            ControlBarRange {
                id: modBar
                visible: root.portrait
                width: root.elementWidth
                height: root.elementHeight
                minValue: modMinSlider.value
                maxValue: modMaxSlider.value
            }
        }
    }
}
