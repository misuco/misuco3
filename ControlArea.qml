// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12

Rectangle {
    id: controlArea
    property string text: "Area"

    width: 420
    height: 50

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

    /*
    Emboss {
        anchors.fill: parent
        source: parent
        offset: -2
        radius: 10
    }
    */

}
