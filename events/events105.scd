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
    "105 UPDATE 105.1: Event 105, freeze (C3).".yield;

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
        "105 UPDATE 105.3: Event 105 kill stage complete. Event finished.".postln;
    }).play;
    "105 UPDATE 105.2: Event 105 final realease.".postln;
}));

// Event 107: feedback
e.put("e107", Routine({
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
    synths.add(Synth(\fb1, [\in, ~audiobus_grp3[0][0], \out, ~audiobus_grp3[1][0], \mul_sig, ~faderbus[4], \feedback, ~faderbus[5], \freq, ~faderbus[8], \low_freq, 62.midicps, \high_freq, 96.midicps], ~grp[2], \addToTail));
    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[1][0], \out, ~audiobus_grp3[1][1], \mul_sig, ~controlbus_grp3[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp3[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp3[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "107 UPDATE 107.0: Event 107 running.".yield;

    // cleanup
    Routine({
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "107 UPDATE 107.2: Event 107 kill stage complete. Event finished.".postln;
    }).play;
    "107 UPDATE 107.1: Event 107 fading out.".postln;
}));

// EVENT 114
// SAMPLE
e.put("e114", Routine({
    var control, control_specs, synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "lpf_freq", "levels" -> #[10000.0, 100.0, 100.0], "times" -> #[4, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.9, 0.2, 0.2], "times" -> #[4, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.1, 0.8, 0.8], "times" -> #[4, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp1[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp1[0][0], \pos, 0.0, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["other"]["harmonics_trill2"]["buffer"], \dur, 3, \release_time, 0.2], ~grp[1], \addToTail));
    synths.add(Synth(\combdelay, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[1][0], \delaytime, 0.5, \decaytime, 6, \mul, -12.dbamp], ~grp[1], \addToTail));
    
    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][0], \out, ~audiobus_grp1[1][1], \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[5], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "114 UPDATE 114.0: Playing sample.".postln;
    1.5.wait;

    synths_out.do({|item| item.set(\gate, 0)});
    "114 UPDATE 114.1: Event 114 fading out.".postln;

    1.wait;
    synths_out.do({|item| item.free});
    synths.do({|item| item.free});
    control.do({|item| item.free});
    "114 UPDATE 114.2: Event 114 kill stage complete. Event finished.".postln;
}));

// EVENT 127
// SAMPLE
e.put("e127", Routine({
    var control, control_specs, synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "hpf_freq", "levels" -> #[100.0, 5000.0, 5000.0], "times" -> #[4, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.9, 0.2, 0.2], "times" -> #[4, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.1, 0.8, 0.8], "times" -> #[4, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp1[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp1[0][0], \pos, 0.0, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["other"]["harmonics_trill2"]["buffer"], \dur, 3, \release_time, 0.2], ~grp[1], \addToTail));
    synths.add(Synth(\hpf8, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[1][0], \freq, ~controlbus_grp1[2]], ~grp[1], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][0], \out, ~audiobus_grp1[1][1], \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[5], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "127 UPDATE 127.0: Playing sample.".postln;
    1.5.wait;

    synths_out.do({|item| item.set(\gate, 0)});
    "127 UPDATE 127.1: Event 127 fading out.".postln;

    1.wait;
    synths_out.do({|item| item.free});
    synths.do({|item| item.free});
    control.do({|item| item.free});
    "127 UPDATE 127.2: Event 127 kill stage complete. Event finished.".postln;
}));

// EVENT 129
// SAMPLE
e.put("e129", Routine({
    var control, control_specs, synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "lpf_freq", "levels" -> #[10000.0, 100.0, 100.0], "times" -> #[2, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.9, 0.2, 0.2], "times" -> #[2, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.1, 0.8, 0.8], "times" -> #[2, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp1[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp1[0][0], \pos, 0.0, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["other"]["harmonics_trill3"]["buffer"], \dur, 3, \release_time, 0.2], ~grp[1], \addToTail));
    synths.add(Synth(\lpf8, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[1][0], \freq, ~controlbus_grp1[2]], ~grp[1], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][0], \out, ~audiobus_grp1[1][1], \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[5], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "129 UPDATE 129.0: Playing sample.".postln;
    1.5.wait;

    synths_out.do({|item| item.set(\gate, 0)});
    "129 UPDATE 129.1: Event 129 fading out.".postln;

    1.wait;
    synths_out.do({|item| item.free});
    synths.do({|item| item.free});
    control.do({|item| item.free});
    "129 UPDATE 129.2: Event 129 kill stage complete. Event finished.".postln;
}));

// EVENT 130 - FAST PITCH SHIFT UP
e.put("e130", Routine({
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
    "130 UPDATE 130.1: Event 130 freeze.".postln;
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
    "130 UPDATE 130.3: Event 130 kill stage complete. Event finished.".postln;
    }).play;
    "130 UPDATE 130.2: Event 130 final realease.".postln;
}));
)