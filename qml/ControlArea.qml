// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick

Rectangle {
    id: controlArea
    property string text: "Area"

    width: 620
    height: 50

    ControlEmboss {
        anchors.fill: parent
        radius: 10
    }

    Text {
        x: 10
        text: controlArea.text
    }

    radius: 10
    color: "Transparent"

    border {
        color: "Gray"
        width: 1
    }

}
