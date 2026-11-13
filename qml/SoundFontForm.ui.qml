// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick
import QtQuick.Controls
import misuco3

Item {
    id: root

    property alias mobileSynthSwitch: mobileSynthSwitch
    property alias soundFontSwitch: soundFontSwitch
    property alias loadButton: loadButton
    property alias reverbSwitch: reverbSwitch
    property alias chorusSwitch: chorusSwitch
    property alias presetSelect: presetSelect
    property alias gainSlider: gainSlider

    property MasterSender sender
    property MobileSynth synthesizer
    property SoundFontSynth soundFont

    property bool mobileSynthOn: true

    property double rasterWidth: 50
    property double elementSpace: 5
    property double elementRadius: 5
    property bool portrait: false
    property string fontFamily
    property double fontPixelSize: 10

    readonly property double contentWidth: width - 2*elementSpace
    readonly property double elementWidth: (contentWidth - 4*elementSpace) / 2
    readonly property double buttonSize: rasterWidth - 3*elementSpace

    ControlArea {
        width: root.width
        height: root.height
        fontFamily: root.fontFamily
        fontPixelSize: root.fontPixelSize
        text: root.soundFont.errorString !== "" ? root.soundFont.errorString :
              root.soundFont.loaded ? "SoundFont / " + root.soundFont.soundFontName :
              "SoundFont"

        Column {
            y: 2*root.elementSpace
            spacing: root.elementSpace
            padding: root.elementSpace

            Row {
                spacing: root.elementSpace

                ControlButton {
                    id: mobileSynthSwitch
                    width: root.rasterWidth
                    height: root.buttonSize
                    text: "synth"
                    selected: root.mobileSynthOn
                    bgColor: selected ? "Orange" : "Gray"
                    fgColor: "White"
                }

                ControlButton {
                    id: soundFontSwitch
                    width: root.rasterWidth
                    height: root.buttonSize
                    text: "sf2"
                    selected: root.soundFont.enabled
                    bgColor: selected ? "Orange" : "Gray"
                    fgColor: "White"
                }

                ControlButton {
                    id: loadButton
                    width: root.rasterWidth
                    height: root.buttonSize
                    text: "load"
                    selected: pressed
                    bgColor: pressed ? "Orange" : "Gray"
                    fgColor: "White"
                }

                ControlButton {
                    id: reverbSwitch
                    width: root.rasterWidth
                    height: root.buttonSize
                    text: "rev"
                    selected: root.soundFont.reverb
                    bgColor: selected ? "Orange" : "Gray"
                    fgColor: "White"
                }

                ControlButton {
                    id: chorusSwitch
                    width: root.rasterWidth
                    height: root.buttonSize
                    text: "cho"
                    selected: root.soundFont.chorus
                    bgColor: selected ? "Orange" : "Gray"
                    fgColor: "White"
                }
            }

            Row {
                spacing: root.elementSpace

                ComboBox {
                    id: presetSelect
                    width: root.elementWidth
                    height: root.buttonSize
                }

                ControlSlider {
                    id: gainSlider
                    width: root.elementWidth
                    height: root.buttonSize
                    fontFamily: root.fontFamily
                    fontPixelSize: root.fontPixelSize
                    text: "Gain"
                    from: 0.0
                    to: 2.0
                    stepSize: 0.01
                }
            }
        }
    }
}
