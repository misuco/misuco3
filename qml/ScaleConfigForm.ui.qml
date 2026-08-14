// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Item {
    id: root

    property int baseNoteIndex: 0

    property bool binaryScale0
    property bool binaryScale1
    property bool binaryScale2
    property bool binaryScale3
    property bool binaryScale4
    property bool binaryScale5
    property bool binaryScale6
    property bool binaryScale7
    property bool binaryScale8
    property bool binaryScale9
    property bool binaryScale10
    property bool binaryScale11

    property int lowOctave: 4
    property int highOctave: 5

    property var bgColors: []
    property var bgColorsActive: []
    property var fgColors: []

    property var scaleNames: [
        "Major Scale (Inoian)",
        "Minor Scale (Dorian)",
        "Minor Triad",
        "Custom"
    ]

    property var binaryScales: [
        [1,0,1,0,1,1,0,1,0,1,0,1],
        [1,0,1,1,0,1,0,1,0,1,0,1],
        [1,0,0,1,0,0,0,1,0,0,0,0]
    ]

    property var binaryScaleIntValues: []
    property var customBinaryScale: [1,0,0,0,0,0,0,0,0,0,0,0]

    signal scaleModelUpdated(var m)
    
    property alias scaleSelect: scaleSelect
    property alias octaveRangeSlider: octaveRangeSlider

    property alias scaleButton_ii: scaleButton_ii
    property alias scaleButton_II: scaleButton_II
    property alias scaleButton_iii: scaleButton_iii
    property alias scaleButton_III: scaleButton_III
    property alias scaleButton_IV: scaleButton_IV
    property alias scaleButton_v: scaleButton_v
    property alias scaleButton_V: scaleButton_V
    property alias scaleButton_vi: scaleButton_vi
    property alias scaleButton_VI: scaleButton_VI
    property alias scaleButton_vii: scaleButton_vii
    property alias scaleButton_VII: scaleButton_VII
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
        x:10
        y:10
        width: root.width
        height: 130
        text: "Scale"

        ComboBox {
            id: scaleSelect
            x:10
            y:20
            model: root.scaleNames
        }

        ControlButton {
            id: scaleButton_I
            x: 10
            y: 70
            text: "I"
            index: 0
            selected: root.binaryScale0
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: scaleButton_ii
            x: 60
            y: 70
            text: "ii"
            index: 1
            selected: root.binaryScale1
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: scaleButton_II
            x: 110
            y: 70
            text: "II"
            index: 2
            selected: root.binaryScale2
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: scaleButton_iii
            x: 160
            y: 70
            text: "iii"
            index: 3
            selected: root.binaryScale3
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: scaleButton_III
            x: 210
            y: 70
            text: "III"
            index: 4
            selected: root.binaryScale4
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: scaleButton_IV
            x: 260
            y: 70
            text: "IV"
            index: 5
            selected: root.binaryScale5
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: scaleButton_v
            x: 310
            y: 70
            text: "v"
            index: 6
            selected: root.binaryScale6
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: scaleButton_V
            x: 360
            y: 70
            text: "V"
            index: 7
            selected: root.binaryScale7
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: scaleButton_vi
            x: 410
            y: 70
            text: "vi"
            index: 8
            selected: root.binaryScale8
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: scaleButton_VI
            x: 460
            y: 70
            text: "VI"
            index: 9
            selected: root.binaryScale9
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: scaleButton_vii
            x: 510
            y: 70
            text: "vii"
            index: 10
            selected: root.binaryScale10
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: scaleButton_VII
            x: 560
            y: 70
            text: "VII"
            index: 11
            selected: root.binaryScale11
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }
    }

    ControlArea {
        x:10
        y:150
        width: root.width
        height: 80
        text: "Basenote"

        ControlButton {
            id: baseButton_C
            x: 10
            y: 20
            text: "C"
            index: 0
            selected: index===root.baseNoteIndex
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: baseButton_Cs
            x: 60
            y: 20
            text: "C#"
            index: 1
            selected: index===root.baseNoteIndex
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: baseButton_D
            x: 110
            y: 20
            text: "D"
            index: 2
            selected: index===root.baseNoteIndex
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: baseButton_Ds
            x: 160
            y: 20
            text: "D#"
            index: 3
            selected: index===root.baseNoteIndex
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: baseButton_E
            x: 210
            y: 20
            text: "E"
            index: 4
            selected: index===root.baseNoteIndex
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: baseButton_F
            x: 260
            y: 20
            text: "F"
            index: 5
            selected: index===root.baseNoteIndex
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: baseButton_Fs
            x: 310
            y: 20
            text: "F#"
            index: 6
            selected: index===root.baseNoteIndex
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: baseButton_G
            x: 360
            y: 20
            text: "G"
            index: 7
            selected: index===root.baseNoteIndex
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: baseButton_Gs
            x: 410
            y: 20
            text: "G#"
            index: 8
            selected: index===root.baseNoteIndex
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: baseButton_A
            x: 460
            y: 20
            text: "A"
            index: 9
            selected: index===root.baseNoteIndex
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: baseButton_As
            x: 510
            y: 20
            text: "A#"
            index: 10
            selected: index===root.baseNoteIndex
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }

        ControlButton {
            id: baseButton_B
            x: 560
            y: 20
            text: "B"
            index: 11
            selected: index===root.baseNoteIndex
            bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
            fgColor: root.fgColors[index]
        }
    }

    ControlArea {
        x:10
        y:240
        width: root.width
        height: 80
        text: "Octave"

        ControlSliderRange {
            id: octaveRangeSlider
            x:10
            y:10
            snapMode: Slider.SnapAlways
            stepSize: 1

            first.value: root.lowOctave
            second.value: root.highOctave
        }
    }    
}
