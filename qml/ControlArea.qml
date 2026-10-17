// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick

Item {
    id: controlArea

    property double elementSpace: 10
    property double elementRadius: 10
    property string fontFamily
    property double fontPixelSize: 10

    property string text: "Area"

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
            font {
                family: controlArea.fontFamily
                pixelSize: controlArea.fontPixelSize
                bold: true
            }
        }
    }
}
