import QtQuick 2.12

Item {
    id: root
    property var synthesizer: synth

    ControlArea {
        x:10
        y:10
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
}
