// File: events068.scd
// This file contains individual events starting at measure 68.

(

// EVENT 68 - PATTERN
// This event is meant to be played automatically, not stepped through.
e.put("e68", Routine({
    var control, control_specs, patterns, synth_freeze, synths, synths_out, tempo_clock;
    var freeze_release_time;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.95, 0.95, 0.95], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.05, 0.05, 0.05], "times" -> #[10, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp1[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // the samples to play
    patterns = List();
    patterns.add(Pbind(\instrument, \sampler_asr_pbind,
        \buf, Pseq([
            ~samples["viola.pizz"]["ff"]["d"]["62"]["buffer"],
            ~samples["viola.pizz"]["ff"]["d"]["62"]["buffer"],
            ~samples["viola.pizz"]["ff"]["d"]["62"]["buffer"],
        ], 3),
        \pan_mode, 1,
        \pos, Pwhite(-0.4, 0.4, inf),
        \out, ~audiobus_grp1[0][0],
        \mul, 0.25,
        \dur, Pseq([0.5], 3),
        \group, ~grp[1],
        \addAction, \addToTail,
    ));
    patterns.add(Pbind(\instrument, \sampler_asr_pbind,
        \buf, Pseq([
            ~samples["viola.pizz"]["ff"]["g"]["62"]["buffer"],
            ~samples["viola.pizz"]["ff"]["g"]["59"]["buffer"],
            ~samples["viola.pizz"]["ff"]["g"]["57"]["buffer"],
        ], 3),
        \pan_mode, 1,
        \pos, Pwhite(-0.4, 0.4, inf),
        \out, ~audiobus_grp1[0][0],
        \mul, 0.25,
        \dur, Pseq([0.5], 3),
        \group, ~grp[1],
        \addAction, \addToTail,
    ));

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[0][1], \mul_sig, ~controlbus_grp1[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    tempo_clock = TempoClock(96/60);
    patterns.do{|pattern| pattern.play(tempo_clock, quant: 1)};
    "68 UPDATE 68.0: Event 68 pattern start.".postln;
    4.wait;

    // SHUTDOWN ///////////////////////////////////////////////////////////////
    synths_out.do({|item| item.set(\gate, 0)});
    "68 UPDATE 68.1: Event 68 fading out.".postln;
    2.wait;
    patterns.do({|item| item.stop});
    tempo_clock.free;
    synths_out.do({|item| item.free});
    synths.do({|item| item.free});
    synth_freeze.free;
    control.do({|item| item.free});
    "68 UPDATE 68.2: Event 68 kill stage complete. Event finished.".postln;
}));


// EVENT 69 - PATTERN
// This event is meant to be played automatically, not stepped through.
e.put("e69", Routine({
    var control, control_specs, patterns, synth_freeze, synths, synths_out, tempo_clock;
    var freeze_release_time;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.95, 0.95, 0.95], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.05, 0.05, 0.05], "times" -> #[10, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // the samples to play
    patterns = List();
    patterns.add(Pbind(\instrument, \sampler_asr_pbind,
        \buf, Pseq([
            ~samples["viola.pizz"]["ff"]["d"]["62"]["buffer"],
            ~samples["viola.pizz"]["ff"]["d"]["62"]["buffer"],
            ~samples["viola.pizz"]["ff"]["d"]["62"]["buffer"],
        ], 1),
        \pan_mode, 1,
        \pos, Pwhite(-0.4, 0.4, inf),
        \out, ~audiobus_grp2[0][0],
        \mul, 0.25,
        \dur, Pseq([Rest(0.5), 0.5, 0.5], 1),
        \group, ~grp[1],
        \addAction, \addToTail,
    ));
    patterns.add(Pbind(\instrument, \sampler_asr_pbind,
        \buf, Pseq([
            ~samples["viola.pizz"]["ff"]["g"]["55"]["buffer"],
            ~samples["viola.pizz"]["ff"]["g"]["57"]["buffer"],
            ~samples["viola.pizz"]["ff"]["g"]["62"]["buffer"],
        ], 1),
        \transpose, Pseq([1, 1, -0.5.midiratio], 1),
        \pan_mode, 1,
        \pos, Pwhite(-0.4, 0.4, inf),
        \out, ~audiobus_grp2[0][0],
        \mul, 0.25,
        \dur, Pseq([0.5], 3),
        \group, ~grp[1],
        \addAction, \addToTail,
    ));

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[0][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    tempo_clock = TempoClock(96/60);
    patterns.do{|pattern| pattern.play(tempo_clock, quant: 1)};
    "69 UPDATE 69.0: Event 69 pattern start.".postln;
    4.wait;

    // SHUTDOWN ///////////////////////////////////////////////////////////////
    synths_out.do({|item| item.set(\gate, 0)});
    "69 UPDATE 69.1: Event 69 fading out.".postln;
    2.wait;
    patterns.do({|item| item.stop});
    tempo_clock.free;
    synths_out.do({|item| item.free});
    synths.do({|item| item.free});
    synth_freeze.free;
    control.do({|item| item.free});
    "69 UPDATE 69.2: Event 69 kill stage complete. Event finished.".postln;
}));

