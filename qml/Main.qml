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
    readonly property double buttonWidth: root.width/scaleModel.length
    readonly property double buttonHeight: root.height/2.2

    readonly property double sizeScaleFactor: Math.min( portrait ? width / 1080 : width / 1920 , portrait ? height / 1920 : height / 1080 )

    property var scaleModel: [
        {
            note: 25
        }
    ]

    property bool holdKeys

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
    width: Screen.width
    height: Screen.height
    title: qsTr("MISUCO3")

    Rectangle {
        id: appBackground
        anchors.fill: parent
        color: "#333"
    }

    Item {
        id: viewRoot

        readonly property int baseWidth: root.portrait ? 1080 : 1920
        readonly property int baseHeight: root.portrait ? 1920 : 1080

        anchors {
            fill: parent
            topMargin: parent.SafeArea.margins.top;
            bottomMargin: parent.SafeArea.margins.bottom;
            leftMargin: parent.SafeArea.margins.left;
            rightMargin: parent.SafeArea.margins.right;
        }

        Item {
            id: viewContainer
            anchors.centerIn: parent
            width: root.portrait ? 1080 : 1920
            height: root.portrait ? 1920 : 1080

            scale: root.sizeScaleFactor

            XYAssignableParameter {
                id: xyAssignableParameter
            }

            ControlArea {
                id: headerArea

                readonly property double vumeterWidth: viewRoot.baseWidth - 270

                x:10
                y:10
                height: 70
                width: viewRoot.baseWidth - 20

                //text: `${root.title} w: ${root.width} h: ${root.height} pixel ratio: ${Screen.devicePixelRatio} density: ${Screen.pixelDensity}`
                text: `${root.title}  w: ${root.width} h: ${root.height} scale: ${root.sizeScaleFactor}  pixel ratio: ${Screen.devicePixelRatio} density: ${Screen.pixelDensity}`

                Switch {
                    id: holdKeysSwitch
                    x:10
                    y:10
                    width: 100
                    height: 50
                    text: qsTr("Hold")
                    onCheckedChanged: function() {
                        root.holdKeys=checked
                        console.log("holdKeysSwitch " + checked)
                    }
                }

                Switch {
                    id: arpSwitch
                    x:100
                    y:10
                    width: 100
                    height: 50
                    text: qsTr("Arp")
                    onCheckedChanged: function() {
                        root.synthContext.set_arpeggio_enabled(checked)
                        console.log("arpSwitch " + checked)
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

                // TabBar for clicking to navigate pages
                TabBar {
                    id: tabBar

                    readonly property int tabCount: 8
                    readonly property double tabWidth: width / tabCount

                    x:250
                    y:20
                    width: viewRoot.baseWidth - 320
                    currentIndex: swipeView.currentIndex

                    Repeater {
                        model: tabBar.tabCount
                        delegate: TabButton {
                            required property int index
                            width: tabBar.tabWidth
                            text: `${index+1}`
                        }
                    }
                }
            }

            SwipeView {
                id: swipeView

                readonly property double areasWidth: root.portrait ? parent.width - 20 : parent.width / 2 - 30

                anchors {
                    top: headerArea.bottom
                    topMargin: 10
                }

                width: viewRoot.baseWidth - 20
                contentWidth: areasWidth
                height: 375
                currentIndex: tabBar.currentIndex

                interactive: true

                AudioDevice {
                    width: swipeView.areasWidth
                    synthesizer: root.synthContext
                }

                ScaleConfig {
                    id: scaleConfigArea
                    width: swipeView.areasWidth
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

                XYModAssign {
                    id: xModAssign
                    width: swipeView.areasWidth
                    title: "X Mod Assign"
                    sender: root.senderContext
                    parameters: xyAssignableParameter
                }

                XYModAssign {
                    id: yModAssign
                    width: swipeView.areasWidth
                    title: "Y Mod Assign"
                    sender: root.senderContext
                    parameters: xyAssignableParameter
                }

                Tuning {
                    id: tuningArea
                    width: swipeView.areasWidth
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
                    width: swipeView.areasWidth
                    modAssign: xyAssignableParameter
                    synthesizer: root.synthContext
                }

                Parameters_Osc {
                    width: swipeView.areasWidth
                    synthesizer: root.synthContext
                }

                Parameters_Osc_2 {
                    width: swipeView.areasWidth
                    synthesizer: root.synthContext
                }

                Parameters_Mod {
                    width: swipeView.areasWidth
                    modAssign: xyAssignableParameter
                    synthesizer: root.synthContext
                }
            }

            PlayArea {
                id: playArea
                x: 10
                y: 450
                width: viewRoot.baseWidth-20
                height: viewRoot.baseHeight-475
                keys: root.scaleModel
                sender: root.senderContext
                bgColors: root.bgColors
                bgColorsActive: root.bgColorsActive
                fgColors: root.fgColors
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
}
