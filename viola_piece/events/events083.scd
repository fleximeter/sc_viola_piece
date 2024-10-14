// File: events083.scd
// This file contains individual events starting at measure 83.

(
// EVENT 83
e.put("e83", Routine({
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
    "83 UPDATE 83.0: Event 83 running and ready for freeze 1 (D5).".yield;
    synths_freeze[0].set(\freeze, 1.0);
    "83 UPDATE 83.1: Event 83 freeze 1 (D5).".yield;

    // 2 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][1], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["g"]["55"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][1], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "83 UPDATE 83.2: Event 83 ready for freeze 2 (G3).".yield;
    synths_freeze[1].set(\freeze, 1.0);
    "83 UPDATE 83.3: Event 83 freeze 2 (G3).".yield;

    // 3 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][2], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["d"]["65"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][2], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "83 UPDATE 83.5: Event 83 ready for freeze 3 (F4).".yield;
    synths_freeze[2].set(\freeze, 1.0);
    "83 UPDATE 83.6: Event 83 freeze 3 (F4).".yield;

    // 4 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][3], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["72"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][3], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "83 UPDATE 83.7: Event 83 ready for freeze 4 (C5).".yield;
    synths_freeze[3].set(\freeze, 1.0);
    "83 UPDATE 83.8: Event 83 freeze 4 (C5).\nReady for release 1-4.".yield;
    synths_freeze[0].set(\gate, 0);
    synths_freeze[1].set(\gate, 0);
    synths_freeze[2].set(\gate, 0);
    synths_freeze[3].set(\gate, 0);
    "83 UPDATE 83.4: Event 83 release 1-4.".yield;

    // 5 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][4], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["77"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][4], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "83 UPDATE 83.10: Event 83 ready for freeze 5 (F5).".yield;
    synths_freeze[4].set(\freeze, 1.0);
    "83 UPDATE 83.11: Event 83 freeze 5 (F5).".yield;

    // 6 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][5], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["74"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][5], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "83 UPDATE 83.13: Event 83 ready for freeze 6 (D5).".yield;
    synths_freeze[5].set(\freeze, 1.0);
    "83 UPDATE 83.14: Event 83 freeze 6 (D5).".yield;

    // 7 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][6], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["d"]["67"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][6], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "83 UPDATE 83.16: Event 83 ready for freeze 7 (G4).".yield;
    synths_freeze[6].set(\freeze, 1.0);
    "83 UPDATE 83.17: Event 83 freeze 7 (G4).\nReady for release 5.".yield;
    synths_freeze[4].set(\gate, 0);
    "83 UPDATE 83.4: Event 83 release 5.".yield;

    // 8 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][6], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["76"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][6], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "83 UPDATE 83.16: Event 83 ready for freeze 8 (E5).".yield;
    synths_freeze[7].set(\freeze, 1.0);
    "83 UPDATE 83.17: Event 83 freeze 8 (E5).\nReady for realease 6-8.".yield;
    synths_freeze[5].set(\gate, 0);
    synths_freeze[6].set(\gate, 0);
    synths_freeze[7].set(\gate, 0);
    "83 UPDATE 83.4: Event 83 release 6-8.".yield;

    // 9 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][6], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["81"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][6], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "83 UPDATE 83.16: Event 83 ready for freeze 9 (A5).".yield;
    synths_freeze[8].set(\freeze, 1.0);
    "83 UPDATE 83.17: Event 83 freeze 9 (A5).".yield;

    // 10 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][6], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["76"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][6], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "83 UPDATE 83.16: Event 83 ready for freeze 10 (E5).".yield;
    synths_freeze[9].set(\freeze, 1.0);
    "83 UPDATE 83.17: Event 83 freeze 10 (E5).\nReady for realease 9.".yield;
    synths_freeze[8].set(\gate, 0);
    "83 UPDATE 83.4: Event 83 release 9.".yield;

    // 11 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][6], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["77"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][6], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "83 UPDATE 83.16: Event 83 ready for freeze 11 (F5).".yield;
    synths_freeze[10].set(\freeze, 1.0);
    "83 UPDATE 83.17: Event 83 freeze 11 (F5).".yield;

    // 12 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][6], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["d"]["67"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][6], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "83 UPDATE 83.16: Event 83 ready for freeze 12 (G4).".yield;
    synths_freeze[11].set(\freeze, 1.0);
    "83 UPDATE 83.17: Event 83 freeze 12 (G4).\nReady for realease 9-10.".yield;
	synths_freeze[9].set(\gate, 0);
	synths_freeze[10].set(\gate, 0);
    "83 UPDATE 83.4: Event 83 release 10-11. Ready for release 12".yield;
	synths_freeze[11].set(\gate, 0);
    "83 UPDATE 83.4: Event 83 release 12.".yield;


    // 13 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][6], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["74"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][6], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "83 UPDATE 83.16: Event 83 ready for freeze 13 (D5).".yield;
    synths_freeze[12].set(\freeze, 1.0);
    "83 UPDATE 83.17: Event 83 freeze 13 (D5).\nReady for final realeases.".yield;

    // 14 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][6], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["76"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][6], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "83 UPDATE 83.16: Event 83 ready for freeze 14 (E5).".yield;
    synths_freeze[13].set(\freeze, 1.0);
    "83 UPDATE 83.17: Event 83 freeze 14 (E5).\nReady for realease 13.".yield;
	synths_freeze[12].set(\gate, 0);
    "83 UPDATE 83.4: Event 83 release 13. Ready for release 14 (final).".yield;
	synths_freeze[13].set(\gate, 0);
    "83 UPDATE 83.4: Event 83 release 14 (final).".yield;

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    synths_out.do({|item| item.set(\gate, 0)});
	"83 UPDATE 83.18: Event 83 final realease.".yield;

	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	synths_freeze.do({|item| item.free});
	control.do({|item| item.free});
    "83 UPDATE 9.19: Event 9 kill stage complete. Event finished.".postln;
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
	synths.add(Synth(\from8to8, [\in, ~audiobus[1][0], \out, ~gainbus], ~grp[5], \addToTail));

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


// EVENT 18
e.put("e18", Routine({
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
    "18 UPDATE 18.0: Event 18 running and ready for freeze 1 (F4).".yield;
    synth_freeze.set(\freeze, 1.0);
    "18 UPDATE 18.1: Event 18 freeze 1 (F4).".yield;


	// SHUTDOWN ///////////////////////////////////////////////////////////////
	synths_out.do({|item| item.set(\gate, 0)});
	"18 UPDATE 18.2: Event 18 fading out.".yield;
	synths_out.do({|item| item.free});
    synths.do({|item| item.free});
	synth_freeze.free;
	control.do({|item| item.free});
    "18 UPDATE 18.3: Event 18 kill stage complete. Event finished.".postln;
}));


// EVENT 19 - DELAY
e.put("e19", Routine({
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
	synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail));
	synths.add(Synth(\combdelay, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \delaytime, 1, \decaytime, 6], ~grp[1], \addToTail));

	// SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][0], \out, ~gainbus, \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[4], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
    "19 UPDATE 19.0: Event 19 delay open.".yield;


	// SHUTDOWN ///////////////////////////////////////////////////////////////
    synths[0].set(\gate, 0);
    "19 UPDATE 19.1: Event 19 mic close.".yield;

	synths_out.do({|item| item.set(\gate, 0)});
	"19 UPDATE 19.2: Event 19 fading out.".yield;
	synths_out.do({|item| item.free});
    synths.do({|item| item.free});
	synth_freeze.free;
	control.do({|item| item.free});
    "19 UPDATE 19.3: Event 19 kill stage complete. Event finished.".postln;
}));


)