// EVENT 68 - PATTERN
// This event is meant to be played automatically, not stepped through.
e.put("e70", Routine({
    var control, control_specs, patterns, synth_freeze, synths, synths_out, tempo_clock;
    var freeze_release_time;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.95, 0.95, 0.95], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.05, 0.05, 0.05], "times" -> #[10, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp1[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // the samples to play
    patterns = List();
    patterns.add(Pbind(\instrument, \sampler_asr_pbind,
        \buf, Pseq([
            ~samples["viola.pizz"]["ff"]["d"]["62"]["buffer"],
            ~samples["viola.pizz"]["ff"]["d"]["62"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["57"]["buffer"],
        ], 3),
        \pan_mode, 1,
        \pos, Pwhite(-0.4, 0.4, inf),
        \out, ~audiobus_grp1[0][0],
        \mul, 0.25,
        \dur, Pseq([Rest(0.5), Rest(0.5), 0.5], 1),
        \group, ~grp[1],
        \addAction, \addToTail,
    ));
    patterns.add(Pbind(\instrument, \sampler_asr_pbind,
        \buf, Pseq([
            ~samples["viola.pizz"]["ff"]["g"]["55"]["buffer"],
            ~samples["viola.pizz"]["ff"]["d"]["62"]["buffer"],
            ~samples["viola.pizz"]["ff"]["g"]["55"]["buffer"],
        ], 3),
        \pan_mode, 1,
        \pos, Pwhite(-0.4, 0.4, inf),
        \out, ~audiobus_grp1[0][0],
        \mul, 0.25,
        \dur, Pseq([0.5], 3),
        \group, ~grp[1],
        \addAction, \addToTail,
    ));

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[0][1], \mul_sig, ~controlbus_grp1[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    tempo_clock = TempoClock(96/60);
    patterns.do{|pattern| pattern.play(tempo_clock, quant: 1)};
    "70 UPDATE 70.0: Event 70 pattern start.".postln;
    4.wait;

    // SHUTDOWN ///////////////////////////////////////////////////////////////
    synths_out.do({|item| item.set(\gate, 0)});
    "70 UPDATE 70.1: Event 70 fading out.".postln;
    2.wait;
    patterns.do({|item| item.stop});
    tempo_clock.free;
    synths_out.do({|item| item.free});
    synths.do({|item| item.free});
    synth_freeze.free;
    control.do({|item| item.free});
    "70 UPDATE 70.2: Event 70 kill stage complete. Event finished.".postln;
}));

