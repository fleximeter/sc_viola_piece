// File: events047.scd
// This file contains individual events starting at measure 47.

(

// EVENT 47
// PS DOWN
e.put("e47", Routine({
	var control, control_specs,	synths, synths_out;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
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
    synths.add(Synth(\pitchshift, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[2][0], \ratio, 2], ~grp[2], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[2][0], \out, ~audiobus_grp1[2][1], \mul_sig, ~controlbus_grp1[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[2][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.5], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[2][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.5], ~grp[4], \addToTail));
    "47 UPDATE 47.0: Pitch shift in effect.".yield;
    
	synths_out.do({|item| item.set(\gate, 0)});
	"47 UPDATE 47.1: Event 47 fading out.".yield;

	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	control.do({|item| item.free});
	"47 UPDATE 47.2: Event 47 kill stage complete. Event finished.".postln;
}));

// EVENT 48
// SAMPLES
e.put("e48", Routine({
	var control, control_specs, roll_time, synths, synths_out;
    roll_time = 0.08;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.9, 0.9, 0.9], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.1, 0.1, 0.1], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[0][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "48 UPDATE 48.0: Playing samples.".postln;
    
	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp2[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.pizz"]["ff"]["a"]["89"]["buffer"], \dur, 1, \release_time, 0.2], ~grp[1], \addToTail));
    roll_time.wait;
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp2[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.pizz"]["ff"]["a"]["77"]["buffer"], \dur, 1, \release_time, 0.2], ~grp[1], \addToTail));
    roll_time.wait;
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp2[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.pizz"]["ff"]["d"]["65"]["buffer"], \dur, 1, \release_time, 0.2], ~grp[1], \addToTail));
    roll_time.wait;
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp2[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.pizz"]["ff"]["c"]["53"]["buffer"], \dur, 1, \release_time, 0.2], ~grp[1], \addToTail));
    
    1.5.wait;

	synths_out.do({|item| item.set(\gate, 0)});
	"48 UPDATE 48.1: Event 48 fading out.".postln;
    
    1.wait;
	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	control.do({|item| item.free});
	"48 UPDATE 48.2: Event 48 kill stage complete. Event finished.".postln;
}));


// EVENT 51
// SAMPLES
e.put("e51", Routine({
	var control, control_specs, roll_time, synths, synths_out;
    roll_time = 0.08;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.9, 0.9, 0.9], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.1, 0.1, 0.1], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus_grp3[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[0][0], \out, ~audiobus_grp3[0][1], \mul_sig, ~controlbus_grp3[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp3[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp3[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "51 UPDATE 51.0: Playing samples.".postln;
    
	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp3[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.pizz"]["ff"]["a"]["89"]["buffer"], \dur, 1, \release_time, 0.2], ~grp[1], \addToTail));
    roll_time.wait;
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp3[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.pizz"]["ff"]["a"]["77"]["buffer"], \dur, 1, \release_time, 0.2], ~grp[1], \addToTail));
    roll_time.wait;
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp3[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.pizz"]["ff"]["d"]["65"]["buffer"], \dur, 1, \release_time, 0.2], ~grp[1], \addToTail));
    roll_time.wait;
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp3[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.pizz"]["ff"]["c"]["53"]["buffer"], \dur, 1, \release_time, 0.2], ~grp[1], \addToTail));
    
    1.5.wait;

	synths_out.do({|item| item.set(\gate, 0)});
	"51 UPDATE 51.1: Event 51 fading out.".postln;
    
    1.wait;
	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	control.do({|item| item.free});
	"51 UPDATE 51.2: Event 51 kill stage complete. Event finished.".postln;
}));

// EVENT 54
// SAMPLES
e.put("e54", Routine({
	var control, control_specs, between_time, synths, synths_out;
    between_time = 60/108;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.9, 0.9, 0.9], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.1, 0.1, 0.1], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[0][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "54 UPDATE 54.0: Playing samples.".postln;
    
	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp2[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["other"]["eee_loop"]["buffer"], \dur, 1, \release_time, 0.2], ~grp[1], \addToTail));
    between_time.wait;
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp2[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["other"]["eee_loop"]["buffer"], \dur, 1, \release_time, 0.2], ~grp[1], \addToTail));
    between_time.wait;
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp2[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["other"]["eee_loop"]["buffer"], \dur, 1, \release_time, 0.2], ~grp[1], \addToTail));
    between_time.wait;
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp2[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["other"]["eee"]["buffer"], \dur, 3, \release_time, 0.2], ~grp[1], \addToTail));
    
    2.wait;

	synths_out.do({|item| item.set(\gate, 0)});
	"54 UPDATE 54.1: Event 54 fading out.".postln;
    
    1.wait;
	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	control.do({|item| item.free});
	"54 UPDATE 54.2: Event 54 kill stage complete. Event finished.".postln;
}));

// EVENT 58
// SAMPLES
e.put("e58", Routine({
	var control, control_specs, between_time, synths, synths_out;
    between_time = 60/108;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.9, 0.9, 0.9], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.1, 0.1, 0.1], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus_grp3[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[0][0], \out, ~audiobus_grp3[0][1], \mul_sig, ~controlbus_grp3[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp3[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp3[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp3[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "58 UPDATE 58.0: Playing samples.".postln;
    
	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp3[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["other"]["eee_loop"]["buffer"], \dur, 1, \release_time, 0.2], ~grp[1], \addToTail));
    between_time.wait;
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp3[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["other"]["eee_loop"]["buffer"], \dur, 1, \release_time, 0.2], ~grp[1], \addToTail));
    between_time.wait;
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp3[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["other"]["eee_loop"]["buffer"], \dur, 1, \release_time, 0.2], ~grp[1], \addToTail));
    between_time.wait;
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp3[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["other"]["eee"]["buffer"], \dur, 3, \release_time, 0.2], ~grp[1], \addToTail));
    
    2.wait;

	synths_out.do({|item| item.set(\gate, 0)});
	"58 UPDATE 58.1: Event 58 fading out.".postln;
    
    1.wait;
	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	control.do({|item| item.free});
	"58 UPDATE 58.2: Event 58 kill stage complete. Event finished.".postln;
}));

