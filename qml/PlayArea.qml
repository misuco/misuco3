// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12
import "ColorPalette.js" as Palette

pragma ComponentBehavior: Bound

Item {
    id: root

    /*
    property int startNote: 1
    property int startOctave: 3
    property int octaveCount: 4
    property int notePerScale: 8
    */

    property var synthesizer
    property var touchMapKey: new Map()
    property var touchMapVid: new Map()
    property int nextVid: 1
    property int palette: 1

    property var keys: [
        {
            note: 25
        }
    ]

    // The tuning model is realized as separate properties to ensure update on value change
    property int tuningModel0: 0
    property int tuningModel1: 0
    property int tuningModel2: 0
    property int tuningModel3: 0
    property int tuningModel4: 0
    property int tuningModel5: 0
    property int tuningModel6: 0
    property int tuningModel7: 0
    property int tuningModel8: 0
    property int tuningModel9: 0
    property int tuningModel10: 0
    property int tuningModel11: 0

    property double keyWidth: root.width / root.keys.length

    Row {
        Repeater {
            id: keyRepeater
            model: root.keys

            Item {
                id: key
                required property int index
                required property var modelData
                property int pressed: 0
                property double f: 6.875 * Math.pow( 2 , ((modelData.note + 3) * 100 + tuning) / 1200)
                property int note: modelData.note
                property int noteSymbol: note%12

                property int tuning: noteSymbol===0 ? root.tuningModel0 :
                        noteSymbol===1 ? root.tuningModel1 :
                        noteSymbol===2 ? root.tuningModel2 :
                        noteSymbol===3 ? root.tuningModel3 :
                        noteSymbol===4 ? root.tuningModel4 :
                        noteSymbol===5 ? root.tuningModel5 :
                        noteSymbol===6 ? root.tuningModel6 :
                        noteSymbol===7 ? root.tuningModel7 :
                        noteSymbol===8 ? root.tuningModel8 :
                        noteSymbol===9 ? root.tuningModel9 :
                        noteSymbol===10 ? root.tuningModel10 : root.tuningModel11

                width: root.keyWidth
                height: root.height

                Rectangle {
                    id: rect
                    anchors.fill: parent
                    color: key.pressed>0 ? Palette.bg(root.palette,noteSymbol,true) :  Palette.bg(root.palette,noteSymbol,false)
                    radius: 15
                }

                Emboss {
                    anchors.fill: rect
                    source: rect
                    offset: pressed>0 ? -2 : 2
                    radius: 15
                }

                Text {
                    anchors.fill: parent
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                    text: key.note+"\n"+key.f.toFixed(2)
                    color: Palette.fg(root.palette,noteSymbol)
                }
            }
        }
    }

    MultiPointTouchArea {
        id: touchArea
        width: root.width
        height: root.height

        touchPoints: [
            TouchPoint {id:touchPoint1},
            TouchPoint {id:touchPoint2},
            TouchPoint {id:touchPoint3},
            TouchPoint {id:touchPoint4},
            TouchPoint {id:touchPoint5},
            TouchPoint {id:touchPoint6},
            TouchPoint {id:touchPoint7},
            TouchPoint {id:touchPoint8},
            TouchPoint {id:touchPoint9},
            TouchPoint {id:touchPoint0}
        ]

        onPressed: {
            console.log("---------- onPressed -----------------")
            touchPoints.forEach((touchPoint) => {
                let keyIndex=Math.floor(touchPoint.x / root.keyWidth)
                let frequency=keyRepeater.itemAt(keyIndex).f
                console.log("pressed keyIndex: " + keyIndex + " pointId: " + touchPoint.pointId + " x: " + touchPoint.x + " y: " + touchPoint.y + " f: " + frequency)

                touchMapKey.set(touchPoint.pointId,keyIndex)
                keyRepeater.itemAt(keyIndex).pressed++
                root.synthesizer.noteOn(nextVid,frequency);
                touchMapVid.set(touchPoint.pointId,nextVid)
                nextVid++
            })
        }

        onUpdated: {
            console.log("---------- onUpdated -----------------")
            touchPoints.forEach((touchPoint) => {
                let keyIndex=Math.floor(touchPoint.x / root.keyWidth)
                console.log("updated " + keyIndex + " " + touchPoint.pointId + " " + touchPoint.x + " " + touchPoint.y)
                let currentKeyIndex=touchMapKey.get(touchPoint.pointId)
                let currentVid=touchMapVid.get(touchPoint.pointId)
                if(currentKeyIndex!==keyIndex) {
                    keyRepeater.itemAt(currentKeyIndex).pressed--
                    keyRepeater.itemAt(keyIndex).pressed++
                    touchMapKey.set(touchPoint.pointId,keyIndex)
                    root.synthesizer.noteOff(currentVid);
                    root.synthesizer.noteOn(nextVid,keyRepeater.itemAt(keyIndex).f)
                    touchMapVid.set(touchPoint.pointId,nextVid)
                    currentVid=nextVid
                    nextVid++
                }
                let currentF=keyRepeater.itemAt(keyIndex).f
                let pitchedF = Math.max( 10, currentF+(touchPoint.startY-touchPoint.y))
                root.synthesizer.pitch(currentVid,pitchedF)

            })
        }

        onCanceled: {
            console.log("---------- onCanceled -----------------")
            touchPoints.forEach((touchPoint) => {
                let keyIndex=Math.floor(touchPoint.x / root.keyWidth)
                console.log("canceled " + keyIndex + " " + touchPoint.pointId + " " + touchPoint.x + " " + touchPoint.y)
                keyRepeater.itemAt(keyIndex).pressed--
                root.synthesizer.noteOff(touchMapVid.get(touchPoint.pointId));
            })
        }

        onReleased: {
            console.log("---------- onReleased -----------------")
            touchPoints.forEach((touchPoint) => {
                let keyIndex=Math.floor(touchPoint.x / root.keyWidth)
                console.log("released " + keyIndex + " " + touchPoint.pointId + " " + touchPoint.x + " " + touchPoint.y)
                keyRepeater.itemAt(keyIndex).pressed--
                root.synthesizer.noteOff(touchMapVid.get(touchPoint.pointId));
            })
        }
    }

    Repeater {
        model: touchArea.touchPoints

        Item {
            id: tpRoot
            required property var modelData
            property var tp: modelData
            visible: tp.pressed

            property int lineWidth: 2
            property int indicatorRadius: 50

            Rectangle {
                id: touchRect
                x: tpRoot.tp.x-50
                y: tpRoot.tp.y-50
                radius: tpRoot.indicatorRadius
                width: 100
                height: 100
                color: "Transparent"

                border {
                    width: tpRoot.lineWidth
                    color: "Orange"
                }

                Text {
                    anchors.left: parent.right
                    text: tpRoot.tp.pointId + " x:" + tpRoot.tp.x.toFixed(0) + " y:" + tpRoot.tp.y.toFixed(0)
                    color: "Orange"
                }
            }

            Rectangle {
                id: startYLine
                x: 0
                y: tpRoot.tp.startY
                width: root.width
                height: tpRoot.lineWidth
                color: "Gray"
            }

            Rectangle {
                id: yLineLeft
                x: 0
                y: tpRoot.tp.y
                width: tpRoot.tp.x-tpRoot.indicatorRadius
                height: tpRoot.lineWidth
                color: "Orange"
            }

            Rectangle {
                id: yLineRight
                x: tpRoot.tp.x+tpRoot.indicatorRadius
                y: tpRoot.tp.y
                width: root.width-tpRoot.tp.x-tpRoot.indicatorRadius
                height: tpRoot.lineWidth
                color: "Orange"
            }
        }
    }
}
