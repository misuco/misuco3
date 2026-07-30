// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick

XYModAssignForm {

    Component.onCompleted: function() {
        console.log("XYModAssignForm completed ")
        //deviceSelect.currentIndex=synthesizer.audioDeviceIndex
    }

    xModAssignSelect.onCurrentIndexChanged: function() {
        //synthesizer.deviceChanged(deviceSelect.currentIndex)
    }

    yModAssignSelect.onCurrentIndexChanged: function() {
//            if(modeSelect.currentIndex===0) {
    }
}

