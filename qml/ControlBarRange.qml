// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

ControlEmboss {
    id: root

    implicitWidth: 400
    implicitHeight: 20

    radius: usedHeight / 2

    property double minValue: 0
    property double maxValue: 1
    property double value: 0.5

    property color noRangeColor: "yellow"
    property color activeRangeColor: "green"

    readonly property double usedWidth: width - (2*effectSize) - (4*radius)
    readonly property double usedHeight: height - (2*effectSize)

    Item {
        x: root.effectSize
        y: root.effectSize

        readonly property double r2: root.radius * 2

        ControlEmboss {
            id: leftNoRange
            down: false
            width: root.usedWidth * root.minValue + parent.r2
            height: root.usedHeight
            bgColor: root.noRangeColor
            radius: root.radius
        }

        ControlEmboss {
            id: rightNoRange
            down: false
            x: root.usedWidth * root.maxValue + parent.r2
            width: root.usedWidth * (1 - root.maxValue) + parent.r2
            height: root.usedHeight
            bgColor: root.noRangeColor
            radius: root.radius
        }

        ControlEmboss {
            id: valueDisplay
            down: false
            anchors.left: leftNoRange.right
            width: root.usedWidth * (root.value - root.minValue)
            height: root.usedHeight
            bgColor: root.activeRangeColor
            radius: root.radius
        }
    }

    /*
    Text {
        text: `min: ${root.minValue} value: ${root.value} max: ${root.maxValue}`
    }
    */
}
