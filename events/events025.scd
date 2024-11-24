// File: events025.scd
// This file contains individual events starting at measure 25.

(
// EVENT 25 - FREEZE 1 NOTE
e.put("e25", Routine({
    var control, control_specs, synths_freeze, synths, synths_out;
    var freeze_release_time;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5, 0.5], "times" -> #[2, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5, 0.5], "times" -> #[2, 100], "curves" -> #[0, 0]],
	];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths_freeze = List();

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][0], \out, ~audiobus_grp2[1][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    // 1 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp2[0][0], \pos, 1.0, \width, 2.0, \mul, -15.dbamp, \buf, ~samples["viola.arco"]["mf"]["g"]["59"]["buffer"]], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[1][0], \above, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[0].set(\freeze, 1.0);
    }).play;
    "25 UPDATE 25.0: Event 25 freeze (B3).".yield;

    // cleanup
    Routine({
        synths_freeze.do({|item| item.set(\gate, 0)});
        freeze_release_time.wait;
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths_freeze.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "25 UPDATE 25.2: Event 25 kill stage complete. Event finished.".postln;
    }).play;
    "25 UPDATE 25.1: Event 25 fading out.".postln;
}));

// EVENT 26 - FREEZE 2 NOTES
e.put("e26", Routine({
    var control, control_specs,    synths_freeze, synths, synths_out;
    var freeze_release_time;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5, 0.5], "times" -> #[2, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5, 0.5], "times" -> #[2, 100], "curves" -> #[0, 0]],    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp1[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths_freeze = List();

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][0], \out, ~audiobus_grp1[1][1], \mul_sig, ~controlbus_grp1[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    // 1 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][0], \pos, 0.5, \width, 2.0, \mul, -15.dbamp, \buf, ~samples["viola.arco"]["mf"]["g"]["59"]["buffer"]], ~grp[1], \addToTail));
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][1], \pos, 1.5, \width, 2.0, \mul, -15.dbamp, \buf, ~samples["viola.arco"]["mf"]["c"]["57"]["buffer"]], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[1][0], \above, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][1], \out, ~audiobus_grp1[1][0], \above, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[0].set(\freeze, 1.0);
        synths_freeze[1].set(\freeze, 1.0);
    }).play;
    "26 UPDATE 26.0: Event 26 freeze (A3, B3).".yield;

    // cleanup
    Routine({
        synths_freeze.do({|item| item.set(\gate, 0)});
        freeze_release_time.wait;
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths_freeze.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "26 UPDATE 26.2: Event 26 kill stage complete. Event finished.".postln;
    }).play;
    "26 UPDATE 26.1: Event 26 fading out.".postln;
}));

// EVENT 27 - FREEZE 3 NOTES
e.put("e27", Routine({
    var control, control_specs,    synths_freeze, synths, synths_out;
    var freeze_release_time;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5, 0.5], "times" -> #[1, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5, 0.5], "times" -> #[1, 100], "curves" -> #[0, 0]],    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths_freeze = List();

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][0], \out, ~audiobus_grp2[1][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    // 1 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp2[0][0], \pos, 0.66, \width, 2.0, \mul, -16.dbamp, \buf, ~samples["viola.arco"]["mf"]["g"]["61"]["buffer"]], ~grp[1], \addToTail));
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp2[0][1], \pos, 1.33, \width, 2.0, \mul, -16.dbamp, \buf, ~samples["viola.arco"]["mf"]["g"]["59"]["buffer"]], ~grp[1], \addToTail));
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp2[0][2], \pos, 1.0, \width, 2.0, \mul, -16.dbamp, \buf, ~samples["viola.arco"]["mf"]["c"]["57"]["buffer"]], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[1][0], \above, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp2[0][1], \out, ~audiobus_grp2[1][0], \above, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp2[0][2], \out, ~audiobus_grp2[1][0], \above, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[0].set(\freeze, 1.0);
        synths_freeze[1].set(\freeze, 1.0);
        synths_freeze[2].set(\freeze, 1.0);
    }).play;
    "27 UPDATE 27.0: Event 27 freeze (A3, B3, C+4).".yield;

    // cleanup
    Routine({
        synths_freeze.do({|item| item.set(\gate, 0)});
        freeze_release_time.wait;
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths_freeze.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "27 UPDATE 27.2: Event 27 kill stage complete. Event finished.".postln;
    }).play;
    "27 UPDATE 27.1: Event 27 fading out.".postln;
}));

