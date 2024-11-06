// File: events105.scd
// This file contains individual events starting at measure 105.

(
// EVENT 105
e.put("e105", Routine({
    var control, control_specs, synth_freeze, synths, synths_out;
    var freeze_release_time;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.8, 0.5, 0.8, 0.3], "times" -> #[10, 10, 10, 10], "curves" -> #[0, 0, 0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.2, 0.5, 0.2, 0.7], "times" -> #[10, 10, 10, 10], "curves" -> #[0, 0, 0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[4][0], \out, ~audiobus_grp2[4][1], \mul_sig, ~faderbus[6], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[4][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[4][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    // 1 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp2[0][0], \pos, 0.0, \width, 2.0, \mul, -6.dbamp, \buf, ~samples["viola.arco"]["ff"]["c"]["48"]["buffer"]], ~grp[1], \addToTail));
        synth_freeze = Synth(\fft_freeze_level_adjust, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[1][0], \above_frac, 0.1, \release_time, freeze_release_time, \mul, 0.5], ~grp[1], \addToTail);
        1.wait;
        synth_freeze.set(\freeze, 1.0);
    }).play;
    "105 UPDATE 105.1: Event 105, freeze (C3).".yield;

    // add the control envelope for the magbelow
    synths.add(Synth(\fft_magbelow, [\in, ~audiobus_grp2[2][0], \out, ~audiobus_grp2[4][0], \below, ~controlbus_grp2[10]], ~grp[3], \addToTail));
    synths.add(Synth(\ctrl_env, [\out, ~controlbus_grp2[10], \levels, #[40, 2, 2], \times, #[10, 20], \curves, #[-4, 0]], ~grp[0]));
    /*
	synth_freeze.set(\attack_time, freeze_release_time);
	synth_freeze.set(\mul, 0);
    "105 UPDATE 105.2: Event 105, fade 1.".yield;

	synth_freeze.set(\mul_lag, 6);
	synth_freeze.set(\mul, -6.dbamp);
    "105 UPDATE 105.2: Event 105, fade 1.".yield;

	synth_freeze.set(\mul, -18.dbamp);
    "105 UPDATE 105.2: Event 105, fade 1.".yield;

	synth_freeze.set(\mul, 0);
    "105 UPDATE 105.2: Event 105, fade 1.".yield;
    */

    // cleanup
    Routine({
        synth_freeze.set(\gate, 0);
        freeze_release_time.wait;
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synth_freeze.free;
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "105 UPDATE 105.19: Event 105 kill stage complete. Event finished.".postln;
    }).play;
    "105 UPDATE 105.18: Event 105 final realease.".postln;
}));

// EVENT 109
// SAMPLE
e.put("e109", Routine({
    var control, control_specs, synths, synths_out;

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
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp1[0][0], \pos, 0.0, \width, 2.0, \mul, -18.dbamp, \buf, ~samples["other"]["8ve_harmonics_trill"]["buffer"], \dur, 3, \release_time, 0.2], ~grp[1], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[0][1], \mul_sig, ~controlbus_grp1[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "109 UPDATE 109.0: Playing sample.".postln;
    1.5.wait;

    synths_out.do({|item| item.set(\gate, 0)});
    "109 UPDATE 109.1: Event 109 fading out.".postln;

    1.wait;
    synths_out.do({|item| item.free});
    synths.do({|item| item.free});
    control.do({|item| item.free});
    "109 UPDATE 109.2: Event 109 kill stage complete. Event finished.".postln;
}));


// EVENT 128 - FAST PITCH SHIFT UP
e.put("e128", Routine({
    var control, control_specs, synths, synth_freeze, synths_out;
    var freeze_release_time;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "pitch_shift", "levels" -> #[0.0, 0.5, 8.0], "times" -> #[0.5, 4.5], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 0.5, 0.1, 0.0, 0.0], "times" -> #[3, 2, 0.3, 5], "curves" -> #[0, 0, 0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.8, 0.8, 0.8], "times" -> #[10, 10], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.2, 0.2, 0.2], "times" -> #[10, 10], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp3[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus_grp3[0][0], \pos, ~controlbus_grp3[0], \width, ~controlbus_grp3[1]], ~grp[1], \addToTail));
    // freeze
    synth_freeze = Synth(\fft_freeze, [\in, ~audiobus_grp3[0][0], \out, ~audiobus_grp3[1][0], \above, 3, \amp_fluctuation, 0.1], ~grp[1], \addToTail);
    synths.add(Synth(\pitchshift1_et, [\in, ~audiobus_grp3[1][0], \out, ~audiobus_grp3[2][0], \semitones, ~controlbus_grp3[2]], ~grp[1], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[2][0], \out, ~audiobus_grp3[2][1], \mul_sig, ~controlbus_grp3[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[2][1], \out, ~gainbus, \mul_sig, ~controlbus_grp3[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[2][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp3[5], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    // 1 freeze
    Routine({
        1.wait;
        synth_freeze.set(\freeze, 1.0);
    }).play;
    "128 UPDATE 128.1: Event 128 freeze.".postln;
    8.wait;

    // cleanup
    Routine({
        synth_freeze.set(\gate, 0);
        freeze_release_time.wait;
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synth_freeze.free;
        synths.do({|item| item.free});
        control.do({|item| item.free});
    "128 UPDATE 128.3: Event 128 kill stage complete. Event finished.".postln;
    }).play;
    "128 UPDATE 128.2: Event 128 final realease.".postln;
}));
)