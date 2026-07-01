// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Basic 2.12

//pragma ComponentBehavior: Bound

Window {
    id: root
    visible: true
    width: 1280
    height: 768
    title: qsTr("Emboss")

    property double buttonWidth: root.width/scaleModel.length
    property double buttonHeight: root.height/2.2
    property var synthesizer: synth
    property int palette: 1

    // The tuning model is realized as separate properties to ensure update on value change
    property var tuningModel0: 0
    property var tuningModel1: 0
    property var tuningModel2: 0
    property var tuningModel3: 0
    property var tuningModel4: 0
    property var tuningModel5: 0
    property var tuningModel6: 0
    property var tuningModel7: 0
    property var tuningModel8: 0
    property var tuningModel9: 0
    property var tuningModel10: 0
    property var tuningModel11: 0

    property var scaleModel: [
        {
            note: 25
        }
    ]

    property bool holdKeys

    Component.onCompleted: {
        console.log("Main.qml Component.onCompleted")
    }

    onSynthesizerChanged: {
        console.log("Main.qml onSynthesizerChanged")
        if(synthesizer!==undefined) {
            console.log("Main.qml sythesizer is defined")
        }
    }

    Repeater {
        id: playArea
        model: root.scaleModel
        delegate: TouchButton {
            required property int index
            required property var modelData
            x: index*root.buttonWidth
            y: root.height-root.buttonHeight
            width: root.buttonWidth
            height: root.buttonHeight
            frequency: 0
            voiceId: index
            note: modelData.note
            noteSymbol: modelData.note%12
            palette: root.palette

            tuning: noteSymbol===0 ? root.tuningModel0 :
                    noteSymbol===1 ? root.tuningModel1 :
                    noteSymbol===2 ? root.tuningModel2 :
                    noteSymbol===3 ? root.tuningModel3 :
                    noteSymbol===4 ? root.tuningModel4 :
                    noteSymbol===5 ? root.tuningModel5 :
                    noteSymbol===6 ? root.tuningModel6 :
                    noteSymbol===7 ? root.tuningModel7 :
                    noteSymbol===8 ? root.tuningModel8 :
                    noteSymbol===9 ? root.tuningModel9 :
                    noteSymbol===10 ? root.tuningModel10 : root.tuningModel11

            holdKeys: root.holdKeys
            synthesizer: root.synthesizer
        }
    }

    ControlArea {
        x:10
        y:10
        height: 70
        width: 1260

        Switch {
            id: holdKeysSwitch
            x:10
            y:10
            width: 100
            height: 50
            text: qsTr("Hold")
            onCheckedChanged: function() {
                root.holdKeys=checked
                console.log("holdKeysSwitch " + checked)
            }
        }

        Switch {
            id: arpSwitch
            x:100
            y:10
            width: 100
            height: 50
            text: qsTr("Arp")
            onCheckedChanged: function() {
                root.synthesizer.set_arpeggio_enabled(checked)
                console.log("arpSwitch " + checked)
            }
        }

        Rectangle {
            x:250
            y:10
            width: 200 * root.synthesizer.peak
            height: 50
            color: "Green"
        }

        Rectangle {
            visible: root.synthesizer.clip
            x:450
            y:10
            width: 50
            height: 50
            color: "Red"
        }
    }

    SwipeView {
        id: gridView
        y: 80
        width: 640
        height: 375
        currentIndex: 0

        interactive: true

        ScaleConfig {
            palette: root.palette
            Connections {
                function onScaleModelUpdated(m) {
                    console.log("onScaleModelUpdated:" + JSON.stringify(m))
                    root.scaleModel = m
                }
            }
        }

        Tuning {
            palette: root.palette
            Connections {
                function onTuningUpdated(i,t) {
                    console.log("onTuningUpdated:" + i + " " + t)
                    switch(i) {
                    case 1:
                        root.tuningModel1 = t
                        break
                    case 2:
                        root.tuningModel2 = t
                        break
                    case 3:
                        root.tuningModel3 = t
                        break
                    case 4:
                        root.tuningModel4 = t
                        break
                    case 5:
                        root.tuningModel5 = t
                        break
                    case 6:
                        root.tuningModel6 = t
                        break
                    case 7:
                        root.tuningModel7 = t
                        break
                    case 8:
                        root.tuningModel8 = t
                        break
                    case 9:
                        root.tuningModel9 = t
                        break
                    case 10:
                        root.tuningModel10 = t
                        break
                    case 11:
                        root.tuningModel11 = t
                        break
                    default:
                        root.tuningModel0 = t
                        break
                    }

                }
            }
        }

        Parameters {}

        Parameters_Osc {}

        Parameters_Osc_2 {}

        Parameters_Mod {}
    }
}
