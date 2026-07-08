// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12

AudioDeviceForm {
    property bool audioInitialized: false

    Component.onCompleted: function() {
        console.log("synth.audioDeviceIndex: " + synth.audioDeviceIndex)
        deviceSelect.currentIndex=synth.audioDeviceIndex
        bufferSizeSelect.currentIndex=Math.sqrt(synth.bufferSize/512)-1
        audioInitialized = true;
    }

    deviceSelect.onCurrentIndexChanged: function() {
        if(audioInitialized) {
            synth.deviceChanged(deviceSelect.currentIndex)
        }
    }

    modeSelect.onCurrentIndexChanged: function() {
        if(audioInitialized) {
            if(modeSelect.currentIndex===0) {
                synth.pull_mode()
            } else {
                synth.push_mode()
            }
        }
    }
    bufferSizeSelect.onCurrentIndexChanged: function() {
        if(audioInitialized) {
            let v=512*Math.pow(2,bufferSizeSelect.currentIndex);
            console.log("buffer size "+v)
            synth.set_buffer_size(v)
        }
    }
}

