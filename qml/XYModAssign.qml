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
        sendPitch(voiceId, note, tuning, value)
    }

    function handleModulationAmount(voiceId :int, note :int, tuning :int, value :double) {
        sendCC(voiceId, note, tuning, value, SenderMobileSynth.CCModAmount)
    }

    function handleModulationFrequency(voiceId :int, note :int, tuning :int, value :double) {
        sendCC(voiceId, note, tuning, value, SenderMobileSynth.CCModFreq)
    }

    function handleFilterCutoff(voiceId :int, note :int, tuning :int, value :double) {
        sendCC(voiceId, note, tuning, value, SenderMobileSynth.CCFilterCutoff)
    }

    function handleFilterResonance(voiceId :int, note :int, tuning :int, value :double) {
        sendCC(voiceId, note, tuning, value, SenderMobileSynth.CCFilterResonance)
    }

    function handleOsc1Level(voiceId :int, note :int, tuning :int, value :double) {
        sendCC(voiceId, note, tuning, value, SenderMobileSynth.CCOsc1Level)
    }

    function handleOsc2Level(voiceId :int, note :int, tuning :int, value :double) {
        sendCC(voiceId, note, tuning, value, SenderMobileSynth.CCOsc2Level)
    }

    function handleOsc2Shift(voiceId :int, note :int, tuning :int, value :double) {
        sendCC(voiceId, note, tuning, value, SenderMobileSynth.CCOsc2Shift)
    }

    function sendCC(voiceId :int, note :int, tuning :int, value :double, cc: int) {
        sender.cc(voiceId,cc,Math.abs(value))
    }

    function sendPitch(voiceId :int, note :int, tuning :int, value :double) {
        let pitchedTuning = tuning + value * 500
        let pitchedF = 6.875 * Math.pow( 2 , ((note + offsetMidiChamberTone) * 100 + pitchedTuning) / 1200)
        sender.pitch(voiceId,pitchedF,note,pitchedTuning)
    }

    function connectHandler(currentHaldlerId :int, newHaldlerId :int, toSignal: var) {
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
        } else if(currentHaldlerId===6) {
            toSignal.disconnect(handleOsc1Level)
        } else if(currentHaldlerId===7) {
            toSignal.disconnect(handleOsc2Level)
        } else if(currentHaldlerId===8) {
            toSignal.disconnect(handleOsc2Shift)
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
        } else if(newHaldlerId===6) {
            toSignal.connect(handleOsc1Level)
        } else if(newHaldlerId===7) {
            toSignal.connect(handleOsc2Level)
        } else if(newHaldlerId===8) {
            toSignal.connect(handleOsc2Shift)
        }
    }

    Component.onCompleted: function() {
        console.log("XYModAssignForm completed ")
        //deviceSelect.currentIndex=synthesizer.audioDeviceIndex
        valueMap.set(SenderMobileSynth.CCModAmount,0.5)
        modMap.set(SenderMobileSynth.CCModAmount,1)
        valueMap.set(SenderMobileSynth.CCModFreq,2)
        modMap.set(SenderMobileSynth.CCModFreq,1)
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

