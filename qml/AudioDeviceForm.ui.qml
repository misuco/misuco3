// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtCore
import misuco3

Item {
    id: root

    property alias deviceSelect: deviceSelect
    property alias modeSelect: modeSelect
    property alias bufferSizeSelect: bufferSizeSelect
    property MobileSynth synthesizer

    property double rasterWidth: 50
    property double elementSpace: 5
    property double elementRadius: 5
    property bool portrait: false
    property string fontFamily
    property double fontPixelSize: 10

    readonly property double contentWidth: width - 2*elementSpace
    readonly property double comboBoxWidth1: (contentWidth - 4*elementSpace) / 2
    readonly property double comboBoxWidth2: (contentWidth - 4*elementSpace) / 4
    readonly property double buttonSize: rasterWidth - 3*elementSpace

    component GridText: Text {
        font {
            family: root.fontFamily
            pixelSize: root.fontPixelSize
            bold: true
        }
    }

    ControlArea {
        width: root.width
        height: root.height
        fontFamily: root.fontFamily
        fontPixelSize: root.fontPixelSize
        text: "Audio Device / System Info"

        Column {
            y: 2*root.elementSpace
            spacing: root.elementSpace
            padding: root.elementSpace
            Row {
                spacing: root.elementSpace
                ComboBox {
                    id: deviceSelect
                    model: root.synthesizer.deviceList
                    width: root.comboBoxWidth1
                    height: root.buttonSize
                }

                ComboBox {
                    id: bufferSizeSelect
                    model: ["512", "1024", "2048", "4096", "8192", "16384"]
                    width: root.comboBoxWidth2
                    height: root.buttonSize
                }

                ComboBox {
                    id: modeSelect
                    model: ["Pull", "Push"]
                    width: root.comboBoxWidth2
                    height: root.buttonSize
                }
            }

            Grid {
                width: root.contentWidth
                columns: root.portrait ? 2 : 4
                rows: 30
                spacing: root.elementSpace

                ////

                GridText {
                    text: "Sample Rate"
                }

                GridText {
                    text: root.synthesizer.sampleRate
                }

                GridText {
                    text: "Sample format"
                }

                GridText {
                    property int format: root.synthesizer.sampleFormat
                    text:   (format === 1 ? "UInt8" :
                            format === 2 ? "Int16" :
                            format === 3 ? "Int32" :
                            format === 4 ? "Float" : "Unknown") + " / " +
                            root.synthesizer.sampleLittleEndian ? "Little" : "Big"
                }

                ////

                GridText {
                    text: "CH count"
                }

                GridText {
                    text: root.synthesizer.channelCount
                }

                GridText {
                    text: "CH bits"
                }

                GridText {
                    text: root.synthesizer.channelBytes * 8
                }

                ////

                GridText {
                    text: "State"
                }

                GridText {
                    text: root.synthesizer.audioState===0 ? "Active" :
                          root.synthesizer.audioState===1 ? "Suspended" :
                          root.synthesizer.audioState===2 ? "Stopped" :
                          root.synthesizer.audioState===3 ? "Idle" : "Unknown"
                }

                GridText {
                    text: "Mode"
                }

                GridText {
                    text: root.synthesizer.pullMode ? "Pull" : "Push"
                }

                ////

                GridText {
                    text: "Buffer size"
                }

                GridText {
                    text: root.synthesizer.bufferSize
                }

                GridText {
                    text: "Buffer frames"
                }

                GridText {
                    text: root.synthesizer.bufferFrameCount
                }

                ////

                GridText {
                    text: "Read Bytes"
                }

                GridText {
                    text: root.synthesizer.readDataLen
                }


                GridText {
                    text: "Buffer free"
                }

                GridText {
                    text: root.synthesizer.bufferBytesFree
                }

                ////

                GridText {
                    text: "- SCREEN -"
                }

                GridText {
                    text: "-"
                }

                GridText {
                    visible: root.portrait===false
                    text: "-"
                }

                GridText {
                    visible: root.portrait===false
                    text: "-"
                }

                ////

                GridText {
                    text: "Width"
                }

                GridText {
                    text: Screen.width
                }

                GridText {
                    text: "Height"
                }

                GridText {
                    text: Screen.height
                }

                ////

                GridText {
                    text: "PX dens"
                }

                GridText {
                    text: Screen.pixelDensity
                }

                GridText {
                    text: "ratio"
                }

                GridText {
                    text: Screen.devicePixelRatio
                }

                ////

                GridText {
                    text: "Manu"
                }

                GridText {
                    text: Screen.manufacturer + ":"
                }

                GridText {
                    text: "Model"
                }

                GridText {
                    text: Screen.model + ":"
                }

                ////

                GridText {
                    text: "Name"
                }

                GridText {
                    text: Screen.name + ":"
                }

                GridText {
                    text: "Serial"
                }

                GridText {
                    text: Screen.serialNumber + ":"
                }

                ////

                GridText {
                    text: "- MACHINE -"
                }

                GridText {
                    text: "-"
                }

                GridText {
                    visible: root.portrait===false
                    text: "-"
                }

                GridText {
                    visible: root.portrait===false
                    text: "-"
                }

                ////

                GridText {
                    text: "Kernel"
                }

                GridText {
                    text: SystemInformation.kernelType
                }

                GridText {
                    text: "version"
                }

                GridText {
                    text: SystemInformation.kernelVersion
                }

                ////

                GridText {
                    text: "CPU"
                }

                GridText {
                    text: SystemInformation.currentCpuArchitecture
                }

                GridText {
                    text: "word"
                }

                GridText {
                    text: SystemInformation.wordSize
                }

                ////

                GridText {
                    text: "Product"
                }

                GridText {
                    text: SystemInformation.prettyProductName
                }

                GridText {
                    text: "Type"
                }

                GridText {
                    text: SystemInformation.productType
                }

                ////

                GridText {
                    text: "Name"
                }

                GridText {
                    text: SystemInformation.machineHostName
                }

                GridText {
                    text: "UID"
                }

                GridText {
                    text: SystemInformation.machineUniqueId
                }
            }
        }
    }
}
