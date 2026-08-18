// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick

Item {
    id: controlArea

    property string text: "Area"
    property double elementSpace: 10
    property double elementRadius: 10

    width: 620
    height: 50

    ControlEmboss {
        radius: controlArea.elementRadius
        bgColor: "Gray"

        anchors {
            fill: parent
            rightMargin: controlArea.elementSpace
        }

        Text {
            x: controlArea.elementSpace
            text: controlArea.text
        }
    }
}
