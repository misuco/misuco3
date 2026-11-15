// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import "Tunings.js" as Tunings

TuningForm {
    id: root

    // the ListStore with the tunings of the user
    required property var store
    // the root note of the scale, 0 is C
    property int rootNote: 0

    signal tuningUpdated(var i, var t)

    property var userTunings: []

    function loadUserTunings() {
        userTunings = store.userEntries()
        tuningNames = Tunings.names().concat(userTunings.map(t => t.name))
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

    // sets the faders to the tuning of the list
    function applyTuning(index) {
        if(index < 0 || index >= tuningNames.length) {
            return
        }
        storeSelect.currentIndex = index
        edited = false
        setValues(index < builtInCount ? Tunings.cents(index, rootNote)
                                       : userTunings[index - builtInCount].values)
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
        onTriggered: root.store.setCurrent(root.storeSelect.currentName, root.values())
    }

    // a tuning that is built on the root note follows it
    onRootNoteChanged: {
        let index = storeSelect.currentIndex
        if(!edited && index >= 0 && index < builtInCount && Tunings.onRoot(index)) {
            applyTuning(index)
        }
    }

    storeSelect.onActivated: function(index) {
        applyTuning(index)
    }

    storeSelect.onSaveRequested: function(name) {
        store.save(name, values())
        loadUserTunings()
        applyTuning(tuningNames.indexOf(name))
    }

    storeSelect.onDeleteRequested: function(name) {
        // the faders stay as they are, as a tuning that is not saved
        store.remove(name)
        edited = true
        loadUserTunings()
        storeSelect.currentIndex = -1
        storeTimer.restart()
    }

    Component.onCompleted: {
        builtInCount = Tunings.names().length
        // for the question when a tuning is saved with a name that exists
        storeSelect.identical = function(name) {
            let index = tuningNames.indexOf(name)
            let cents = index < builtInCount ? Tunings.cents(index, rootNote) : userTunings[index - builtInCount].values
            return cents.join(" ") === values().join(" ")
        }
        loadUserTunings()
        let current = store.current()
        if(current.values === undefined) {
            applyTuning(0)
            return
        }
        let index = tuningNames.indexOf(current.name)
        storeSelect.currentIndex = index
        setValues(current.values)
        edited = index < 0
    }
}
