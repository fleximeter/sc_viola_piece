// File: events106.scd
// This file contains individual events starting at measure 106.

(
// EVENT 106
e.put("e106", Routine({
    var control, control_specs, synth_freeze, synths, synths_out;
    var freeze_release_time;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[8.0, 8.0, 8.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.2, 0.2, 0.2], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.8, 0.8, 0.8], "times" -> #[10, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = Dictionary();
    // pass the regular signal straight through
	synths.add("main_connector" -> Synth(\passthrough8, [\in, ~audiobus_grp2[1][0], \out, ~audiobus_grp2[4][0], \attack_time, 0, \release_time, 5, \curve, -2], ~grp[2], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[4][0], \out, ~audiobus_grp2[4][1], \mul_sig, ~faderbus[6], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[4][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[4][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    // 1 freeze
    Routine({
		synths.add("sampler" -> Synth(\sampler_pan, [\out, ~audiobus_grp2[0][0], \pos, 0.0, \width, 2.0, \mul, 0.dbamp, \buf, ~samples["viola.arco"]["ff"]["c"]["48"]["buffer"]], ~grp[1], \addToTail));
        synth_freeze = Synth(\fft_freeze_level_adjust, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[1][0], \above_frac, 0.1, \release_time, freeze_release_time, \mul, 0.5], ~grp[1], \addToTail);
        1.wait;
        synth_freeze.set(\freeze, 1.0);
    }).play;
    "106 UPDATE 106.1: Event 106, freeze (C3).".yield;

    // cleanup
    Routine({
        synth_freeze.set(\gate, 0);
        freeze_release_time.wait;
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synth_freeze.free;
        synths.keysValuesDo({|key, val| val.free});
        control.do({|item| item.free});
        "106 UPDATE 106.3: Event 106 kill stage complete. Event finished.".postln;
    }).play;
    "106 UPDATE 106.2: Event 106 final realease.".postln;
}));

// Event 108: feedback
e.put("e108", Routine({
    var control, control_specs, synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 40], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[3.0, 6.0, 3.0, 3.0], "times" -> #[10, 10, 100], "curves" -> #[0, 0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5, 0.5], "times" -> #[10, 40], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5, 0.5], "times" -> #[10, 40], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp3[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus_grp3[0][0], \pos, ~controlbus_grp3[0], \width, ~controlbus_grp3[1]], ~grp[1], \addToTail));

    // add processing synths
    synths.add(Synth(\fbx, [\in, ~audiobus_grp3[0][0], \out, ~audiobus_grp3[1][0], \mul_sig, ~faderbus[4], \feedback, ~faderbus[5], \feedback_scaler, 2, \freq, ~faderbus[8], \low_freq, 62.midicps, \high_freq, 96.midicps], ~grp[2], \addToTail));
    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[1][0], \out, ~audiobus_grp3[1][1], \mul_sig, ~controlbus_grp3[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp3[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp3[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "108 UPDATE 108.0: Event 108 running.".yield;

    // cleanup
    Routine({
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "108 UPDATE 108.2: Event 108 kill stage complete. Event finished.".postln;
    }).play;
    "108 UPDATE 108.1: Event 108 fading out.".postln;
}));
)