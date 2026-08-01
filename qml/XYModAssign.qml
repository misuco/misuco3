// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import misuco3

XYModAssignForm {
    required property MasterSender sender

    property var valueMap: new Map()
    property var modMap: new Map()
    readonly property int offsetMidiChamberTone: 3

    function setBaseValue(cc :int, value :double) {
        console.log(`setBaseValue ${cc} ${value}`)
        valueMap.set(cc,value)
        let mod=modMap.get(cc)
        let modValue=value*mod
        console.log(`mod ${mod} modValue ${modValue}`)
        sender.ccAllVoices(cc,modValue)
    }

    function xMod(voiceId :int, note :int, tuning :int, value :double) {
        console.log(`onXMod note: ${note} tuning: ${tuning} value: ${value}`)
        let pitchedTuning = tuning + value * 500
        let pitchedF = 6.875 * Math.pow( 2 , ((note + offsetMidiChamberTone) * 100 + pitchedTuning) / 1200)
        console.log(`    pitchedF: ${pitchedF} pitchedTuning: ${pitchedTuning}`)
        sender.pitch(voiceId,pitchedF,note,pitchedTuning)
    }

    function yMod(voiceId :int, note :int, tuning :int, value :double) {
        console.log(`onYMod note: ${note} tuning: ${tuning} value: ${value}`)
        //sender.ccAllVoices(1,Math.abs(value))
        sender.cc(voiceId,1,Math.abs(value))
    }

    Component.onCompleted: function() {
        console.log("XYModAssignForm completed ")
        //deviceSelect.currentIndex=synthesizer.audioDeviceIndex
        valueMap.set(1,0.5)
        modMap.set(1,1)
    }

    xModAssignSelect.onCurrentIndexChanged: function() {
        //synthesizer.deviceChanged(deviceSelect.currentIndex)
    }

    yModAssignSelect.onCurrentIndexChanged: function() {
//            if(modeSelect.currentIndex===0) {
    }
}

