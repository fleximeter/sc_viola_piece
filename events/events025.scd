// File: events025.scd
// This file contains individual events starting at measure 25.

(
// EVENT 25
e.put("e25", Routine({
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
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][0], \out, ~gainbus, \mul_sig, ~controlbus[2], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));

    // 1 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["74"]["buffer"]], ~grp[1], \addToTail));
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][1], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["74"]["buffer"]], ~grp[1], \addToTail));
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][2], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["74"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \above, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \above, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \above, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "25 UPDATE 25.0: Event 25 running and ready for freeze 1 (D5).".yield;
    synths_freeze[0].set(\freeze, 1.0);
    "25 UPDATE 25.1: Event 25 freeze 1 (D5).".yield;

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    synths_out.do({|item| item.set(\gate, 0)});
	"25 UPDATE 25.2: Event 25 final realease.".yield;

	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	synths_freeze.do({|item| item.free});
	control.do({|item| item.free});
    "25 UPDATE 25.3: Event 25 kill stage complete. Event finished.".postln;
}));

// EVENT 28
e.put("e28", Routine({
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
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][0], \out, ~gainbus, \mul_sig, ~controlbus[2], \attack_time, 0.01, \release_time, 3], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 3], ~grp[5], \addToTail));


    // 1 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["d"]["65"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \above, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "28 UPDATE 28.0: Event 28 running and ready for freeze 1 (F4).".yield;
    synths_freeze[0].set(\freeze, 1.0);
    "28 UPDATE 28.1: Event 28 freeze 1 (F4).".yield;

    // 2 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][1], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["g"]["55"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][1], \out, ~audiobus[1][0], \above, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "28 UPDATE 28.2: Event 28 ready for freeze 2 (G3).".yield;
    synths_freeze[1].set(\freeze, 1.0);
    "28 UPDATE 28.3: Event 28 freeze 2 (G3).".yield;

    // 3 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][2], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["d"]["64"]["buffer"]], ~grp[1], \addToTail));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][2], \out, ~audiobus[1][0], \above, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "28 UPDATE 28.4: Event 28 ready for freeze 3 (E4).".yield;
    synths_freeze[2].set(\freeze, 1.0);
    "28 UPDATE 28.5: Event 28 freeze 3 (E4).".yield;

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    synths_out.do({|item| item.set(\gate, 0)});
	"28 UPDATE 28.6: Event 28 final realease.".yield;

	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	synths_freeze.do({|item| item.free});
	control.do({|item| item.free});
    "28 UPDATE 28.7: Event 28 kill stage complete. Event finished.".postln;
}));

