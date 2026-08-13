// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import misuco3
import "./"

XYModAssignForm {   
    required property XYAssignableParameter parameters
    required property MasterSender sender

    readonly property int offsetMidiChamberTone: 3

    property int modAssignId: 0

    signal handleMod(voiceId :int, note :int, tuning :int, value :double)

    function xyMod(voiceId :int, note :int, tuning :int, value :double) {
        console.log(`xyMod voiceId: ${voiceId} note: ${note} tuning: ${tuning} value ${value}`)
        handleMod(voiceId, note, tuning, value)
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
        // translate value |-0.5....0.5| -> to sendValue |0.0...1.0| in range | minValue |0.0...1.0| ... maxValue |0.0...1.0| |
        let minValue = modMinSlider.value
        let maxValue = modMaxSlider.value
        let range = maxValue - minValue
        let valueClipped = Math.min(Math.max(value, -0.5), 0.5)
        let sendValue = minValue + range * (valueClipped + 0.5)
        sender.cc(voiceId,cc,sendValue)
        modBar.value = sendValue
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
            sender.ccAllVoices(
                SenderMobileSynth.CCModAmount,
                parameters.getBaseValue(SenderMobileSynth.CCModAmount)
            )
            toSignal.disconnect(handleModulationAmount)
        } else if(currentHaldlerId===3) {
            sender.ccAllVoices(
                SenderMobileSynth.CCModFreq,
                parameters.getBaseValue(SenderMobileSynth.CCModFreq)
            )
            toSignal.disconnect(handleModulationFrequency)
        } else if(currentHaldlerId===4) {
            sender.ccAllVoices(
                SenderMobileSynth.CCFilterCutoff,
                parameters.getBaseValue(SenderMobileSynth.CCFilterCutoff)
            )
            toSignal.disconnect(handleFilterCutoff)
        } else if(currentHaldlerId===5) {
            sender.ccAllVoices(
                SenderMobileSynth.CCFilterResonance,
                parameters.getBaseValue(SenderMobileSynth.CCFilterResonance)
            )
            toSignal.disconnect(handleFilterResonance)
        } else if(currentHaldlerId===6) {
            sender.ccAllVoices(
                SenderMobileSynth.CCOsc1Level,
                parameters.getBaseValue(SenderMobileSynth.CCOsc1Level)
            )
            toSignal.disconnect(handleOsc1Level)
        } else if(currentHaldlerId===7) {
            sender.ccAllVoices(
                SenderMobileSynth.CCOsc2Level,
                parameters.getBaseValue(SenderMobileSynth.CCOsc2Level)
            )
            toSignal.disconnect(handleOsc2Level)
        } else if(currentHaldlerId===8) {
            sender.ccAllVoices(
                SenderMobileSynth.CCOsc2Shift,
                parameters.getBaseValue(SenderMobileSynth.CCOsc2Shift)
            )
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
    }

    modAssignSelect.onCurrentIndexChanged: function() {
        connectHandler(modAssignId, modAssignSelect.currentIndex, handleMod)
        modAssignId=modAssignSelect.currentIndex
    }
}

