// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import misuco3

QtObject {
    property var valueMap: new Map()

    function setBaseValue(cc :int, value :double) {
        console.log(`setBaseValue ${cc} ${value}`)
        valueMap.set(cc,value)
    }

    function getBaseValue(cc :int) :double {
        return valueMap.get(cc)
    }

    Component.onCompleted: function() {
        // TODO: properly initialize value map according to real values
        console.log("XYAssignableParameter completed ")
        valueMap.set(SenderMobileSynth.CCModAmount,0.5)
        valueMap.set(SenderMobileSynth.CCModFreq,2)
    }
}
