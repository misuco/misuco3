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
    width: 1024
    height: 768
    title: qsTr("Emboss")
    //color: "lightsteelblue"

    property int buttonWidth: root.width/12
    property int buttonHeight: root.height/2.2
    property var synthesizer: synth

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
        model: [
            {
                i: 0,
                note: 25,
                f: 261.63
            },
            {
                i: 1,
                note: 26,
                f: 277.18
            },
            {
                i: 2,
                note: 27,
                f: 293.66
            },
            {
                i: 3,
                note: 28,
                f: 311.13
            },
            {
                i: 4,
                note: 29,
                f: 329.63
            },
            {
                i: 5,
                note: 30,
                f: 349.23
            },
            {
                i: 6,
                note: 31,
                f: 369.99
            },
            {
                i: 7,
                note: 32,
                f: 392
            },
            {
                i: 8,
                note: 33,
                f: 415.3
            },
            {
                i: 9,
                note: 34,
                f: 440
            },
            {
                i: 10,
                note: 35,
                f: 466.16
            },
            {
                i: 11,
                note: 36,
                f: 493.88
            }
        ]
        delegate: TouchButton {
            x: modelData.i*root.buttonWidth
            y: root.height-root.buttonHeight
            width: root.buttonWidth
            height: root.buttonHeight
            frequency: modelData.f
            voiceId: modelData.i
            note: modelData.note
            holdKeys: root.holdKeys
            synthesizer: root.synthesizer
        }
    }

    ControlArea {
        x:10
        y:10
        height: 70
        width:1014

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
    }

    SwipeView {
        id: gridView
        x: 10
        y: 90
        width: 512
        height: 375
        currentIndex: 0

        interactive: true

        Parameters {}

        Parameters_Osc {}

        Parameters_Osc_2 {}

        Parameters_Mod {}
    }

}
