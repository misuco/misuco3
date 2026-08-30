// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Item {
    id: root

    property int wave
    property int octave

    property double rasterWidth: 50
    property double elementSpace: 5
    property double elementRadius: 5
    property bool portrait: false

    property string fontFamily
    property double fontPixelSize: 10

    property color bgColor: "Gray"
    property color bgColorActive: "Orange"
    property color fgColor: "Black"

    readonly property double contentWidth: width - 2*elementSpace
    readonly property double buttonSize: rasterWidth - 3*elementSpace
    readonly property int gridRows: 2
    readonly property int gridColumns: portrait ? 6 : 12

    property alias levelSlider: levelSlider
    property alias wave0Button: woGrid.wave0Button
    property alias wave1Button: woGrid.wave1Button
    property alias wave2Button: woGrid.wave2Button
    property alias wave3Button: woGrid.wave3Button
    property alias wave4Button: woGrid.wave4Button
    property alias octave0Button: woGrid.octave0Button
    property alias octave1Button: woGrid.octave1Button
    property alias octave2Button: woGrid.octave2Button
    property alias octave3Button: woGrid.octave3Button
    property alias octave4Button: woGrid.octave4Button

    ControlArea {
        width: root.width
        height: root.height
        fontFamily: root.fontFamily
        fontPixelSize: root.fontPixelSize
        text: "OSC1"

        Column {
            y: 2*root.elementSpace

            leftPadding: root.elementSpace
            spacing: root.elementSpace

            ControlSlider {
                id: levelSlider
                width: root.contentWidth
                height: root.buttonSize
                fontFamily: root.fontFamily
                fontPixelSize: root.fontPixelSize
                text: "Level"
                from: 0
                to: 1
                value: 0.5
                stepSize: 0.01
            }

            Parameters_Osc_WaveOctaveGrid {
                id: woGrid

                elementSpace: root.elementSpace
                portrait: root.portrait
                buttonSize: root.buttonSize

                bgColor: root.bgColor
                bgColorActive: root.bgColorActive
                fgColor: root.fgColor

                wave: root.wave
                octave: root.octave
            }
        }
    }
}
