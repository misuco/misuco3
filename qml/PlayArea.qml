// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import misuco3

pragma ComponentBehavior: Bound

Item {
    id: root

    required property MasterSender sender

    property var touchMapKey: new Map()
    property var touchMapVid: new Map()
    property var keyMapVid: new Map()

    property var bgColors: []
    property var bgColorsActive: []
    property var fgColors: []

    property var keys: [
        {
            note: 25
        }
    ]
    property bool holdKeys

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

    signal xMod(voiceId :int, note :int, tuning :int, value :double)
    signal yMod(voiceId :int, note :int, tuning :int, value :double)

    onHoldKeysChanged: {
        // transition for hold keys on/off
        // transform still active touch points in other domain
        if(holdKeys===true) {
            // turn off all regularly playing voices and clear pointId to voiceId map
            console.log("noteOff all in touchMapVid")
            touchMapVid.forEach((vid,pointId) => {
                let keyIndex=touchMapKey.get(pointId)
                console.log(`pointId ${pointId} vid ${vid} keyIndex ${keyIndex}`)
                keyRepeater.itemAt(keyIndex).pressed--
                root.sender.noteOff(vid)
            })
            touchMapVid.clear()
            // set up keyIndex to voiceId map for active touch points and trigger voices
            console.log("noteOn all in touchMapKey")
            touchMapKey.forEach((keyIndex,pointId) => {
                console.log(`pointId ${pointId} keyIndex ${keyIndex}`)
                keyRepeater.itemAt(keyIndex).pressed=1
                let frequency=keyRepeater.itemAt(keyIndex).f
                let note=keyRepeater.itemAt(keyIndex).note
                let tuning=keyRepeater.itemAt(keyIndex).tuning
                let newVid=root.sender.noteOn(frequency,note,tuning,127)
                keyMapVid.set(keyIndex,newVid)
            })
        } else {
            console.log("enabe hold, keyMapVid -> touchMapVid")
            console.log("noteOff all in keyMapVid")
            keyMapVid.forEach((vid,keyIndex) => {
                keyRepeater.itemAt(keyIndex).pressed=0
                root.sender.noteOff(vid)
                console.log(`keyIndex ${keyIndex} vid ${vid}`)
            })
            keyMapVid.clear()
            console.log("noteOn all in touchMapKey")
            touchMapKey.forEach((keyIndex,pointId) => {
                console.log(`pointId ${pointId} keyIndex ${keyIndex}`)
                keyRepeater.itemAt(keyIndex).pressed++
                let frequency=keyRepeater.itemAt(keyIndex).f
                let note=keyRepeater.itemAt(keyIndex).note
                let tuning=keyRepeater.itemAt(keyIndex).tuning
                let newVid=root.sender.noteOn(frequency,note,tuning,127)
                touchMapVid.set(pointId,newVid)
            })
        }
    }

    function handlePress(touchPoints) {
        console.log("---------- onPressed -----------------")
        touchPoints.forEach((touchPoint) => {
            let keyIndex=Math.floor(touchPoint.x / root.keyWidth)
            let frequency=keyRepeater.itemAt(keyIndex).f
            let note=keyRepeater.itemAt(keyIndex).note
            let tuning=keyRepeater.itemAt(keyIndex).tuning

            console.log("pressed keyIndex: " + keyIndex + " pointId: " + touchPoint.pointId + " x: " + touchPoint.x + " y: " + touchPoint.y + " f: " + frequency)

            touchMapKey.set(touchPoint.pointId,keyIndex)
            if(root.holdKeys===false ) {
                keyRepeater.itemAt(keyIndex).pressed++
                let newVid=root.sender.noteOn(frequency,note,tuning,127)
                touchMapVid.set(touchPoint.pointId,newVid)
            } else {
                if(keyRepeater.itemAt(keyIndex).pressed>0) {
                    keyRepeater.itemAt(keyIndex).pressed=0
                    root.sender.noteOff(keyMapVid.get(keyIndex))
                    keyMapVid.delete(keyIndex)
                } else {
                    touchMapKey.set(touchPoint.pointId,keyIndex)
                    keyRepeater.itemAt(keyIndex).pressed=1
                    let newVid=root.sender.noteOn(frequency,note,tuning,127)
                    keyMapVid.set(keyIndex,newVid)
                }
            }
        })
    }

    function handleUpdate(touchPoints) {
        console.log("---------- onUpdated -----------------")
        touchPoints.forEach((touchPoint) => {
            let keyIndex=Math.floor(touchPoint.x / root.keyWidth)
            console.log("updated " + keyIndex + " " + touchPoint.pointId + " " + touchPoint.x + " " + touchPoint.y)
            let currentKeyIndex=touchMapKey.get(touchPoint.pointId)
            let currentVid=touchMapVid.get(touchPoint.pointId)
            let currentF = keyRepeater.itemAt(keyIndex).f
            let currentNote = keyRepeater.itemAt(keyIndex).note
            let currentTuning = keyRepeater.itemAt(keyIndex).tuning
            if(currentKeyIndex!==keyIndex) {
                keyRepeater.itemAt(currentKeyIndex).pressed--
                keyRepeater.itemAt(keyIndex).pressed++
                touchMapKey.set(touchPoint.pointId,keyIndex)
                root.sender.noteOff(currentVid)
                let newVid=root.sender.noteOn(currentF,currentNote,currentTuning,127)
                touchMapVid.set(touchPoint.pointId,newVid)
                currentVid=newVid
            }

            let xDiff=touchPoint.x-touchPoint.startX
            let yDiff=touchPoint.startY-touchPoint.y

            root.xMod(currentVid, currentNote, currentTuning, xDiff/root.keyWidth)
            root.yMod(currentVid, currentNote, currentTuning, yDiff/root.height)
        })
    }

    function handleRelease(touchPoints) {
        console.log("---------- onReleased -----------------")
        touchPoints.forEach((touchPoint) => {
            let keyIndex=Math.floor(touchPoint.x / root.keyWidth)
            console.log("released " + keyIndex + " " + touchPoint.pointId + " " + touchPoint.x + " " + touchPoint.y)
            touchMapKey.delete(touchPoint.pointId)
            if(root.holdKeys===false ) {
                let keyIndex=Math.floor(touchPoint.x / root.keyWidth)
                keyRepeater.itemAt(keyIndex).pressed--
                root.sender.noteOff(touchMapVid.get(touchPoint.pointId));
            }
        })
    }

    Row {
        Repeater {
            id: keyRepeater
            model: root.keys

            Item {
                id: key
                required property int index
                required property var modelData
                property int pressed: 0
                readonly property int offsetMidiChamberTone: 3
                property double f: 6.875 * Math.pow( 2 , ((modelData.note + offsetMidiChamberTone) * 100 + tuning) / 1200)
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
                    color: key.pressed>0 ? root.bgColorsActive[key.noteSymbol] : root.bgColors[key.noteSymbol]
                    radius: 15
                }

                ControlEmboss {
                    anchors.fill: rect
                    down: key.pressed
                    radius: 15
                    bgColor: key.pressed>0 ? root.bgColorsActive[key.noteSymbol] : root.bgColors[key.noteSymbol]
                }

                Text {
                    anchors.fill: parent
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                    text: key.note+"\n"+key.f.toFixed(2)
                    color: root.fgColors[key.noteSymbol]
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

        onPressed: function(tps) { root.handlePress(tps) }

        onUpdated: function(tps) { root.handleUpdate(tps) }

        onCanceled: function(tps) { root.handleRelease(tps) }

        onReleased: function(tps) { root.handleRelease(tps) }
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
