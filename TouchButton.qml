import QtQuick 2.12

Item {
    property bool buttonPressed: false
    property double frequency: 1000
    property int voiceId: 0
    property int note: 65
    property var synthesizer
    property bool holdKeys: false

    onHoldKeysChanged: function() {
        if(root.holdKeys==false && root.buttonPressed==true) {
            root.buttonPressed=false
            root.synthesizer.noteOff(root.note)
        }
    }

    id: root
    width: 200
    height: 200

    Rectangle {
        anchors.fill: parent

        gradient: root.buttonPressed ? "LandingAircraft" : "AboveTheSky"

        radius: 20

        Emboss {
            anchors.fill: parent
            source: parent
            offset: root.buttonPressed ? -2 : 2
            radius: 10
        }
    }

    MultiPointTouchArea {
        anchors.fill: parent

        onPressed: function(touchPoints) {
            root.buttonPressed=(touchPoints.length>0 ? true : false)
            if(root.buttonPressed) {
                root.synthesizer.noteOn(root.note,root.frequency);
            }
        }

        onCanceled: function(touchPoints) {
            if(root.holdKeys==false) {
                root.buttonPressed=(touchPoints.length>1 ? true : false)
                if(root.buttonPressed==false) {
                    root.synthesizer.noteOff(root.note)
                }
            }
        }

        onReleased: function(touchPoints) {
            if(root.holdKeys==false) {
                root.buttonPressed=(touchPoints.length>1 ? true : false)
                if(root.buttonPressed==false) {
                    root.synthesizer.noteOff(root.note)
                }
            }
        }

        onGestureStarted: function(gesture) {
            //gesture.grab();
        }
    }
}
