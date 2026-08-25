// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls
import misuco3

Item {
    id: root

    required property MasterSender sender

    property double rasterWidth: 50
    property double elementSpace: 10
    property double elementRadius: 5
    property bool portrait: false

    property var bgColors: []
    property var bgColorsActive: []
    property var fgColors: []

    readonly property double contentWidth: width - 2*elementSpace
    readonly property double elementWidth: contentWidth/12 - elementSpace

    signal tuningUpdated(var i, var t)

    ControlArea {
        width: root.width
        height: root.height
        elementRadius: root.elementRadius

        text: "Tuning"

        Column {
            y: 2*root.elementSpace
            padding: root.elementSpace
            spacing: root.elementSpace

            ComboBox {
                width: root.contentWidth
                height: root.rasterWidth
                model: ["Equal", "Pure", "Well-tempered", "Custom"]
            }

            Row {
                height: root.height - root.rasterWidth - 5*root.elementSpace
                spacing: root.elementSpace

                ControlSliderTuning {
                    controller: root
                    sender: root.sender
                    width: root.elementWidth
                    height: parent.height
                    index: 0
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlSliderTuning {
                    controller: root
                    sender: root.sender
                    index: 1
                    width: root.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlSliderTuning {
                    controller: root
                    sender: root.sender
                    index: 2
                    width: root.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlSliderTuning {
                    controller: root
                    sender: root.sender
                    index: 3
                    width: root.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlSliderTuning {
                    controller: root
                    sender: root.sender
                    index: 4
                    width: root.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlSliderTuning {
                    controller: root
                    sender: root.sender
                    index: 5
                    width: root.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlSliderTuning {
                    controller: root
                    sender: root.sender
                    index: 6
                    width: root.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlSliderTuning {
                    controller: root
                    sender: root.sender
                    index: 7
                    width: root.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlSliderTuning {
                    controller: root
                    sender: root.sender
                    index: 8
                    width: root.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlSliderTuning {
                    controller: root
                    sender: root.sender
                    index: 9
                    width: root.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlSliderTuning {
                    controller: root
                    sender: root.sender
                    index: 10
                    width: root.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlSliderTuning {
                    controller: root
                    sender: root.sender
                    index: 11
                    width: root.elementWidth
                    height: parent.height
                    bgColor: root.bgColors[index]
                    fgColor: root.fgColors[index]
                }
            }
        }
    }
}
