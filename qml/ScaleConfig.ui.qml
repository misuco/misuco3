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

    function getBinaryScaleIntValue(s) {
        let value=0
        let bitValue=1
        s.forEach((bit) => {
            if(bit) { value+=bitValue }
            bitValue*=2
        });
        return value;
    }

    Component.onCompleted: {
        root.binaryScales.forEach((scale,index) => {
            root.binaryScaleIntValues[index] = getBinaryScaleIntValue(scale);
        });
    }

    property var customBinaryScale: [1,0,0,0,0,0,0,0,0,0,0,0]

    signal scaleModelUpdated(var m)

    property var updateModel: function() {
        let scaleModel=[]
        let playArea=0
        for(let octave=lowOctave;octave<=highOctave;octave++) {
            for(let note=0;note<=11;note++) {
                if(root["binaryScale"+note]===true) {
                    scaleModel[playArea] = {
                        note: root.baseNoteIndex+note+octave*12
                    }
                    playArea++
                }
            }
        }
        root.scaleModelUpdated(scaleModel)
    }

    property var updateScaleSelect: function() {
        let currentBinaryScaleArray = [
            root.binaryScale0,
            root.binaryScale1,
            root.binaryScale2,
            root.binaryScale3,
            root.binaryScale4,
            root.binaryScale5,
            root.binaryScale6,
            root.binaryScale7,
            root.binaryScale8,
            root.binaryScale9,
            root.binaryScale10,
            root.binaryScale11
        ]

        let currentIntValue = getBinaryScaleIntValue( currentBinaryScaleArray )

        let regularScaleIndex=root.binaryScaleIntValues.indexOf(currentIntValue)

        if(regularScaleIndex>=0) {
            scaleSelect.currentIndex=regularScaleIndex
        } else {
            root.customBinaryScale=currentBinaryScaleArray
            scaleSelect.currentIndex=binaryScales.length
        }

        root.updateModel()
    }

    property var baseButtonPressed: function(caller) {
        console.log("pressed " + caller.text)
        root.baseNoteIndex=caller.index
        root.updateModel()
    }

    property var scaleButtonPressed: function(caller) {
        console.log("pressed " + caller.text)
        root["binaryScale"+caller.index]=!root["binaryScale"+caller.index]
        root.updateScaleSelect()
    }

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
            onCurrentIndexChanged: function() {
                if(currentIndex>=binaryScales.length) {
                    binaryScale0=customBinaryScale[0]
                    binaryScale1=customBinaryScale[1]
                    binaryScale2=customBinaryScale[2]
                    binaryScale3=customBinaryScale[3]
                    binaryScale4=customBinaryScale[4]
                    binaryScale5=customBinaryScale[5]
                    binaryScale6=customBinaryScale[6]
                    binaryScale7=customBinaryScale[7]
                    binaryScale8=customBinaryScale[8]
                    binaryScale9=customBinaryScale[9]
                    binaryScale10=customBinaryScale[10]
                    binaryScale11=customBinaryScale[11]
                } else {
                    binaryScale0=binaryScales[currentIndex][0]
                    binaryScale1=binaryScales[currentIndex][1]
                    binaryScale2=binaryScales[currentIndex][2]
                    binaryScale3=binaryScales[currentIndex][3]
                    binaryScale4=binaryScales[currentIndex][4]
                    binaryScale5=binaryScales[currentIndex][5]
                    binaryScale6=binaryScales[currentIndex][6]
                    binaryScale7=binaryScales[currentIndex][7]
                    binaryScale8=binaryScales[currentIndex][8]
                    binaryScale9=binaryScales[currentIndex][9]
                    binaryScale10=binaryScales[currentIndex][10]
                    binaryScale11=binaryScales[currentIndex][11]
                }
                root.updateModel()
            }
        }

        ControlButton {
            x: 10
            y: 70
            text: "I"
            index: 0
            selected: binaryScale0
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            //onPressed: base note in scale cannot be removed
        }

        ControlButton {
            x: 60
            y: 70
            text: "ii"
            index: 1
            selected: binaryScale1
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 110
            y: 70
            text: "II"
            index: 2
            selected: binaryScale2
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 160
            y: 70
            text: "iii"
            index: 3
            selected: binaryScale3
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 210
            y: 70
            text: "III"
            index: 4
            selected: binaryScale4
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 260
            y: 70
            text: "IV"
            index: 5
            selected: binaryScale5
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 310
            y: 70
            text: "v"
            index: 6
            selected: binaryScale6
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 360
            y: 70
            text: "V"
            index: 7
            selected: binaryScale7
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 410
            y: 70
            text: "vi"
            index: 8
            selected: binaryScale8
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 460
            y: 70
            text: "VI"
            index: 9
            selected: binaryScale9
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 510
            y: 70
            text: "vii"
            index: 10
            selected: binaryScale10
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 560
            y: 70
            text: "VII"
            index: 11
            selected: binaryScale11
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: scaleButtonPressed(this)
        }
    }

    ControlArea {
        x:10
        y:150
        height: 80
        text: "Basenote"

        ControlButton {
            x: 10
            y: 20
            text: "C"
            index: 0
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 60
            y: 20
            text: "C#"
            index: 1
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 110
            y: 20
            text: "D"
            index: 2
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 160
            y: 20
            text: "D#"
            index: 3
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 210
            y: 20
            text: "E"
            index: 4
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 260
            y: 20
            text: "F"
            index: 5
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 310
            y: 20
            text: "F#"
            index: 6
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 360
            y: 20
            text: "G"
            index: 7
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 410
            y: 20
            text: "G#"
            index: 8
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 460
            y: 20
            text: "A"
            index: 9
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 510
            y: 20
            text: "A#"
            index: 10
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 560
            y: 20
            text: "B"
            index: 11
            selected: index===root.baseNoteIndex
            bgColor: Palette.bg(root.palette,index,selected)
            fgColor: Palette.fg(root.palette,index)
            onPressed: baseButtonPressed(this)
        }
    }

    ControlArea {
        x:10
        y:240
        height: 80
        text: "Octave"

        ControlSliderRange {
            x:10
            y:10
            snapMode: Slider.SnapAlways
            stepSize: 1

            first.value: root.lowOctave
            second.value: root.highOctave

            first.onValueChanged: function() {
                console.log("set_low_octave " + first.value)
                lowOctave = first.value
                updateModel()
            }

            second.onValueChanged: function() {
                console.log("set_high_octave " + second.value)
                highOctave = second.value
                updateModel()
            }
        }
    }    
}
