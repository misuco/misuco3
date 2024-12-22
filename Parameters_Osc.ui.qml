import QtQuick 2.12

Item {
    id: root
    property var synthesizer: synth
    property int wave
    property int octave

    ControlArea {
        x:10
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
                root.synthesizer.set_osc1_level(value)
                console.log("set_osc1_level " + value)
            }
        }

        ControlButton {
            x:10
            y:60
            text: "Wave 0"
            selected: root.wave===0
            onPressed: function() {
                root.synthesizer.set_osc1_wave_type(0)
                root.wave=0
            }
        }

        ControlButton {
            x:70
            y:60
            text: "Wave 1"
            selected: root.wave===1
            onPressed: function() {
                root.synthesizer.set_osc1_wave_type(1)
                root.wave=1
            }
        }

        ControlButton {
            x:130
            y:60
            text: "Wave 2"
            selected: root.wave===2
            onPressed: function() {
                root.synthesizer.set_osc1_wave_type(2)
                root.wave=2
            }
        }

        ControlButton {
            x:190
            y:60
            text: "Wave 3"
            selected: root.wave===3
            onPressed: function() {
                root.synthesizer.set_osc1_wave_type(3)
                root.wave=3
            }
        }

        ControlButton {
            x:250
            y:60
            text: "Wave 4"
            selected: root.wave===4
            onPressed: function() {
                root.synthesizer.set_osc1_wave_type(4)
                root.wave=4
            }
        }



        ControlButton {
            x:10
            y:120
            text: "0"
            selected: root.octave===0
            onPressed: function() {
                root.synthesizer.set_osc1_octave(0)
                root.octave=0
            }
        }

        ControlButton {
            x:70
            y:120
            text: "1"
            selected: root.octave===1
            onPressed: function() {
                root.synthesizer.set_osc1_octave(1)
                root.octave=1
            }
        }

        ControlButton {
            x:130
            y:120
            text: "2"
            selected: root.octave===2
            onPressed: function() {
                root.synthesizer.set_osc1_octave(2)
                root.octave=2
            }
        }

        ControlButton {
            x:190
            y:120
            text: "3"
            selected: root.octave===3
            onPressed: function() {
                root.synthesizer.set_osc1_octave(3)
                root.octave=3
            }
        }

        ControlButton {
            x:250
            y:120
            text: "4"
            selected: root.octave===4
            onPressed: function() {
                root.synthesizer.set_osc1_octave(4)
                root.octave=4
            }
        }
    }
}
