// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

ScaleConfigForm {
    id: root

    property int baseNoteIndex: 0
    property int lowOctave: 4
    property int highOctave: 5

    property var binaryScales: [
        [1,0,1,0,1,1,0,1,0,1,0,1],
        [1,0,1,1,0,1,0,1,0,1,0,1],
        [1,0,0,1,0,0,0,1,0,0,0,0]
    ]

    property var binaryScaleIntValues: []
    property var customBinaryScale: [1,0,0,0,0,0,0,0,0,0,0,0]

    signal scaleModelUpdated(var m)

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
        target: root.scaleButton_III
        function onPressed() { root.scaleButtonPressed(root.scaleButton_III) }
    }
    Connections {
        target: root.scaleButton_IV
        function onPressed() { root.scaleButtonPressed(root.scaleButton_IV) }
    }
    Connections {
        target: root.scaleButton_v
        function onPressed() { root.scaleButtonPressed(root.scaleButton_v) }
    }
    Connections {
        target: root.scaleButton_V
        function onPressed() { root.scaleButtonPressed(root.scaleButton_V) }
    }
    Connections {
        target: root.scaleButton_vi
        function onPressed() { root.scaleButtonPressed(root.scaleButton_vi) }
    }
    Connections {
        target: root.scaleButton_VI
        function onPressed() { root.scaleButtonPressed(root.scaleButton_VI) }
    }
    Connections {
        target: root.scaleButton_vii
        function onPressed() { root.scaleButtonPressed(root.scaleButton_vii) }
    }
    Connections {
        target: root.scaleButton_VII
        function onPressed() { root.scaleButtonPressed(root.scaleButton_VII) }
    }    
}
