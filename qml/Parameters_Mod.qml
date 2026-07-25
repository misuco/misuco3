// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls

Parameters_ModForm {
    id: root
    
    Component.onCompleted: {
        amountSlider.onValueChanged.connect(function() {
            root.synthesizer.set_modulation_amount(amountSlider.value)
            console.log("set_modulation_amount " + amountSlider.value)
        })
        
        freqSlider.onValueChanged.connect(function() {
            root.synthesizer.set_modulation_frequency(freqSlider.value)
            console.log("set_modulation_frequency " + freqSlider.value)
        })
        
        sourceSquareButton.onPressed.connect(function() {
            root.synthesizer.set_modulation_source(0)
            root.source=0
        })
        
        sourceTriButton.onPressed.connect(function() {
            root.synthesizer.set_modulation_source(1)
            root.source=1
        })
        
        sourceSawButton.onPressed.connect(function() {
            root.synthesizer.set_modulation_source(2)
            root.source=2
        })
        
        sourceRevsawButton.onPressed.connect(function() {
            root.synthesizer.set_modulation_source(3)
            root.source=3
        })
        
        destWaveButton.onPressed.connect(function() {
            root.synthesizer.set_modulation_destination(0)
            root.destination=0
        })
        
        destPitchButton.onPressed.connect(function() {
            root.synthesizer.set_modulation_destination(1)
            root.destination=1
        })
        
        destFilterButton.onPressed.connect(function() {
            root.synthesizer.set_modulation_destination(2)
            root.destination=2
        })
    }
}
