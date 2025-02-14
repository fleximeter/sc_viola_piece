// File: events001.scd
// This file contains individual events starting at measure 1.

(
// this alternate event 1 uses a sampler, not live audio
e.put("e1alt", Routine({
    var control, control_specs, freeze_release_time, synth_freeze, synths, synths_out;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[4, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_above", "levels" -> #[30, 2, 2], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_pitch_shift1", "levels" -> #[4.0, 5.0, 5.0], "times" -> #[4, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_pitch_shift2", "levels" -> #[-12.0, -12.0, -12.0], "times" -> #[4, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_pan_pos1", "levels" -> #[1.5, 1.25, 1.25], "times" -> #[4, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_pan_width1", "levels" -> #[2.0, 3.0, 3.0], "times" -> #[4, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_pan_pos2", "levels" -> #[0.5, 0.75, 0.75], "times" -> #[4, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_pan_width2", "levels" -> #[2.0, 3.0, 3.0], "times" -> #[4, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_lpf", "levels" -> #[800, 800, 800], "times" -> #[4, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 0.25, 0.5], "times" -> #[4, 100], "curves" -> #[2, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.5, 0.1, 0.1], "times" -> #[4, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.5, 0.9, 0.9], "times" -> #[4, 100], "curves" -> #[0, 0]],
    ];


    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp1[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][0], \pos, 0.0, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["viola.arco"]["mf"]["d"]["74"]["buffer"]], ~grp[1], \addToTail));

    // freeze and mag below
	synth_freeze = Synth(\fft_freeze, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[2][0], \above_frac, 0.2, \amp_fluctuation, 0.1, \release_time, 3], ~grp[1], \addToTail);
    synths.add(Synth(\fft_magbelow, [\in, ~audiobus_grp1[1][0], \out, ~audiobus_grp1[2][0], \below, ~controlbus_grp1[2]], ~grp[1], \addToTail));

    // pitch shift and independent panning
    synths.add(Synth(\pitchshift1_et, [\in, ~audiobus_grp1[2][0], \out, ~audiobus_grp1[3][0], \semitones1, ~controlbus_grp1[3], \mul, -3.dbamp], ~grp[2], \addToTail));
    synths.add(Synth(\pitchshift1_et, [\in, ~audiobus_grp1[2][0], \out, ~audiobus_grp1[3][1], \semitones1, ~controlbus_grp1[4], \mul, -12.dbamp], ~grp[2], \addToTail));
    synths.add(Synth(\pan8to8ctrl, [\in, ~audiobus_grp1[3][0], \out, ~audiobus_grp1[5][0], \pos, ~controlbus_grp1[5], \width, ~controlbus_grp1[6]], ~grp[3], \addToTail));
    synths.add(Synth(\pan8to8ctrl, [\in, ~audiobus_grp1[3][1], \out, ~audiobus_grp1[5][0], \pos, ~controlbus_grp1[7], \width, ~controlbus_grp1[8]], ~grp[3], \addToTail));
    synths.add(Synth(\passthrough8, [\in, ~audiobus_grp1[2][0], \out, ~audiobus_grp1[5][0]], ~grp[2], \addToTail));
    //synths.add(Synth(\lpf8, [\in, ~audiobus_grp1[4][0], \out, ~audiobus_grp1[5][0], \freq, ~controlbus_grp1[9]], ~grp[4], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[5][0], \out, ~audiobus_grp1[5][1], \mul_sig, ~controlbus_grp1[10], \attack_time, 0.01, \release_time, freeze_release_time], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[5][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[11], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[5][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[12], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    // freeze
    Routine({
        1.wait;
        synth_freeze.set(\freeze, 1.0);
    }).play;
    "1 UPDATE 1.0: Event 1 running. Wait 6 sec...".postln;

    // cleanup
    Routine({
		3.5.wait;
		"1 UPDATE 1.1: Event 1 fading out.".postln;
        synth_freeze.do({|item| item.set(\gate, 0)});
        freeze_release_time.wait;
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synth_freeze.free;
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "1 UPDATE 1.2: Event 1 kill stage complete. Event finished.".postln;
    }).play;
}));

