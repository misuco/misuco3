// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import "Tunings.js" as Tunings

TuningForm {
    id: root

    // the TuningStore with the tunings of the user
    required property var store
    // the root note of the scale, 0 is C
    property int rootNote: 0

    signal tuningUpdated(var i, var t)

    readonly property int builtInCount: Tunings.names().length
    property var userTunings: []

    function loadUserTunings() {
        userTunings = store.userTunings()
        tuningNames = Tunings.names().concat(userTunings.map(t => t.name))
    }

    function indexOfName(name) {
        return tuningNames.indexOf(name)
    }

    function values() {
        let v = []
        for(let i = 0; i < 12; i++) {
            v.push(tuningRepeater.itemAt(i).value)
        }
        return v
    }

    function setValues(cents) {
        for(let i = 0; i < 12; i++) {
            tuningRepeater.itemAt(i).setValue(cents[i])
        }
    }

    function currentName() {
        return edited || tuningSelect.currentIndex < 0 ? "" : tuningNames[tuningSelect.currentIndex]
    }

    // sets the faders to the tuning of the list
    function applyTuning(index) {
        if(index < 0 || index >= tuningNames.length) {
            return
        }
        tuningSelect.currentIndex = index
        edited = false
        userTuningSelected = index >= builtInCount
        setValues(index < builtInCount ? Tunings.cents(index, rootNote)
                                       : userTunings[index - builtInCount].cents)
        storeTimer.restart()
    }

    // called by the faders when they are moved by hand
    function tuningEdited() {
        edited = true
    }

    // the tuning in use is stored a moment after the last change
    onTuningUpdated: storeTimer.restart()

    Timer {
        id: storeTimer
        interval: 500
        onTriggered: root.store.setCurrent(root.currentName(), root.values())
    }

    // a tuning that is built on the root note follows it
    onRootNoteChanged: {
        let index = tuningSelect.currentIndex
        if(!edited && index >= 0 && index < builtInCount && Tunings.onRoot(index)) {
            applyTuning(index)
        }
    }

    tuningSelect.onActivated: function(index) {
        applyTuning(index)
    }

    // what is done when the question is answered with yes
    property string pendingAction: ""
    property string pendingName: ""

    function ask(question, action, name) {
        pendingAction = action
        pendingName = name
        confirmText = question
    }

    function saveTuning(name) {
        store.saveTuning(name, values())
        loadUserTunings()
        naming = false
        applyTuning(indexOfName(name))
    }

    function deleteTuning(name) {
        // the faders stay as they are, as a tuning that is not saved
        store.deleteTuning(name)
        edited = true
        loadUserTunings()
        userTuningSelected = false
        storeTimer.restart()
    }

    function saveNamed() {
        let name = nameField.text.trim()
        // the names of the built in tunings are taken
        if(name === "" || Tunings.names().indexOf(name) >= 0) {
            return
        }
        if(userTunings.some(t => t.name === name)) {
            ask("Overwrite \"" + name + "\"?", "overwrite", name)
        } else {
            saveTuning(name)
        }
    }

    saveButton.onPressed: function() {
        if(confirming) {
            // yes
            let action = pendingAction
            confirmText = ""
            if(action === "overwrite") {
                saveTuning(pendingName)
            } else if(action === "delete") {
                deleteTuning(pendingName)
            }
        } else if(naming) {
            saveNamed()
        } else {
            // a tuning of the user that has been changed keeps its name
            nameField.text = userTuningSelected ? tuningNames[tuningSelect.currentIndex] : ""
            naming = true
            nameField.forceActiveFocus()
        }
    }

    nameField.onAccepted: saveNamed()

    deleteButton.onPressed: function() {
        if(confirming) {
            // no, back to where the question came from
            confirmText = ""
        } else if(naming) {
            naming = false
        } else {
            ask("Delete \"" + currentName() + "\"?", "delete", currentName())
        }
    }

    Component.onCompleted: {
        loadUserTunings()
        let current = store.current()
        if(current.cents === undefined) {
            applyTuning(0)
            return
        }
        let index = indexOfName(current.name)
        if(index >= 0) {
            tuningSelect.currentIndex = index
            userTuningSelected = index >= builtInCount
        }
        setValues(current.cents)
        edited = index < 0
    }
}
