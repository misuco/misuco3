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


    /*

    ControlArea {
        x:10
        y:10
        height: 70

        Switch {
            id: holdKeysSwitch
            x:10
            y:10
            width: 100
            height: 50
            text: qsTr("Hold")
            onCheckedChanged: function() {
                root.holdKeys=checked
                console.log(checked)
            }
        }
    }

    ControlArea {
        x:10
        y:90
        height: 70
        text: "Arpeggio"

        ControlSlider {
            x:10
            y:10
            text: "Samples"
            from: 1000
            to: 200000
            value: 48000
            onValueChanged: function() {
                console.log("set_arpeggio_samples " + value)
                root.synthesizer.set_arpeggio_samples(value)
            }
        }
    }

    ControlArea {
        x:10
        y:170
        height: 120
        text: "Filter"

        ControlSlider {
            x:10
            y:10
            text: "Cutoff"
            from: 1
            to: 1000
            value: 1
            onValueChanged: function() {
                root.synthesizer.set_filter_cutoff(value)
            }
        }

        ControlSlider {
            x:10
            y:60
            text: "Resonance"
            from: 0.0
            to: 1.0
            value: 0.1
            onValueChanged: function() {
                root.synthesizer.set_filter_resonance(value)
            }
        }
    }

    ControlArea {
        x:500
        y:10
        height: 170
        text: "OSC1"

        ControlSlider {
            x:10
            y:10
            text: "Level"
            from: 0
            to: 1
            value: 0.5
            onValueChanged: function() {
                console.log("set_osc1_level " + value)
            }
        }

        ControlSlider {
            x:10
            y:60
            text: "Wave"
            from: 0
            to: 4
            value: 0
            onValueChanged: function() {
                root.synthesizer.set_osc1_wave_type(value)
            }
        }

        ControlSlider {
            x:10
            y:110
            text: "Octave"
            from: 0
            to: 5
            value: 0
            onValueChanged: function() {
                root.synthesizer.set_osc1_octave(value)
            }
        }
    }

    ControlArea {
        x:500
        y:190
        height: 220
        text: "OSC2"

        ControlSlider {
            x:10
            y:10
            text: "Level"
            from: 0
            to: 1
            stepSize: 0.01
            value: 0.5
            onValueChanged: function() {
                root.synthesizer.set_osc2_level(value)
            }
        }

        ControlSlider {
            x:10
            y:60
            text: "Wave"
            from: 0
            to: 4
            stepSize: 1
            value: 0
            onValueChanged: function() {
                root.synthesizer.set_osc2_wave_type(value)
            }
        }

        ControlSlider {
            x:10
            y:110
            text: "Octave"
            from: 0
            to: 5
            stepSize: 1
            value: 0
            onValueChanged: function() {
                root.synthesizer.set_osc2_octave(value)
            }
        }

        ControlSlider {
            x:10
            y:160
            text: "Shift"
            from: 0
            to: 1200
            value: 0
            onValueChanged: function() {
                root.synthesizer.set_osc2_shift(value)
            }
        }
    }
    */
}
