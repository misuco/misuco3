// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12

AudioDeviceForm {
    property bool audioInitialized: false

    Component.onCompleted: function() {
        console.log("synthContext.audioDeviceIndex: " + synthContext.audioDeviceIndex)
        deviceSelect.currentIndex=synthContext.audioDeviceIndex
        bufferSizeSelect.currentIndex=Math.sqrt(synthContext.bufferSize/512)-1
        audioInitialized = true;
    }

    deviceSelect.onCurrentIndexChanged: function() {
        if(audioInitialized) {
            synthContext.deviceChanged(deviceSelect.currentIndex)
        }
    }

    modeSelect.onCurrentIndexChanged: function() {
        if(audioInitialized) {
            if(modeSelect.currentIndex===0) {
                synthContext.pull_mode()
            } else {
                synthContext.push_mode()
            }
        }
    }
    bufferSizeSelect.onCurrentIndexChanged: function() {
        if(audioInitialized) {
            let v=512*Math.pow(2,bufferSizeSelect.currentIndex);
            console.log("buffer size "+v)
            synthContext.set_buffer_size(v)
        }
    }
}

