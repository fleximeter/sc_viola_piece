// File: events084.scd
// This file contains individual events starting at measure 84.

(
// EVENT 84
e.put("e84", Routine({
    var control, control_specs,    synths_freeze, synths, synths_out;
    var freeze_release_time;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.2, 0.2, 0.2], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.8, 0.8, 0.8], "times" -> #[10, 100], "curves" -> #[0, 0]],    ];

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
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~gainbus, \mul, 0.dbamp, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~reverbbus[0], \mul, 0.dbamp, \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    // 1 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][0], \pos, 1.0, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["74"]["buffer"]], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze2, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time, \levels, #[1, 0.5, 0.5], \times, #[5, 20]], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[0].set(\freeze, 1.0);
    }).play;
    "84 UPDATE 84.0: Event 84, freeze 1 (D5).".yield;

    // 2 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][1], \pos, 0.5, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["viola.arco"]["mf"]["g"]["55"]["buffer"]], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze2, [\in, ~audiobus_grp1[0][1], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time, \levels, #[1, 0.5, 0.5], \times, #[5, 20]], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[1].set(\freeze, 1.0);
    }).play;
    "84 UPDATE 84.1: Event 84, freeze 2 (G3).".yield;

    // 3 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][2], \pos, 1.5, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["viola.arco"]["mf"]["d"]["65"]["buffer"],], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze2, [\in, ~audiobus_grp1[0][2], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time, \levels, #[1, 0.5, 0.5], \times, #[5, 20]], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[2].set(\freeze, 1.0);
    }).play;
    "84 UPDATE 84.2: Event 84, freeze 3 (F4).".yield;

    // 4 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][3], \pos, 0.0, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["72"]["buffer"]], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze2, [\in, ~audiobus_grp1[0][3], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time, \levels, #[1, 0.5, 0.5], \times, #[5, 20]], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[3].set(\freeze, 1.0);
    }).play;
    "84 UPDATE 84.3: Event 84, freeze 4 (C5).\nReady for release 1-4.".yield;
    synths_freeze[0].set(\gate, 0);
    synths_freeze[1].set(\gate, 0);
    synths_freeze[2].set(\gate, 0);
    synths_freeze[3].set(\gate, 0);
    "84 UPDATE 84.4: Event 84 release 1-4.".yield;

    // 5 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][0], \pos, 0.25, \width, 2.0, \mul, -6.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["77"]["buffer"]], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze2, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time, \levels, #[1, 0.5, 0.5], \times, #[5, 20]], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[4].set(\freeze, 1.0);
    }).play;
    "84 UPDATE 84.5: Event 84, freeze 5 (F5).".yield;

    // 6 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][1], \pos, 1.75, \width, 2.0, \mul, -6.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["74"]["buffer"]], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze2, [\in, ~audiobus_grp1[0][1], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time, \levels, #[1, 0.5, 0.5], \times, #[5, 20]], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[5].set(\freeze, 1.0);
    }).play;
    "84 UPDATE 84.6: Event 84, freeze 6 (D5).".yield;

    // 7 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][2], \pos, 0.5, \width, 2.0, \mul, -6.dbamp, \buf, ~samples["viola.arco"]["mf"]["d"]["67"]["buffer"]], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze2, [\in, ~audiobus_grp1[0][2], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time, \levels, #[1, 0.5, 0.5], \times, #[5, 20]], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[6].set(\freeze, 1.0);
    }).play;
    synths_freeze[4].set(\gate, 0);
    "84 UPDATE 84.7: Event 84, freeze 7 (G4), release 5.".yield;

    // 8 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][3], \pos, 1.5, \width, 2.0, \mul, -6.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["76"]["buffer"]], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze2, [\in, ~audiobus_grp1[0][3], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time, \levels, #[1, 0.5, 0.5], \times, #[5, 20]], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[7].set(\freeze, 1.0);
    }).play;
    "84 UPDATE 84.8: Event 84, freeze 8 (E5).\nReady for release 6-8.".yield;
    synths_freeze[5].set(\gate, 0);
    synths_freeze[6].set(\gate, 0);
    synths_freeze[7].set(\gate, 0);
    "84 UPDATE 84.9: Event 84 release 6-8.".yield;

    // 9 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][0], \pos, 0.75, \width, 2.0, \mul, -9.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["81"]["buffer"]], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze2, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time, \levels, #[1, 0.5, 0.5], \times, #[5, 20]], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[8].set(\freeze, 1.0);
    }).play;
    "84 UPDATE 84.10: Event 84, freeze 9 (A5).".yield;

    // 10 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][1], \pos, 1.25, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["76"]["buffer"]], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze2, [\in, ~audiobus_grp1[0][1], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time, \levels, #[1, 0.5, 0.5], \times, #[5, 20]], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[9].set(\freeze, 1.0);
    }).play;
    "84 UPDATE 84.11: Event 84, freeze 10 (E5).\nReady for release 9.".yield;
    synths_freeze[8].set(\gate, 0);
    "84 UPDATE 84.12: Event 84 release 9.".yield;

    // 11 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][2], \pos, 0.25, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["77"]["buffer"]], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze2, [\in, ~audiobus_grp1[0][2], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time, \levels, #[1, 0.5, 0.5], \times, #[5, 20]], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[10].set(\freeze, 1.0);
    }).play;
    "84 UPDATE 84.13: Event 84, freeze 11 (F5).\nReady for release 10-11.".yield;
    synths_freeze[9].set(\gate, 0);
    synths_freeze[10].set(\gate, 0);
    "84 UPDATE 84.14: Event 84 release 10-11.".yield;

    // 13 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][6], \pos, 1.5, \width, 2.0, \mul, -9.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["74"]["buffer"]], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze2, [\in, ~audiobus_grp1[0][6], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time, \levels, #[1, 0.5, 0.5], \times, #[5, 20]], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[11].set(\freeze, 1.0);
    }).play;
    "84 UPDATE 84.15: Event 84, freeze 12 (D5).".yield;

    // 14 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][6], \pos, 0.5, \width, 2.0, \mul, -9.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["76"]["buffer"]], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze2, [\in, ~audiobus_grp1[0][6], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time, \levels, #[1, 0.5, 0.5], \times, #[5, 20]], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[12].set(\freeze, 1.0);
    }).play;
    "84 UPDATE 84.16: Event 84, freeze 13 (E5).\nReady for release 12.".yield;
    synths_freeze[11].set(\gate, 0);
    "84 UPDATE 84.17: Event 84, release 12. Ready for release 13 (final).".yield;

    // cleanup
    Routine({
        synths_freeze[12].set(\gate, 0);
        freeze_release_time.wait;
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths_freeze.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "84 UPDATE 84.19: Event 84 kill stage complete. Event finished.".postln;
    }).play;
    "84 UPDATE 84.18: Event 84 fading out.".postln;
}));


