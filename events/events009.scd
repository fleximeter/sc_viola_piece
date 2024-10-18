// File: events009.scd
// This file contains individual events starting at measure 9.

(
// EVENT 9
e.put("e9", Routine({
	var control, control_specs,	synths_freeze, synths, synths_out;
    var freeze_release_time;
    freeze_release_time = 2;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5, 0.5], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5, 0.5], "times" -> #[10, 100], "curves" -> #[0, 0]],	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
    synths_freeze = List();

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][0], \out, ~gainbus, \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[4], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));


    // 1 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["74"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "9 UPDATE 9.0: Event 9 running and ready for freeze 1 (D5).".yield;
    synths_freeze[0].set(\freeze, 1.0);
    "9 UPDATE 9.1: Event 9 freeze 1 (D5).".yield;

    // 2 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][1], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["g"]["55"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][1], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "9 UPDATE 9.2: Event 9 ready for freeze 2 (G3).".yield;
    synths_freeze[1].set(\freeze, 1.0);
    "9 UPDATE 9.3: Event 9 freeze 2 (G3).\nReady for release 1.".yield;
    synths_freeze[0].set(\gate, 0);
    "9 UPDATE 9.4: Event 9 release 1 (D5).".yield;

    // 3 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][2], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["73"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][2], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "9 UPDATE 9.5: Event 9 ready for freeze 3 (C+5).".yield;
    synths_freeze[2].set(\freeze, 1.0);
    "9 UPDATE 9.6: Event 9 freeze 3 (C+5).".yield;

    // 4 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][3], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["d"]["62"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][3], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "9 UPDATE 9.7: Event 9 ready for freeze 4 (D4).".yield;
    synths_freeze[3].set(\freeze, 1.0);
    "9 UPDATE 9.8: Event 9 freeze 4 (D4).\nReady for release 2.".yield;
    synths_freeze[1].set(\gate, 0);
    "9 UPDATE 9.9: Event 9 release 2 (G3).".yield;

    // 5 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][4], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["71"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][4], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "9 UPDATE 9.10: Event 9 ready for freeze 5 (B4).".yield;
    synths_freeze[4].set(\freeze, 1.0);
    "9 UPDATE 9.11: Event 9 freeze 5 (B4).\nReady for release 3.".yield;
    synths_freeze[2].set(\gate, 0);
    "9 UPDATE 9.12: Event 9 release 3 (C+5).".yield;

    // 6 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][5], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["d"]["63"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][5], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "9 UPDATE 9.13: Event 9 ready for freeze 6 (D+4).".yield;
    synths_freeze[5].set(\freeze, 1.0);
    "9 UPDATE 9.14: Event 9 freeze 6 (D+4).\nReady for release 4.".yield;
    synths_freeze[3].set(\gate, 0);
    "9 UPDATE 9.15: Event 9 release 4 (D4).".yield;

    // 7 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][6], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["d"]["65"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][6], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "9 UPDATE 9.16: Event 9 ready for freeze 7 (F4).".yield;
    synths_freeze[6].set(\freeze, 1.0);
    "9 UPDATE 9.17: Event 9 freeze 7 (F4).\nReady for final realeases.".yield;

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    synths_out.do({|item| item.set(\gate, 0)});
	"9 UPDATE 9.18: Event 9 final realease.".yield;

	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	synths_freeze.do({|item| item.free});
	control.do({|item| item.free});
    "9 UPDATE 9.19: Event 9 kill stage complete. Event finished.".postln;
}));

// EVENT 14
// PS DOWN
e.put("e14", Routine({
	var control, control_specs,	synths, synths_out;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5, 0.5], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5, 0.5], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail));
	synths.add(Synth(\pitchshift, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \ratio, 2/3], ~grp[2], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][0], \out, ~gainbus, \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[4], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	"14 UPDATE 14.0: Pitch shift in effect.".yield;

	synths_out.do({|item| item.set(\gate, 0)});
	"14 UPDATE 14.1: Event 14 fading out.".yield;

	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	control.do({|item| item.free});
	"14 UPDATE 14.2: Event 14 kill stage complete. Event finished.".postln;
}));


