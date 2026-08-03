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

    property int xAssignId: 0
    property int yAssignId: 0

    signal handleXMod(voiceId :int, note :int, tuning :int, value :double)
    signal handleYMod(voiceId :int, note :int, tuning :int, value :double)

    function setBaseValue(cc :int, value :double) {
        console.log(`setBaseValue ${cc} ${value}`)
        valueMap.set(cc,value)
        let mod=modMap.get(cc)
        let modValue=value*mod
        console.log(`mod ${mod} modValue ${modValue}`)
        sender.ccAllVoices(cc,modValue)
    }

    function xMod(voiceId :int, note :int, tuning :int, value :double) {
        console.log(`xMod voiceId: ${voiceId} note: ${note} tuning: ${tuning} value ${value}`)
        handleXMod(voiceId, note, tuning, value)
    }

    function yMod(voiceId :int, note :int, tuning :int, value :double) {
        console.log(`yMod voiceId: ${voiceId} note: ${note} tuning: ${tuning} value ${value}`)
        handleYMod(voiceId, note, tuning, value)
    }

    function handlePitch(voiceId :int, note :int, tuning :int, value :double) {
        console.log(`handlePitch voiceId: ${voiceId} note: ${note} tuning: ${tuning} value ${value}`)
        sendPitch(voiceId, note, tuning, value)
    }

    function handleModulationAmount(voiceId :int, note :int, tuning :int, value :double) {
        console.log(`handleModulationAmount voiceId: ${voiceId} note: ${note} tuning: ${tuning} value ${value}`)
        sendCC(voiceId, note, tuning, value, 1)
    }

    function handleModulationFrequency(voiceId :int, note :int, tuning :int, value :double) {
        console.log(`handleModulationFrequency voiceId: ${voiceId} note: ${note} tuning: ${tuning} value ${value}`)
        sendCC(voiceId, note, tuning, value, 87)
    }

    function handleFilterCutoff(voiceId :int, note :int, tuning :int, value :double) {
        console.log(`handleFilterCutoff voiceId: ${voiceId} note: ${note} tuning: ${tuning} value ${value}`)
        sendCC(voiceId, note, tuning, value, 74)
    }

    function handleFilterResonance(voiceId :int, note :int, tuning :int, value :double) {
        console.log(`handleFilterFrequency voiceId: ${voiceId} note: ${note} tuning: ${tuning} value ${value}`)
        sendCC(voiceId, note, tuning, value, 71)
    }

    function sendCC(voiceId :int, note :int, tuning :int, value :double, cc: int) {
        console.log(`sendCC cc: ${cc} note: ${note} tuning: ${tuning} value: ${value}`)
        //sender.cc(voiceId,cc,Math.abs(value))
        sender.ccAllVoices(cc,Math.abs(value))
    }

    function sendPitch(voiceId :int, note :int, tuning :int, value :double) {
        console.log(`sendPitch note: ${note} tuning: ${tuning} value: ${value}`)
        let pitchedTuning = tuning + value * 500
        let pitchedF = 6.875 * Math.pow( 2 , ((note + offsetMidiChamberTone) * 100 + pitchedTuning) / 1200)
        console.log(`    pitchedF: ${pitchedF} pitchedTuning: ${pitchedTuning}`)
        sender.pitch(voiceId,pitchedF,note,pitchedTuning)
    }

    function connectHandler(currentHaldlerId :int, newHaldlerId :int, toSignal: var) {
        console.log(`connectHandler curr ${currentHaldlerId} new: ${newHaldlerId} sig: ${toSignal}`)
        if(currentHaldlerId===1) {
            toSignal.disconnect(handlePitch)
        } else if(currentHaldlerId===2) {
            toSignal.disconnect(handleModulationAmount)
        } else if(currentHaldlerId===3) {
            toSignal.disconnect(handleModulationFrequency)
        } else if(currentHaldlerId===4) {
            toSignal.disconnect(handleFilterCutoff)
        } else if(currentHaldlerId===5) {
            toSignal.disconnect(handleFilterResonance)
        }

        if(newHaldlerId===1) {
            toSignal.connect(handlePitch)
        } else if(newHaldlerId===2) {
            toSignal.connect(handleModulationAmount)
        } else if(newHaldlerId===3) {
            toSignal.connect(handleModulationFrequency)
        } else if(newHaldlerId===4) {
            toSignal.connect(handleFilterCutoff)
        } else if(newHaldlerId===5) {
            toSignal.connect(handleFilterResonance)
        }
    }

    Component.onCompleted: function() {
        console.log("XYModAssignForm completed ")
        //deviceSelect.currentIndex=synthesizer.audioDeviceIndex
        valueMap.set(1,0.5)
        modMap.set(1,1)
        valueMap.set(87,2)
        modMap.set(87,1)
    }

    xModAssignSelect.onCurrentIndexChanged: function() {
        connectHandler(xAssignId, xModAssignSelect.currentIndex, handleXMod)
        xAssignId=xModAssignSelect.currentIndex
    }

    yModAssignSelect.onCurrentIndexChanged: function() {
        connectHandler(yAssignId, yModAssignSelect.currentIndex, handleYMod)
        yAssignId=yModAssignSelect.currentIndex
    }
}

