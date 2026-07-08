// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12

AudioDeviceForm {
    deviceSelect.onCurrentIndexChanged: function() {synth.deviceChanged(deviceSelect.currentIndex)}
    modeSelect.onCurrentIndexChanged: function() {
        if(modeSelect.currentIndex===0) {
            synth.push_mode()
        } else {
            synth.pull_mode()
        }
    }
    bufferSizeSelect.onCurrentIndexChanged: function() {
        let v=512*Math.pow(2,bufferSizeSelect.currentIndex);
        console.log("buffer size "+v)
        synth.set_buffer_size(v)
    }
}

