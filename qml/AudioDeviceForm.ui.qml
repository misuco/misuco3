// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12
import QtQuick.Controls

Item {
    id: root
    required property var synthesizer
    property alias deviceSelect: deviceSelect
    property alias modeSelect: modeSelect
    property alias bufferSizeSelect: bufferSizeSelect

    ControlArea {
        x:10
        y:10
        height: 310
        text: "Audio Device"

        ComboBox {
            id: modeSelect
            x:10
            y:20
            model: ["Pull", "Push"]
        }

        ComboBox {
            id: bufferSizeSelect
            x:200
            y:20
            model: ["512", "1024", "2048", "4096", "8192", "16384"]
        }

        ComboBox {
            id: deviceSelect
            x:400
            y:20
            model: synthesizer.deviceList
        }

        Text {
            x:10
            y:80
            text: "Read Data Bytes:"
        }

        Text {
            x:160
            y:80
            text: synthesizer.readDataLen
        }

        Text {
            x:10
            y:100
            text: "Sample Rate:"
        }

        Text {
            x:160
            y:100
            text: synthesizer.sampleRate
        }

        Text {
            x:10
            y:120
            text: "Channel bits:"
        }

        Text {
            x:160
            y:120
            text: synthesizer.channelBytes * 8
        }

        Text {
            x:10
            y:140
            text: "Channel count:"
        }

        Text {
            x:160
            y:140
            text: synthesizer.channelCount
        }

        Text {
            x:10
            y:160
            text: "Sample format:"
        }

        Text {
            property int format: synthesizer.sampleFormat
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
            text: synthesizer.sampleLittleEndian ? "Little" : "Big"
        }

        Text {
            x:10
            y:200
            text: "Mode:"
        }

        Text {
            x:160
            y:200
            text: synthesizer.pullMode ? "Pull" : "Push"
        }

        Text {
            x:10
            y:220
            text: "State:"
        }

        Text {
            x:160
            y:220
            text: synthesizer.audioState===0 ? "Active" :
                  synthesizer.audioState===1 ? "Suspended" :
                  synthesizer.audioState===2 ? "Stopped" :
                  synthesizer.audioState===3 ? "Idle" : "Unknown"
        }

        Text {
            x:10
            y:240
            text: "Buffer size:"
        }

        Text {
            x:160
            y:240
            text: synthesizer.bufferSize
        }

        Text {
            x:10
            y:260
            text: "Buffer frames:"
        }

        Text {
            x:160
            y:260
            text: synthesizer.bufferFrameCount
        }

        Text {
            x:10
            y:280
            text: "Buffer free:"
        }

        Text {
            x:160
            y:280
            text: synthesizer.bufferBytesFree
        }
    }
}
