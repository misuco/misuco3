// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick

NetworkMidiForm {
    id: root

    Component.onCompleted: function() {
        hostField.text = rtpMidi.host
        portField.text = rtpMidi.port
        nameField.text = rtpMidi.name
        channelSelect.currentIndex = rtpMidi.channel - 1
        modeSelect.currentIndex = rtpMidi.mode
    }

    // the fields are stored when they are edited, the session takes
    // them when it is switched on
    function storeFields() {
        rtpMidi.host = hostField.text.trim()
        if(portField.acceptableInput) {
            rtpMidi.port = parseInt(portField.text)
        }
        portField.text = rtpMidi.port
        rtpMidi.name = nameField.text.trim()
    }

    // a typed address is not the selected session any more
    hostField.onTextEdited: sessionSelected = false
    portField.onTextEdited: sessionSelected = false

    hostField.onEditingFinished: storeFields()
    portField.onEditingFinished: storeFields()
    nameField.onEditingFinished: storeFields()

    channelSelect.onActivated: function(index) {
        rtpMidi.channel = index + 1
    }

    modeSelect.onActivated: function(index) {
        rtpMidi.mode = index
    }

    searchButton.onPressed: function() {
        sessionSelected = false
        rtpMidi.search()
    }

    sessionSelect.onActivated: function(index) {
        rtpMidi.selectSession(index)
        sessionSelected = true
        hostField.text = rtpMidi.host
        portField.text = rtpMidi.port
    }

    enableSwitch.onPressed: function() {
        storeFields()
        rtpMidi.enabled = !rtpMidi.enabled
    }
}
