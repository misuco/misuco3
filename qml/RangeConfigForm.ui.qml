// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Item {
    id: root

    property int baseNoteIndex: 0

    property double rasterWidth: 50
    property double elementSpace: 5
    property double elementRadius: 5
    property bool portrait: false

    property var bgColors: []
    property var bgColorsActive: []
    property var fgColors: []

    readonly property double buttonSize: rasterWidth - 3*elementSpace
    
    property alias octaveRangeSlider: octaveRangeSlider

    property alias baseButton_C: baseButton_C
    property alias baseButton_Cs: baseButton_Cs
    property alias baseButton_D: baseButton_D
    property alias baseButton_Ds: baseButton_Ds
    property alias baseButton_E: baseButton_E
    property alias baseButton_F: baseButton_F
    property alias baseButton_Fs: baseButton_Fs
    property alias baseButton_G: baseButton_G
    property alias baseButton_Gs: baseButton_Gs
    property alias baseButton_A: baseButton_A
    property alias baseButton_As: baseButton_As
    property alias baseButton_B: baseButton_B

    ControlArea {
        width: root.width
        height: root.height

        text: "Range"

        Column {
            y: root.elementSpace
            padding: root.elementSpace

            Grid {
                columns: root.portrait ? 6 : 12
                rows: 2 //root.portrait ? 2 : 1

                padding: root.elementSpace

                ControlButton {
                    id: baseButton_C
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "C"
                    index: 0
                    selected: index===root.baseNoteIndex
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: baseButton_Cs
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "C#"
                    index: 1
                    selected: index===root.baseNoteIndex
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: baseButton_D
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "D"
                    index: 2
                    selected: index===root.baseNoteIndex
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: baseButton_Ds
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "D#"
                    index: 3
                    selected: index===root.baseNoteIndex
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: baseButton_E
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "E"
                    index: 4
                    selected: index===root.baseNoteIndex
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: baseButton_F
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "F"
                    index: 5
                    selected: index===root.baseNoteIndex
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: baseButton_Fs
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "F#"
                    index: 6
                    selected: index===root.baseNoteIndex
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: baseButton_G
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "G"
                    index: 7
                    selected: index===root.baseNoteIndex
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: baseButton_Gs
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "G#"
                    index: 8
                    selected: index===root.baseNoteIndex
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: baseButton_A
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "A"
                    index: 9
                    selected: index===root.baseNoteIndex
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: baseButton_As
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "A#"
                    index: 10
                    selected: index===root.baseNoteIndex
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: baseButton_B
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "B"
                    index: 11
                    selected: index===root.baseNoteIndex
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }
            }

            ControlSliderRange {
                id: octaveRangeSlider

                width: root.width - 2*root.elementSpace
                height: root.buttonSize

                snapMode: Slider.SnapAlways
                stepSize: 1

                elementRadius:root.elementRadius

                first.value: 4
                second.value: 5
            }
        }
    }
}
