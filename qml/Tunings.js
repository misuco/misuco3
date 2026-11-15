// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

// The built in tunings. A tuning is the deviation of the twelve notes
// from the equal temperament in cent.

.pragma library

const pureFifth = 1200 * Math.log2(3/2)
const pythagoreanComma = 12 * pureFifth - 7 * 1200
const syntonicComma = 1200 * Math.log2(81/80)

// deviations of the notes with the given frequency ratios to the first note
function fromRatios(ratios) {
    let cents = []
    for(let i = 0; i < 12; i++) {
        cents.push(1200 * Math.log2(ratios[i]) - 100 * i)
    }
    return cents
}

// deviations of a tuning that is built as a chain of fifths. up are the
// fifths above the first note (C-G, G-D, ...), down the fifths below it
// (F-C, Bb-F, ...), each given as the part of the comma it is narrowed by.
function fromFifths(up, down, comma) {
    let cents = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    let pitch = 0
    for(let i = 0; i < up.length; i++) {
        pitch += pureFifth - up[i] * comma
        let note = (7 * (i + 1)) % 12
        cents[note] = ((pitch % 1200) + 1200) % 1200 - 100 * note
    }
    pitch = 0
    for(let j = 0; j < down.length; j++) {
        pitch -= pureFifth - down[j] * comma
        let note = (5 * (j + 1)) % 12
        cents[note] = ((pitch % 1200) + 1200) % 1200 - 100 * note
    }
    return cents
}

// onRoot: the tuning is built on the root note of the scale, which keeps
// its pitch. The other tunings are built on C as on a keyboard instrument,
// and A keeps its pitch.
const tunings = [
    {
        name: "Equal",
        onRoot: false,
        cents: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    },
    {
        name: "Pure (just intonation)",
        onRoot: true,
        cents: fromRatios([1, 16/15, 9/8, 6/5, 5/4, 4/3, 45/32, 3/2, 8/5, 5/3, 9/5, 15/8])
    },
    {
        name: "Pythagorean",
        onRoot: true,
        // pure fifths from Eb to G#
        cents: fromFifths([0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0], pythagoreanComma)
    },
    {
        name: "Meantone (1/4 comma)",
        onRoot: true,
        // all fifths from Eb to G# narrowed, pure major thirds
        cents: fromFifths([1/4, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4], [1/4, 1/4, 1/4], syntonicComma)
    },
    {
        name: "Meantone (1/6 comma)",
        onRoot: true,
        cents: fromFifths([1/6, 1/6, 1/6, 1/6, 1/6, 1/6, 1/6, 1/6], [1/6, 1/6, 1/6], syntonicComma)
    },
    {
        name: "Well-tempered: Werckmeister III",
        onRoot: false,
        // C-G, G-D, D-A and B-F# narrowed
        cents: fromFifths([1/4, 1/4, 1/4, 0, 0, 1/4, 0, 0], [0, 0, 0], pythagoreanComma)
    },
    {
        name: "Well-tempered: Kirnberger III",
        onRoot: false,
        // C-G, G-D, D-A and A-E narrowed, C-E is pure
        cents: fromFifths([1/4, 1/4, 1/4, 1/4, 0, 0], [0, 0, 0, 0, 0], syntonicComma)
    },
    {
        name: "Well-tempered: Vallotti",
        onRoot: false,
        // the six fifths from F to B narrowed
        cents: fromFifths([1/6, 1/6, 1/6, 1/6, 1/6, 0, 0, 0], [1/6, 0, 0], pythagoreanComma)
    },
    {
        name: "Well-tempered: Kellner (Bach)",
        onRoot: false,
        // C-G, G-D, D-A, A-E and B-F# narrowed
        cents: fromFifths([1/5, 1/5, 1/5, 1/5, 0, 1/5, 0, 0], [0, 0, 0], pythagoreanComma)
    },
    {
        name: "Overtones (harmonic series)",
        onRoot: true,
        cents: fromRatios([1, 17/16, 9/8, 19/16, 5/4, 21/16, 11/8, 3/2, 13/8, 27/16, 7/4, 15/8])
    }
]

function names() {
    return tunings.map(t => t.name)
}

function onRoot(index) {
    return tunings[index].onRoot
}

// the deviations in whole cent for the notes C to B
function cents(index, rootNote) {
    const t = tunings[index]
    let result = []
    for(let note = 0; note < 12; note++) {
        let c = t.onRoot ? t.cents[(note - rootNote + 12) % 12]
                         : t.cents[note] - t.cents[9]
        result.push(Math.max(-100, Math.min(100, Math.round(c))))
    }
    return result
}