// this alternate event 2 uses a sampler, not live audio
e.put("e2alt", Routine({
    var control, control_specs, freeze_release_time, synth_freeze, synths, synths_out;
    freeze_release_time = 2;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[5, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_below", "levels" -> #[30, 3, 3], "times" -> #[5, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_pitch_shift1", "levels" -> #[5.0, 3.0, 3.0], "times" -> #[5, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_pitch_shift2", "levels" -> #[0, 0, -0.5, -0.5], "times" -> #[1, 4, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_pan_pos1", "levels" -> #[1.0, 1.5, 1.5], "times" -> #[5, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_pan_width1", "levels" -> #[2.0, 3.0, 3.0], "times" -> #[5, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_pan_pos2", "levels" -> #[1.0, 0.5, 0.5], "times" -> #[5, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_pan_width2", "levels" -> #[2.0, 3.0, 3.0], "times" -> #[5, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_lpf", "levels" -> #[10000, 440, 440], "times" -> #[5, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[0.125, 2.0, 4.0, 4.0], "times" -> #[3, 2, 100], "curves" -> #[2, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.5, 0.0, 0.0], "times" -> #[5, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.5, 1.0, 1.0], "times" -> #[5, 100], "curves" -> #[0, 0]],
    ];


    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp2[0][0], \pos, 0.0, \width, 2.0, \mul, -12.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["74"]["buffer"]], ~grp[1], \addToTail));

    // freeze and mag below
    synth_freeze = Synth(\fft_freeze, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[1][0], \above_frac, 0.2, \amp_fluctuation, 0.1, \release_time, freeze_release_time], ~grp[1], \addToTail);
    synths.add(Synth(\fft_magbelow, [\in, ~audiobus_grp2[1][0], \out, ~audiobus_grp2[2][0], \below, ~controlbus_grp2[2]], ~grp[1], \addToTail));

    // pitch shift and independent panning
    synths.add(Synth(\pitchshift1_et, [\in, ~audiobus_grp2[2][0], \out, ~audiobus_grp2[3][0], \semitones1, ~controlbus_grp2[3], \mul, -6.dbamp], ~grp[2], \addToTail));
    synths.add(Synth(\pitchshift1_et, [\in, ~audiobus_grp2[2][0], \out, ~audiobus_grp2[3][1], \semitones1, ~controlbus_grp2[4], \mul, -12.dbamp], ~grp[2], \addToTail));
    synths.add(Synth(\pan8to8ctrl, [\in, ~audiobus_grp2[3][0], \out, ~audiobus_grp2[4][0], \pos, ~controlbus_grp2[5], \width, ~controlbus_grp2[6]], ~grp[3], \addToTail));
    synths.add(Synth(\pan8to8ctrl, [\in, ~audiobus_grp2[3][1], \out, ~audiobus_grp2[4][0], \pos, ~controlbus_grp2[7], \width, ~controlbus_grp2[8]], ~grp[3], \addToTail));
    synths.add(Synth(\passthrough8, [\in, ~audiobus_grp2[2][0], \out, ~audiobus_grp2[4][0]], ~grp[2], \addToTail));
    synths.add(Synth(\lpf8, [\in, ~audiobus_grp2[4][0], \out, ~audiobus_grp2[5][0], \freq, ~controlbus_grp2[9]], ~grp[4], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[5][0], \out, ~audiobus_grp2[5][1], \mul_sig, ~controlbus_grp2[10], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[5][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[11], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[5][1], \out, ~reverbbus[1], \mul, -36.dbamp, \mul_sig, ~controlbus_grp2[12], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[5][1], \out, ~reverbbus[3], \mul, -24.dbamp, \mul_sig, ~controlbus_grp2[12], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    // freeze
    Routine({
        1.wait;
        synth_freeze.set(\freeze, 1.0);
    }).play;
    "2 UPDATE 2.0: Event 2 running. Wait 8 sec...".postln;

    // cleanup
    Routine({
		5.wait;
		"2 UPDATE 2.1: Event 2 fading out.".postln;
        synth_freeze.do({|item| item.set(\gate, 0)});
        freeze_release_time.wait;
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synth_freeze.free;
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "2 UPDATE 2.2: Event 2 kill stage complete. Event finished.".postln;
    }).play;

}));


