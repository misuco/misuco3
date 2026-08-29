// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Item {
    id: root

    property double elementSpace: 5
    property bool portrait: false

    readonly property double contentWidth: width - 2*elementSpace
    readonly property double elementWidth: portrait ? contentWidth : (contentWidth - elementSpace) / 2
    readonly property double contentHeight: height - 2*elementSpace
    readonly property double elementHeight: portrait ? (contentHeight - 4*elementSpace) / 3  : (contentHeight - 3*elementSpace) / 2
    readonly property int gridRows: 2
    readonly property int gridColumns: portrait ? 1 : 2

    property alias arpeggioSamplesSlider: arpeggioSamplesSlider
    property alias arpeggioOctavesSlider: arpeggioOctavesSlider
    property alias arpeggioStepSlider: arpeggioStepSlider

    ControlArea {
        width: root.width
        height: root.height

        text: "Arpeggio"

        Column {
            y: 2*root.elementSpace

            leftPadding: root.elementSpace
            spacing: root.elementSpace

            Grid {
                rows: root.gridRows
                columns: root.gridColumns
                spacing: root.elementSpace


                ControlSlider {
                    id: arpeggioOctavesSlider
                    width: root.elementWidth
                    height: root.elementHeight
                    text: "Octaves"
                    from: 1
                    to: 5
                    value: 2
                    stepSize: 1
                    snapMode: Slider.SnapAlways
                }

                ControlSlider {
                    id: arpeggioStepSlider
                    width: root.elementWidth
                    height: root.elementHeight
                    text: "Step"
                    from: 0
                    to: 4
                    value: 1
                }
            }

            ControlSlider {
                id: arpeggioSamplesSlider
                width: root.contentWidth
                height: root.elementHeight
                text: "Samples"
                from: 1000
                to: 200000
                value: 48000
            }
        }
    }
}