// Event 93: feedback
e.put("e93", Routine({
    var control, control_specs,    synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 40], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[10, 20], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5, 0.5], "times" -> #[10, 20], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5, 0.5], "times" -> #[10, 20], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp3[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus_grp3[0][0], \pos, ~controlbus_grp3[0], \width, ~controlbus_grp3[1]], ~grp[1], \addToTail));

    // add processing synths
    synths.add(Synth(\fbx, [\in, ~audiobus_grp3[0][0], \out, ~audiobus_grp3[1][0], \mul_sig, ~faderbus[4], \feedback, ~faderbus[5], \feedback_scaler, 2, \freq, ~faderbus[8], \low_freq, 43.midicps, \high_freq, 108.midicps], ~grp[2], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[1][0], \out, ~audiobus_grp3[1][1], \mul_sig, ~controlbus_grp3[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[1][1], \out, ~gainbus, \mul, -12.dbamp, \mul_sig, ~controlbus_grp3[3], \attack_time, 0.01, \release_time, 2], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[1][1], \out, ~reverbbus[3], \mul, -12.dbamp, \mul_sig, ~controlbus_grp3[4], \attack_time, 0.01, \release_time, 2], ~grp[4], \addToTail));
    "93 UPDATE 93.0: Event 93 running.".yield;

    // cleanup
    Routine({
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "93 UPDATE 93.2: Event 93 kill stage complete. Event finished.".postln;
    }).play;
    "93 UPDATE 93.1: Event 93 fading out.".postln;
}));

