/*
This file is for working with MIDI controllers with faders and knobs.
Some MIDI controllers have a keyboard and faders and knobs,
so you would combine stuff from the regular midi.scd file to work with these.
*/

MIDIClient.init;

~midi_sources = Dictionary();  // track the midi sources that we're using
// connect *only* specific devices by name (QuNeo and V25)
{
	var devIdx = 0;
	MIDIClient.sources.do({
		|src, i|
		if(src.device.toLower.matchRegexp("quneo"), {
			~midi_sources["quneo"] = src;
			MIDIIn.connect(devIdx, MIDIClient.sources.at(i));
			devIdx = devIdx + 1;
		});
		if(src.device.toLower.matchRegexp("v25") && src.name.toLower.matchRegexp("^out"), {
			~midi_sources["v25"] = src;
			MIDIIn.connect(devIdx, MIDIClient.sources.at(i));
			devIdx = devIdx + 1;
		});
	});
}.();

//MIDIIn.connectAll;
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

// BPF frequency MIDI keyboard reader
MIDIdef.noteOn("on", {
    arg velocity, noteNumber, channel, source;
    Synth(\buschange, [\start, ~notebus.getSynchronous, \end, noteNumber, \bus, ~notebus]);
    ("note number " ++ noteNumber ++ " was pressed on device v25").postln;
}, srcID: ~midi_sources["v25"].uid).permanent = true;

// Tester to verify that the QuNeo controller works
MIDIdef.noteOn("on", {
    arg velocity, noteNumber, channel, source;
    "Test QuNeo MIDI controller".postln;
    //("note number " ++ noteNumber ++ " was pressed").postln;
}, 19, srcID: ~midi_sources["quneo"].uid).permanent = true;

// Event player - starts the next event
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
}, 36, srcID: ~midi_sources["quneo"].uid).permanent = true;

/*
// Piece sample player - for use with prerecorded recordings of the piece
MIDIdef.noteOn("on", {
    arg velocity, noteNumber, channel, source;
    Synth(\sampler_out3, [\buf, ~samples["piece"][~measure_list[~piece_index]]["buffer"], \mul_sig, ~faderbus[7], \out, 0, \mul, 0.dbamp], ~grp[0], \addToTail);
    (">> playing " ++ ~measure_list[~piece_index]).postln;
    ~piece_index = ~piece_index + 1;
    //("note number " ++ noteNumber ++ " was pressed").postln;
}, 37, srcID: ~midi_sources["quneo"].uid).permanent = true;

// Sample player for use with prerecorded recordings of the piece
MIDIdef.noteOn("on", {
    arg velocity, noteNumber, channel, source;
    Synth(\sampler_out3, [\buf, ~samples["piece"]["m82f"]["buffer"], \mul_sig, ~faderbus[7], \out, 0, \mul, 0.dbamp], ~grp[0], \addToTail);
    (">> playing " ++ "m82f").postln;
    //("note number " ++ noteNumber ++ " was pressed").postln;
}, 40, srcID: ~midi_sources["quneo"].uid).permanent = true;

MIDIdef.noteOn("on", {
    arg velocity, noteNumber, channel, source;
    Synth(\sampler_out3, [\buf, ~samples["piece"]["m82g"]["buffer"], \mul_sig, ~faderbus[7], \out, 0, \mul, 0.dbamp], ~grp[0], \addToTail);
    (">> playing " ++ "m82g").postln;
    //("note number " ++ noteNumber ++ " was pressed").postln;
}, 41, srcID: ~midi_sources["quneo"].uid).permanent = true;

MIDIdef.noteOn("on", {
    arg velocity, noteNumber, channel, source;
    Synth(\sampler_out3, [\buf, ~samples["piece"]["m82h"]["buffer"], \mul_sig, ~faderbus[7], \out, 0, \mul, 0.dbamp], ~grp[0], \addToTail);
    (">> playing " ++ "m82h").postln;
    //("note number " ++ noteNumber ++ " was pressed").postln;
}, 42, srcID: ~midi_sources["quneo"].uid).permanent = true;
*/

// Records the output
MIDIdef.noteOn("on", {
    arg velocity, noteNumber, channel, source;
    ~record_num = ~record_num + 1;
    if(r[0].isRecording, {
        r[0].stopRecording;
        r[1].stopRecording;
        "STOPPED RECORDING".postln;
    }, {
        r[0].record(PathName(~root_sample_dir ++ "samples/recording_" ++ ~record_num ++ "a.wav").fullPath, ~recordbus1, 1);
        r[1].record(PathName(~root_sample_dir ++ "samples/recording_" ++ ~record_num ++ "b.wav").fullPath, ~recordbus2, 2);
        "RECORDING...".postln;
    });
    //("note number " ++ noteNumber ++ " was pressed").postln;
}, 48, srcID: ~midi_sources["quneo"].uid).permanent = true;

// Resets the event counter
MIDIdef.noteOn("on", {
    arg velocity, noteNumber, channel, source;
    ~event_counter_reset.();
    //("note number " ++ noteNumber ++ " was pressed").postln;
}, 49, srcID: ~midi_sources["quneo"].uid).permanent = true;

// Performs a partial reset
MIDIdef.noteOn("on", {
    arg velocity, noteNumber, channel, source;
    ~partial_reset.();
    //("note number " ++ noteNumber ++ " was pressed").postln;
}, 50, srcID: ~midi_sources["quneo"].uid).permanent = true;

// Performs a full reset
MIDIdef.noteOn("on", {
    arg velocity, noteNumber, channel, source;
    ~full_reset.();
    //("note number " ++ noteNumber ++ " was pressed").postln;
}, 51, srcID: ~midi_sources["quneo"].uid).permanent = true;

// FADER BUSES ////////////////////////////////////////////
MIDIdef.cc("fader1", {
    arg val, idx;
    var current, target;
    current = ~faderbus[0].getSynchronous;
    target = val.linlin(0, 127, 0.0, 1.0);
    Synth(\buschange, [\start, current, \end, target, \bus, ~faderbus[0]]);
    //("fader bus 1: " ++ target).postln;
}, ~midimap["fader1"]).permanent = true;

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

// KNOB BUSES /////////////////////////////////////////////

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
