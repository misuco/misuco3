// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024-2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Effects

Rectangle {
    id: root

    property bool down: true
    property int effectSize: 3
    property color bgColor: "Gray"
    readonly property int effectOffset: down ? -1 * effectSize : effectSize

    anchors.margins: effectSize

    radius: 10
    color: bgColor

    layer.enabled: true
    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: "Black"
        shadowBlur: 0.5
        shadowOpacity: 0.5
        shadowHorizontalOffset: root.effectOffset
        shadowVerticalOffset: root.effectOffset
        autoPaddingEnabled: true
    }

    Rectangle {
        anchors.fill: parent
        radius: parent.radius
        color: root.bgColor

        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: "White"
            shadowBlur: 0.5
            shadowOpacity: 0.5
            shadowHorizontalOffset: -1 * root.effectOffset
            shadowVerticalOffset: -1 * root.effectOffset
            autoPaddingEnabled: true
        }
    }
}
