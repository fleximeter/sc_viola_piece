// File: events105.scd
// This file contains individual events starting at measure 105.

(
// EVENT 105
e.put("e105", Routine({
	var control, control_specs,	synth_freeze, synths, synths_out;
    var freeze_release_time;
    freeze_release_time = 2;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 0.5, 0.0, 0.0, 0.5, 0.0, 0.8, 0.5, 1.0, 0.2, 0.0], "times" -> #[3, 3, 1, 3, 5, 4, 4, 8, 5, 4], "curves" -> #[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.8, 0.5, 0.8, 0.3], "times" -> #[10, 10, 10, 10], "curves" -> #[0, 0, 0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.2, 0.5, 0.2, 0.7], "times" -> #[10, 10, 10, 10], "curves" -> #[0, 0, 0, 0]],
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
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][0], \out, ~audiobus[1][1], \mul_sig, ~controlbus[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][1], \out, ~gainbus, \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));


    // 1 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["ff"]["c"]["48"]["buffer"]], ~grp[1], \addToTail));
    synth_freeze = Synth(\fft_freeze, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \above, 1.5, \release_time, freeze_release_time, \mul, 0.5], ~grp[1], \addToTail);
    "105 UPDATE 105.0: Event 105 running and ready for freeze (C3).".yield;
    synth_freeze.set(\freeze, 1.0);
    "105 UPDATE 105.1: Event 105 freeze (C3).".yield;


	// SHUTDOWN ///////////////////////////////////////////////////////////////
    synths_out.do({|item| item.set(\gate, 0)});
	"105 UPDATE 105.18: Event 105 final realease.".yield;

	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	synth_freeze.free;
	control.do({|item| item.free});
    "105 UPDATE 105.19: Event 105 kill stage complete. Event finished.".postln;
}));

// EVENT 128 - FAST PITCH SHIFT UP
e.put("e128", Routine({
	var control, control_specs,	synths, synth_freeze, synths_out;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "pitch_shift", "levels" -> #[0.0, 0.5, 8.0], "times" -> #[0.5, 4.5], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 0.5, 0.1, 0.0, 0.0], "times" -> #[3, 2, 0.3, 5], "curves" -> #[0, 0, 0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.8, 0.8, 0.8], "times" -> #[10, 10], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.2, 0.2, 0.2], "times" -> #[10, 10], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
   	synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail));
    // freeze
    synth_freeze = Synth(\fft_freeze, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \above, 3, \amp_fluctuation, 0.1], ~grp[1], \addToTail);
    synths.add(Synth(\pitchshift1_et, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \semitones, ~controlbus[2] ], ~grp[1], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[2][0], \out, ~audiobus[2][1], \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[2][1], \out, ~gainbus, \mul_sig, ~controlbus[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[2][1], \out, ~reverbbus[0], \mul_sig, ~controlbus[5], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "128 UPDATE 128.0: Event 128 running and ready for freeze.".yield;
    synth_freeze.set(\freeze, 1.0);
    "128 UPDATE 128.1: Event 128 freeze.".yield;
    
	// SHUTDOWN ///////////////////////////////////////////////////////////////
    synths_out.do({|item| item.set(\gate, 0)});
	"128 UPDATE 128.2: Event 128 final realease.".yield;

	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
    synth_freeze.free;
	control.do({|item| item.free});
    "128 UPDATE 128.3: Event 128 kill stage complete. Event finished.".postln;
}));


)