// EVENT 72 - PATTERN
// This event is meant to be played automatically, not stepped through.
e.put("e72", Routine({
    var control, control_specs,    patterns, synth_freeze, synths, synths_out, tempo_clock;
    var freeze_release_time;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.95, 0.95, 0.95], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.05, 0.05, 0.05], "times" -> #[10, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // the samples to play
    patterns = List();
    patterns.add(Pbind(\instrument, \sampler_asr_pbind,
        \buf, Pseq([
            ~samples["viola.pizz"]["ff"]["d"]["65"]["buffer"],
            ~samples["viola.pizz"]["ff"]["d"]["62"]["buffer"],
            ~samples["viola.pizz"]["ff"]["d"]["67"]["buffer"],
            ~samples["viola.pizz"]["ff"]["d"]["67"]["buffer"],
            ~samples["viola.pizz"]["ff"]["d"]["67"]["buffer"],
            ~samples["viola.pizz"]["ff"]["a"]["69"]["buffer"],
        ], 3),
        \transpose, Pseq([1, 1, 1, -0.5.midiratio, 1, 1], 1),
        \pan_mode, 1,
        \pos, Pwhite(-0.4, 0.4, inf),
        \out, ~audiobus_grp2[0][0],
        \mul, 0.25,
        \dur, Pseq([1/3], 6),
        \group, ~grp[1],
        \addAction, \addToTail,
    ));
    patterns.add(Pbind(\instrument, \sampler_asr_pbind,
        \buf, Pseq([
            ~samples["viola.pizz"]["ff"]["d"]["62"]["buffer"],
            ~samples["viola.pizz"]["ff"]["d"]["63"]["buffer"],
            ~samples["viola.pizz"]["ff"]["d"]["64"]["buffer"],
            ~samples["viola.pizz"]["ff"]["g"]["57"]["buffer"],
            ~samples["viola.pizz"]["ff"]["g"]["57"]["buffer"],
        ], 3),
        \transpose, Pseq([1, 1, 1, 1, -0.5.midiratio], 1),
        \pan_mode, 1,
        \pos, Pwhite(-0.4, 0.4, inf),
        \out, ~audiobus_grp2[0][0],
        \mul, 0.25,
        \dur, Pseq([0.5], 5),
        \group, ~grp[1],
        \addAction, \addToTail,
    ));

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[0][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    tempo_clock = TempoClock(96/60);
    patterns.do{|pattern| pattern.play(tempo_clock, quant: 1)};
    "72 UPDATE 72.0: Event 72 pattern start.".postln;
    4.wait;

    // SHUTDOWN ///////////////////////////////////////////////////////////////
    synths_out.do({|item| item.set(\gate, 0)});
    "72 UPDATE 72.1: Event 72 fading out.".postln;
    2.wait;
    patterns.do({|item| item.stop});
    tempo_clock.free;
    synths_out.do({|item| item.free});
    synths.do({|item| item.free});
    synth_freeze.free;
    control.do({|item| item.free});
    "72 UPDATE 72.2: Event 72 kill stage complete. Event finished.".postln;
}));

// EVENT 73 - PATTERN
// This event is meant to be played automatically, not stepped through.
e.put("e73", Routine({
    var control, control_specs,    patterns, synth_freeze, synths, synths_out, tempo_clock;
    var freeze_release_time;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.95, 0.95, 0.95], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.05, 0.05, 0.05], "times" -> #[10, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp1[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // the samples to play
    patterns = List();
    patterns.add(Pbind(\instrument, \sampler_asr_pbind,
        \buf, Pseq([
            ~samples["viola.pizz"]["ff"]["a"]["71"]["buffer"],
            ~samples["viola.pizz"]["ff"]["a"]["69"]["buffer"],
            ~samples["viola.pizz"]["ff"]["d"]["67"]["buffer"],
            ~samples["viola.pizz"]["ff"]["d"]["67"]["buffer"],
            ~samples["viola.pizz"]["ff"]["d"]["67"]["buffer"],
            ~samples["viola.pizz"]["ff"]["a"]["69"]["buffer"],
        ], 3),
        \transpose, Pseq([1, 1, 1, -0.5.midiratio, 1, 1], 1),
        \pan_mode, 1,
        \pos, Pwhite(-0.4, 0.4, inf),
        \out, ~audiobus_grp1[0][0],
        \mul, 0.25,
        \dur, Pseq([0.5, 0.5, 1/3, 1/3, 1/3, 0.5], 1),
        \group, ~grp[1],
        \addAction, \addToTail,
    ));
    patterns.add(Pbind(\instrument, \sampler_asr_pbind,
        \buf, Pseq([
            ~samples["viola.pizz"]["ff"]["d"]["64"]["buffer"],
            ~samples["viola.pizz"]["ff"]["d"]["64"]["buffer"],
            ~samples["viola.pizz"]["ff"]["d"]["64"]["buffer"],
            ~samples["viola.pizz"]["ff"]["g"]["64"]["buffer"],
            ~samples["viola.pizz"]["ff"]["g"]["67"]["buffer"],
        ], 3),
        \transpose, Pseq([1, 1, 1, -0.5.midiratio, -0.5.midiratio], 1),
        \pan_mode, 1,
        \pos, Pwhite(-0.4, 0.4, inf),
        \out, ~audiobus_grp1[0][0],
        \mul, 0.25,
        \dur, Pseq([0.5], 5),
        \group, ~grp[1],
        \addAction, \addToTail,
    ));

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[0][1], \mul_sig, ~controlbus_grp1[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    tempo_clock = TempoClock(96/60);
    patterns.do{|pattern| pattern.play(tempo_clock, quant: 1)};
    "73 UPDATE 73.0: Event 73 pattern start.".postln;
    4.wait;

    // SHUTDOWN ///////////////////////////////////////////////////////////////
    synths_out.do({|item| item.set(\gate, 0)});
    "73 UPDATE 73.1: Event 73 fading out.".postln;
    2.wait;
    patterns.do({|item| item.stop});
    tempo_clock.free;
    synths_out.do({|item| item.free});
    synths.do({|item| item.free});
    synth_freeze.free;
    control.do({|item| item.free});
    "73 UPDATE 73.2: Event 73 kill stage complete. Event finished.".postln;
}));


