// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick

OscSenderForm {
    id: root

    Component.onCompleted: function() {
        hostField.text = osc.host
        portField.text = osc.port
        channelSelect.currentIndex = osc.channel - 1
        formatSelect.currentIndex = osc.format
        protocolSelect.currentIndex = osc.tcp ? 1 : 0
    }

    // the fields are stored when they are edited, the sender takes them
    // when it is switched on
    function storeFields() {
        osc.host = hostField.text.trim()
        if(portField.acceptableInput) {
            osc.port = parseInt(portField.text)
        }
        portField.text = osc.port
    }

    hostField.onEditingFinished: storeFields()
    portField.onEditingFinished: storeFields()

    formatSelect.onActivated: function(index) {
        // the port follows the format, if it is the port of the old format
        if(!osc.enabled && osc.port === osc.defaultPort(osc.format)) {
            osc.port = osc.defaultPort(index)
            portField.text = osc.port
        }
        osc.format = index
    }

    protocolSelect.onActivated: function(index) {
        osc.tcp = index === 1
    }

    channelSelect.onActivated: function(index) {
        osc.channel = index + 1
    }

    enableSwitch.onPressed: function() {
        storeFields()
        osc.enabled = !osc.enabled
    }
}