// EVENT 60 - DELAY
e.put("e60", Routine({
	var control, control_specs,	synth_freeze, synths, synths_out;
    var freeze_release_time;
    freeze_release_time = 2;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
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
	synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus_grp2[0][0], \pos, ~controlbus_grp2[0], \width, ~controlbus_grp2[1], \attack_time, 0.2, \release_time, 0.2], ~grp[1], \addToTail));
	synths.add(Synth(\combdelay, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[1][0], \delaytime, 1, \decaytime, 6], ~grp[1], \addToTail));

	// SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][0], \out, ~audiobus_grp2[1][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "60 UPDATE 60.0: Event 60 delay open.".yield;

    synths[0].set(\gate, 0);
    "60 UPDATE 60.1: Event 60 mic close.".yield;

	// SHUTDOWN ///////////////////////////////////////////////////////////////
	synths_out.do({|item| item.set(\gate, 0)});
	"60 UPDATE 60.2: Event 60 fading out.".yield;
	synths_out.do({|item| item.free});
    synths.do({|item| item.free});
	synth_freeze.free;
	control.do({|item| item.free});
    "60 UPDATE 60.3: Event 60 kill stage complete. Event finished.".postln;
}));

// EVENT 62
// SAMPLES
e.put("e62", Routine({
	var control, control_specs, synths, synths_out;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.9, 0.9, 0.9], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.1, 0.1, 0.1], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus_grp1[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[0][1], \mul_sig, ~controlbus_grp1[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "62 UPDATE 62.0: Playing sample.".postln;
    
	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp1[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.pizz"]["ff"]["a"]["74"]["buffer"], \dur, 1, \release_time, 0.2], ~grp[1], \addToTail));  
    1.5.wait;

	synths_out.do({|item| item.set(\gate, 0)});
	"62 UPDATE 62.1: Event 62 fading out.".postln;
    
    1.wait;
	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	control.do({|item| item.free});
	"62 UPDATE 62.2: Event 62 kill stage complete. Event finished.".postln;
}));


// EVENT 63
// SAMPLES
e.put("e63", Routine({
	var control, control_specs, synths, synths_out;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.9, 0.9, 0.9], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.1, 0.1, 0.1], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[0][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "63 UPDATE 63.0: Playing sample.".postln;
    
	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp2[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.pizz"]["ff"]["a"]["74"]["buffer"], \dur, 1, \release_time, 0.2], ~grp[1], \addToTail));  
    1.5.wait;

	synths_out.do({|item| item.set(\gate, 0)});
	"63 UPDATE 63.1: Event 63 fading out.".postln;
    
    1.wait;
	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	control.do({|item| item.free});
	"63 UPDATE 63.2: Event 63 kill stage complete. Event finished.".postln;
}));

// EVENT 64
// SAMPLES
e.put("e64", Routine({
	var control, control_specs, synths, synths_out;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.9, 0.9, 0.9], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.1, 0.1, 0.1], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[0][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "64 UPDATE 64.0: Playing sample.".postln;
    
	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
    synths.add(Synth(\sampler_env, [\out, ~audiobus_grp2[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.pizz"]["ff"]["a"]["74"]["buffer"], \dur, 1, \release_time, 0.2], ~grp[1], \addToTail));  
    1.5.wait;

	synths_out.do({|item| item.set(\gate, 0)});
	"64 UPDATE 64.1: Event 64 fading out.".postln;
    
    1.wait;
	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	control.do({|item| item.free});
	"64 UPDATE 64.2: Event 64 kill stage complete. Event finished.".postln;
}));

// event 65: freeze
// send this to a bus that 65b can read from
e.put("e65a", Routine({
	var control, control_specs,	synth_freeze, synths, synths_out;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[20, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_below", "levels" -> #[30, 3, 3], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift1", "levels" -> #[5.0, 3.0, 3.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift2", "levels" -> #[0, -0.5, -0.5], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pan_pos1", "levels" -> #[2.0, 1.5, 1.5], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pan_width1", "levels" -> #[2.0, 3.0, 3.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pan_pos2", "levels" -> #[0.0, 0.5, 0.5], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pan_width2", "levels" -> #[2.0, 3.0, 3.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_lpf", "levels" -> #[10000, 440, 440], "times" -> #[10, 100], "curves" -> #[0, 0]],
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
	synths.add(Synth(\sampler_pan, [\out, ~audiobus_grp1[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["74"]["buffer"]], ~grp[1], \addToTail));
    synth_freeze = Synth(\fft_freeze, [\in, ~audiobus_grp1[0][0], \out, ~audiobus_grp1[1][0], \above, 1, \amp_fluctuation, 0.1], ~grp[1], \addToTail);
    
	// SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][0], \out, ~audiobus_grp1[1][1], \mul_sig, ~controlbus_grp1[10], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp1[11], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp1[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp1[12], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "65a UPDATE 65a.0: Event 65a running and ready for freeze.".yield;

    synth_freeze.set(\freeze, 1.0);
    "65a UPDATE 65a.1: Event 65a freeze.".yield;
	synths_out.do({|item| item.set(\gate, 0)});
    "65a UPDATE 65a.2: Event 65a fading out.".yield;
	synths_out.do({|item| item.free});
	synth_freeze.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
    "65a UPDATE 65a.3: Event 65a kill stage complete. Event finished.".postln;
}));

// Event 65b: feedback
e.put("e65b", Routine({
	var control, control_specs,	synths, synths_out;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0, 0.0], "times" -> #[10, 40], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0, 4.0], "times" -> #[10, 40], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_dry_gain", "levels" -> #[1.0, 0.5, 0.5], "times" -> #[10, 40], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.0, 0.5, 0.5], "times" -> #[10, 40], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus_grp2[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
    synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus_grp2[0][0], \pos, ~controlbus_grp2[0], \width, ~controlbus_grp2[1]], ~grp[1], \addToTail));

	// add processing synths
	synths.add(Synth(\fb1, [\in, ~audiobus_grp2[0][0], \out, ~audiobus_grp2[1][0], \mul_sig, ~faderbus[4], \feedback, ~faderbus[5], \freq, ~faderbus[8]], ~grp[2], \addToTail));

    // SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][0], \out, ~audiobus_grp2[1][1], \mul_sig, ~controlbus_grp2[2], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~gainbus, \mul_sig, ~controlbus_grp2[3], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus_grp2[1][1], \out, ~reverbbus[0], \mul_sig, ~controlbus_grp2[4], \attack_time, 0.01, \release_time, 0.1], ~grp[4], \addToTail));
    "65b UPDATE 65b.0: Event 65b running.".yield;

	// SHUTDOWN ///////////////////////////////////////////////////////////////
   	synths_out.do({|item| item.set(\gate, 0)});
    "65b UPDATE 65b.1: Event 65b fading out.".yield;
	synths_out.do({|item| item.free});
	synths.do({|item| item.free});
	control.do({|item| item.free});
    "65b UPDATE 65b.2: Event 65b kill stage complete. Event finished.".postln;
}));


)