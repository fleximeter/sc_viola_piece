// File: events001.scd
// This file contains individual events starting at measure 1.

(
e.put("e1", Routine({
	var control, control_specs,	synth_freeze, synths, synths_out;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_below", "levels" -> #[0.1, 0.1, 0.1], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift1", "levels" -> #[4.0, 5.0], "times" -> #[10], "curves" -> #[0]],
		Dictionary["name" -> "control_pitch_shift2", "levels" -> #[0.0, -0.5], "times" -> #[10], "curves" -> #[0]],
		Dictionary["name" -> "control_pan_pos1", "levels" -> #[2.0, 1.7], "times" -> #[10], "curves" -> #[0]],
		Dictionary["name" -> "control_pan_width1", "levels" -> #[2.0, 3.0], "times" -> #[10], "curves" -> #[0]],
		Dictionary["name" -> "control_pan_pos2", "levels" -> #[0.0, 0.3], "times" -> #[10], "curves" -> #[0]],
		Dictionary["name" -> "control_pan_width2", "levels" -> #[2.0, 3.0], "times" -> #[10], "curves" -> #[0]],
		Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5], "times" -> #[10], "curves" -> #[0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5], "times" -> #[10], "curves" -> #[0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail));
	
    // freeze and mag below
    synth_freeze = Synth(\fft_freeze, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \below, 0.01], ~grp[1], \addToTail);
	synths.add(Synth(\fft_magbelow, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \below, ~controlbus[2]], ~grp[2], \addToTail));
    
    // pitch shift and independent panning
    synths.add(Synth(\pitchshift1_et, [\in, ~audiobus[2][0], \out, ~audiobus[3][0], \semitones1, ~controlbus[3], \mul, 0.5], ~grp[3], \addToTail));
	synths.add(Synth(\pitchshift1_et, [\in, ~audiobus[2][0], \out, ~audiobus[3][1], \semitones1, ~controlbus[4], \mul, 0.5], ~grp[3], \addToTail));
    synths.add(Synth(\pan8to8ctrl, [\in, ~audiobus[3][0], \out, ~audiobus[4][0], \pos, ~controlbus[5], \width, ~controlbus[6]], ~grp[4], \addToTail));
    synths.add(Synth(\pan8to8ctrl, [\in, ~audiobus[3][1], \out, ~audiobus[4][0], \pos, ~controlbus[7], \width, ~controlbus[8]], ~grp[4], \addToTail));
    synths.add(Synth(\passthrough8, [\in, ~audiobus[2][0], \out, ~audiobus[4][0]], ~grp[4], \addToTail));

	// SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[4][0], \out, ~gainbus, \mul_sig, ~controlbus[9], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[4][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[10], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
    "1 UPDATE 1.0: Event 1 running and ready for freeze.".yield;

    synth_freeze.set(\freeze, 1.0);
    "1 UPDATE 1.1: Event 1 freeze.".yield;
	synths_out.do({|item| item.set(\gate, 0)});
    "1 UPDATE 1.2: Event 1 fading out.".yield;
	synths_out.do({|item| item.free});
	synth_freeze.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
    "1 UPDATE 1.3: Event 1 kill stage complete. Event finished.".postln;
}));

// this alternate event 1 uses a sampler, not live audio
e.put("e1alt", Routine({
	var control, control_specs,	synth_freeze, synths, synths_out;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_below", "levels" -> #[0.1, 0.1, 0.1], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift1", "levels" -> #[4.0, 5.0], "times" -> #[10], "curves" -> #[0]],
		Dictionary["name" -> "control_pitch_shift2", "levels" -> #[0.0, -0.5], "times" -> #[10], "curves" -> #[0]],
		Dictionary["name" -> "control_pan_pos1", "levels" -> #[2.0, 1.7], "times" -> #[10], "curves" -> #[0]],
		Dictionary["name" -> "control_pan_width1", "levels" -> #[2.0, 3.0], "times" -> #[10], "curves" -> #[0]],
		Dictionary["name" -> "control_pan_pos2", "levels" -> #[0.0, 0.3], "times" -> #[10], "curves" -> #[0]],
		Dictionary["name" -> "control_pan_width2", "levels" -> #[2.0, 3.0], "times" -> #[10], "curves" -> #[0]],
		Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5], "times" -> #[10], "curves" -> #[0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5], "times" -> #[10], "curves" -> #[0]],
	];


	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["74"]["buffer"]], ~grp[1], \addToTail));
	
    // freeze and mag below
    synth_freeze = Synth(\fft_freeze, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \below, 0.01], ~grp[1], \addToTail);
	synths.add(Synth(\fft_magbelow, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \below, ~controlbus[2]], ~grp[2], \addToTail));
    
    // pitch shift and independent panning
    synths.add(Synth(\pitchshift1_et, [\in, ~audiobus[2][0], \out, ~audiobus[3][0], \semitones1, ~controlbus[3], \mul, 0.5], ~grp[3], \addToTail));
	synths.add(Synth(\pitchshift1_et, [\in, ~audiobus[2][0], \out, ~audiobus[3][1], \semitones1, ~controlbus[4], \mul, 0.5], ~grp[3], \addToTail));
    synths.add(Synth(\pan8to8ctrl, [\in, ~audiobus[3][0], \out, ~audiobus[4][0], \pos, ~controlbus[5], \width, ~controlbus[6]], ~grp[4], \addToTail));
    synths.add(Synth(\pan8to8ctrl, [\in, ~audiobus[3][1], \out, ~audiobus[4][0], \pos, ~controlbus[7], \width, ~controlbus[8]], ~grp[4], \addToTail));
    synths.add(Synth(\passthrough8, [\in, ~audiobus[2][0], \out, ~audiobus[4][0]], ~grp[4], \addToTail));

	// SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[4][0], \out, ~gainbus, \mul_sig, ~controlbus[9], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[4][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[10], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
    "1 UPDATE 1.0: Event 1 running and ready for freeze.".yield;

    synth_freeze.set(\freeze, 1.0);
    "1 UPDATE 1.1: Event 1 freeze.".yield;
	synths_out.do({|item| item.set(\gate, 0)});
    "1 UPDATE 1.2: Event 1 fading out.".yield;
	synths_out.do({|item| item.free});
	synth_freeze.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
    "1 UPDATE 1.3: Event 1 kill stage complete. Event finished.".postln;
}));

// Event: feedback
e.put("e4", Routine({
	var control, control_specs,	synths, synths_out;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 1.0], "times" -> #[10], "curves" -> #[0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5], "times" -> #[10], "curves" -> #[0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
    synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail));
    
	// add processing synths
	synths.add(Synth(\fb1, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \mul_sig, ~faderbus[4], \feedback, ~faderbus[5], \freq, ~faderbus[8]], ~grp[3], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[4][0], \out, ~gainbus, \mul_sig, ~controlbus[9], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	//synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[4][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[10], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
    "4 UPDATE 4.0: Event 4 running.".yield;

	// SHUTDOWN ///////////////////////////////////////////////////////////////
   	synths_out.do({|item| item.set(\gate, 0)});
    "4 UPDATE 4.1: Event 4 fading out.".yield;
	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	control.do({|item| item.free});
    "4 UPDATE 4.2: Event 4 kill stage complete. Event finished.".postln;
}));


)