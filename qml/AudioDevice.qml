// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12

AudioDeviceForm {
    deviceSelect.onCurrentIndexChanged: function() {synth.deviceChanged(deviceSelect.currentIndex)}
    modeSelect.onCurrentIndexChanged: function() {
        if(modeSelect.currentIndex===0) {
            console.log("push mode")
            synth.push_mode()
        } else {
            console.log("pull mode")
            synth.pull_mode()
        }
    }
}

