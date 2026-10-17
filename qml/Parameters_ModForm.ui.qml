// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick

Item {
    id: root

    property int source
    property int destination

    property double rasterWidth: 50
    property double elementSpace: 5
    property double elementRadius: 5
    property bool portrait: false

    property string fontFamily
    property double fontPixelSize: 10

    property color bgColor: "Gray"
    property color bgColorActive: "Orange"
    property color fgColor: "Black"

    readonly property double contentWidth: width - 2*elementSpace
    readonly property double contentWidth2: (width - 3*elementSpace) / 2
    readonly property double sliderHeight: rasterWidth - 3*elementSpace
    readonly property double buttonSize: sliderHeight * (portrait ? 0.9 : 1)

    property alias amountSlider: amountSlider
    property alias freqSlider: freqSlider
    property alias sourceSquareButton: sourceSquareButton
    property alias sourceTriButton: sourceTriButton
    property alias sourceSawButton: sourceSawButton
    property alias sourceRevsawButton: sourceRevsawButton
    property alias destWaveButton: destWaveButton
    property alias destPitchButton: destPitchButton
    property alias destFilterButton: destFilterButton

    ControlArea {
        width: root.width
        height: root.height
        fontFamily: root.fontFamily
        fontPixelSize: root.fontPixelSize
        text: "MOD"

        Column {
            y: 2*root.elementSpace
            padding: root.elementSpace
            //spacing: root.elementSpace

            Grid {

                rows: 2
                columns: root.portrait ? 1 : 2
                spacing: root.elementSpace

                ControlSlider {
                    id: amountSlider
                    width: root.portrait ? root.contentWidth : root.contentWidth2
                    height: root.sliderHeight
                    fontFamily: root.fontFamily
                    fontPixelSize: root.fontPixelSize
                    text: "Amount"
                    from: 0
                    to: 1
                    value: 0.5
                    stepSize: 0.01
                }

                ControlSlider {
                    id: freqSlider
                    width: root.portrait ? root.contentWidth : root.contentWidth2
                    height: root.sliderHeight
                    fontFamily: root.fontFamily
                    fontPixelSize: root.fontPixelSize
                    text: "Freq"
                    from: 0
                    to: 1
                    value: 0.5
                    stepSize: 0.01
                }
            }

            Row {
                spacing: root.elementSpace
                topPadding: root.portrait ? root.elementSpace : 0

                ControlButton {
                    id: sourceSquareButton
                    width: root.buttonSize
                    height: root.buttonSize
                    bgColor: selected ? root.bgColorActive : root.bgColor
                    fgColor: root.fgColor
                    text: ""
                    icon {
                        width: parent.width
                        height: parent.height
                        color: root.fgColor
                        source: "qrc:/qt/qml/misuco3/qml/icons/wave-square.svg"
                    }
                    selected: root.source===0
                }

                ControlButton {
                    id: sourceTriButton
                    width: root.buttonSize
                    height: root.buttonSize
                    bgColor: selected ? root.bgColorActive : root.bgColor
                    fgColor: root.fgColor
                    text: ""
                    icon {
                        width: parent.width
                        height: parent.height
                        color: root.fgColor
                        source: "qrc:/qt/qml/misuco3/qml/icons/wave-tri.svg"
                    }
                    selected: root.source===1
                }

                ControlButton {
                    id: sourceSawButton
                    width: root.buttonSize
                    height: root.buttonSize
                    bgColor: selected ? root.bgColorActive : root.bgColor
                    fgColor: root.fgColor
                    text: ""
                    icon {
                        width: parent.width
                        height: parent.height
                        color: root.fgColor
                        source: "qrc:/qt/qml/misuco3/qml/icons/wave-saw.svg"
                    }
                    selected: root.source===2
                }

                ControlButton {
                    id: sourceRevsawButton
                    width: root.buttonSize
                    height: root.buttonSize
                    bgColor: selected ? root.bgColorActive : root.bgColor
                    fgColor: root.fgColor
                    text: ""
                    icon {
                        width: parent.width
                        height: parent.height
                        color: root.fgColor
                        source: "qrc:/qt/qml/misuco3/qml/icons/wave-saw-rev.svg"
                    }
                    selected: root.source===3
                }

                Item {
                    id: spacer
                    visible: root.portrait===false
                    width: root.buttonSize
                    height: root.buttonSize
                }

                ControlButton {
                    id: destWaveButton
                    width: root.buttonSize
                    height: root.buttonSize
                    bgColor: selected ? root.bgColorActive : root.bgColor
                    fgColor: root.fgColor
                    text: "AMP"
                    selected: root.destination===0
                }

                ControlButton {
                    id: destPitchButton
                    width: root.buttonSize
                    height: root.buttonSize
                    bgColor: selected ? root.bgColorActive : root.bgColor
                    fgColor: root.fgColor
                    text: "PITCH"
                    selected: root.destination===1
                }

                ControlButton {
                    id: destFilterButton
                    width: root.buttonSize
                    height: root.buttonSize
                    bgColor: selected ? root.bgColorActive : root.bgColor
                    fgColor: root.fgColor
                    text: "FILTER"
                    selected: root.destination===2
                }
            }
        }
    }
}
