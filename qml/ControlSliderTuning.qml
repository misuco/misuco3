// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2024 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

import QtQuick 2.12
import QtQuick.Controls 2.12

Slider {
    property var controller
    property int index
    x:10
    y:70
    height: 240
    from: -120
    to: 120
    value: 0
    orientation: Qt.Vertical
    onValueChanged: function() {
        controller.tuningUpdated(index,value)
    }
}
