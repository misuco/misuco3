// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

// A select box for built in entries and entries of the user, with a save
// and a delete button. It asks for the name of an entry that is saved,
// and asks before an entry is deleted or overwritten. Used for the
// tunings and the scales.
Row {
    id: root

    // the names of the built in entries, followed by the entries of the user
    property var names: []
    property int builtInCount: 0
    // the values have been changed, they are not an entry of the list
    property bool edited: false
    property alias currentIndex: select.currentIndex
    // what is saved, for the hint in the name field
    property string what: "entry"
    // function(name): true if the entry with this name has the values that
    // are about to be saved, set by the owner
    property var identical: null

    property double buttonWidth: 75
    property string fontFamily
    property double fontPixelSize: 10

    readonly property bool userSelected: select.currentIndex >= builtInCount
    readonly property string currentName: !edited && select.currentIndex >= 0 && select.currentIndex < names.length
                                          ? names[select.currentIndex] : ""

    // an entry of the list has been selected
    signal activated(int index)
    // the values shall be saved with this name
    signal saveRequested(string name)
    // the entry of the user with this name shall be deleted
    signal deleteRequested(string name)

    // the name of an entry is typed in
    property bool naming: false
    // the question that has to be answered with yes or no, empty if there is none
    property string confirmText: ""
    readonly property bool confirming: confirmText !== ""
    // what is done when the question is answered with yes
    property string pendingAction: ""
    property string pendingName: ""

    // a name that exists can be overwritten, renamed or the saving is cancelled
    readonly property bool threeButtons: confirming && pendingAction !== "delete"
    readonly property double selectWidth: width - (threeButtons ? 3 : 2) * (buttonWidth + spacing)

    function ask(question, action, name) {
        pendingAction = action
        pendingName = name
        confirmText = question
    }

    // says if the entry with this name has the values that are saved
    function article(name) {
        return identical !== null && identical(name) ? "An identical" : "A different"
    }

    function saveNamed() {
        let name = nameField.text.trim()
        let index = names.indexOf(name)
        if(name === "") {
            return
        }
        if(index >= 0 && index < builtInCount) {
            // a built in entry cannot be replaced, the name has to be changed
            ask(article(name) + " built in " + what + " \"" + name + "\" exists.", "taken", name)
        } else if(index >= 0) {
            ask(article(name) + " " + what + " \"" + name + "\" exists already.", "overwrite", name)
        } else {
            naming = false
            saveRequested(name)
        }
    }

    ComboBox {
        id: select
        width: root.selectWidth
        height: root.height
        visible: !root.naming && !root.confirming
        model: root.names
        displayText: root.edited ? "Custom (not saved)" : currentText
        font.family: root.fontFamily
        font.pixelSize: root.fontPixelSize
        onActivated: function(index) {
            root.activated(index)
        }
    }

    TextField {
        id: nameField
        width: root.selectWidth
        height: root.height
        visible: root.naming && !root.confirming
        placeholderText: "name of the " + root.what
        maximumLength: 40
        font.family: root.fontFamily
        font.pixelSize: root.fontPixelSize
        onAccepted: root.saveNamed()
    }

    Text {
        width: root.selectWidth
        height: root.height
        visible: root.confirming
        text: root.confirmText
        wrapMode: Text.WordWrap
        maximumLineCount: 2
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
        color: "White"
        font {
            family: root.fontFamily
            pixelSize: root.fontPixelSize
            bold: true
        }
    }

    ControlButton {
        width: root.buttonWidth
        height: root.height
        // a built in name can only be changed
        enabled: !(root.confirming && root.pendingAction === "taken")
        opacity: enabled ? 1 : 0.4
        text: !root.confirming ? (root.naming ? "ok" : "save") :
              root.pendingAction === "delete" ? "yes" : "overwrite"
        bgColor: root.naming || root.confirming ? "Orange" : "Gray"
        fgColor: "White"
        font.family: root.fontFamily
        font.pixelSize: root.fontPixelSize
        onPressed: {
            if(root.confirming) {
                let action = root.pendingAction
                root.confirmText = ""
                if(action === "overwrite") {
                    root.naming = false
                    root.saveRequested(root.pendingName)
                } else if(action === "delete") {
                    root.deleteRequested(root.pendingName)
                }
            } else if(root.naming) {
                root.saveNamed()
            } else {
                // an entry of the user that has been changed keeps its name
                nameField.text = root.userSelected && select.currentIndex < root.names.length
                                 ? root.names[select.currentIndex] : ""
                root.naming = true
                nameField.forceActiveFocus()
            }
        }
    }

    ControlButton {
        width: root.buttonWidth
        height: root.height
        enabled: root.naming || root.confirming || (root.userSelected && !root.edited)
        opacity: enabled ? 1 : 0.4
        text: !root.confirming ? (root.naming ? "cancel" : "delete") :
              root.pendingAction === "delete" ? "no" : "rename"
        bgColor: "Gray"
        fgColor: "White"
        font.family: root.fontFamily
        font.pixelSize: root.fontPixelSize
        onPressed: {
            if(root.confirming) {
                // no or rename, back to where the question came from
                root.confirmText = ""
                if(root.naming) {
                    nameField.forceActiveFocus()
                }
            } else if(root.naming) {
                root.naming = false
            } else {
                root.ask("Delete \"" + root.currentName + "\"?", "delete", root.currentName)
            }
        }
    }

    ControlButton {
        width: root.buttonWidth
        height: root.height
        visible: root.threeButtons
        text: "cancel"
        bgColor: "Gray"
        fgColor: "White"
        font.family: root.fontFamily
        font.pixelSize: root.fontPixelSize
        onPressed: {
            root.confirmText = ""
            root.naming = false
        }
    }
}
