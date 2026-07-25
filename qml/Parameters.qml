// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12

ParametersForm {
    id: root
    
    Component.onCompleted: {
        arpeggioSamplesSlider.onValueChanged.connect(function() {
            console.log("set_arpeggio_samples " + arpeggioSamplesSlider.value)
            root.synthesizer.set_arpeggio_samples(arpeggioSamplesSlider.value)
        })
        
        arpeggioOctavesSlider.onValueChanged.connect(function() {
            console.log("set_arpeggio_octaves " + arpeggioOctavesSlider.value)
            root.synthesizer.set_arpeggio_octaves(arpeggioOctavesSlider.value)
        })
        
        arpeggioStepSlider.onValueChanged.connect(function() {
            console.log("set_arpeggio_step " + arpeggioStepSlider.value)
            root.synthesizer.set_arpeggio_step(arpeggioStepSlider.value)
        })
        
        filterCutoffSlider.onValueChanged.connect(function() {
            root.synthesizer.set_filter_cutoff(filterCutoffSlider.value)
        })
        
        filterResonanceSlider.onValueChanged.connect(function() {
            root.synthesizer.set_filter_resonance(filterResonanceSlider.value)
        })
    }
}
