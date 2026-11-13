// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Dialogs

SoundFontForm {
    id: root

    // The preset list is replaced as a whole when a soundfont is loaded.
    // Model and index are set together, a binding on the index would be
    // lost in the model reset.
    function syncPresets() {
        presetSelect.model = soundFont.presetList
        presetSelect.currentIndex = soundFont.presetIndex
    }

    Component.onCompleted: function() {
        syncPresets()
        gainSlider.value = soundFont.gain
    }

    Connections {
        target: root.soundFont
        function onSoundFontChanged() {
            root.syncPresets()
        }
        function onPresetIndexChanged() {
            root.presetSelect.currentIndex = root.soundFont.presetIndex
        }
    }

    mobileSynthSwitch.onPressed: function() {
        mobileSynthOn = !mobileSynthOn
        sender.onToggleSender("MobileSynth", mobileSynthOn)
        if(!mobileSynthOn) {
            // release the notes that would never get their note off
            for(let voiceId=1; voiceId<=87; voiceId++) {
                synthesizer.noteOff(voiceId)
            }
        }
    }

    soundFontSwitch.onPressed: function() {
        if(soundFont.enabled) {
            sender.onToggleSender("SoundFont", false)
            soundFont.enabled = false
        } else {
            soundFont.enabled = true
            sender.onToggleSender("SoundFont", true)
        }
    }

    loadButton.onClicked: function() {
        fileDialog.open()
    }

    reverbSwitch.onPressed: function() {
        soundFont.reverb = !soundFont.reverb
    }

    chorusSwitch.onPressed: function() {
        soundFont.chorus = !soundFont.chorus
    }

    presetSelect.onActivated: function(index) {
        soundFont.presetIndex = index
    }

    gainSlider.onMoved: function() {
        soundFont.gain = gainSlider.value
    }

    FileDialog {
        id: fileDialog
        title: "Load SoundFont"
        // the document pickers of the mobile platforms do not know the sf2 type
        nameFilters: Qt.platform.os === "android" || Qt.platform.os === "ios"
                     ? []
                     : ["SoundFont (*.sf2 *.SF2)", "All files (*)"]
        onAccepted: function() {
            root.soundFont.loadSoundFont(selectedFile)
        }
    }
}