// EVENT 28 - FREEZE 3x
e.put("e28", Routine({
    var control, control_specs,    synths_freeze, synths, synths_out;
    var freeze_release_time;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5, 0.5], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5, 0.5], "times" -> #[10, 100], "curves" -> #[0, 0]],    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp1[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths_freeze = List();

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][0], \out, ~audiobus_grp1[1][1], \mul_sig, ~controlbus_grp1[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 3], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 3], ~grp[4], \addToTail));


    // 1 freeze
    // 1 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][0], \pos, 1.66, \width, 2.0, \mul, -14.dbamp, \buf, ~samples["viola.arco"]["mf"]["d"]["65"]["buffer"]], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[1][0], \above, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[0].set(\freeze, 1.0);
    }).play;
    "28 UPDATE 28.0: Event 28 freeze 1 (F4).".yield;

    // 2 freeze
    // 1 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][1], \pos, 0.4, \width, 2.0, \mul, -14.dbamp, \buf, ~samples["viola.arco"]["mf"]["g"]["55"]["buffer"]], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][1], \out, ~audiobus_grp1[1][0], \above, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[1].set(\freeze, 1.0);
    }).play;
    "28 UPDATE 28.1: Event 28 freeze 2 (G3).".yield;

    // 3 freeze
    // 1 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][2], \pos, 1.5, \width, 2.0, \mul, -14.dbamp, \buf, ~samples["viola.arco"]["mf"]["d"]["64"]["buffer"]], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][2], \out, ~audiobus_grp1[1][0], \above, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[2].set(\freeze, 1.0);
    }).play;
    "28 UPDATE 28.2: Event 28 freeze 3 (E4).".yield;

    // cleanup
    Routine({
        synths_freeze.do({|item| item.set(\gate, 0)});
        freeze_release_time.wait;
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths_freeze.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "28 UPDATE 28.4: Event 28 kill stage complete. Event finished.".postln;
    }).play;
    "28 UPDATE 28.3: Event 28 fading out.".postln;
}));

// EVENT 31
// PS UP, SAMPLE
e.put("e31", Routine({
    var control, control_specs,    synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5, 0.5], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5, 0.5], "times" -> #[10, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus_grp2[0][0], \pos, ~controlbus_grp2[0], \width, ~controlbus_grp2[1]], ~grp[1], \addToTail));
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp2[2][0], \pos, 1.5, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["viola.arco"]["mf"]["g"]["55"]["buffer"], \dur, 60/108, \release_time, 0.2], ~grp[1], \addToTail));
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp2[2][0], \pos, 1.0, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["viola.arco"]["mf"]["d"]["64"]["buffer"], \dur, 60/108, \release_time, 0.2], ~grp[1], \addToTail));
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp2[2][0], \pos, 0.5, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["viola.arco"]["mf"]["d"]["65"]["buffer"], \dur, 60/108, \release_time, 0.2], ~grp[1], \addToTail));
    synths.add(Synth(\passthrough8, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[1][0], \attack_time, 0.01, \release_time, 0.5], ~grp[2], \addToTail));
    synths.add(Synth(\pitchshift, [\in, ~audiobus_grp2[1][0], \out, ~audiobus_grp2[2][0], \ratio, 2], ~grp[3], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[2][0], \out, ~audiobus_grp2[2][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[2][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[2][1], \out, ~reverbbus[1], \mul, -18.dbamp, \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "31 UPDATE 31.0: Pitch shift in effect.".yield;
    synths[4].set(\gate, 0);
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp2[2][0], \pos, 1.0, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["viola.arco"]["mf"]["g"]["55"]["buffer"], \dur, 60/108, \release_time, 0.2], ~grp[1], \addToTail));
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp2[2][0], \pos, 0.5, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["viola.arco"]["mf"]["d"]["64"]["buffer"], \dur, 60/108, \release_time, 0.2], ~grp[1], \addToTail));
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp2[2][0], \pos, 1.5, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["viola.arco"]["mf"]["d"]["65"]["buffer"], \dur, 60/108, \release_time, 0.2], ~grp[1], \addToTail));
    "31 UPDATE 31.1: Pitch shift closed, second chord playing.".postln;

    // cleanup
    Routine({
        2.wait;
        "31 UPDATE 31.2: Event 31 fading out.".postln;
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "31 UPDATE 31.3: Event 31 kill stage complete. Event finished.".postln;
    }).play;
}));

