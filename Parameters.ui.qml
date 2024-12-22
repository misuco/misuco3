import QtQuick 2.12

Item {
    id: root
    property var synthesizer: synth

    ControlArea {
        x:10
        y:10
        height: 180
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

        ControlSlider {
            x:10
            y:70
            text: "Octaves"
            from: 1
            to: 5
            value: 2
            onValueChanged: function() {
                console.log("set_arpeggio_octaves " + value)
                root.synthesizer.set_arpeggio_octaves(value)
            }
        }

        ControlSlider {
            x:10
            y:120
            text: "Step"
            from: 0
            to: 4
            value: 1
            onValueChanged: function() {
                console.log("set_arpeggio_step " + value)
                root.synthesizer.set_arpeggio_step(value)
            }
        }
    }

    ControlArea {
        x:10
        y:210
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

}
