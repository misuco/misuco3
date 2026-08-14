// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls
import misuco3

Item {
    id: root

    property alias deviceSelect: deviceSelect
    property alias modeSelect: modeSelect
    property alias bufferSizeSelect: bufferSizeSelect
    property MobileSynth synthesizer

    ControlArea {
        x:10
        y:10
        width: root.width
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
            model: root.synthesizer.deviceList
        }

        Text {
            x:10
            y:80
            text: "Read Data Bytes:"
        }

        Text {
            x:160
            y:80
            text: root.synthesizer.readDataLen
        }

        Text {
            x:10
            y:100
            text: "Sample Rate:"
        }

        Text {
            x:160
            y:100
            text: root.synthesizer.sampleRate
        }

        Text {
            x:10
            y:120
            text: "Channel bits:"
        }

        Text {
            x:160
            y:120
            text: root.synthesizer.channelBytes * 8
        }

        Text {
            x:10
            y:140
            text: "Channel count:"
        }

        Text {
            x:160
            y:140
            text: root.synthesizer.channelCount
        }

        Text {
            x:10
            y:160
            text: "Sample format:"
        }

        Text {
            property int format: root.synthesizer.sampleFormat
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
            text: root.synthesizer.sampleLittleEndian ? "Little" : "Big"
        }

        Text {
            x:10
            y:200
            text: "Mode:"
        }

        Text {
            x:160
            y:200
            text: root.synthesizer.pullMode ? "Pull" : "Push"
        }

        Text {
            x:10
            y:220
            text: "State:"
        }

        Text {
            x:160
            y:220
            text: root.synthesizer.audioState===0 ? "Active" :
                  root.synthesizer.audioState===1 ? "Suspended" :
                  root.synthesizer.audioState===2 ? "Stopped" :
                  root.synthesizer.audioState===3 ? "Idle" : "Unknown"
        }

        Text {
            x:10
            y:240
            text: "Buffer size:"
        }

        Text {
            x:160
            y:240
            text: root.synthesizer.bufferSize
        }

        Text {
            x:10
            y:260
            text: "Buffer frames:"
        }

        Text {
            x:160
            y:260
            text: root.synthesizer.bufferFrameCount
        }

        Text {
            x:10
            y:280
            text: "Buffer free:"
        }

        Text {
            x:160
            y:280
            text: root.synthesizer.bufferBytesFree
        }
    }
}
