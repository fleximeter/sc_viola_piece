// File: events083.scd
// This file contains individual events starting at measure 83.

(
// EVENT 83
e.put("e83", Routine({
    var control, control_specs,    synths_freeze, synths, synths_out;
    var freeze_release_time;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.8, 0.8, 0.8], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.2, 0.2, 0.2], "times" -> #[10, 100], "curves" -> #[0, 0]],    ];

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
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][0], \pos, 1.0, \width, 2.0, \mul, -18.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["74"]["buffer"], \mul, 0.5], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[0].set(\freeze, 1.0);
    }).play;
    "83 UPDATE 83.0: Event 83, freeze 1 (D5).".yield;

    // 2 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][1], \pos, 0.5, \width, 2.0, \mul, -18.dbamp, \buf, ~samples["viola.arco"]["mf"]["g"]["55"]["buffer"], \mul, 0.5], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][1], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[1].set(\freeze, 1.0);
    }).play;
    "83 UPDATE 83.1: Event 83, freeze 2 (G3).".yield;

    // 3 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][2], \pos, 1.5, \width, 2.0, \mul, -18.dbamp, \buf, ~samples["viola.arco"]["mf"]["d"]["65"]["buffer"], \mul, 0.5], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][2], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[2].set(\freeze, 1.0);
    }).play;
    "83 UPDATE 83.2: Event 83, freeze 3 (F4).".yield;

    // 4 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][3], \pos, 0.0, \width, 2.0, \mul, -18.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["72"]["buffer"], \mul, 0.5], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][3], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[3].set(\freeze, 1.0);
    }).play;
    "83 UPDATE 83.3: Event 83, freeze 4 (C5).\nReady for release 1-4.".yield;
    synths_freeze[0].set(\gate, 0);
    synths_freeze[1].set(\gate, 0);
    synths_freeze[2].set(\gate, 0);
    synths_freeze[3].set(\gate, 0);
    "83 UPDATE 83.4: Event 83 release 1-4.".yield;

    // 5 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][0], \pos, 0.25, \width, 2.0, \mul, -18.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["77"]["buffer"], \mul, 0.5], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[4].set(\freeze, 1.0);
    }).play;
    "83 UPDATE 83.5: Event 83, freeze 5 (F5).".yield;

    // 6 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][1], \pos, 1.75, \width, 2.0, \mul, -18.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["74"]["buffer"], \mul, 0.5], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][1], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[5].set(\freeze, 1.0);
    }).play;
    "83 UPDATE 83.6: Event 83, freeze 6 (D5).".yield;

    // 7 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][2], \pos, 0.5, \width, 2.0, \mul, -18.dbamp, \buf, ~samples["viola.arco"]["mf"]["d"]["67"]["buffer"], \mul, 0.5], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][2], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[6].set(\freeze, 1.0);
    }).play;
    synths_freeze[4].set(\gate, 0);
    "83 UPDATE 83.7: Event 83, freeze 7 (G4), release 5.".yield;
    
    // 8 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][3], \pos, 1.5, \width, 2.0, \mul, -18.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["76"]["buffer"], \mul, 0.5], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][3], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[7].set(\freeze, 1.0);
    }).play;
    "83 UPDATE 83.8: Event 83, freeze 8 (E5).\nReady for realease 6-8.".yield;
    synths_freeze[5].set(\gate, 0);
    synths_freeze[6].set(\gate, 0);
    synths_freeze[7].set(\gate, 0);
    "83 UPDATE 83.9: Event 83 release 6-8.".yield;

    // 9 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][0], \pos, 0.75, \width, 2.0, \mul, -18.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["81"]["buffer"], \mul, 0.5], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[8].set(\freeze, 1.0);
    }).play;
    "83 UPDATE 83.10: Event 83, freeze 9 (A5).".yield;

    // 10 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][1], \pos, 1.25, \width, 2.0, \mul, -18.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["76"]["buffer"], \mul, 0.5], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][1], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[9].set(\freeze, 1.0);
    }).play;
    "83 UPDATE 83.11: Event 83, freeze 10 (E5).\nReady for realease 9.".yield;
    synths_freeze[8].set(\gate, 0);
    "83 UPDATE 83.12: Event 83 release 9.".yield;

    // 11 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][2], \pos, 0.25, \width, 2.0, \mul, -18.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["77"]["buffer"], \mul, 0.5], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][2], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[10].set(\freeze, 1.0);
    }).play;
    "83 UPDATE 83.13: Event 83, freeze 11 (F5).".yield;

    // 12 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][3], \pos, 1.75, \width, 2.0, \mul, -18.dbamp, \buf, ~samples["viola.arco"]["mf"]["d"]["67"]["buffer"], \mul, 0.5], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][3], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[11].set(\freeze, 1.0);
    }).play;
    "83 UPDATE 83.15: Event 83 freeze 12 (G4).\nReady for release 9-10.".yield;
    synths_freeze[9].set(\gate, 0);
    synths_freeze[10].set(\gate, 0);
    "83 UPDATE 83.16: Event 83 release 10-11. Ready for release 12".yield;
    synths_freeze[11].set(\gate, 0);
    "83 UPDATE 83.17: Event 83 release 12.".yield;

    // 13 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][6], \pos, 1.5, \width, 2.0, \mul, -18.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["74"]["buffer"], \mul, 0.5], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][6], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[12].set(\freeze, 1.0);
    }).play;
    "83 UPDATE 83.18: Event 83, freeze 13 (D5).".yield;

    // 14 freeze
    Routine({
        synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][6], \pos, 0.5, \width, 2.0, \mul, -18.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["76"]["buffer"], \mul, 0.5], ~grp[1], \addToTail));
        synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus_grp1[0][6], \out, ~audiobus_grp1[1][0], \above, 3, \release_time, freeze_release_time], ~grp[1], \addToTail));
        1.wait;
        synths_freeze[13].set(\freeze, 1.0);
    }).play;
    "83 UPDATE 83.19: Event 83, freeze 14 (E5).\nReady for realease 13.".yield;
    synths_freeze[12].set(\gate, 0);
    "83 UPDATE 83.20: Event 83, release 13. Ready for release 14 (final).".yield;

    // cleanup
    Routine({
        synths_freeze[13].set(\gate, 0);
        freeze_release_time.wait;
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths_freeze.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "83 UPDATE 83.22: Event 83 kill stage complete. Event finished.".postln;
    }).play;
    "83 UPDATE 83.21: Event 83 fading out.".postln;
}));

