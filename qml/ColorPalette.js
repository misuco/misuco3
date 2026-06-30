// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

.pragma library

let colors=
[
    {
        name: "piano",
        fg: [
            "#000000",
            "#ffffff",
            "#000000",
            "#ffffff",
            "#000000",
            "#000000",
            "#ffffff",
            "#000000",
            "#ffffff",
            "#000000",
            "#ffffff",
            "#000000"
        ],
        bg: [
            "#ffffff",
            "#000000",
            "#ffffff",
            "#000000",
            "#ffffff",
            "#ffffff",
            "#000000",
            "#ffffff",
            "#000000",
            "#ffffff",
            "#000000",
            "#ffffff"
        ],
        bgActive: [
            "#aaffaa",
            "#00aa00",
            "#aaffaa",
            "#00aa00",
            "#aaffaa",
            "#aaffaa",
            "#00aa00",
            "#aaffaa",
            "#00aa00",
            "#aaffaa",
            "#00aa00",
            "#aaffaa"
        ]
    }
        ,
    {
        name: "nice colors",
        fg: [
            "#ffffff",
            "#ffffff",
            "#ffffff",
            "#ffffff",
            "#ffffff",
            "#ffffff",
            "#ffffff",
            "#ffffff",
            "#ffffff",
            "#ffffff",
            "#ffffff",
            "#ffffff"
        ],
        bg: [
            "#a6cee366",
            "#1f78b466",
            "#b2df8a66",
            "#33a02c66",
            "#fb9a9966",
            "#e31a1c66",
            "#fdbf6f66",
            "#ff7f0066",
            "#cab2d666",
            "#6a3d9a66",
            "#ffff9966",
            "#b1592866"
        ],
        bgActive: [
            "#a6cee3",
            "#1f78b4",
            "#b2df8a",
            "#33a02c",
            "#fb9a99",
            "#e31a1c",
            "#fdbf6f",
            "#ff7f00",
            "#cab2d6",
            "#6a3d9a",
            "#ffff99",
            "#b15928"
        ]
    }
]

function fg(palette,index) {
    return colors[palette].fg[index];
}

function bg(palette,index,active) {
    if(active) {
        return colors[palette].bgActive[index];
    } else {
        return colors[palette].bg[index];
    }
}