// EVENT 17 - SINGLE FREEZE
e.put("e17", Routine({
	var control, control_specs,	synth_freeze, synths, synths_out;
    var freeze_release_time;
    freeze_release_time = 2;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5, 0.5], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5, 0.5], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();

	// SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][0], \out, ~gainbus, \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[4], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));

    // 1 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["d"]["65"]["buffer"]], ~grp[1], \addToTail));
    synth_freeze = Synth(\fft_freeze, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \above, 2, \release_time, freeze_release_time], ~grp[1], \addToTail);
    "17 UPDATE 17.0: Event 17 running and ready for freeze 1 (F4).".yield;
    synth_freeze.set(\freeze, 1.0);
    "17 UPDATE 17.1: Event 17 freeze 1 (F4).".yield;
    synth_freeze.set(\gate, 0.0);
    "17 UPDATE 17.1: Event 17 freeze out.".yield;


	// SHUTDOWN ///////////////////////////////////////////////////////////////
	synths_out.do({|item| item.set(\gate, 0)});
	"17 UPDATE 17.2: Event 17 fading out.".yield;
	synths_out.do({|item| item.free});
    synths.do({|item| item.free});
	synth_freeze.free;
	control.do({|item| item.free});
    "17 UPDATE 17.3: Event 17 kill stage complete. Event finished.".postln;
}));


// EVENT 18 - DELAY
e.put("e18", Routine({
	var control, control_specs,	synth_freeze, synths, synths_out;
    var freeze_release_time;
    freeze_release_time = 2;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.9, 0.9, 0.9], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.1, 0.1, 0.1], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1], \attack_time, 0.2, \release_time, 0.2], ~grp[1], \addToTail));
	synths.add(Synth(\combdelay, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \delaytime, 1, \decaytime, 6], ~grp[1], \addToTail));

	// SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][0], \out, ~gainbus, \mul_sig, ~controlbus[2], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
    "18 UPDATE 18.0: Event 18 delay open 1.".yield;

    // 3 open/close pairs
    synths[0].set(\gate, 0);
    "18 UPDATE 18.1: Event 18 mic close 1. Ready for mic open 2.".yield;
    synths[0].set(\gate, 1);
    "18 UPDATE 18.1: Event 18 mic open 2. Ready for mic close 2.".yield;
    synths[0].set(\gate, 0);
    "18 UPDATE 18.1: Event 18 mic close 2. Ready for mic open 3.".yield;
    synths[0].set(\gate, 1);
    "18 UPDATE 18.1: Event 18 mic open 3. Ready for mic close 3.".yield;
    synths[0].set(\gate, 0);
    "18 UPDATE 18.1: Event 18 mic close 3.".yield;

	// SHUTDOWN ///////////////////////////////////////////////////////////////
	synths_out.do({|item| item.set(\gate, 0)});
	"18 UPDATE 18.2: Event 18 fading out.".yield;
	synths_out.do({|item| item.free});
    synths.do({|item| item.free});
	synth_freeze.free;
	control.do({|item| item.free});
    "18 UPDATE 18.3: Event 18 kill stage complete. Event finished.".postln;
}));


// Event 24: feedback
e.put("e24", Routine({
	var control, control_specs,	synths, synths_out;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
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

	// add processing synths
	synths.add(Synth(\fb1, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \mul_sig, ~faderbus[4], \feedback, ~faderbus[5], \freq, ~faderbus[8]], ~grp[3], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][0], \out, ~gainbus, \mul_sig, ~controlbus[2], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
    "24 UPDATE 24.0: Event 24 running.".yield;

	// SHUTDOWN ///////////////////////////////////////////////////////////////
   	synths_out.do({|item| item.set(\gate, 0)});
    "24 UPDATE 24.1: Event 24 fading out.".yield;
	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	control.do({|item| item.free});
    "24 UPDATE 24.2: Event 24 kill stage complete. Event finished.".postln;
}));

)