/*
This file is for working with MIDI controllers with faders and knobs.
Some MIDI controllers have a keyboard and faders and knobs,
so you would combine stuff from the regular midi.scd file to work with these.
*/

MIDIClient.init;
MIDIIn.connectAll;
//MIDIdef.freeAll;

// This synth allows for changing control bus values without clicking.
SynthDef(\buschange, {
    var sig;
    sig = Line.kr(\start.ir(0), \end.ir(1), \dur.ir(0.001), doneAction: 2);
    Out.kr(\bus.ir(0), sig);
}).add;

// Mapping for QuNeo
~midimap = Dictionary.newFrom([
    "fader1", 0,
    "fader2", 1,
    "fader3", 2,
    "fader4", 3,
    "fader5", 6,
    "fader6", 7,
    "fader7", 8,
    "fader8", 9,
    "fader9", 10,
    "knob1", 4,
    "knob2", 5,
    "stop", 84,
    "pause", 85,
    "play", 86,
    "test", 79,
]);

~piece_index = 0;

// I'm having trouble with fader 1 on the QuNeo.
/*
MIDIdef.cc("fader1", {
    arg val, idx;
    var current, target;
    current = ~faderbus[0].getSynchronous;
    target = val.linlin(0, 127, 0.0, 1.0);
    Synth(\buschange, [\start, current, \end, target, \bus, ~faderbus[0]]);
    ("fader bus 0: " ++ target).postln;
}, ~midimap["fader1"]).permanent = true;
*/

// note: the quneo pads go from note number 36 to 51
/*MIDIdef.noteOn("on", {
    arg velocity, noteNumber, channel, source;
    if(noteNumber == 36, {
        if(~event_counter < ~event_order_list.size, {
            if(~event_order_list[~event_counter][1] == "next", {
                e[~event_order_list[~event_counter][0]].next.postln;
            }, {
                e[~event_order_list[~event_counter][0]].play;
            });
            ~event_counter = ~event_counter + 1;
        }, {
            e["main"].next;
        });
    });
    if(noteNumber == 49, {
        ~event_counter_reset.();
    });
    if(noteNumber == 50, {
        ~partial_reset.();
    });
    if(noteNumber == 51, {
        ~full_reset.();
    });
    if(noteNumber == 19, {
        "Test QuNeo MIDI controller".postln;
    });
    //("note number " ++ noteNumber ++ " was pressed").postln;
}).permanent = true;
*/

MIDIdef.noteOn("on", {
    arg velocity, noteNumber, channel, source;
    "Test QuNeo MIDI controller".postln;
    //("note number " ++ noteNumber ++ " was pressed").postln;
}, 19).permanent = true;

MIDIdef.noteOn("on", {
    arg velocity, noteNumber, channel, source;
    if(~event_counter < ~event_order_list.size, {
        if(~event_order_list[~event_counter][1] == "next", {
            e[~event_order_list[~event_counter][0]].next.postln;
        }, {
            e[~event_order_list[~event_counter][0]].play;
        });
        ~event_counter = ~event_counter + 1;
    }, {
        e["main"].next;
    });
    //("note number " ++ noteNumber ++ " was pressed").postln;
}, 36).permanent = true;

MIDIdef.noteOn("on", {
    arg velocity, noteNumber, channel, source;
    Synth(\sampler_out3, [\buf, ~samples["piece"][~piece_index]["buffer"], \mul_sig, ~faderbus[7], \out1, ~gainbus, \out2, ~reverbbus[0], \mul, 3.dbamp, \mul1, 1, \mul2, 1], ~grp[0], \addToTail);
    ~piece_index = ~piece_index + 1;
    //("note number " ++ noteNumber ++ " was pressed").postln;
}, 37).permanent = true;

MIDIdef.noteOn("on", {
    arg velocity, noteNumber, channel, source;
    ~event_counter_reset.();
    //("note number " ++ noteNumber ++ " was pressed").postln;
}, 49).permanent = true;

MIDIdef.noteOn("on", {
    arg velocity, noteNumber, channel, source;
    ~partial_reset.();
    //("note number " ++ noteNumber ++ " was pressed").postln;
}, 50).permanent = true;

MIDIdef.noteOn("on", {
    arg velocity, noteNumber, channel, source;
    ~full_reset.();
    //("note number " ++ noteNumber ++ " was pressed").postln;
}, 51).permanent = true;

MIDIdef.noteOff("off", {
    arg velocity, noteNumber, channel, source;
    //("note number " ++ noteNumber ++ " was released").postln;
}).permanent = true;

