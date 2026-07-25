// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

ScaleConfigForm {
    id: root
    
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

    function updateModel() {
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

    function updateScaleSelect() {
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

    function baseButtonPressed(caller) {
        console.log("pressed " + caller.text)
        root.baseNoteIndex=caller.index
        root.updateModel()
    }

    function scaleButtonPressed(caller) {
        console.log("pressed " + caller.text)
        root["binaryScale"+caller.index]=!root["binaryScale"+caller.index]
        root.updateScaleSelect()
    }
    
    // Connect scale select combo box
    Connections {
        target: root.scaleSelect
        function onCurrentIndexChanged() {
            if(root.scaleSelect.currentIndex>=root.binaryScales.length) {
                root.binaryScale0=root.customBinaryScale[0]
                root.binaryScale1=root.customBinaryScale[1]
                root.binaryScale2=root.customBinaryScale[2]
                root.binaryScale3=root.customBinaryScale[3]
                root.binaryScale4=root.customBinaryScale[4]
                root.binaryScale5=root.customBinaryScale[5]
                root.binaryScale6=root.customBinaryScale[6]
                root.binaryScale7=root.customBinaryScale[7]
                root.binaryScale8=root.customBinaryScale[8]
                root.binaryScale9=root.customBinaryScale[9]
                root.binaryScale10=root.customBinaryScale[10]
                root.binaryScale11=root.customBinaryScale[11]
            } else {
                root.binaryScale0=root.binaryScales[root.scaleSelect.currentIndex][0]
                root.binaryScale1=root.binaryScales[root.scaleSelect.currentIndex][1]
                root.binaryScale2=root.binaryScales[root.scaleSelect.currentIndex][2]
                root.binaryScale3=root.binaryScales[root.scaleSelect.currentIndex][3]
                root.binaryScale4=root.binaryScales[root.scaleSelect.currentIndex][4]
                root.binaryScale5=root.binaryScales[root.scaleSelect.currentIndex][5]
                root.binaryScale6=root.binaryScales[root.scaleSelect.currentIndex][6]
                root.binaryScale7=root.binaryScales[root.scaleSelect.currentIndex][7]
                root.binaryScale8=root.binaryScales[root.scaleSelect.currentIndex][8]
                root.binaryScale9=root.binaryScales[root.scaleSelect.currentIndex][9]
                root.binaryScale10=root.binaryScales[root.scaleSelect.currentIndex][10]
                root.binaryScale11=root.binaryScales[root.scaleSelect.currentIndex][11]
            }
            root.updateModel()
        }
    }
    
    // Connect scale note buttons
    Connections {
        target: root.scaleButton_ii
        function onPressed() { root.scaleButtonPressed(root.scaleButton_ii) }
    }
    Connections {
        target: root.scaleButton_II
        function onPressed() { root.scaleButtonPressed(root.scaleButton_II) }
    }
    Connections {
        target: root.scaleButton_iii
        function onPressed() { root.scaleButtonPressed(root.scaleButton_iii) }
    }
    Connections {
        target: scaleButton_III
        function onPressed() { scaleButtonPressed(root.scaleButton_III) }
    }
    Connections {
        target: scaleButton_IV
        function onPressed() { scaleButtonPressed(root.scaleButton_IV) }
    }
    Connections {
        target: scaleButton_v
        function onPressed() { scaleButtonPressed(root.scaleButton_v) }
    }
    Connections {
        target: scaleButton_V
        function onPressed() { scaleButtonPressed(root.scaleButton_V) }
    }
    Connections {
        target: scaleButton_vi
        function onPressed() { scaleButtonPressed(root.scaleButton_vi) }
    }
    Connections {
        target: scaleButton_VI
        function onPressed() { scaleButtonPressed(root.scaleButton_VI) }
    }
    Connections {
        target: scaleButton_vii
        function onPressed() { scaleButtonPressed(root.scaleButton_vii) }
    }
    Connections {
        target: scaleButton_VII
        function onPressed() { scaleButtonPressed(root.scaleButton_VII) }
    }
    
    // Connect base note buttons
    Connections {
        target: baseButton_C
        function onPressed() { baseButtonPressed(baseButton_C) }
    }
    Connections {
        target: baseButton_Cs
        function onPressed() { baseButtonPressed(baseButton_Cs) }
    }
    Connections {
        target: baseButton_D
        function onPressed() { baseButtonPressed(baseButton_D) }
    }
    Connections {
        target: baseButton_Ds
        function onPressed() { baseButtonPressed(baseButton_Ds) }
    }
    Connections {
        target: baseButton_E
        function onPressed() { baseButtonPressed(baseButton_E) }
    }
    Connections {
        target: baseButton_F
        function onPressed() { baseButtonPressed(baseButton_F) }
    }
    Connections {
        target: baseButton_Fs
        function onPressed() { baseButtonPressed(baseButton_Fs) }
    }
    Connections {
        target: baseButton_G
        function onPressed() { baseButtonPressed(baseButton_G) }
    }
    Connections {
        target: baseButton_Gs
        function onPressed() { baseButtonPressed(baseButton_Gs) }
    }
    Connections {
        target: baseButton_A
        function onPressed() { baseButtonPressed(baseButton_A) }
    }
    Connections {
        target: baseButton_As
        function onPressed() { baseButtonPressed(baseButton_As) }
    }
    Connections {
        target: baseButton_B
        function onPressed() { baseButtonPressed(baseButton_B) }
    }
    
    // Connect octave range slider
    Connections {
        target: octaveRangeSlider.first
        function onValueChanged() {
            console.log("set_low_octave " + octaveRangeSlider.first.value)
            lowOctave = octaveRangeSlider.first.value
            updateModel()
        }
    }
    Connections {
        target: octaveRangeSlider.second
        function onValueChanged() {
            console.log("set_high_octave " + octaveRangeSlider.second.value)
            highOctave = octaveRangeSlider.second.value
            updateModel()
        }
    }
}
