// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12
import QtQuick.Controls

Item {
    id: root

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
        }
        ControlSliderTuning {
            x:60
            controller: root
            index: 1
        }
        ControlSliderTuning {
            x:110
            controller: root
            index: 2
        }
        ControlSliderTuning {
            x:160
            controller: root
            index: 3
        }
        ControlSliderTuning {
            x:210
            controller: root
            index: 4
        }
        ControlSliderTuning {
            x:260
            controller: root
            index: 5
        }
        ControlSliderTuning {
            x:310
            controller: root
            index: 6
        }
        ControlSliderTuning {
            x:360
            controller: root
            index: 7
        }
        ControlSliderTuning {
            x:410
            controller: root
            index: 8
        }
        ControlSliderTuning {
            x:460
            controller: root
            index: 9
        }
        ControlSliderTuning {
            x:510
            controller: root
            index: 10
        }
        ControlSliderTuning {
            x:560
            controller: root
            index: 11
        }
    }
}
