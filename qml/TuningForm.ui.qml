// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Item {
    id: root

    property double rasterWidth: 50
    property double elementSpace: 10
    property bool portrait: false

    readonly property double contentWidth: width - 2*elementSpace

    property var bgColors: []
    property var bgColorsActive: []
    property var fgColors: []

    signal tuningUpdated(var i, var t)

    ControlArea {
        width: root.width
        height: root.height
        text: "Tuning"

        Column {
            y: 2* root.elementSpace
            padding: root.elementSpace

            ComboBox {
                width: root.width
                height: root.rasterWidth
                model: ["Equal", "Pure", "Well-tempered", "Custom"]
            }

            Row {
                height: root.height - root.rasterWidth
                padding: root.elementSpace

                readonly property double elementWidth: root.width/12 - root.elementSpace

                ControlSliderTuning {
                    controller: root
                    width: parent.elementWidth
                    height: parent.height
                    index: 0
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlSliderTuning {
                    controller: root
                    index: 1
                    width: parent.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }
                ControlSliderTuning {
                    controller: root
                    index: 2
                    width: parent.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }
                ControlSliderTuning {
                    controller: root
                    index: 3
                    width: parent.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }
                ControlSliderTuning {
                    controller: root
                    index: 4
                    width: parent.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }
                ControlSliderTuning {
                    controller: root
                    index: 5
                    width: parent.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }
                ControlSliderTuning {
                    controller: root
                    index: 6
                    width: parent.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }
                ControlSliderTuning {
                    controller: root
                    index: 7
                    width: parent.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }
                ControlSliderTuning {
                    controller: root
                    index: 8
                    width: parent.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }
                ControlSliderTuning {
                    controller: root
                    index: 9
                    width: parent.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }
                ControlSliderTuning {
                    controller: root
                    index: 10
                    width: parent.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }
                ControlSliderTuning {
                    controller: root
                    index: 11
                    width: parent.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }
            }
        }
    }
}
