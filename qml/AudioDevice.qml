// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick

AudioDeviceForm {
    property bool audioInitialized: false

    Component.onCompleted: function() {
        console.log("synthContext.audioDeviceIndex: " + synthesizer.audioDeviceIndex)
        deviceSelect.currentIndex=synthesizer.audioDeviceIndex

        audioInitialized = true

        bufferSizeSelect.currentIndex=3 //Math.sqrt(synthesizer.bufferSize/512)-1
    }

    deviceSelect.onCurrentIndexChanged: function() {
        if(audioInitialized) {
            synthesizer.deviceChanged(deviceSelect.currentIndex)
        }
    }

    modeSelect.onCurrentIndexChanged: function() {
        if(audioInitialized) {
            if(modeSelect.currentIndex===0) {
                synthesizer.pull_mode()
            } else {
                synthesizer.push_mode()
            }
        }
    }
    bufferSizeSelect.onCurrentIndexChanged: function() {
        if(audioInitialized) {
            let v=512*Math.pow(2,bufferSizeSelect.currentIndex);
            console.log("buffer size "+v)
            synthesizer.set_buffer_size(v)
        }
    }
}