// EVENT 31
// PS UP, SAMPLE
e.put("e31", Routine({
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
    synths.add(Synth(\sampler_env, [\out, ~audiobus[2][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["g"]["55"]["buffer"], \dur, 60/108, \release_time, 0.2], ~grp[1], \addToTail));
    synths.add(Synth(\sampler_env, [\out, ~audiobus[2][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["d"]["64"]["buffer"], \dur, 60/108, \release_time, 0.2], ~grp[1], \addToTail));
    synths.add(Synth(\sampler_env, [\out, ~audiobus[2][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["d"]["65"]["buffer"], \dur, 60/108, \release_time, 0.2], ~grp[1], \addToTail));
	synths.add(Synth(\passthrough8, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \attack_time, 0.01, \release_time, 0.5], ~grp[2], \addToTail));
    synths.add(Synth(\pitchshift, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \ratio, 2], ~grp[3], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[2][0], \out, ~gainbus, \mul_sig, ~controlbus[2], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[2][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
    "31 UPDATE 31.0: Pitch shift in effect.".yield;
    synths[4].set(\gate, 0);
    synths.add(Synth(\sampler_env, [\out, ~audiobus[2][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["g"]["55"]["buffer"], \dur, 60/108, \release_time, 0.2], ~grp[1], \addToTail));
    synths.add(Synth(\sampler_env, [\out, ~audiobus[2][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["d"]["64"]["buffer"], \dur, 60/108, \release_time, 0.2], ~grp[1], \addToTail));
    synths.add(Synth(\sampler_env, [\out, ~audiobus[2][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["d"]["65"]["buffer"], \dur, 60/108, \release_time, 0.2], ~grp[1], \addToTail));
    "31 UPDATE 31.0: Pitch shift closed, second chord playing.".yield;    

	synths_out.do({|item| item.set(\gate, 0)});
	"31 UPDATE 31.1: Event 31 fading out.".yield;

	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	control.do({|item| item.free});
	"31 UPDATE 31.2: Event 31 kill stage complete. Event finished.".postln;
}));

// EVENT 33
// PS UP
e.put("e33", Routine({
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
    synths.add(Synth(\pitchshift, [\in, ~audiobus[0][0], \out, ~audiobus[2][0], \ratio, 2], ~grp[3], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[2][0], \out, ~gainbus, \mul_sig, ~controlbus[2], \attack_time, 0.01, \release_time, 0.5], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[2][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.5], ~grp[5], \addToTail));
    "33 UPDATE 33.0: Pitch shift in effect.".yield;
    
	synths_out.do({|item| item.set(\gate, 0)});
	"33 UPDATE 33.1: Event 33 fading out.".yield;

	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	control.do({|item| item.free});
	"33 UPDATE 33.2: Event 33 kill stage complete. Event finished.".postln;
}));

// EVENT 35 - DELAY
e.put("e35", Routine({
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
	synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1], \attack_time, 0.2, \release_time, 0.2], ~grp[1], \addToTail));
	synths.add(Synth(\combdelay, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \delaytime, 1, \decaytime, 6], ~grp[1], \addToTail));

	// SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][0], \out, ~gainbus, \mul_sig, ~controlbus[2], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[1][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
    "35 UPDATE 35.0: Event 35 delay open 1.".yield;

    // 3 open/close pairs
    synths[0].set(\gate, 0);
    "35 UPDATE 35.1: Event 35 mic close 1. Ready for mic open 2.".yield;
    synths[0].set(\gate, 1);
    "35 UPDATE 35.1: Event 35 mic open 2. Ready for mic close 2.".yield;
    synths[0].set(\gate, 0);
    "35 UPDATE 35.1: Event 35 mic close 2.".yield;

	// SHUTDOWN ///////////////////////////////////////////////////////////////
	synths_out.do({|item| item.set(\gate, 0)});
	"35 UPDATE 35.2: Event 35 fading out.".yield;
	synths_out.do({|item| item.free});
    synths.do({|item| item.free});
	synth_freeze.free;
	control.do({|item| item.free});
    "35 UPDATE 35.3: Event 35 kill stage complete. Event finished.".postln;
}));


// EVENT 41
// SAMPLE
e.put("e41", Routine({
	var control, control_specs,	synths, synths_out;

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
    synths.add(Synth(\sampler_env, [\out, ~audiobus[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["other"]["ede"]["buffer"], \dur, 2, \release_time, 0.2], ~grp[1], \addToTail));
    
    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][0], \out, ~gainbus, \mul_sig, ~controlbus[2], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
    "41 UPDATE 41.0: Playing sample.".postln;
    1.5.wait;

	synths_out.do({|item| item.set(\gate, 0)});
	"41 UPDATE 41.1: Event 41 fading out.".postln;
    
    1.wait;
	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	control.do({|item| item.free});
	"41 UPDATE 41.2: Event 41 kill stage complete. Event finished.".postln;
}));

// EVENT 42
// SAMPLE
e.put("e42", Routine({
	var control, control_specs,	synths, synths_out;

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
    synths.add(Synth(\sampler_env, [\out, ~audiobus[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["other"]["ede"]["buffer"], \dur, 2, \release_time, 0.2], ~grp[1], \addToTail));
    
    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][0], \out, ~gainbus, \mul_sig, ~controlbus[2], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
    "42 UPDATE 42.0: Playing sample.".postln;
    1.5.wait;

	synths_out.do({|item| item.set(\gate, 0)});
	"42 UPDATE 42.1: Event 42 fading out.".postln;
    
    1.wait;
	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	control.do({|item| item.free});
	"42 UPDATE 42.2: Event 42 kill stage complete. Event finished.".postln;
}));

// EVENT 43
// SAMPLE
e.put("e43", Routine({
	var control, control_specs,	synths, synths_out;

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
    synths.add(Synth(\sampler_env, [\out, ~audiobus[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["other"]["ede"]["buffer"], \dur, 2, \release_time, 0.2], ~grp[1], \addToTail));
    
    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][0], \out, ~gainbus, \mul_sig, ~controlbus[2], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
    "43 UPDATE 43.0: Playing sample.".postln;
    1.5.wait;

	synths_out.do({|item| item.set(\gate, 0)});
	"43 UPDATE 43.1: Event 43 fading out.".postln;
    
    1.wait;
	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	control.do({|item| item.free});
	"43 UPDATE 43.2: Event 43 kill stage complete. Event finished.".postln;
}));

// EVENT 44
// SAMPLE
e.put("e44", Routine({
	var control, control_specs,	synths, synths_out;

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
    synths.add(Synth(\sampler_env, [\out, ~audiobus[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["other"]["ede"]["buffer"], \dur, 2, \release_time, 0.2], ~grp[1], \addToTail));
    
    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][0], \out, ~gainbus, \mul_sig, ~controlbus[2], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
    "44 UPDATE 44.0: Playing sample.".postln;
    1.5.wait;

	synths_out.do({|item| item.set(\gate, 0)});
	"44 UPDATE 44.1: Event 44 fading out.".postln;
    
    1.wait;
	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	control.do({|item| item.free});
	"44 UPDATE 44.2: Event 44 kill stage complete. Event finished.".postln;
}));



// Event 45: feedback
e.put("e45", Routine({
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
    "45 UPDATE 45.0: Event 45 running.".yield;

	// SHUTDOWN ///////////////////////////////////////////////////////////////
   	synths_out.do({|item| item.set(\gate, 0)});
    "45 UPDATE 45.1: Event 45 fading out.".yield;
	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	control.do({|item| item.free});
    "45 UPDATE 45.2: Event 45 kill stage complete. Event finished.".postln;
}));



)