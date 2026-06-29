// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12
import QtQuick.Controls

Item {
    id: root

    property color bgHalfToneActive: "#00AA00"
    property color bgHalfTone:       "#000000"
    property color fgHalfTone:       "#FFFFFF"
    property color bgFullToneActive: "#AAFFAA"
    property color bgFullTone:       "#FFFFFF"
    property color fgFullTone:       "#000000"

    //property string baseNote: "C"
    property int baseNoteIndex: 0
    property var binaryScale: [true,false,false,false,false,false,false,false,false,false,false,false]
    property int lowOctave: 0
    property int highOctave: 9

    signal scaleModelUpdated(var m)

    property var updateModel: function() {
        let scaleModel=[]
        let playArea=0
        for(let octave=lowOctave;octave<=highOctave;octave++) {
            for(let note=0;note<=11;note++) {
                if(root.binaryScale[note]===true) {
                    scaleModel[playArea] = {
                        note: root.baseNoteIndex+note+octave*12
                    }
                    playArea++
                }
            }
        }
        root.scaleModelUpdated(scaleModel)
    }

    property var baseButtonPressed: function(caller) {
        console.log("pressed " + caller.text)
        root.baseNoteIndex=caller.index
        root.updateModel()
    }

    property var scaleButtonPressed: function(caller) {
        console.log("pressed " + caller.text)
        caller.selected=!caller.selected
        binaryScale[caller.index]=caller.selected
        root.updateModel()
    }

    ControlArea {
        x:10
        y:10
        height: 80
        text: "Basenote"

        ControlButton {
            x: 10
            y: 20
            text: "C"
            index: 0
            selected: index===root.baseNoteIndex
            bgColor: selected ? bgFullToneActive : bgFullTone
            fgColor: fgFullTone
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 60
            y: 20
            text: "C#"
            index: 1
            selected: index===root.baseNoteIndex
            bgColor: selected ? bgHalfToneActive : bgHalfTone
            fgColor: fgHalfTone
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 110
            y: 20
            text: "D"
            index: 2
            selected: index===root.baseNoteIndex
            bgColor: selected ? bgFullToneActive : bgFullTone
            fgColor: fgFullTone
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 160
            y: 20
            text: "D#"
            index: 3
            selected: index===root.baseNoteIndex
            bgColor: selected ? bgHalfToneActive : bgHalfTone
            fgColor: fgHalfTone
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 210
            y: 20
            text: "E"
            index: 4
            selected: index===root.baseNoteIndex
            bgColor: selected ? bgFullToneActive : bgFullTone
            fgColor: fgFullTone
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 260
            y: 20
            text: "F"
            index: 5
            selected: index===root.baseNoteIndex
            bgColor: selected ? bgFullToneActive : bgFullTone
            fgColor: fgFullTone
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 310
            y: 20
            text: "F#"
            index: 6
            selected: index===root.baseNoteIndex
            bgColor: selected ? bgHalfToneActive : bgHalfTone
            fgColor: fgHalfTone
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 360
            y: 20
            text: "G"
            index: 7
            selected: index===root.baseNoteIndex
            bgColor: selected ? bgFullToneActive : bgFullTone
            fgColor: fgFullTone
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 410
            y: 20
            text: "G#"
            index: 8
            selected: index===root.baseNoteIndex
            bgColor: selected ? bgHalfToneActive : bgHalfTone
            fgColor: fgHalfTone
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 460
            y: 20
            text: "A"
            index: 9
            selected: index===root.baseNoteIndex
            bgColor: selected ? bgFullToneActive : bgFullTone
            fgColor: fgFullTone
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 510
            y: 20
            text: "A#"
            index: 10
            selected: index===root.baseNoteIndex
            bgColor: selected ? bgHalfToneActive : bgHalfTone
            fgColor: fgHalfTone
            onPressed: baseButtonPressed(this)
        }

        ControlButton {
            x: 560
            y: 20
            text: "B"
            index: 11
            selected: index===root.baseNoteIndex
            bgColor: selected ? bgFullToneActive : bgFullTone
            fgColor: fgFullTone
            onPressed: baseButtonPressed(this)
        }
    }

    ControlArea {
        x:10
        y:100
        height: 130
        text: "Scale"

        ComboBox {
            x:10
            y:20
            model: ["Major", "Minor", "Custom"]
        }

        ControlButton {
            x: 10
            y: 70
            text: "I"
            index: 0
            selected: true
            bgColor: selected ? bgFullToneActive : bgFullTone
            fgColor: fgFullTone
            //onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 60
            y: 70
            text: "ii"
            index: 1
            bgColor: selected ? bgHalfToneActive : bgHalfTone
            fgColor: fgHalfTone
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 110
            y: 70
            text: "II"
            index: 2
            bgColor: selected ? bgFullToneActive : bgFullTone
            fgColor: fgFullTone
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 160
            y: 70
            text: "iii"
            index: 3
            bgColor: selected ? bgHalfToneActive : bgHalfTone
            fgColor: fgHalfTone
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 210
            y: 70
            text: "III"
            index: 4
            bgColor: selected ? bgFullToneActive : bgFullTone
            fgColor: fgFullTone
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 260
            y: 70
            text: "IV"
            index: 5
            bgColor: selected ? bgFullToneActive : bgFullTone
            fgColor: fgFullTone
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 310
            y: 70
            text: "v"
            index: 6
            bgColor: selected ? bgHalfToneActive : bgHalfTone
            fgColor: fgHalfTone
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 360
            y: 70
            text: "V"
            index: 7
            bgColor: selected ? bgFullToneActive : bgFullTone
            fgColor: fgFullTone
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 410
            y: 70
            text: "vi"
            index: 8
            bgColor: selected ? bgHalfToneActive : bgHalfTone
            fgColor: fgHalfTone
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 460
            y: 70
            text: "VI"
            index: 9
            bgColor: selected ? bgFullToneActive : bgFullTone
            fgColor: fgFullTone
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 510
            y: 70
            text: "vii"
            index: 10
            bgColor: selected ? bgHalfToneActive : bgHalfTone
            fgColor: fgHalfTone
            onPressed: scaleButtonPressed(this)
        }

        ControlButton {
            x: 560
            y: 70
            text: "VII"
            index: 11
            bgColor: selected ? bgFullToneActive : bgFullTone
            fgColor: fgFullTone
            onPressed: scaleButtonPressed(this)
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
