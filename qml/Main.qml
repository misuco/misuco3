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

Window {
    id: root

    required property MasterSender senderContext
    required property MobileSynth synthContext

    readonly property bool portrait: height > width

    onWidthChanged: { console.log(`root:Window w: ${width}`) }
    onHeightChanged: { console.log(`root:Window h: ${height}`) }
    onPortraitChanged: { console.log(`root:Window portrait: ${portrait}`) }

    property var scaleModel: [
        {
            note: 25
        }
    ]

    property bool holdKeys
    property bool arpOn

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
        width=1920 //Screen.width
        height=1080 //Screen.height
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
        property double contentWidth: width - 2*elementSpace

        property double headerHeight: rasterWidth
        property double swipeHeight: rasterWidth * (root.portrait ? 3 : 2)
        property double playAreaHeight: height - headerHeight - swipeHeight

        x: root.SafeArea.margins.left
        y: root.SafeArea.margins.top
        width: root.width - root.SafeArea.margins.left - root.SafeArea.margins.right
        height: root.height - root.SafeArea.margins.top - root.SafeArea.margins.bottom

        XYAssignableParameter {
            id: xyAssignableParameter
        }

        ControlArea {
            id: headerArea

            property int tabCount: 10

            readonly property double vumeterWidth: width * 0.5
            readonly property double buttonHeight: viewContainer.rasterWidth - 5*viewContainer.elementSpace
            readonly property double buttonWidth: viewContainer.rasterWidth

            x:viewContainer.elementSpace
            y:viewContainer.elementSpace

            width: viewContainer.contentWidth
            height: viewContainer.headerHeight - 2*viewContainer.elementSpace

            elementRadius: viewContainer.elementRadius

            //text: `${root.title} w: ${root.width} h: ${root.height} pixel ratio: ${Screen.devicePixelRatio} density: ${Screen.pixelDensity}`
            //text: `${root.title}  w: ${root.width} h: ${root.height} scale: ${root.sizeScaleFactor}  pixel ratio: ${Screen.devicePixelRatio} density: ${Screen.pixelDensity}`
            text: `${root.title} w: ${viewContainer.width} h: ${viewContainer.height} w: ${Screen.width} / ${Screen.width/Screen.pixelDensity} mm h: ${Screen.height}  / ${Screen.height/Screen.pixelDensity} mm pixel ratio: ${Screen.devicePixelRatio} density: ${Screen.pixelDensity}`

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

                ControlButton {
                    id: tabLeft
                    width: headerArea.buttonWidth
                    height: headerArea.buttonHeight
                    text: "◀"
                    selected: pressed
                    bgColor: pressed ? "Orange" : "Gray"
                    fgColor: "White"
                    onPressed: {
                        swipeView.currentIndex = Math.max(swipeView.currentIndex-1,0)
                    }
                }

                ControlEmboss {
                    id: tabBar

                    width: headerArea.width - headerArea.buttonWidth*5 - 7*viewContainer.elementSpace
                    height: headerArea.buttonHeight
                    readonly property int tabWidth: width / headerArea.tabCount

                    Row {
                        width: tabBar.width
                        height: tabBar.height
                        Repeater {
                            model: headerArea.tabCount
                            delegate: Item {
                                id: tabIndicator
                                required property int index
                                width: tabBar.tabWidth
                                height: tabBar.height
                                ControlEmboss {
                                    width: parent.width / 2
                                    height: width
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
                    text: "▶"
                    selected: pressed
                    bgColor: pressed ? "Orange" : "Gray"
                    fgColor: "White"
                    onPressed: {
                        swipeView.currentIndex = Math.min(swipeView.currentIndex+1,headerArea.tabCount-1)
                    }
                }
            }

            Rectangle {
                x:250
                y:2

                width: headerArea.vumeterWidth * root.synthContext.peak
                height: 15
                color: "Green"
            }

            Rectangle {
                visible: root.synthContext.clip
                x:250+headerArea.vumeterWidth
                y:2
                width: 50
                height: 15
                color: "Red"

                Text {
                    anchors.fill: parent
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    text: root.synthContext.clipLen
                    color: "White"
                }
            }
        }

        PlayArea {
            id: playArea

            x: viewContainer.elementSpace
            y: viewContainer.swipeHeight + viewContainer.headerHeight

            width: viewContainer.contentWidth
            height: viewContainer.playAreaHeight - viewContainer.elementSpace

            keys: root.scaleModel
            sender: root.senderContext
            bgColors: root.bgColors
            bgColorsActive: root.bgColorsActive
            fgColors: root.fgColors
        }

        SwipeView {
            id: swipeView

            x: viewContainer.elementSpace
            y: viewContainer.headerHeight

            width: viewContainer.contentWidth
            height: viewContainer.swipeHeight - viewContainer.elementSpace

            contentWidth: viewContainer.contentWidth

            interactive: true

            ScaleConfig {
                id: scaleConfigArea

                width: swipeView.width
                height: swipeView.height

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

                width: swipeView.width
                height: swipeView.height

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

                rasterWidth: viewContainer.rasterWidth
                elementSpace: viewContainer.elementSpace
                elementRadius: viewContainer.elementRadius
                portrait: root.portrait

                height: swipeView.height + playArea.height + viewContainer.elementSpace

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

            Parameters {
                //width: swipeView.width
                modAssign: xyAssignableParameter
                synthesizer: root.synthContext
            }

            Parameters_Osc {
                //width: swipeView.areasWidth
                synthesizer: root.synthContext
            }

            Parameters_Osc_2 {
                //width: swipeView.areasWidth
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

        /*
        Rectangle {
            x: 0
            y: 0
            width: viewContainer.elementSpace
            height: viewContainer.headerHeight
            color: "Red"
        }
        Rectangle {
            x: 0
            y: viewContainer.headerHeight
            width: viewContainer.elementSpace
            height: viewContainer.swipeHeight
            color: "Green"
        }
        Rectangle {
            x: 0
            y: viewContainer.headerHeight + viewContainer.swipeHeight
            width: viewContainer.elementSpace
            height: viewContainer.playAreaHeight
            color: "Blue"
        }

        Rectangle {
            x: 0
            y: viewContainer.headerHeight + viewContainer.swipeHeight + viewContainer.playAreaHeight - viewContainer.elementSpace
            width: viewContainer.elementSpace
            height: viewContainer.elementSpace
            color: "Red"
        }
        */
    }
}