// this alternate event 3 uses a sampler, not live audio
e.put("e3alt", Routine({
    var control, control_osc, control_specs, freeze_release_time, synth_freeze, synths, synths_out;
    freeze_release_time = 3;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[8, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[8, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_above", "levels" -> #[0.1, 0.5, 20, 20], "times" -> #[2, 6, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_pitch_shift1", "levels" -> #[7.0, 7.5, 7.5], "times" -> #[8, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_pitch_shift2", "levels" -> #[-7.0, -7.5, -7.5], "times" -> #[8, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_pan_pos1", "levels" -> #[2.0, 1.25, 1.25], "times" -> #[8, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_pan_width1", "levels" -> #[2.0, 3.0, 3.0], "times" -> #[8, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_pan_pos2", "levels" -> #[0.0, 0.75, 0.75], "times" -> #[8, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_pan_width2", "levels" -> #[2.0, 3.0, 3.0], "times" -> #[8, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 0.25, 0.25], "times" -> #[8, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.5, 0.1, 0.1], "times" -> #[8, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.5, 0.9, 0.9], "times" -> #[8, 100], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp1[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // lpf oscillator control
    control_osc = [
        Synth(\ctrl_tri, [\out, ~controlbus_grp1[12], \freq, 1, \high, 10000, \low, 1600], ~grp[0])
    ];

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][0], \pos, 0.0, \width, 2.0, \mul, 0.dbamp, \buf, ~samples["viola.arco"]["mf"]["a"]["74"]["buffer"]], ~grp[1], \addToTail));

    // freeze and mag below
    synth_freeze = Synth(\fft_freeze, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[1][0], \above_frac, 0.2, \amp_fluctuation, 0.1, \release_time, freeze_release_time], ~grp[1], \addToTail);
    synths.add(Synth(\fft_magabove, [\in, ~audiobus_grp1[1][0], \out, ~audiobus_grp1[2][0], \above, ~controlbus_grp1[2]], ~grp[1], \addToTail));

    // pitch shift and independent panning
    synths.add(Synth(\pitchshift1_et, [\in, ~audiobus_grp1[2][0], \out, ~audiobus_grp1[3][0], \semitones1, ~controlbus_grp1[3], \mul, -6.dbamp], ~grp[2], \addToTail));
    synths.add(Synth(\pitchshift1_et, [\in, ~audiobus_grp1[2][0], \out, ~audiobus_grp1[3][1], \semitones1, ~controlbus_grp1[4], \mul, -12.dbamp], ~grp[2], \addToTail));
    synths.add(Synth(\pan8to8ctrl, [\in, ~audiobus_grp1[3][0], \out, ~audiobus_grp1[4][0], \pos, ~controlbus_grp1[5], \width, ~controlbus_grp1[6]], ~grp[3], \addToTail));
    synths.add(Synth(\pan8to8ctrl, [\in, ~audiobus_grp1[3][1], \out, ~audiobus_grp1[4][0], \pos, ~controlbus_grp1[7], \width, ~controlbus_grp1[8]], ~grp[3], \addToTail));
    synths.add(Synth(\passthrough8, [\in, ~audiobus_grp1[2][0], \out, ~audiobus_grp1[4][0]], ~grp[2], \addToTail));
    synths.add(Synth(\lpf8, [\in, ~audiobus_grp1[4][0], \out, ~audiobus_grp1[5][0], \freq, ~controlbus_grp1[12]], ~grp[4], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[5][0], \out, ~audiobus_grp1[5][1], \mul_sig, ~controlbus_grp1[9], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[5][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[10], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[5][1], \out, ~reverbbus[0], \mul, -6.dbamp, \mul_sig, ~controlbus_grp1[11], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[5][1], \out, ~reverbbus[3], \mul, -30.dbamp, \mul_sig, ~controlbus_grp1[11], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));

    // freeze
    Routine({
        1.wait;
        synth_freeze.set(\freeze, 1.0);
    }).play;
    "3 UPDATE 3.0: Event 3 running. Wait 10 sec...".postln;

    // cleanup
    Routine({
		6.wait;
		"3 UPDATE 3.1: Event 3 fading out.".postln;
        synth_freeze.do({|item| item.set(\gate, 0)});
        freeze_release_time.wait;
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synth_freeze.free;
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "3 UPDATE 3.2: Event 3 kill stage complete. Event finished.".postln;
    }).play;
}));

// Event 4: feedback
e.put("e4", Routine({
    var control, control_specs,    synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.5, -0.5, -0.5], "times" -> #[10, 40], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 3.0, 3.0], "times" -> #[10, 20], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5, 0.5], "times" -> #[10, 20], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5, 0.5], "times" -> #[10, 20], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus_grp2[0][0], \pos, ~controlbus_grp2[0], \width, ~controlbus_grp2[1]], ~grp[1], \addToTail));

    // add processing synths
	synths.add(Synth(\fbx2, [
		\in, ~audiobus_grp2[0][0],
		\out, ~audiobus_grp2[1][0],
		\mul_sig, ~faderbus[4],
		\mul, -6.dbamp,
		\feedback, ~faderbus[5],
		\feedback_scaler, 2,
		\freq, ~faderbus[8],
		\low_freq, 36.midicps,
		\high_freq, 72.midicps,
	], ~grp[2], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][0], \out, ~audiobus_grp2[1][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 2], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~gainbus, \mul, 0.dbamp, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 2], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~reverbbus[0], \mul, 0.dbamp, \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 2], ~grp[4], \addToTail));
    "4 UPDATE 4.0: Event 4 running.".yield;

    // cleanup
    Routine({
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "4 UPDATE 4.2: Event 4 kill stage complete. Event finished.".postln;
    }).play;
    "4 UPDATE 4.1: Event 4 fading out.".postln;
}));

