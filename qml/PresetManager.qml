import QtQuick
import QtQuick.Controls
import "./"

ControlArea {
    id: root
    required property MobileSynth synthesizer
    required property XYAssignableParameter modAssign

    width: parent.width
    height: parent.height
    text: "Presets"

    Column {
        anchors.fill: parent
        spacing: root.elementSpace
        padding: root.elementSpace

        Row {
            spacing: root.elementSpace
            ComboBox {
                id: presetCombo
                width: parent.width * 0.7
                model: PresetStore.presets()
                textRole: "name"
                onCurrentIndexChanged: {
                    if (currentIndex >= 0) {
                        var p = PresetStore.getPreset(currentIndex)
                        if (p.osc1) {
                            if (p.osc1.level !== undefined) synthesizer.set_osc1_level(p.osc1.level)
                            if (p.osc1.wave_type !== undefined) synthesizer.set_osc1_wave_type(p.osc1.wave_type)
                            if (p.osc1.octave !== undefined) synthesizer.set_osc1_octave(p.osc1.octave)
                        }
                        if (p.osc2) {
                            if (p.osc2.level !== undefined) synthesizer.set_osc2_level(p.osc2.level)
                            if (p.osc2.shift !== undefined) synthesizer.set_osc2_shift(p.osc2.shift)
                            if (p.osc2.wave_type !== undefined) synthesizer.set_osc2_wave_type(p.osc2.wave_type)
                            if (p.osc2.octave !== undefined) synthesizer.set_osc2_octave(p.osc2.octave)
                        }
                        if (p.filter_cutoff !== undefined) modAssign.setBaseValue(74, p.filter_cutoff)
                        if (p.filter_resonance !== undefined) modAssign.setBaseValue(71, p.filter_resonance)

                        if (p.volume_envelope) {
                            if (p.volume_envelope.attack !== undefined) synthesizer.set_volume_attack(Math.round(p.volume_envelope.attack))
                            if (p.volume_envelope.decay !== undefined) synthesizer.set_volume_decay(Math.round(p.volume_envelope.decay))
                            if (p.volume_envelope.sustain !== undefined) synthesizer.set_volume_sustain(p.volume_envelope.sustain)
                            if (p.volume_envelope.release !== undefined) synthesizer.set_volume_release(Math.round(p.volume_envelope.release))
                        }

                        if (p.filter_envelope) {
                            if (p.filter_envelope.attack !== undefined) synthesizer.set_filter_attack(Math.round(p.filter_envelope.attack))
                            if (p.filter_envelope.decay !== undefined) synthesizer.set_filter_decay(Math.round(p.filter_envelope.decay))
                            if (p.filter_envelope.sustain !== undefined) synthesizer.set_filter_sustain(p.filter_envelope.sustain)
                            if (p.filter_envelope.release !== undefined) synthesizer.set_filter_release(Math.round(p.filter_envelope.release))
                        }
                    }
                }
            }
            Button {
                text: "Store"
                onPressed: saveDialog.open()
            }
        }

        TextArea {
            id: presetInfo
            readOnly: true
            wrapMode: Text.Wrap
            text: presetCombo.currentIndex >= 0 ? JSON.stringify(PresetStore.getPreset(presetCombo.currentIndex), null, 2) : ""
            width: parent.width
            height: parent.height - 120
        }
    }

    PresetSaveDialog {
        id: saveDialog
        onSaveRequested: function(name, mode) {
            var p = {}
            p.name = name

            try {
                p.osc1 = {
                    level: synthesizer.get_osc1_level ? synthesizer.get_osc1_level() : undefined,
                    wave_type: synthesizer.get_osc1_wave_type ? synthesizer.get_osc1_wave_type() : undefined,
                    octave: synthesizer.get_osc1_octave ? synthesizer.get_osc1_octave() : undefined
                }
            } catch (e) {}

            try {
                p.osc2 = {
                    level: synthesizer.get_osc2_level ? synthesizer.get_osc2_level() : undefined,
                    shift: synthesizer.get_osc2_shift ? synthesizer.get_osc2_shift() : undefined,
                    wave_type: synthesizer.get_osc2_wave_type ? synthesizer.get_osc2_wave_type() : undefined,
                    octave: synthesizer.get_osc2_octave ? synthesizer.get_osc2_octave() : undefined
                }
            } catch (e) {}

            try {
                p.volume_envelope = {
                    attack: synthesizer.get_volume_attack ? synthesizer.get_volume_attack() : undefined,
                    decay: synthesizer.get_volume_decay ? synthesizer.get_volume_decay() : undefined,
                    sustain: synthesizer.get_volume_sustain ? synthesizer.get_volume_sustain() : undefined,
                    release: synthesizer.get_volume_release ? synthesizer.get_volume_release() : undefined
                }
            } catch (e) {}

            try {
                p.filter_envelope = {
                    attack: synthesizer.get_filter_attack ? synthesizer.get_filter_attack() : undefined,
                    decay: synthesizer.get_filter_decay ? synthesizer.get_filter_decay() : undefined,
                    sustain: synthesizer.get_filter_sustain ? synthesizer.get_filter_sustain() : undefined,
                    release: synthesizer.get_filter_release ? synthesizer.get_filter_release() : undefined
                }
            } catch (e) {}

            try { p.filter_cutoff = modAssign.getBaseValue(74) } catch (e) {}
            try { p.filter_resonance = modAssign.getBaseValue(71) } catch (e) {}

            PresetStore.saveUserPreset(p, mode === "overwrite", -1)
        }
    }
}
