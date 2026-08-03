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
    visible: true
    width: 1280
    height: 768
    title: qsTr("MISUCO3")

    required property MasterSender senderContext;
    required property MobileSynth synthContext;

    property double buttonWidth: root.width/scaleModel.length
    property double buttonHeight: root.height/2.2

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

    Component.onCompleted: {
        console.log("Main.qml Component.onCompleted")
    }

    Rectangle {
        anchors.fill: parent
        color: "#666"
    }

    PlayArea {
        id: playArea
        width: root.width
        height: root.buttonHeight
        y: root.height-root.buttonHeight
        keys: root.scaleModel
        sender: root.senderContext
        bgColors: root.bgColors
        bgColorsActive: root.bgColorsActive
        fgColors: root.fgColors
    }

    Connections {
        target: playArea
        function onXMod(voiceId :int, note :int, tuning :int, value :double) {
            xyModAssign.xMod(voiceId, note, tuning, value)
        }
    }

    Connections {
        target: playArea
        function onYMod(voiceId :int, note :int, tuning :int, value :double) {
            xyModAssign.yMod(voiceId, note, tuning, value)
        }
    }

    ControlArea {
        x:10
        y:10
        height: 70
        width: 1260

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
            width: 200 * root.synthContext.peak
            height: 15
            color: "Green"
        }

        Rectangle {
            visible: root.synthContext.clip
            x:450
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
            x:250
            y:20

            id: tabBar
            width: parent.width - 260
            currentIndex: swipeView.currentIndex

            TabButton { text: "P1" }
            TabButton { text: "P2" }
            TabButton { text: "P3" }
            TabButton { text: "P4" }
            TabButton { text: "P5" }
            TabButton { text: "P6" }
            TabButton { text: "P7" }
        }
    }

    SwipeView {
        id: swipeView
        y: 80
        width: 640
        height: 375
        currentIndex: tabBar.currentIndex

        interactive: true

        AudioDevice {
            synthesizer: root.synthContext
        }

        ScaleConfig {
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
            id: xyModAssign
            sender: root.senderContext
        }

        Tuning {
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
            modAssign: xyModAssign
            synthesizer: root.synthContext
        }

        Parameters_Osc {
            synthesizer: root.synthContext
        }

        Parameters_Osc_2 {
            synthesizer: root.synthContext
        }

        Parameters_Mod {
            synthesizer: root.synthContext
            modAssign: xyModAssign
        }
    }
}
