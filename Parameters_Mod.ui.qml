import QtQuick 2.12

Item {
    id: root
    property var synthesizer: synth
    property int source
    property int destination

    ControlArea {
        x:10
        y:10
        height: 240
        text: "MOD"

        ControlSlider {
            x:10
            y:10
            text: "Amount"
            from: 0
            to: 1
            value: 0.5
            onValueChanged: function() {
                root.synthesizer.set_modulation_amount(value)
                console.log("set_modulation_amount " + value)
            }
        }

        ControlSlider {
            x:10
            y:60
            text: "Freq"
            from: 0
            to: 20
            value: 2
            onValueChanged: function() {
                root.synthesizer.set_modulation_frequency(value)
                console.log("set_modulation_frequency " + value)
            }
        }

        ControlButton {
            x:10
            y:120
            text: "SQUARE"
            selected: root.source===0
            onPressed: function() {
                root.synthesizer.set_modulation_source(0)
                root.source=0
            }
        }

        ControlButton {
            x:70
            y:120
            text: "TRI"
            selected: root.source===1
            onPressed: function() {
                root.synthesizer.set_modulation_source(1)
                root.source=1
            }
        }

        ControlButton {
            x:130
            y:120
            text: "SAW"
            selected: root.source===2
            onPressed: function() {
                root.synthesizer.set_modulation_source(2)
                root.source=2
            }
        }

        ControlButton {
            x:190
            y:120
            text: "REVSAW"
            selected: root.source===3
            onPressed: function() {
                root.synthesizer.set_modulation_source(3)
                root.source=3
            }
        }

        ControlButton {
            x:10
            y:180
            text: "WAVE"
            selected: root.destination===0
            onPressed: function() {
                root.synthesizer.set_modulation_destination(0)
                root.destination=0
            }
        }

        ControlButton {
            x:70
            y:180
            text: "PITCH"
            selected: root.destination===1
            onPressed: function() {
                root.synthesizer.set_modulation_destination(1)
                root.destination=1
            }
        }

        ControlButton {
            x:130
            y:180
            text: "FILTER"
            selected: root.destination===2
            onPressed: function() {
                root.synthesizer.set_modulation_destination(2)
                root.destination=2
            }
        }
    }
}