// EVENT 75 - PATTERN
// This event is meant to be played automatically, not stepped through.
e.put("e75", Routine({
    var control, control_specs,    pattern, synth_freeze, synths, synths_out, tempo_clock;
    var freeze_release_time;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.95, 0.95, 0.95], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.05, 0.05, 0.05], "times" -> #[10, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // the samples to play
    pattern = Pbind(\instrument, \sampler_asr_pbind,
        \buf, Pseq([
            ~samples["viola.pizz"]["ff"]["a"]["69"]["buffer"],
        ], inf),
        \pan_mode, 1,
        \pos, Pwhite(-0.4, 0.4, inf),
        \out, ~audiobus_grp2[0][0],
        \mul, 0.25,
        \dur, Pseq(Array.interpolation(12, 0.5, 0.125) ++ Array.interpolation(12, 0.125, 0.5), 3),
        \group, ~grp[1],
        \addAction, \addToTail,
    );

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[0][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    tempo_clock = TempoClock(96/60);
    pattern.play(tempo_clock);

    "75 UPDATE 75.0: Event 75 pattern start.".postln;
    15.wait;

    // SHUTDOWN ///////////////////////////////////////////////////////////////
    synths_out.do({|item| item.set(\gate, 0)});
    "75 UPDATE 75.1: Event 75 fading out.".postln;
    2.wait;
    pattern.stop;
    tempo_clock.free;
    synths_out.do({|item| item.free});
    synths.do({|item| item.free});
    synth_freeze.free;
    control.do({|item| item.free});
    "75 UPDATE 75.2: Event 75 kill stage complete. Event finished.".postln;
}));


// EVENT 76 - PATTERN
// This event is meant to be played automatically, not stepped through.
e.put("e76", Routine({
    var control, control_specs, pattern, synth_freeze, synths, synths_out, tempo_clock;
    var freeze_release_time;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.95, 0.95, 0.95], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.05, 0.05, 0.05], "times" -> #[10, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp1[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // the samples to play
    pattern = Pbind(\instrument, \sampler_asr_pbind,
        \buf, Pseq([
            ~samples["viola.pizz"]["ff"]["a"]["74"]["buffer"],
        ], inf),
        \transpose, Pswitch1([Pseq([1], inf), Pseq(Array.interpolation(8, -0.5.midiratio, 1) ++ Array.interpolation(8, 1, -0.5.midiratio), inf)], Pseq([0, 1], inf)),
        \pan_mode, 1,
        \pos, Pwhite(-0.4, 0.4, inf),
        \out, ~audiobus_grp1[0][0],
        \mul, 0.25,
        \dur, Pseq(Array.interpolation(16, 0.5, 0.125) ++ Array.interpolation(16, 0.125, 0.5), 3),
        \group, ~grp[1],
        \addAction, \addToTail,
    );

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[0][1], \mul_sig, ~controlbus_grp1[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    tempo_clock = TempoClock(96/60);
    pattern.play(tempo_clock);

    "76 UPDATE 76.0: Event 76 pattern start.".postln;
    22.wait;

    // SHUTDOWN ///////////////////////////////////////////////////////////////
    synths_out.do({|item| item.set(\gate, 0)});
    "76 UPDATE 76.1: Event 76 fading out.".postln;
    2.wait;
    pattern.stop;
    tempo_clock.free;
    synths_out.do({|item| item.free});
    synths.do({|item| item.free});
    synth_freeze.free;
    control.do({|item| item.free});
    "76 UPDATE 76.2: Event 76 kill stage complete. Event finished.".postln;
}));

