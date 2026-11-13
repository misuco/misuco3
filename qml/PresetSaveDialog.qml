import QtQuick
import QtQuick.Controls

Dialog {
    id: dlg
    modal: true
    property alias nameText: nameField.text
    signal saveRequested(string name, string mode)

    contentItem: Column {
        spacing: 8
        padding: 8
        Text { text: "Preset name:" }
        TextField { id: nameField; placeholderText: "Preset name" }
        Row {
            spacing: 8
            Button { text: "New"; onClicked: { saveRequested(nameField.text, "new"); dlg.close(); } }
            Button { text: "Overwrite"; onClicked: { saveRequested(nameField.text, "overwrite"); dlg.close(); } }
            Button { text: "Cancel"; onClicked: dlg.close(); }
        }
    }
}
