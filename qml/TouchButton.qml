// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12
import "VoiceControl.js" as VoiceControl
import "ColorPalette.js" as Palette

Item {
    id: root
    width: 200
    height: 200

    property bool buttonPressed: false
    property double frequency: 1000
    property int voiceId: 0
    property int note: 65
    property int noteSymbol: 0
    property int tuning: 65
    property var synthesizer
    property bool holdKeys: false
    property int palette: 1

    function pitch() {
        let f = Math.max( 10, root.frequency+(touchPoint1.startY-touchPoint1.y) )
        root.synthesizer.pitch(root.voiceId,f)
    }

    onTuningChanged: function() {
        console.log("onTuningChanged "+tuning)
        frequency =  6.875 * Math.pow( 2 , ((note + 3) * 100 + tuning) / 1200)
        if(root.buttonPressed) {
            root.pitch()
        }
    }

    onHoldKeysChanged: function() {
        if(root.holdKeys==false && root.buttonPressed==true) {
            root.buttonPressed=false
            root.synthesizer.noteOff(root.voiceId)
        }
    }

    Rectangle {
        anchors.fill: parent

        //gradient: root.buttonPressed ? "LandingAircraft" : "AboveTheSky"
        color: Palette.bg(root.palette,root.noteSymbol,root.buttonPressed)

        radius: 20

        Emboss {
            anchors.fill: parent
            source: parent
            offset: root.buttonPressed ? -2 : 2
            radius: 10
        }
    }

    Text {
        anchors.fill: parent
        verticalAlignment: Qt.AlignVCenter
        horizontalAlignment: Qt.AlignHCenter
        text: root.note+"\n"+root.frequency.toFixed(2)
    }

    property double touchIndicatorSize: width / 1.5
    property double touchIndicatorRadius: touchIndicatorSize / 2

    Rectangle {
        visible: root.buttonPressed
        width: touchIndicatorSize
        height: touchIndicatorSize
        radius: touchIndicatorRadius
        x: touchPoint1.startX - touchIndicatorRadius
        y: touchPoint1.startY - touchIndicatorRadius
        color: "orange"
    }

    Rectangle {
        visible: root.buttonPressed
        width: touchIndicatorSize
        height: touchIndicatorSize
        radius: touchIndicatorRadius
        x: touchPoint1.x - touchIndicatorRadius
        y: touchPoint1.y - touchIndicatorRadius
        color: "yellow"
    }

    Rectangle {
        visible: root.buttonPressed
        width: Math.abs(touchPoint1.startX-touchPoint1.x)
        height: Math.abs(touchPoint1.startY-touchPoint1.y)
        x: Math.min(touchPoint1.x,touchPoint1.startX)
        y: Math.min(touchPoint1.y,touchPoint1.startY)
        color: "violet"
    }

    MultiPointTouchArea {
        anchors.fill: parent

        touchPoints: [
            TouchPoint {id:touchPoint1}
        ]

        onPressed: function(touchPoints) {
            // already pressed toggle in hod mode and return
            if(root.buttonPressed) {
                if(root.holdKeys) {
                    root.buttonPressed=false
                    root.synthesizer.noteOff(root.voiceId)
                }
                return
            }

            root.buttonPressed=true
            if(root.buttonPressed) {
                root.voiceId=VoiceControl.GetNextVoiceId()
                root.synthesizer.noteOn(root.voiceId,root.frequency)
            }
        }

        onUpdated: function(touchPoints) {
            root.pitch()
        }

        onCanceled: function(touchPoints) {
            if(root.holdKeys==false) {
                root.buttonPressed=(touchPoints.length>1 ? true : false)
                if(root.buttonPressed==false) {
                    root.synthesizer.noteOff(root.voiceId)
                }
            }
        }

        onReleased: function(touchPoints) {
            if(root.holdKeys==false) {
                root.buttonPressed=(touchPoints.length>1 ? true : false)
                if(root.buttonPressed==false) {
                    root.synthesizer.noteOff(root.voiceId)
                }
            }
        }

        onGestureStarted: function(gesture) {
            //gesture.grab();
        }
    }
}