// EVENT 79 - PATTERN
// This event is meant to be played automatically, not stepped through.
e.put("e79", Routine({
    var control, control_specs, pattern, synth_freeze, synths, synths_out, tempo_clock;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.95, 0.95, 0.95], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.05, 0.05, 0.05], "times" -> #[10, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // the samples to play
    pattern = Pbind(\instrument, \sampler_asr_pbind,
        \buf, Pseq([
            ~samples["viola.pizz"]["ff"]["g"]["55"]["buffer"],
        ], inf),
        \pan_mode, 1,
        \pos, Pwhite(-0.4, 0.4, inf),
        \out, ~audiobus_grp2[0][0],
        \mul, Pseq(Array.interpolation(10, 0.25, 0.1), 1),
        \dur, Pseq([0.25], 10),
        \group, ~grp[1],
        \addAction, \addToTail,
    );

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[0][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    tempo_clock = TempoClock(96/60);
    pattern.play(tempo_clock);

    "79 UPDATE 79.0: Event 79 pattern start.".postln;
    6.wait;

    pattern.stop;
    // SHUTDOWN ///////////////////////////////////////////////////////////////
    synths_out.do({|item| item.set(\gate, 0)});
    "79 UPDATE 79.1: Event 79 fading out.".postln;
    2.wait;
    tempo_clock.free;
    synths_out.do({|item| item.free});
    synths.do({|item| item.free});
    synth_freeze.free;
    control.do({|item| item.free});
    "79 UPDATE 79.2: Event 79 kill stage complete. Event finished.".postln;
}));


// EVENT 82a - PATTERN
// This event is meant to be played automatically, not stepped through.
e.put("e82a", Routine({
    var control, control_specs,    patterns, synth_freeze, synths, synths_out, tempo_clock;
    var freeze_release_time;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.95, 0.95, 0.95], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.05, 0.05, 0.05], "times" -> #[10, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp1[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // the samples to play
    patterns = List();
	patterns.add(Pbind(\instrument, \sampler_asr_pbind,
        \buf, Pseq([
            ~samples["viola.pizz"]["ff"]["g"]["57"]["buffer"],
        ], inf),
        \transpose, Pseq(Array.interpolation(16 * 6, 1, -2.midiratio), 1),
        \pan_mode, 1,
        \pos, Pwhite(-0.4, 0.4, inf),
        \out, ~audiobus_grp1[0][0],
        \mul, -18.dbamp,
        \dur, Pseq(Array.interpolation(16, 0.5, 0.125) ++ Array.interpolation(16, 0.125, 0.5), 3),
        \group, ~grp[1],
        \addAction, \addToTail,
    ));
	patterns.add(Pbind(\instrument, \sampler_asr_pbind,
        \buf, Pseq([
            ~samples["viola.pizz"]["ff"]["g"]["55"]["buffer"],
        ], inf),
        \pan_mode, 1,
        \pos, Pwhite(-0.4, 0.4, inf),
        \out, ~audiobus_grp1[0][0],
        \mul, -18.dbamp,
        \dur, Pseq(Array.interpolation(16, 0.5, 0.125) ++ Array.interpolation(16, 0.125, 0.5), 3),
        \group, ~grp[1],
        \addAction, \addToTail,
    ));

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[0][1], \mul_sig, ~controlbus_grp1[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    tempo_clock = TempoClock(96/60);
    patterns.do{|pattern| pattern.play(tempo_clock, quant: 1)};

    "82a UPDATE 82a.0: Event 82a pattern start.".postln;
    20.wait;
    patterns.do({|item| item.stop});

    // SHUTDOWN ///////////////////////////////////////////////////////////////
    synths_out.do({|item| item.set(\gate, 0)});
    "82a UPDATE 82a.1: Event 82a fading out.".postln;
    2.wait;
    tempo_clock.free;
    synths_out.do({|item| item.free});
    synths.do({|item| item.free});
    synth_freeze.free;
    control.do({|item| item.free});
    "82a UPDATE 82a.2: Event 82a kill stage complete. Event finished.".postln;
}));

