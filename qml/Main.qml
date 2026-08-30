// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Basic
import misuco3
import "./"

pragma ComponentBehavior: Bound

ApplicationWindow {
    id: root

    required property MasterSender senderContext
    required property MobileSynth synthContext

    readonly property bool portrait: height > width

    property var scaleModel: [
        {
            note: 25
        }
    ]

    property bool holdKeys: false
    property bool arpOn: false

    property var bgColors: [
        "#403",
        "#512",
        "#633",
        "#742",
        "#750",
        "#452",
        "#264",
        "#165",
        "#065",
        "#046",
        "#135",
        "#314"
    ]

    property var bgColorsActive: [
        "#817",
        "#a35",
        "#c66",
        "#e94",
        "#ed0",
        "#9d5",
        "#4d8",
        "#2cb",
        "#0bc",
        "#09c",
        "#36b",
        "#639"
    ]

    property var fgColors: [
        "#f2e",
        "#f6a",
        "#fcc",
        "#ff8",
        "#ff0",
        "#ffa",
        "#8ff",
        "#4ff",
        "#0ff",
        "#0ff",
        "#6cf",
        "#c6f"
    ]

    visible: true
    title: qsTr("MISUCO3")

    Component.onCompleted: {
        width=Math.min(Screen.width,1920)
        height=Math.min(Screen.height,1080)
    }

    FontLoader {
        id: misuco3font
        source: "qrc:/qt/qml/misuco3/qml/fonts/alpha-prota/AlphaProta.otf"
    }

    font {
        family: misuco3font.name
        pixelSize: viewContainer.elementSpace * 2
        bold: true
    }

    Rectangle {
        id: appBackground
        anchors.fill: parent
        color: "#333"
    }

    Item {
        id: viewContainer

        // Raster 12mm @ 60x140mm display
        property double rasterWidth: root.portrait ? width / 6 : height / 6
        property double elementSpace: rasterWidth / 12
        property double elementRadius: rasterWidth / 12        
        property double effectSize: 3

        property double contentWidth: width - 2*elementSpace

        property double headerHeight: rasterWidth
        property double swipeHeight: rasterWidth * (root.portrait ? 3 : 2) - viewContainer.elementSpace
        property double playAreaHeight: height - headerHeight - swipeHeight

        x: root.SafeArea.margins.left
        y: root.SafeArea.margins.top
        width: root.width - root.SafeArea.margins.left - root.SafeArea.margins.right
        height: root.height - root.SafeArea.margins.top - root.SafeArea.margins.bottom

        XYAssignableParameter {
            id: xyAssignableParameter
            sender: root.senderContext
        }

        ControlArea {
            id: headerArea

            property int tabCount: 11

            readonly property double buttonHeight: viewContainer.rasterWidth - 5*viewContainer.elementSpace
            readonly property double buttonWidth: viewContainer.rasterWidth

            x:viewContainer.elementSpace
            y:viewContainer.elementSpace

            width: viewContainer.contentWidth
            height: viewContainer.headerHeight - 2*viewContainer.elementSpace

            elementRadius: viewContainer.elementRadius

            text: ""

            Row {
                x: viewContainer.elementSpace
                y: viewContainer.elementSpace

                spacing: viewContainer.elementSpace
                topPadding: viewContainer.elementSpace
                rightPadding: viewContainer.elementSpace

                ControlButton {
                    id: holdKeysSwitch
                    width: headerArea.buttonWidth
                    height: headerArea.buttonHeight
                    text: "hold"
                    selected: root.holdKeys
                    bgColor: root.holdKeys ? "Orange" : "Gray"
                    fgColor: "White"
                    onPressed: {
                        root.holdKeys=!root.holdKeys
                    }
                }

                ControlButton {
                    id: arpSwitch
                    width: headerArea.buttonWidth
                    height: headerArea.buttonHeight
                    text: "arp"
                    selected: root.arpOn
                    bgColor: root.arpOn ? "Orange" : "Gray"
                    fgColor: "White"
                    onPressed: {
                        root.arpOn=!root.arpOn
                        root.synthContext.set_arpeggio_enabled(root.arpOn)
                    }
                }

                /*
                ControlButton {
                    id: portraitSwitch
                    width: headerArea.buttonWidth
                    height: headerArea.buttonHeight
                    text: "⤸"
                    selected: pressed
                    bgColor: pressed ? "Orange" : "Gray"
                    fgColor: "White"
                    onPressed: {
                        if(root.width===1920) {
                            root.width=1080
                            root.height=1920
                        } else {
                            root.width=1920
                            root.height=1080
                        }
                    }
                }
                */

                ControlButton {
                    id: tabLeft
                    width: headerArea.buttonWidth
                    height: headerArea.buttonHeight
                    text: "<"
                    selected: pressed
                    bgColor: pressed ? "Orange" : "Gray"
                    fgColor: "White"
                    onPressed: {
                        swipeView.currentIndex = Math.max(swipeView.currentIndex-1,0)
                    }
                }

                ControlEmboss {
                    id: tabBar

                    visible: root.portrait===false
                    width: headerArea.width - headerArea.buttonWidth*4 - 8*viewContainer.elementSpace
                    height: headerArea.buttonHeight
                    readonly property int tabWidth: width / headerArea.tabCount - viewContainer.elementSpace

                    Row {
                        width: tabBar.width
                        height: tabBar.height
                        leftPadding: viewContainer.elementSpace
                        spacing: viewContainer.elementSpace

                        Repeater {
                            model: headerArea.tabCount
                            delegate: Item {
                                id: tabIndicator
                                required property int index
                                width: tabBar.tabWidth
                                height: tabBar.height
                                ControlEmboss {
                                    width: parent.width
                                    height: width / 2
                                    radius: width / 2

                                    down: mouseArea.pressed ? true : false

                                    anchors.centerIn: parent

                                    bgColor: swipeView.currentIndex===tabIndicator.index || mouseArea.pressed ? "Orange" : "Gray"

                                    Text {
                                        anchors.fill: parent
                                        text: `${tabIndicator.index+1}`
                                        horizontalAlignment: Qt.AlignHCenter
                                        verticalAlignment: Qt.AlignVCenter
                                    }
                                    MouseArea {
                                        id: mouseArea
                                        anchors.fill: parent
                                        onClicked: swipeView.currentIndex=tabIndicator.index
                                    }
                                }
                            }
                        }
                    }
                }

                ControlButton {
                    id: tabRight
                    width: headerArea.buttonWidth
                    height: headerArea.buttonHeight
                    text: ">"
                    selected: pressed
                    bgColor: pressed ? "Orange" : "Gray"
                    fgColor: "White"
                    onPressed: {
                        swipeView.currentIndex = Math.min(swipeView.currentIndex+1,headerArea.tabCount-1)
                    }
                }
            }

            Item {
                id: vuMeter

                readonly property double barWidth: width*0.95
                readonly property double clipWidth: width*0.05

                x:viewContainer.elementSpace
                y:height + viewContainer.effectSize
                width: headerArea.width - 4*viewContainer.elementSpace
                height: viewContainer.elementSpace / 3

                Rectangle {
                    width: vuMeter.barWidth * root.synthContext.peak
                    height: vuMeter.height
                    color: "Green"
                }

                Rectangle {
                    visible: root.synthContext.clip
                    x:vuMeter.barWidth
                    width: vuMeter.clipWidth
                    height: vuMeter.height
                    color: "Red"

                    Text {
                        anchors.fill: parent
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                        text: root.synthContext.clipLen
                        color: "White"
                        font.pixelSize: vuMeter.height
                    }
                }
            }
        }

        PlayArea {
            id: playArea

            sender: root.senderContext

            x: viewContainer.elementSpace
            y: viewContainer.swipeHeight + viewContainer.headerHeight + viewContainer.elementSpace

            width: viewContainer.contentWidth
            height: viewContainer.playAreaHeight - viewContainer.elementSpace

            keys: root.scaleModel
            holdKeys: root.holdKeys
            bgColors: root.bgColors
            bgColorsActive: root.bgColorsActive
            fgColors: root.fgColors
        }

        SwipeView {
            id: swipeView

            x: viewContainer.elementSpace
            y: viewContainer.headerHeight

            width: viewContainer.contentWidth
            height: currentIndex === 4                  ? viewContainer.swipeHeight + viewContainer.playAreaHeight : // Tuning
                    currentIndex === 8 && root.portrait ? viewContainer.swipeHeight + viewContainer.rasterWidth :    // OSC2 Parameters
                    viewContainer.swipeHeight

            contentWidth: viewContainer.contentWidth

            interactive: true

            ScaleConfig {
                id: scaleConfigArea

                height: viewContainer.swipeHeight

                rasterWidth: viewContainer.rasterWidth
                elementSpace: viewContainer.elementSpace
                elementRadius: viewContainer.elementRadius
                portrait: root.portrait

                bgColors: root.bgColors
                bgColorsActive: root.bgColorsActive
                fgColors: root.fgColors

                Connections {
                    function onScaleModelUpdated(m) {
                        console.log("onScaleModelUpdated:" + JSON.stringify(m))
                        root.scaleModel = m
                    }
                }
            }

            RangeConfig {
                id: rangeConfigArea

                height: viewContainer.swipeHeight

                rasterWidth: viewContainer.rasterWidth
                elementSpace: viewContainer.elementSpace
                elementRadius: viewContainer.elementRadius
                portrait: root.portrait

                bgColors: root.bgColors
                bgColorsActive: root.bgColorsActive
                fgColors: root.fgColors

                Connections {
                    function onBaseNoteUpdated(n) {
                        console.log(`onBaseNoteUpdated: ${n}`)
                        scaleConfigArea.baseNoteIndex = n
                        scaleConfigArea.updateModel()
                    }
                }

                Connections {
                    function onLowOctaveUpdated(o) {
                        console.log(`onLowOctaveUpdated: ${o}`)
                        scaleConfigArea.lowOctave = o
                        scaleConfigArea.updateModel()
                    }
                }

                Connections {
                    function onHighOctaveUpdated(o) {
                        console.log(`onHighOctaveUpdated: ${o}`)
                        scaleConfigArea.highOctave = o
                        scaleConfigArea.updateModel()
                    }
                }
            }

            XYModAssign {
                id: xModAssign

                height: viewContainer.swipeHeight

                rasterWidth: viewContainer.rasterWidth
                elementSpace: viewContainer.elementSpace
                elementRadius: viewContainer.elementRadius
                portrait: root.portrait

                title: "X Mod Assign"

                sender: root.senderContext
                parameters: xyAssignableParameter
            }

            XYModAssign {
                id: yModAssign

                height: viewContainer.swipeHeight

                rasterWidth: viewContainer.rasterWidth
                elementSpace: viewContainer.elementSpace
                elementRadius: viewContainer.elementRadius
                portrait: root.portrait

                title: "Y Mod Assign"

                sender: root.senderContext
                parameters: xyAssignableParameter
            }

            Tuning {
                id: tuningArea

                sender: root.senderContext

                height: viewContainer.swipeHeight + viewContainer.playAreaHeight + viewContainer.elementSpace

                rasterWidth: viewContainer.rasterWidth
                elementSpace: viewContainer.elementSpace
                elementRadius: viewContainer.elementRadius
                portrait: root.portrait

                bgColors: root.bgColors
                bgColorsActive: root.bgColorsActive
                fgColors: root.fgColors

                Connections {
                    function onTuningUpdated(i,t) {
                        console.log("onTuningUpdated:" + i + " " + t)
                        switch(i) {
                        case 1:
                            playArea.tuningModel1 = t
                            break
                        case 2:
                            playArea.tuningModel2 = t
                            break
                        case 3:
                            playArea.tuningModel3 = t
                            break
                        case 4:
                            playArea.tuningModel4 = t
                            break
                        case 5:
                            playArea.tuningModel5 = t
                            break
                        case 6:
                            playArea.tuningModel6 = t
                            break
                        case 7:
                            playArea.tuningModel7 = t
                            break
                        case 8:
                            playArea.tuningModel8 = t
                            break
                        case 9:
                            playArea.tuningModel9 = t
                            break
                        case 10:
                            playArea.tuningModel10 = t
                            break
                        case 11:
                            playArea.tuningModel11 = t
                            break
                        default:
                            playArea.tuningModel0 = t
                            break
                        }
                    }
                }
            }

            Parameters_Arp {
                synthesizer: root.synthContext
                elementSpace: viewContainer.elementSpace
            }

            Parameters_Filter {
                modAssign: xyAssignableParameter
                elementSpace: viewContainer.elementSpace
            }

            Parameters_Osc_1 {
                rasterWidth: viewContainer.rasterWidth
                elementSpace: viewContainer.elementSpace
                elementRadius: viewContainer.elementRadius
                portrait: root.portrait
                synthesizer: root.synthContext
            }

            Parameters_Osc_2 {
                rasterWidth: viewContainer.rasterWidth
                elementSpace: viewContainer.elementSpace
                elementRadius: viewContainer.elementRadius
                portrait: root.portrait
                synthesizer: root.synthContext
            }

            Parameters_Mod {
                //width: swipeView.areasWidth
                modAssign: xyAssignableParameter
                synthesizer: root.synthContext
            }

            AudioDevice {
                //id: audioDeviceArea
                //width: swipeView.areasWidth
                //height: swipeView.height
                synthesizer: root.synthContext
                displayInfo: `${root.title} w: ${viewContainer.width} h: ${viewContainer.height} w: ${Screen.width} / ${Screen.width/Screen.pixelDensity} mm h: ${Screen.height}  / ${Screen.height/Screen.pixelDensity} mm pixel ratio: ${Screen.devicePixelRatio} density: ${Screen.pixelDensity}`
            }
        }

        Connections {
            target: playArea
            function onXMod(voiceId :int, note :int, tuning :int, value :double) {
                xModAssign.xyMod(voiceId, note, tuning, value)
            }
        }

        Connections {
            target: playArea
            function onYMod(voiceId :int, note :int, tuning :int, value :double) {
                yModAssign.xyMod(voiceId, note, tuning, value)
            }
        }
    }
}
