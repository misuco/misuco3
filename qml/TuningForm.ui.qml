// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Item {
    id: root

    property var bgColors: []
    property var bgColorsActive: []
    property var fgColors: []

    signal tuningUpdated(var i, var t)

    ControlArea {
        x:10
        y:10
        height: 310
        text: "Tuning"

        ComboBox {
            x:10
            y:20
            model: ["Equal", "Pure", "Well-tempered", "Custom"]
        }

        ControlSliderTuning {
            x:10
            controller: root
            index: 0
            bgColor: root.bgColors[index]
            fgColor: root.fgColors[index]
        }
        ControlSliderTuning {
            x:60
            controller: root
            index: 1
            bgColor: root.bgColors[index]
            fgColor: root.fgColors[index]
        }
        ControlSliderTuning {
            x:110
            controller: root
            index: 2
            bgColor: root.bgColors[index]
            fgColor: root.fgColors[index]
        }
        ControlSliderTuning {
            x:160
            controller: root
            index: 3
            bgColor: root.bgColors[index]
            fgColor: root.fgColors[index]
        }
        ControlSliderTuning {
            x:210
            controller: root
            index: 4
            bgColor: root.bgColors[index]
            fgColor: root.fgColors[index]
        }
        ControlSliderTuning {
            x:260
            controller: root
            index: 5
            bgColor: root.bgColors[index]
            fgColor: root.fgColors[index]
        }
        ControlSliderTuning {
            x:310
            controller: root
            index: 6
            bgColor: root.bgColors[index]
            fgColor: root.fgColors[index]
        }
        ControlSliderTuning {
            x:360
            controller: root
            index: 7
            bgColor: root.bgColors[index]
            fgColor: root.fgColors[index]
        }
        ControlSliderTuning {
            x:410
            controller: root
            index: 8
            bgColor: root.bgColors[index]
            fgColor: root.fgColors[index]
        }
        ControlSliderTuning {
            x:460
            controller: root
            index: 9
            bgColor: root.bgColors[index]
            fgColor: root.fgColors[index]
        }
        ControlSliderTuning {
            x:510
            controller: root
            index: 10
            bgColor: root.bgColors[index]
            fgColor: root.fgColors[index]
        }
        ControlSliderTuning {
            x:560
            controller: root
            index: 11
            bgColor: root.bgColors[index]
            fgColor: root.fgColors[index]
        }
    }
}
