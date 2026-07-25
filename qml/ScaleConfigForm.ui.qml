// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12
import QtQuick.Controls
import "ColorPalette.js" as Palette

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

    property int palette: 1

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

    ControlArea {
        x:10
        y:10
        height: 130
        text: "Scale"

        ComboBox {
            id: scaleSelect
            x:10
            y:20
            model: scaleNames
        }

        ControlButton {
            id: scaleButton_I
            x: 10
            y: 70
            text: "I"
            index: 0
            selected: binaryScale0
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: scaleButton_ii
            x: 60
            y: 70
            text: "ii"
            index: 1
            selected: binaryScale1
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: scaleButton_II
            x: 110
            y: 70
            text: "II"
            index: 2
            selected: binaryScale2
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: scaleButton_iii
            x: 160
            y: 70
            text: "iii"
            index: 3
            selected: binaryScale3
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: scaleButton_III
            x: 210
            y: 70
            text: "III"
            index: 4
            selected: binaryScale4
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: scaleButton_IV
            x: 260
            y: 70
            text: "IV"
            index: 5
            selected: binaryScale5
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: scaleButton_v
            x: 310
            y: 70
            text: "v"
            index: 6
            selected: binaryScale6
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: scaleButton_V
            x: 360
            y: 70
            text: "V"
            index: 7
            selected: binaryScale7
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: scaleButton_vi
            x: 410
            y: 70
            text: "vi"
            index: 8
            selected: binaryScale8
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: scaleButton_VI
            x: 460
            y: 70
            text: "VI"
            index: 9
            selected: binaryScale9
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: scaleButton_vii
            x: 510
            y: 70
            text: "vii"
            index: 10
            selected: binaryScale10
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: scaleButton_VII
            x: 560
            y: 70
            text: "VII"
            index: 11
            selected: binaryScale11
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }
    }

    ControlArea {
        x:10
        y:150
        height: 80
        text: "Basenote"

        ControlButton {
            id: baseButton_C
            x: 10
            y: 20
            text: "C"
            index: 0
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: baseButton_Cs
            x: 60
            y: 20
            text: "C#"
            index: 1
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: baseButton_D
            x: 110
            y: 20
            text: "D"
            index: 2
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: baseButton_Ds
            x: 160
            y: 20
            text: "D#"
            index: 3
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: baseButton_E
            x: 210
            y: 20
            text: "E"
            index: 4
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: baseButton_F
            x: 260
            y: 20
            text: "F"
            index: 5
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: baseButton_Fs
            x: 310
            y: 20
            text: "F#"
            index: 6
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: baseButton_G
            x: 360
            y: 20
            text: "G"
            index: 7
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: baseButton_Gs
            x: 410
            y: 20
            text: "G#"
            index: 8
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: baseButton_A
            x: 460
            y: 20
            text: "A"
            index: 9
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: baseButton_As
            x: 510
            y: 20
            text: "A#"
            index: 10
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }

        ControlButton {
            id: baseButton_B
            x: 560
            y: 20
            text: "B"
            index: 11
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
        }
    }

    ControlArea {
        x:10
        y:240
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
