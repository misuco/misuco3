// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Item {
    id: root

    property double rasterWidth: 50
    property double elementSpace: 5
    property double elementRadius: 5
    property bool portrait: false
    property string fontFamily
    property double fontPixelSize: 10

    property var bgColors: []
    property var bgColorsActive: []
    property var fgColors: []

    property bool binaryScale0
    property bool binaryScale1
    property bool binaryScale2
    property bool binaryScale3
    property bool binaryScale4
    property bool binaryScale5
    property bool binaryScale6
    property bool binaryScale7
    property bool binaryScale8
    property bool binaryScale9
    property bool binaryScale10
    property bool binaryScale11

    readonly property double buttonSize: rasterWidth - 3*elementSpace
    
    property alias scaleSelect: scaleSelect

    property alias scaleButton_ii: scaleButton_ii
    property alias scaleButton_II: scaleButton_II
    property alias scaleButton_iii: scaleButton_iii
    property alias scaleButton_III: scaleButton_III
    property alias scaleButton_IV: scaleButton_IV
    property alias scaleButton_v: scaleButton_v
    property alias scaleButton_V: scaleButton_V
    property alias scaleButton_vi: scaleButton_vi
    property alias scaleButton_VI: scaleButton_VI
    property alias scaleButton_vii: scaleButton_vii
    property alias scaleButton_VII: scaleButton_VII

    property var scaleNames: [
        "Major Scale (Inoian)",
        "Minor Scale (Dorian)",
        "Minor Triad",
        "Custom"
    ]

    ControlArea {
        width: root.width
        height: root.height
        fontFamily: root.fontFamily
        fontPixelSize: root.fontPixelSize
        elementRadius: root.elementRadius

        text: "Scale"

        Column {
            y: 2* root.elementSpace

            leftPadding: root.elementSpace
            spacing: root.elementSpace

            ComboBox {
                id: scaleSelect
                width: root.buttonSize * (root.portrait ? 6 : 12)
                height: root.buttonSize
                model: root.scaleNames
            }

            Grid {
                columns: root.portrait ? 6 : 12
                rows: 2 //root.portrait ? 2 : 1
                spacing: root.elementSpace

                ControlButton {
                    id: scaleButton_I
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "I"
                    index: 0
                    selected: root.binaryScale0
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: scaleButton_ii
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "ii"
                    index: 1
                    selected: root.binaryScale1
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: scaleButton_II
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "II"
                    index: 2
                    selected: root.binaryScale2
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: scaleButton_iii
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "iii"
                    index: 3
                    selected: root.binaryScale3
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: scaleButton_III
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "III"
                    index: 4
                    selected: root.binaryScale4
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: scaleButton_IV
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "IV"
                    index: 5
                    selected: root.binaryScale5
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: scaleButton_v
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "v"
                    index: 6
                    selected: root.binaryScale6
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: scaleButton_V
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "V"
                    index: 7
                    selected: root.binaryScale7
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: scaleButton_vi
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "vi"
                    index: 8
                    selected: root.binaryScale8
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: scaleButton_VI
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "VI"
                    index: 9
                    selected: root.binaryScale9
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: scaleButton_vii
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "vii"
                    index: 10
                    selected: root.binaryScale10
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }

                ControlButton {
                    id: scaleButton_VII
                    width: root.buttonSize
                    height: root.buttonSize
                    text: "VII"
                    index: 11
                    selected: root.binaryScale11
                    bgColor: selected ? root.bgColorsActive[index] : root.bgColors[index]
                    fgColor: root.fgColors[index]
                }
            }
        }
    }
}
