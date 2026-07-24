// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Basic 2.12

pragma ComponentBehavior: Bound

Window {
    id: root
    visible: true
    width: 1280
    height: 768
    title: qsTr("MISUCO3")

    property double buttonWidth: root.width/scaleModel.length
    property double buttonHeight: root.height/2.2
    property int palette: 1

    property var scaleModel: [
        {
            note: 25
        }
    ]

    property bool holdKeys

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
        synthesizer: synthContext
        sender: senderContext
        palette: root.palette
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
                synthContext.set_arpeggio_enabled(checked)
                console.log("arpSwitch " + checked)
            }
        }

        Rectangle {
            x:250
            y:2
            width: 200 * synthContext.peak
            height: 15
            color: "Green"
        }

        Rectangle {
            visible: synthContext.clip
            x:450
            y:2
            width: 50
            height: 15
            color: "Red"

            Text {
                anchors.fill: parent
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                text: synthContext.clipLen
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
            synthesizer: synthContext
        }

        ScaleConfig {
            palette: root.palette
            Connections {
                function onScaleModelUpdated(m) {
                    console.log("onScaleModelUpdated:" + JSON.stringify(m))
                    root.scaleModel = m
                }
            }
        }

        Tuning {
            palette: root.palette
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
            synthesizer: synthContext
        }

        Parameters_Osc {
            synthesizer: synthContext
        }

        Parameters_Osc_2 {
            synthesizer: synthContext
        }

        Parameters_Mod {
            synthesizer: synthContext
        }
    }
}