// EVENT 33
// PS UP
e.put("e33", Routine({
    var control, control_specs,    synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5, 0.5], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5, 0.5], "times" -> #[10, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp1[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus_grp1[0][0], \pos, ~controlbus_grp1[0], \width, ~controlbus_grp1[1]], ~grp[1], \addToTail));
    synths.add(Synth(\pitchshift, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[2][0], \ratio, 2], ~grp[2], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[2][0], \out, ~audiobus_grp1[2][1], \mul_sig, ~controlbus_grp1[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[2][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.5], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[2][1], \out, ~reverbbus[1], \mul, -18.dbamp, \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.5], ~grp[4], \addToTail));
    "33 UPDATE 33.0: Pitch shift in effect.".yield;

    // cleanup
    Routine({
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "33 UPDATE 33.2: Event 33 kill stage complete. Event finished.".postln;
    }).play;
    "33 UPDATE 33.1: Event 33 fading out.".postln;
}));

// EVENT 35 - DELAY
e.put("e35", Routine({
    var control, control_specs,    synth_freeze, synths, synths_out;
    var freeze_release_time;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5, 0.5], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5, 0.5], "times" -> #[10, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus_grp2[0][0], \pos, ~controlbus_grp2[0], \width, ~controlbus_grp2[1], \attack_time, 0.2, \release_time, 0.2], ~grp[1], \addToTail));
    synths.add(Synth(\combdelay, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[1][0], \delaytime, 1, \decaytime, 6, \mul, -12.dbamp], ~grp[1], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][0], \out, ~audiobus_grp2[1][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "35 UPDATE 35.0: Event 35 delay open 1.".yield;
	synths[0].set(\gate, 0);
    "35 UPDATE 35.0: Event 35 delay close 1.".yield;
	synths[0].set(\gate, 1);
    "35 UPDATE 35.0: Event 35 delay open 2.".yield;

    // 3 open/close pairs
    synths[0].set(\gate, 0);
    "35 UPDATE 35.1: Event 35 mic close.".postln;

    // cleanup
    Routine({
        4.wait;
        "35 UPDATE 35.2: Event 35 fading out.".postln;
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "35 UPDATE 35.3: Event 35 kill stage complete. Event finished.".postln;
    }).play;
}));

// EVENT 39 - FREEZE 1 NOTE
e.put("e39", Routine({
    var control, control_specs,    synths_freeze, synths, synths_out;
    var freeze_release_time;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5, 0.5], "times" -> #[1.5, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5, 0.5], "times" -> #[1.5, 100], "curves" -> #[0, 0]],    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp1[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths_freeze = List();

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][0], \out, ~audiobus_grp1[1][1], \mul_sig, ~controlbus_grp1[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    // 1 freeze
    Routine({
    synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][0], \pos, 0.0, \width, 6.0, \mul, -21.dbamp, \buf, ~samples["viola.arco"]["mf"]["d"]["72"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[1][0], \above, 1, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[0].set(\freeze, 1.0);
    }).play;
    "39 UPDATE 39.0: Event 39 freeze (C5).".postln;

    // cleanup
    Routine({
        1.5.wait;
        "39 UPDATE 39.1: Event 39 fading out.".postln;
        synths_freeze.do({|item| item.set(\gate, 0)});
        freeze_release_time.wait;
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths_freeze.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "39 UPDATE 39.2: Event 39 kill stage complete. Event finished.".postln;
    }).play;
}));

