// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12

Parameters_Osc_2Form {
    id: root
    
    Component.onCompleted: {
        levelSlider.onValueChanged.connect(function() {
            root.synthesizer.set_osc2_level(levelSlider.value)
        })
        
        waveSlider.onValueChanged.connect(function() {
            root.synthesizer.set_osc2_wave_type(waveSlider.value)
        })
        
        octaveSlider.onValueChanged.connect(function() {
            root.synthesizer.set_osc2_octave(octaveSlider.value)
        })
        
        shiftSlider.onValueChanged.connect(function() {
            root.synthesizer.set_osc2_shift(shiftSlider.value)
        })
    }
}
