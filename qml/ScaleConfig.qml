// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls
import "Scales.js" as Scales

ScaleConfigForm {
    id: root

    property int baseNoteIndex: 0
    property int lowOctave: 4
    property int highOctave: 5

    // the ListStore with the scales of the user
    required property var store

    property var userScales: []

    signal scaleModelUpdated(var m)

    function loadUserScales() {
        userScales = store.userEntries()
        scaleNames = Scales.names().concat(userScales.map(s => s.name))
    }

    // the steps of the scale with this index in the list
    function stepsOf(index) {
        return index < builtInCount ? Scales.steps(index) : userScales[index - builtInCount].values
    }

    // the steps that are switched on, 1 or 0 for each of the twelve steps
    function steps() {
        let s = []
        for(let i = 0; i < 12; i++) {
            s.push(root["binaryScale"+i] ? 1 : 0)
        }
        return s
    }

    function setSteps(s) {
        // the root note is always part of the scale
        root.binaryScale0 = true
        for(let i = 1; i < 12; i++) {
            root["binaryScale"+i] = s[i] > 0
        }
    }

    function updateModel() {
        let scaleModel=[]
        let playArea=0
        for(let octave=lowOctave;octave<=highOctave;octave++) {
            for(let note=0;note<=11;note++) {
                if(root["binaryScale"+note]===true) {
                    scaleModel[playArea] = {
                        note: root.baseNoteIndex+note+octave*12
                    }
                    playArea++
                }
            }
        }
        root.scaleModelUpdated(scaleModel)
    }

    // the scale in use is stored a moment after the last change
    Timer {
        id: storeTimer
        interval: 500
        onTriggered: root.store.setCurrent(root.storeSelect.currentName, root.steps())
    }

    // shows the scale of the list that has the steps that are switched on
    function updateScaleSelect() {
        let current = steps().join("")
        let index = -1
        for(let i = 0; i < scaleNames.length && index < 0; i++) {
            if(stepsOf(i).join("") === current) {
                index = i
            }
        }
        storeSelect.currentIndex = index
        edited = index < 0
    }

    // sets the steps to the scale of the list
    function applyScale(index) {
        if(index < 0 || index >= scaleNames.length) {
            return
        }
        setSteps(stepsOf(index))
        storeSelect.currentIndex = index
        edited = false
        root.updateModel()
        storeTimer.restart()
    }

    function scaleButtonPressed(caller) {
        root["binaryScale"+caller.index]=!root["binaryScale"+caller.index]
        root.updateScaleSelect()
        root.updateModel()
        storeTimer.restart()
    }

    storeSelect.onActivated: function(index) {
        applyScale(index)
    }

    storeSelect.onSaveRequested: function(name) {
        store.save(name, steps())
        loadUserScales()
        storeSelect.currentIndex = scaleNames.indexOf(name)
        edited = false
        storeTimer.restart()
    }

    storeSelect.onDeleteRequested: function(name) {
        // the steps stay as they are
        store.remove(name)
        loadUserScales()
        updateScaleSelect()
        storeTimer.restart()
    }

    Component.onCompleted: {
        builtInCount = Scales.names().length
        // for the question when a scale is saved with a name that exists
        storeSelect.identical = function(name) {
            return stepsOf(scaleNames.indexOf(name)).join("") === steps().join("")
        }
        loadUserScales()
        let current = store.current()
        if(current.values === undefined) {
            applyScale(0)
            return
        }
        setSteps(current.values)
        let index = scaleNames.indexOf(current.name)
        if(index >= 0 && stepsOf(index).join("") === steps().join("")) {
            storeSelect.currentIndex = index
            edited = false
        } else {
            updateScaleSelect()
        }
        root.updateModel()
    }

    // Connect scale note buttons
    Connections {
        target: root.scaleButton_ii
        function onPressed() { root.scaleButtonPressed(root.scaleButton_ii) }
    }
    Connections {
        target: root.scaleButton_II
        function onPressed() { root.scaleButtonPressed(root.scaleButton_II) }
    }
    Connections {
        target: root.scaleButton_iii
        function onPressed() { root.scaleButtonPressed(root.scaleButton_iii) }
    }
    Connections {
        target: root.scaleButton_III
        function onPressed() { root.scaleButtonPressed(root.scaleButton_III) }
    }
    Connections {
        target: root.scaleButton_IV
        function onPressed() { root.scaleButtonPressed(root.scaleButton_IV) }
    }
    Connections {
        target: root.scaleButton_v
        function onPressed() { root.scaleButtonPressed(root.scaleButton_v) }
    }
    Connections {
        target: root.scaleButton_V
        function onPressed() { root.scaleButtonPressed(root.scaleButton_V) }
    }
    Connections {
        target: root.scaleButton_vi
        function onPressed() { root.scaleButtonPressed(root.scaleButton_vi) }
    }
    Connections {
        target: root.scaleButton_VI
        function onPressed() { root.scaleButtonPressed(root.scaleButton_VI) }
    }
    Connections {
        target: root.scaleButton_vii
        function onPressed() { root.scaleButtonPressed(root.scaleButton_vii) }
    }
    Connections {
        target: root.scaleButton_VII
        function onPressed() { root.scaleButtonPressed(root.scaleButton_VII) }
    }    
}