// EVENT 97
// PS DELAY
e.put("e97", Routine({
    var control, control_specs,    synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 8.0, 8.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
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

    synths.add(Synth(\psdelay3_et, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[1][0], \semitones, -3, \delayint, 60/84/2], ~grp[2], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][0], \out, ~audiobus_grp2[1][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~gainbus, \mul, -12.dbamp, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~reverbbus[1], \mul, -30.dbamp, \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "97 UPDATE 97.0: Pitch shift in effect.".yield;

    synths[0].set(\gate, 0);
    "97 UPDATE 97.1: Mic closed.".postln;

    // cleanup
    Routine({
        4.wait;
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "97 UPDATE 97.3: Event 97 kill stage complete. Event finished.".postln;
    }).play;
    "97 UPDATE 97.2: Event 97 fading out.".postln;
}));


// EVENT 99
// PS DELAY
e.put("e99", Routine({
    var control, control_specs, synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 8.0, 8.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
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

    synths.add(Synth(\psdelay4_et, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[1][0], \semitones, -3, \delayint, 60/84/1.5], ~grp[2], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][0], \out, ~audiobus_grp1[1][1], \mul_sig, ~controlbus_grp1[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~gainbus, \mul, -12.dbamp, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~reverbbus[1], \mul, -30.dbamp, \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "99 UPDATE 99.0: Pitch shift in effect.".yield;

    synths[0].set(\gate, 0);
    "99 UPDATE 99.1: Mic closed.".postln;

    // cleanup
    Routine({
        4.wait;
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "99 UPDATE 99.3: Event 99 kill stage complete. Event finished.".postln;
    }).play;
    "99 UPDATE 99.2: Event 99 fading out.".postln;
}));


// Event 100: feedback
e.put("e100", Routine({
    var control, control_specs,    synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 40], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[10, 20], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5, 0.5], "times" -> #[10, 20], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5, 0.5], "times" -> #[10, 20], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp3[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus_grp3[0][0], \pos, ~controlbus_grp3[0], \width, ~controlbus_grp3[1]], ~grp[1], \addToTail));

    // add processing synths
    synths.add(Synth(\fbx, [\in, ~audiobus_grp3[0][0], \out, ~audiobus_grp3[1][0], \mul_sig, ~faderbus[4], \feedback, ~faderbus[5], \feedback_scaler, 2, \freq, ~faderbus[8], \low_freq, 40.midicps, \high_freq, 108.midicps], ~grp[2], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[1][0], \out, ~audiobus_grp3[1][1], \mul_sig, ~controlbus_grp3[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[1][1], \out, ~gainbus, \mul, -12.dbamp, \mul_sig, ~controlbus_grp3[3], \attack_time, 0.01, \release_time, 2], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[1][1], \out, ~reverbbus[3], \mul, -12.dbamp, \mul_sig, ~controlbus_grp3[4], \attack_time, 0.01, \release_time, 2], ~grp[4], \addToTail));
    "100 UPDATE 100.0: Event 100 running.".yield;

    // cleanup
    Routine({
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "100 UPDATE 100.3: Event 100 kill stage complete. Event finished.".postln;
    }).play;
    "100 UPDATE 100.2: Event 100 fading out.".postln;
}));

// EVENT 102
// PS 8ve down
e.put("e102", Routine({
    var control, control_specs,    synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 6.0, 6.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.1, 0.9, 0.3, 0.1, 0.9, 0.1, 0.1], "times" -> #[2, 1, 2, 2, 2, 10], "curves" -> #[0, 0, 0, 0, 0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.05, 0.1, 0.05, 0.02, 0.1, 0.05, 0.02], "times" -> #[2, 1, 2, 2, 2, 10], "curves" -> #[0, 0, 0, 0, 0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus_grp2[0][0], \pos, ~controlbus_grp2[0], \width, ~controlbus_grp1[1]], ~grp[1], \addToTail));

    synths.add(Synth(\pitchshift, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[1][0], \ratio, 1/2], ~grp[2], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][0], \out, ~audiobus_grp2[1][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "102 UPDATE 102.0: Pitch shift in effect.".yield;

    synths[0].set(\gate, 0);
    "102 UPDATE 102.1: Mic closed.".postln;

    // cleanup
    Routine({
        4.wait;
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
    "102 UPDATE 102.3: Event 102 kill stage complete. Event finished.".postln;
    }).play;
    "102 UPDATE 102.2: Event 102 fading out.".postln;
}));

// EVENT 105
// PS DELAY
e.put("e105", Routine({
    var control, control_specs,    synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 2.0, 2.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
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

    synths.add(Synth(\psdelay3_et, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[1][0], \semitones, -3, \delayint, 60/84/2], ~grp[2], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][0], \out, ~audiobus_grp1[1][1], \mul_sig, ~controlbus_grp1[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~gainbus, \mul, -12.dbamp, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~reverbbus[1], \mul, -30.dbamp, \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "105 UPDATE 105.0: Pitch shift in effect.".yield;

    synths[0].set(\gate, 0);
    "105 UPDATE 105.1: Mic closed.".postln;

    // cleanup
    Routine({
        4.wait;
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "105 UPDATE 105.3: Event 105 kill stage complete. Event finished.".postln;
    }).play;
    "105 UPDATE 105.2: Event 105 fading out.".postln;
}));
)