// EVENT 41
// SAMPLE
e.put("e41", Routine({
    var control, control_specs,    synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.9, 0.9, 0.9], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.1, 0.1, 0.1], "times" -> #[10, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp2[0][0], \pos, 1.0, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["other"]["ede"]["buffer"], \dur, 2, \release_time, 0.2], ~grp[1], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[0][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "41 UPDATE 41.0: Playing sample.".postln;
    1.5.wait;

    synths_out.do({|item| item.set(\gate, 0)});
    "41 UPDATE 41.1: Event 41 fading out.".postln;

    1.wait;
    synths_out.do({|item| item.free});
    synths.do({|item| item.free});
    control.do({|item| item.free});
    "41 UPDATE 41.2: Event 41 kill stage complete. Event finished.".postln;
}));

// EVENT 42
// SAMPLE
e.put("e42", Routine({
    var control, control_specs,    synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.9, 0.9, 0.9], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.1, 0.1, 0.1], "times" -> #[10, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp1[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp1[0][0], \pos, 1.0, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["other"]["ede"]["buffer"], \dur, 2, \release_time, 0.2], ~grp[1], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[0][1], \mul_sig, ~controlbus_grp1[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "42 UPDATE 42.0: Playing sample.".postln;
    1.5.wait;

    synths_out.do({|item| item.set(\gate, 0)});
    "42 UPDATE 42.1: Event 42 fading out.".postln;

    1.wait;
    synths_out.do({|item| item.free});
    synths.do({|item| item.free});
    control.do({|item| item.free});
    "42 UPDATE 42.2: Event 42 kill stage complete. Event finished.".postln;
}));

// EVENT 43
// SAMPLE
e.put("e43", Routine({
    var control, control_specs,    synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.9, 0.9, 0.9], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.1, 0.1, 0.1], "times" -> #[10, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp2[0][0], \pos, 1.0, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["other"]["ede"]["buffer"], \dur, 2, \release_time, 0.2], ~grp[1], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[0][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "43 UPDATE 43.0: Playing sample.".postln;
    1.5.wait;

    synths_out.do({|item| item.set(\gate, 0)});
    "43 UPDATE 43.1: Event 43 fading out.".postln;

    1.wait;
    synths_out.do({|item| item.free});
    synths.do({|item| item.free});
    control.do({|item| item.free});
    "43 UPDATE 43.2: Event 43 kill stage complete. Event finished.".postln;
}));

// EVENT 44
// SAMPLE
e.put("e44", Routine({
    var control, control_specs,    synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.9, 0.9, 0.9], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.1, 0.1, 0.1], "times" -> #[10, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp1[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp1[0][0], \pos, 1.0, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["other"]["ede"]["buffer"], \dur, 2, \release_time, 0.2], ~grp[1], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[0][1], \mul_sig, ~controlbus_grp1[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "44 UPDATE 44.0: Playing sample.".postln;
    1.5.wait;

    synths_out.do({|item| item.set(\gate, 0)});
    "44 UPDATE 44.1: Event 44 fading out.".postln;

    1.wait;
    synths_out.do({|item| item.free});
    synths.do({|item| item.free});
    control.do({|item| item.free});
    "44 UPDATE 44.2: Event 44 kill stage complete. Event finished.".postln;
}));

// Event 45: feedback
e.put("e45", Routine({
    var control, control_specs,    synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[3.0, 8.0, 8.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5], "times" -> #[10], "curves" -> #[0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5], "times" -> #[10], "curves" -> #[0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus_grp2[0][0], \pos, ~controlbus_grp2[0], \width, ~controlbus_grp2[1]], ~grp[1], \addToTail));

    // add processing synths
    synths.add(Synth(\fb1, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[1][0], \mul_sig, ~faderbus[4], \feedback, ~faderbus[5], \freq, ~faderbus[8], \low_freq, 52.midicps, \high_freq, 108.midicps], ~grp[2], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][0], \out, ~audiobus_grp2[1][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 2], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~gainbus, \mul, -12.dbamp, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 2], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~reverbbus[3], \mul, -18.dbamp, \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 2], ~grp[4], \addToTail));
    "45 UPDATE 45.0: Event 45 running.".yield;

    // cleanup
    Routine({
        synths_out.do({|item| item.set(\gate, 0)});
        3.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "45 UPDATE 45.2: Event 45 kill stage complete. Event finished.".postln;
    }).play;
    "45 UPDATE 45.1: Event 45 fading out.".postln;
}));
)