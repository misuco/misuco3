// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12
//import QtQuick.Controls 2.12

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
    property var nextVid: 0

    property var keys: [
        {
            i: 0,
            note: 25,
            f: 261.63,
            pressed: 0
        },
        {
            i: 1,
            note: 26,
            f: 277.18,
            pressed: 0
        },
        {
            i: 2,
            note: 27,
            f: 293.66,
            pressed: 0
        },
        {
            i: 3,
            note: 28,
            f: 311.13,
            pressed: 0
        },
        {
            i: 4,
            note: 29,
            f: 329.63,
            pressed: 0
        },
        {
            i: 5,
            note: 30,
            f: 349.23,
            pressed: 0
        },
        {
            i: 6,
            note: 31,
            f: 369.99,
            pressed: 0
        },
        {
            i: 7,
            note: 32,
            f: 392,
            pressed: 0
        },
        {
            i: 8,
            note: 33,
            f: 415.3,
            pressed: 0
        },
        {
            i: 9,
            note: 34,
            f: 440,
            pressed: 0
        },
        {
            i: 10,
            note: 35,
            f: 466.16,
            pressed: 0
        },
        {
            i: 11,
            note: 36,
            f: 493.88,
            pressed: 0
        }
    ]

    property double keyWidth: root.width / root.keys.length

    Row {
        Repeater {
            id: keyRepeater
            model: root.keys

            Rectangle {
                id: key
                required property int index
                required property var modelData
                property bool pressed: modelData.pressed
                property double f: modelData.f

                width: root.keyWidth
                height: root.height
                color: modelData.note%2===0 ?
                           (pressed>0 ? "Red" : "Orange") :
                           (pressed>0 ? "White" : "Gray")

                Text {
                    text: key.modelData.note
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
                console.log("pressed " + keyIndex + " " + touchPoint.pointId + " " + touchPoint.x + " " + touchPoint.y)
                touchMapKey.set(touchPoint.pointId,keyIndex)
                keyRepeater.itemAt(keyIndex).pressed++
                root.synthesizer.noteOn(nextVid,keyRepeater.itemAt(keyIndex).f);
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
                if(currentKeyIndex!=keyIndex) {
                    keyRepeater.itemAt(currentKeyIndex).pressed--
                    keyRepeater.itemAt(keyIndex).pressed++
                    touchMapKey.set(touchPoint.pointId,keyIndex)
                    root.synthesizer.noteOff(currentVid);
                    root.synthesizer.noteOn(nextVid,keyRepeater.itemAt(keyIndex).f);
                    touchMapVid.set(touchPoint.pointId,nextVid)
                    nextVid++
                }
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

        Rectangle {
            id: touchRect
            required property var modelData
            property var tp: modelData
            visible: modelData.pressed
            x: modelData.x-50
            y: modelData.y-50
            radius: 50
            width: 100
            height: 100
            color: "Yellow"

            Text {
                anchors.left: parent.right
                text: touchRect.tp.pointId + "\nx:" + touchRect.tp.x + "\ny:" + touchRect.tp.y
            }
        }
    }
}
