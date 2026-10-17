// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Item {
    id: root

    property double rasterWidth: 50
    property double elementSpace: 5
    property bool portrait: false

    property string fontFamily
    property double fontPixelSize: 10

    readonly property double contentWidth: width - 2*elementSpace
    readonly property double elementWidth: portrait ? contentWidth : (contentWidth - elementSpace) / 2
    readonly property double elementHeight: rasterWidth - (portrait ? 2 : 3)*elementSpace
    readonly property int gridRows: 2
    readonly property int gridColumns: portrait ? 1 : 2

    property alias arpeggioSamplesSlider: arpeggioSamplesSlider
    property alias arpeggioOctavesSlider: arpeggioOctavesSlider
    property alias arpeggioStepSlider: arpeggioStepSlider

    ControlArea {
        width: root.width
        height: root.height
        fontFamily: root.fontFamily
        fontPixelSize: root.fontPixelSize

        text: "Arpeggio"

        Column {
            y: 2*root.elementSpace

            padding: root.elementSpace
            //spacing: root.elementSpace

            Grid {
                rows: root.gridRows
                columns: root.gridColumns
                spacing: root.elementSpace

                ControlSlider {
                    id: arpeggioOctavesSlider
                    width: root.elementWidth
                    height: root.elementHeight
                    fontFamily: root.fontFamily
                    fontPixelSize: root.fontPixelSize
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
                    fontFamily: root.fontFamily
                    fontPixelSize: root.fontPixelSize
                    text: "Step"
                    from: 1
                    to: 4
                    value: 1
                    stepSize: 1
                }
            }

            ControlSlider {
                id: arpeggioSamplesSlider
                width: root.contentWidth
                height: root.elementHeight
                fontFamily: root.fontFamily
                fontPixelSize: root.fontPixelSize
                text: "Samples"
                from: 1000
                to: 200000
                value: 48000
                stepSize: 1
            }
        }
    }
}