// Event: shifting pattern playing
// This event is meant to be played automatically, not stepped through.
e.put("e82b", Routine({
    var control, control_specs, transpose, pattern, synths, synths_out, tempo_clock;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_delay_semitones_1", "levels" -> #[4.0, 5.0], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_delay_time_1", "levels" -> #[0.5, 0.4], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_delay_mul_1", "levels" -> #[1.0, 0.5], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_delay_semitones_2", "levesls" -> #[-5.0, -4.0], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_delay_time_2", "levels" -> #[0.8, 0.9], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_delay_mul_2", "levels" -> #[0.5, 1.0], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_delay_semitones_3", "levels" -> #[1.0, 2.0], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_delay_time_3", "levels" -> #[2.0, 1.8], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_delay_mul_3", "levels" -> #[1.0, 0.5], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_delay_semitones_4", "levels" -> #[-1.0, -2.0], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_delay_time_4", "levels" -> #[1.3, 1.5], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_delay_mul_4", "levels" -> #[1.0, 0.5], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.95, 0.95, 0.95], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.05, 0.05, 0.05], "times" -> #[10, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    synths = List();
    transpose = Array[1, 1, 1, 1, 0.5.midiratio, 1, 1, 1, 0.5.midiratio, 1, 1, 1, 1, 1, 1, 1, 1, 0.5.midiratio, 1, 1, 1, 1, 0.5.midiratio, 1];

    // microtonal pattern
    pattern = Pbind(\instrument, \sampler_asr_pbind,
        \buf, Pseq([
            ~samples["viola.pizz"]["ff"]["c"]["55"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["59"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["69"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["65"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["64"]["buffer"], //+
            ~samples["viola.pizz"]["ff"]["c"]["65"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["59"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["55"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["54"]["buffer"], //+
            ~samples["viola.pizz"]["ff"]["c"]["57"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["64"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["65"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["54"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["57"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["61"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["68"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["72"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["71"]["buffer"], //+
            ~samples["viola.pizz"]["ff"]["c"]["72"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["62"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["65"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["62"]["buffer"],
            ~samples["viola.pizz"]["ff"]["c"]["61"]["buffer"], //+
            ~samples["viola.pizz"]["ff"]["c"]["62"]["buffer"]
        ], 20),
        \transpose, Pseq(transpose ++ (transpose * 5.midiratio) ++ (transpose * -5.midiratio) ++ transpose, inf),
        \pan_mode, 1,
        \pos, Pwhite(Pseq(Array.interpolation(30, 0, -0.5) ++ Array.interpolation(30, -0.5, 0), 4), Pseq(Array.interpolation(30, 0, 0.5) ++ Array.interpolation(30, 0.5, 0), 4), inf),
        \out, ~audiobus_grp2[0][0],
        \mul, Pwhite(Pseq(Array.interpolation(20, 0.6, 0.1) ++ Array.interpolation(20, 0.1, 0.6), 6), Pseq(Array.interpolation(20, 0.5, 0.05) ++ Array.interpolation(20, 0.05, 0.5), 6), inf),
        \dur, Pseq([0.15, 0.15, 0.15, 0.15], inf),
        \group, ~grp[1],
        \addAction, \addToTail,
    );

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\passthrough8, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[1][0]], ~grp[2], \addToTail));
    synths.add(Synth(\psdelay1ctrl_et, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[1][0], \semitones, ~controlbus_grp2[2], \delayint, ~controlbus_grp2[3], \mul, ~controlbus_grp2[4]], ~grp[2], \addToTail));
    synths.add(Synth(\psdelay1ctrl_et, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[1][0], \semitones, ~controlbus_grp2[5], \delayint, ~controlbus_grp2[6], \mul, ~controlbus_grp2[7]], ~grp[2], \addToTail));
    synths.add(Synth(\psdelay1ctrl_et, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[1][0], \semitones, ~controlbus_grp2[8], \delayint, ~controlbus_grp2[9], \mul, ~controlbus_grp2[10]], ~grp[2], \addToTail));
    synths.add(Synth(\psdelay1ctrl_et, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[1][0], \semitones, ~controlbus_grp2[11], \delayint, ~controlbus_grp2[12], \mul, ~controlbus_grp2[13]], ~grp[2], \addToTail));
    //synth_fft = Synth(\fft_magbelow2, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[1][0], \threshold, 0.2, \rmfreq, 200, \rmmul, 0.5, \lpf, 4000, \mul, 10], ~grp[2], \addToTail);
    //synth_filter = Synth(\bpf8, [\in, ~audiobus_grp2[1][0], \out, ~audiobus_grp2[2][0], \freq, ~controlbus_grp2[0], \mul, ~controlbus_grp2[1]], ~grp[2], \addToTail);


    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][0], \out, ~audiobus_grp2[1][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[15], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[16], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    tempo_clock = TempoClock(96/60);
    pattern.play(tempo_clock, quant: 1);

    "82b UPDATE 82b.0: Event 82b pattern start.".postln;
    60.wait;
    pattern.stop;

    // SHUTDOWN ///////////////////////////////////////////////////////////////
    synths_out.do({|item| item.set(\gate, 0)});
    "82b UPDATE 82b.1: Event 82b fading out.".postln;
    2.wait;
    tempo_clock.free;
    synths_out.do({|item| item.free});
    synths.do({|item| item.free});
    control.do({|item| item.free});
    "82b UPDATE 82b.2: Event 82b kill stage complete. Event finished.".postln;
}));
)