// EVENT 96
// PS DELAY
e.put("e96", Routine({
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
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "96 UPDATE 96.0: Pitch shift in effect.".yield;

    synths[0].set(\gate, 0);
    "96 UPDATE 96.1: Mic closed.".yield;

    // cleanup
    Routine({
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "96 UPDATE 96.3: Event 96 kill stage complete. Event finished.".postln;
    }).play;
    "96 UPDATE 96.2: Event 96 fading out.".postln;
}));


// EVENT 98
// PS DELAY
e.put("e98", Routine({
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
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "98 UPDATE 98.0: Pitch shift in effect.".yield;

    synths[0].set(\gate, 0);
    "98 UPDATE 98.1: Mic closed.".yield;

    // cleanup
    Routine({
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "98 UPDATE 98.3: Event 98 kill stage complete. Event finished.".postln;
    }).play;
    "98 UPDATE 98.2: Event 98 fading out.".postln;
}));


// Event 99: feedback
e.put("e99", Routine({
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
    synths.add(Synth(\fb1, [\in, ~audiobus_grp3[0][0], \out, ~audiobus_grp3[1][0], \mul_sig, ~faderbus[4], \feedback, ~faderbus[5], \freq, ~faderbus[8]], ~grp[2], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[1][0], \out, ~audiobus_grp3[1][1], \mul_sig, ~controlbus_grp3[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp3[3], \attack_time, 0.01, \release_time, 2], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp3[4], \attack_time, 0.01, \release_time, 2], ~grp[4], \addToTail));
    "99 UPDATE 99.0: Event 99 running.".yield;

    // cleanup
    Routine({
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "99 UPDATE 99.3: Event 99 kill stage complete. Event finished.".postln;
    }).play;
    "99 UPDATE 99.2: Event 99 fading out.".postln;
}));

// EVENT 101
// PS 8ve down
e.put("e101", Routine({
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
    "101 UPDATE 101.0: Pitch shift in effect.".yield;

    synths[0].set(\gate, 0);
    "101 UPDATE 101.1: Mic closed.".yield;

    // cleanup
    Routine({
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
    "101 UPDATE 101.3: Event 101 kill stage complete. Event finished.".postln;
    }).play;
    "101 UPDATE 101.2: Event 101 fading out.".postln;
}));

// EVENT 104
// PS DELAY
e.put("e104", Routine({
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
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "104 UPDATE 104.0: Pitch shift in effect.".yield;

    synths[0].set(\gate, 0);
    "104 UPDATE 104.1: Mic closed.".yield;

    // cleanup
    Routine({
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "104 UPDATE 104.3: Event 104 kill stage complete. Event finished.".postln;
    }).play;
    "104 UPDATE 104.2: Event 104 fading out.".postln;
}));
)