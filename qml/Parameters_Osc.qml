// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Parameters_OscForm {
    id: root
    
    Component.onCompleted: {
        levelSlider.onValueChanged.connect(function() {
            root.synthesizer.set_osc1_level(levelSlider.value)
            console.log("set_osc1_level " + levelSlider.value)
        })
        
        wave0Button.onPressed.connect(function() {
            root.synthesizer.set_osc1_wave_type(0)
            root.wave=0
        })
        
        wave1Button.onPressed.connect(function() {
            root.synthesizer.set_osc1_wave_type(1)
            root.wave=1
        })
        
        wave2Button.onPressed.connect(function() {
            root.synthesizer.set_osc1_wave_type(2)
            root.wave=2
        })
        
        wave3Button.onPressed.connect(function() {
            root.synthesizer.set_osc1_wave_type(3)
            root.wave=3
        })
        
        wave4Button.onPressed.connect(function() {
            root.synthesizer.set_osc1_wave_type(4)
            root.wave=4
        })
        
        octave0Button.onPressed.connect(function() {
            root.synthesizer.set_osc1_octave(0)
            root.octave=0
        })
        
        octave1Button.onPressed.connect(function() {
            root.synthesizer.set_osc1_octave(1)
            root.octave=1
        })
        
        octave2Button.onPressed.connect(function() {
            root.synthesizer.set_osc1_octave(2)
            root.octave=2
        })
        
        octave3Button.onPressed.connect(function() {
            root.synthesizer.set_osc1_octave(3)
            root.octave=3
        })
        
        octave4Button.onPressed.connect(function() {
            root.synthesizer.set_osc1_octave(4)
            root.octave=4
        })
    }
}