MIDIdef.cc("fader2", {
    arg val, idx;
    var current, target;
    current = ~faderbus[1].getSynchronous;
    target = val.linlin(0, 127, 0.0, 1.0);
    Synth(\buschange, [\start, current, \end, target, \bus, ~faderbus[1]]);
    //("fader bus 1: " ++ target).postln;
}, ~midimap["fader2"]).permanent = true;

MIDIdef.cc("fader3", {
    arg val, idx;
    var current, target;
    current = ~faderbus[2].getSynchronous;
    target = val.linlin(0, 127, 0.0, 1.0);
    Synth(\buschange, [\start, current, \end, target, \bus, ~faderbus[2]]);
    //("fader bus 2: " ++ target).postln;
}, ~midimap["fader3"]).permanent = true;

MIDIdef.cc("fader4", {
    arg val, idx;
    var current, target;
    current = ~faderbus[3].getSynchronous;
    target = val.linlin(0, 127, 0.0, 1.0);
    Synth(\buschange, [\start, current, \end, target, \bus, ~faderbus[3]]);
    //("fader bus 3: " ++ target).postln;
}, ~midimap["fader4"]).permanent = true;

MIDIdef.cc("fader5", {
    arg val, idx;
    var current, target;
    current = ~faderbus[4].getSynchronous;
    target = val.linlin(0, 127, 0.0, 1.0);
    Synth(\buschange, [\start, current, \end, target, \bus, ~faderbus[4]]);
    //("fader bus 4: " ++ target).postln;
}, ~midimap["fader5"]).permanent = true;

MIDIdef.cc("fader6", {
    arg val, idx;
    var current, target;
    current = ~faderbus[5].getSynchronous;
    target = val.linlin(0, 127, 0.0, 1.0);
    Synth(\buschange, [\start, current, \end, target, \bus, ~faderbus[5]]);
    //("fader bus 5: " ++ target).postln;
}, ~midimap["fader6"]).permanent = true;

MIDIdef.cc("fader7", {
    arg val, idx;
    var current, target;
    current = ~faderbus[6].getSynchronous;
    target = val.linlin(0, 127, 0.0, 1.0);
    Synth(\buschange, [\start, current, \end, target, \bus, ~faderbus[6]]);
    //("fader bus 6: " ++ target).postln;
}, ~midimap["fader7"]).permanent = true;

MIDIdef.cc("fader8", {
    arg val, idx;
    var current, target;
    current = ~faderbus[7].getSynchronous;
    target = val.linlin(0, 127, 0.0, 1.0);
    Synth(\buschange, [\start, current, \end, target, \bus, ~faderbus[7]]);
    //("fader bus 7: " ++ target).postln;
}, ~midimap["fader8"]).permanent = true;

MIDIdef.cc("fader9", {
    arg val, idx;
    var current, target;
    current = ~faderbus[8].getSynchronous;
    target = val.linlin(0, 127, 0.0, 1.0);
    Synth(\buschange, [\start, current, \end, target, \bus, ~faderbus[8]]);
    //("fader bus 8: " ++ target).postln;
}, ~midimap["fader9"]).permanent = true;

MIDIdef.cc("knob1", {
    arg val, idx;
    var current, target;
    current = ~knobbus[0].getSynchronous;
    target = val.linlin(0, 127, 0.0, 1.0);
    Synth(\buschange, [\start, current, \end, target, \bus, ~knobbus[0]]);
    //("knob bus 1: " ++ target).postln;
}, ~midimap["knob1"]).permanent = true;

MIDIdef.cc("knob2", {
    arg val, idx;
    var current, target;
    current = ~knobbus[1].getSynchronous;
    target = val.linlin(0, 127, 0.0, 1.0);
    Synth(\buschange, [\start, current, \end, target, \bus, ~knobbus[1]]);
    //("knob bus 2: " ++ target).postln;
}, ~midimap["knob2"]).permanent = true;

MIDIdef.cc("stop", {
    arg val, idx;
    //val.postln;
}, ~midimap["stop"]).permanent = true;

MIDIdef.cc("pause", {
    arg val, idx;
    //val.postln;
}, ~midimap["pause"]).permanent = true;

MIDIdef.cc("play", {
    arg val, idx;
    //val.postln;
}, ~midimap["play"]).permanent = true;

MIDIdef.cc("test", {
    arg val, idx;
    //"test midi controller".postln;
}, ~midimap["test"]).permanent = true;
