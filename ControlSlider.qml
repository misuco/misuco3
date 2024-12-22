import QtQuick 2.12
import QtQuick.Controls 2.12

Slider {
    property string text: "Control"
    id: controlSlider
    width: 400
    height: 50
    from: 1
    to: 1000
    value: 1
    property int ruler: 5

    background: Rectangle {
        x: controlSlider.leftPadding
        y: controlSlider.topPadding + controlSlider.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 20
        width: controlSlider.availableWidth
        height: implicitHeight
        radius: 2
        color: "#bdbebf"

        Rectangle {
            width: controlSlider.visualPosition * parent.width
            height: parent.height
            color: "#21be2b"
            radius: 2
        }

        Repeater {
            model: controlSlider.ruler

            Rectangle {
                width: 1
                height: parent.height
                x: modelData*parent.width/controlSlider.ruler
                y: 0
            }
        }
    }

    handle: Rectangle {
        x: controlSlider.leftPadding + controlSlider.visualPosition * (controlSlider.availableWidth - width)
        y: controlSlider.topPadding + controlSlider.availableHeight / 2 - height / 2
        implicitWidth: 50
        implicitHeight: 50
        radius: 25
        color: controlSlider.pressed ? "#f0f0f0" : "#f6f6f6"
        border.color: "#bdbebf"
    }

    Text {
        text: controlSlider.text
        anchors {
            bottom: parent.bottom
            right: parent.right
        }
    }
}
