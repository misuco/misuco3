import QtQuick 2.12
import QtQuick.Controls 2.12

Dial {
    property string text: "Control"

    id: controlDial
    width: 400
    height: 50
    from: 1
    to: 1000
    value: 1

    Text {
        text: controlDial.text
        anchors {
            bottom: parent.bottom
            right: parent.right
        }
    }
}