// EVENT 5
// PS DOWN
e.put("e5", Routine({
    var control, control_specs,    synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[10, 40], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[4.0, 4.0, 4.0], "times" -> #[10, 40], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5, 0.5], "times" -> #[10, 40], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5, 0.5], "times" -> #[10, 40], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp1[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths_out = List();
    synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus_grp1[0][0], \pos, ~controlbus_grp1[0], \width, ~controlbus_grp1[1], \mul, -12.dbamp], ~grp[1], \addToTail));
    synths.add(Synth(\pitchshift, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[1][0], \ratio, 0.5], ~grp[2], \addToTail));
    synths.add(Synth(\passthrough8, [\in, ~audiobus_grp1[1][0], \out, ~audiobus_grp1[2][0], \attack_time, 0.1, \release_time, 1], ~grp[2], \addToTail));

    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[2][0], \out, ~audiobus_grp1[2][1], \mul_sig, ~controlbus_grp1[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[2][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[2][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "5 UPDATE 5.0: Pitch shift in effect.".yield;

    synths[2].set(\gate, 0);
    synths[2].set(\attack_time, 3);
    "5 UPDATE 5.1: Pitch shift fade out.".yield;

    synths[2].set(\gate, 1);
    "5 UPDATE 5.2: Pitch shift fade in.".yield;

    // cleanup
    Routine({
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "5 UPDATE 5.4: Event 5 kill stage complete. Event finished.".postln;
    }).play;
    "5 UPDATE 5.3: Event 5 fading out.".postln;
}));

// Event 6: feedback
e.put("e6", Routine({
    var control, control_specs, synths, synths_out;

    // CONTROLS ///////////////////////////////////////////////////////////////
    control_specs = [
        Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[10, 40], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_sound_pan_width", "levels" -> #[3.0, 6.0, 3.0, 3.0], "times" -> #[5, 5, 10], "curves" -> #[0, 0, 0]],
        Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5, 0.5], "times" -> #[10, 20], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5, 0.5], "times" -> #[10, 20], "curves" -> #[0, 0]],
    ];

    control = Array.fill(control_specs.size, {
        | i |
        Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
    });

    // SYNTHS ///////////////////////////////////////////////////////////////
    synths = List();
    synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus_grp2[0][0], \pos, ~controlbus_grp2[0], \width, ~controlbus_grp2[1]], ~grp[1], \addToTail));

    // add processing synths
    synths.add(Synth(\fbx2, [
		\in, ~audiobus_grp2[0][0],
		\out, ~audiobus_grp2[1][0],
		\mul_sig, ~faderbus[4],
		\mul, -6.dbamp,
		\feedback, ~faderbus[5],
		\feedback_scaler, 2,
		\freq, ~faderbus[8],
		\low_freq, 36.midicps,
		\high_freq, 72.midicps,
	], ~grp[2], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][0], \out, ~audiobus_grp2[1][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 3], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~gainbus, \mul, -6.dbamp, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 3], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~reverbbus[3], \mul, -18.dbamp, \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 3], ~grp[4], \addToTail));
    "6 UPDATE 6.0: Event 6 running.".yield;

    // cleanup
    Routine({
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "6 UPDATE 6.2: Event 6 kill stage complete. Event finished.".postln;
    }).play;
    "6 UPDATE 6.1: Event 6 fading out.".postln;
}));

// Event 7: feedback
e.put("e7", Routine({
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
    synths.add(Synth(\fbx2, [
		\in, ~audiobus_grp2[0][0],
		\out, ~audiobus_grp2[1][0],
		\mul_sig, ~faderbus[4],
		\mul, -6.dbamp,
		\feedback, ~faderbus[5],
		\feedback_scaler, 2,
		\freq, ~faderbus[8],
		\low_freq, 36.midicps,
		\high_freq, 72.midicps,
	], ~grp[2], \addToTail));
    
    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
    synths_out = List();
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[1][0], \out, ~audiobus_grp3[1][1], \mul_sig, ~controlbus_grp3[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[1][1], \out, ~gainbus, \mul, -12.dbamp, \mul_sig, ~controlbus_grp3[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[1][1], \out, ~reverbbus[0], \mul, -18.dbamp, \mul_sig, ~controlbus_grp3[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[1][1], \out, ~reverbbus[2], \mul, -24.dbamp, \mul_sig, ~controlbus_grp3[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "7 UPDATE 7.0: Event 7 running.".yield;

    // cleanup
    Routine({
        synths_out.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths_out.do({|item| item.free});
        synths.do({|item| item.free});
        control.do({|item| item.free});
        "7 UPDATE 7.2: Event 7 kill stage complete. Event finished.".postln;
    }).play;
    "7 UPDATE 7.1: Event 7 fading out.".postln;
}));
)