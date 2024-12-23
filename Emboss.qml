// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12
import Qt5Compat.GraphicalEffects

Item {
    id: emboss

    property alias source: topLeftShadow.source
    property color lightColor: "white"
    property color darkColor: "black"
    property bool cached: true
    property real radius: 1
    property real spread: 0.1
    property real offset: 1

    InnerShadow {
        id: topLeftShadow
        anchors.fill: parent
        cached: emboss.cached
        horizontalOffset: emboss.offset
        verticalOffset: emboss.offset
        color: emboss.lightColor
        radius: emboss.radius
        samples: emboss.radius * 2
        spread: emboss.spread
    }
    InnerShadow {
        id: bottomRightShadow
        anchors.fill: parent
        cached: emboss.cached
        source: topLeftShadow
        horizontalOffset: -emboss.offset
        verticalOffset: -emboss.offset
        color: emboss.darkColor
        radius: emboss.radius
        samples: emboss.radius * 2
        spread: emboss.spread
    }
}
