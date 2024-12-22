import QtQuick 2.12
import QtQuick.Controls 2.12

Button {
    text: "Control"
    id: controlButton
    width: 50
    height: 50

    Rectangle {
        id: rect
        anchors.fill: parent
        radius: 10
    }

    property bool selected: false

    Emboss {
        anchors.fill: parent
        source: rect
        offset: controlButton.selected ? -2 : 2
        radius: 10
    }
}
