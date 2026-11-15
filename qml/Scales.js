// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

// The built in scales. A scale is the list of its notes as the number of
// half tones above the root note.

.pragma library

const scales = [
    { name: "Major / Ionian",               notes: [0, 2, 4, 5, 7, 9, 11] },
    { name: "Natural Minor / Aeolian",      notes: [0, 2, 3, 5, 7, 8, 10] },
    { name: "Harmonic Minor",               notes: [0, 2, 3, 5, 7, 8, 11] },
    { name: "Melodic Minor",                notes: [0, 2, 3, 5, 7, 9, 11] },
    { name: "Dorian",                       notes: [0, 2, 3, 5, 7, 9, 10] },
    { name: "Phrygian",                     notes: [0, 1, 3, 5, 7, 8, 10] },
    { name: "Lydian",                       notes: [0, 2, 4, 6, 7, 9, 11] },
    { name: "Mixolydian",                   notes: [0, 2, 4, 5, 7, 9, 10] },
    { name: "Locrian",                      notes: [0, 1, 3, 5, 6, 8, 10] },
    { name: "Major Pentatonic",             notes: [0, 2, 4, 7, 9] },
    { name: "Minor Pentatonic",             notes: [0, 3, 5, 7, 10] },
    { name: "Blues",                        notes: [0, 3, 5, 6, 7, 10] },
    { name: "Whole Tone",                   notes: [0, 2, 4, 6, 8, 10] },
    { name: "Diminished (whole-half)",      notes: [0, 2, 3, 5, 6, 8, 9, 11] },
    { name: "Phrygian Dominant / Hijaz",    notes: [0, 1, 4, 5, 7, 8, 10] },
    { name: "Double Harmonic / Byzantine",  notes: [0, 1, 4, 5, 7, 8, 11] },
    { name: "Hungarian Minor",              notes: [0, 2, 3, 6, 7, 8, 11] },
    { name: "Hirajoshi",                    notes: [0, 2, 3, 7, 8] },
    { name: "Major Triad",                  notes: [0, 4, 7] },
    { name: "Minor Triad",                  notes: [0, 3, 7] },
    { name: "Chromatic",                    notes: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11] }
]

function names() {
    return scales.map(s => s.name)
}

// the twelve steps of the scale, 1 if the step is played
function steps(index) {
    let result = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    scales[index].notes.forEach(n => result[n] = 1)
    return result
}
