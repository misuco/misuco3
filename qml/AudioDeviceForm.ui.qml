// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12
import QtQuick.Controls

Item {
    id: root
    property var synthesizer: synth
    property alias deviceSelect: deviceSelect
    property alias modeSelect: modeSelect

    ControlArea {
        x:10
        y:10
        height: 310
        text: "Audio Device"

        ComboBox {
            id: modeSelect
            x:10
            y:20
            model: ["Push", "Pull"]
        }

        ComboBox {
            x:200
            y:20
            model: ["512", "1024"]
        }

        ComboBox {
            id: deviceSelect
            x:400
            y:20
            model: synth.deviceList
        }

        Text {
            x:10
            y:80
            text: "Read Data Bytes:"
        }

        Text {
            x:160
            y:80
            text: synth.readDataLen
        }

        Text {
            x:10
            y:100
            text: "Sample Rate:"
        }

        Text {
            x:160
            y:100
            text: synth.sampleRate
        }

        Text {
            x:10
            y:120
            text: "Channel bits:"
        }

        Text {
            x:160
            y:120
            text: synth.channelBytes * 8
        }

        Text {
            x:10
            y:140
            text: "Channel count:"
        }

        Text {
            x:160
            y:140
            text: synth.channelCount
        }

        Text {
            x:10
            y:160
            text: "Sample format:"
        }

        Text {
            property int format: synth.sampleFormat
            x:160
            y:160
            text:   format === 1 ? "UInt8" :
                    format === 2 ? "Int16" :
                    format === 3 ? "Int32" :
                    format === 4 ? "Float" : "Unknown"
        }

        Text {
            x:10
            y:180
            text: "Sample endianness:"
        }

        Text {
            x:160
            y:180
            text: synth.sampleLittleEndian ? "Little" : "Big"
        }

        Text {
            x:10
            y:200
            text: "Mode:"
        }

        Text {
            x:160
            y:200
            text: synth.pullMode ? "Pull" : "Push"
        }

        Text {
            x:10
            y:220
            text: "State:"
        }

        Text {
            x:160
            y:220
            text: synth.audioState===0 ? "Active" :
                  synth.audioState===1 ? "Suspended" :
                  synth.audioState===2 ? "Stopped" :
                  synth.audioState===3 ? "Idle" : "Unknown"
        }
    }
}
