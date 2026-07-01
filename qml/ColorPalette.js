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
    },
    {
        name: "https://iamkate.com/data/12-bit-rainbow/",
        fg: [
            "#f2e",
            "#f6a",
            "#fcc",
            "#ff8",
            "#ff0",
            "#ffa",
            "#8ff",
            "#4ff",
            "#0ff",
            "#0ff",
            "#6cf",
            "#c6f"
        ],
        bg: [
            "#403",
            "#512",
            "#633",
            "#742",
            "#750",
            "#452",
            "#264",
            "#165",
            "#065",
            "#046",
            "#135",
            "#314"
        ],
        bgActive: [
            "#817",
            "#a35",
            "#c66",
            "#e94",
            "#ed0",
            "#9d5",
            "#4d8",
            "#2cb",
            "#0bc",
            "#09c",
            "#36b",
            "#639"
        ]
    },
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
