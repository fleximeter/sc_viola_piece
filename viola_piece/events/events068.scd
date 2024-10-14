// File: events068.scd
// This file contains individual events starting at measure 68.

(

// EVENT 68 - PATTERN
// This event is meant to be played automatically, not stepped through.
e.put("e68", Routine({
	var control, control_specs,	patterns, synth_freeze, synths, synths_out, tempo_clock;
    var freeze_release_time;
    freeze_release_time = 2;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.95, 0.95, 0.95], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.05, 0.05, 0.05], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// the samples to play
	patterns = List();
	patterns.add(Pbind(\instrument, \sampler_adsr,
		\buf, Pseq([
			~samples["viola.pizz"]["ff"]["d"]["62"]["buffer"],
			~samples["viola.pizz"]["ff"]["d"]["62"]["buffer"],
			~samples["viola.pizz"]["ff"]["d"]["62"]["buffer"],
		], 3),
		\pan_mode, 1,
		\pos, Pwhite(-0.4, 0.4, inf),
		\out, ~audiobus[0][0],
		\mul, 0.25,
		\dur, Pseq([0.5], 3),
		\group, ~grp[1],
		\addAction, \addToTail,
	));
	patterns.add(Pbind(\instrument, \sampler_adsr,
		\buf, Pseq([
			~samples["viola.pizz"]["ff"]["g"]["62"]["buffer"],
			~samples["viola.pizz"]["ff"]["g"]["59"]["buffer"],
			~samples["viola.pizz"]["ff"]["g"]["57"]["buffer"],
		], 3),
		\pan_mode, 1,
		\pos, Pwhite(-0.4, 0.4, inf),
		\out, ~audiobus[0][0],
		\mul, 0.25,
		\dur, Pseq([0.5], 3),
		\group, ~grp[1],
		\addAction, \addToTail,
	));

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();

	// SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][0], \out, ~gainbus, \mul_sig, ~controlbus[2], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));

	tempo_clock = TempoClock(96/60);
	patterns.do{|pattern| pattern.play(tempo_clock, quant: 1)};
    "68 UPDATE 68.0: Event 68 pattern start.".postln;
	4.wait;

	// SHUTDOWN ///////////////////////////////////////////////////////////////
	synths_out.do({|item| item.set(\gate, 0)});
	"68 UPDATE 68.1: Event 68 fading out.".postln;
	2.wait;
	tempo_clock.free;
	synths_out.do({|item| item.free});
    synths.do({|item| item.free});
	synth_freeze.free;
	control.do({|item| item.free});
    "68 UPDATE 68.2: Event 68 kill stage complete. Event finished.".postln;
}));


// EVENT 69 - PATTERN
// This event is meant to be played automatically, not stepped through.
e.put("e69", Routine({
	var control, control_specs,	patterns, synth_freeze, synths, synths_out, tempo_clock;
    var freeze_release_time;
    freeze_release_time = 2;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.95, 0.95, 0.95], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.05, 0.05, 0.05], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// the samples to play
	patterns = List();
	patterns.add(Pbind(\instrument, \sampler_adsr,
		\buf, Pseq([
			~samples["viola.pizz"]["ff"]["d"]["62"]["buffer"],
			~samples["viola.pizz"]["ff"]["d"]["62"]["buffer"],
			~samples["viola.pizz"]["ff"]["d"]["62"]["buffer"],
		], 1),
		\pan_mode, 1,
		\pos, Pwhite(-0.4, 0.4, inf),
		\out, ~audiobus[0][1],
		\mul, 0.25,
		\dur, Pseq([Rest(0.5), 0.5, 0.5], 1),
		\group, ~grp[1],
		\addAction, \addToTail,
	));
	patterns.add(Pbind(\instrument, \sampler_adsr,
		\buf, Pseq([
			~samples["viola.pizz"]["ff"]["g"]["55"]["buffer"],
			~samples["viola.pizz"]["ff"]["g"]["57"]["buffer"],
			~samples["viola.pizz"]["ff"]["g"]["62"]["buffer"],
		], 1),
		\transpose, Pseq([1, 1, -0.5.midiratio], 1),
		\pan_mode, 1,
		\pos, Pwhite(-0.4, 0.4, inf),
		\out, ~audiobus[0][1],
		\mul, 0.25,
		\dur, Pseq([0.5], 3),
		\group, ~grp[1],
		\addAction, \addToTail,
	));

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();

	// SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][1], \out, ~gainbus, \mul_sig, ~controlbus[2], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][1], \out, ~reverbbus[0], \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));

	tempo_clock = TempoClock(96/60);
	patterns.do{|pattern| pattern.play(tempo_clock, quant: 1)};
    "69 UPDATE 69.0: Event 69 pattern start.".postln;
	4.wait;

	// SHUTDOWN ///////////////////////////////////////////////////////////////
	synths_out.do({|item| item.set(\gate, 0)});
	"69 UPDATE 69.1: Event 69 fading out.".postln;
	2.wait;
	tempo_clock.free;
	synths_out.do({|item| item.free});
    synths.do({|item| item.free});
	synth_freeze.free;
	control.do({|item| item.free});
    "69 UPDATE 69.2: Event 69 kill stage complete. Event finished.".postln;
}));


// EVENT 85 - PATTERN
e.put("e85", Routine({
	var control, control_specs,	pattern, synth_freeze, synths, synths_out, tempo_clock;
    var freeze_release_time;
    freeze_release_time = 2;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.95, 0.95, 0.95], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.05, 0.05, 0.05], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// the samples to play
	pattern = Pbind(\instrument, \sampler_adsr,
		\buf, Pseq([
			~samples["viola.pizz"]["ff"]["a"]["69"]["buffer"],
		], inf),
		\pan_mode, 1,
		\pos, Pwhite(-0.4, 0.4, inf),
		\out, ~audiobus[0][0],
		\mul, 0.25,
		\dur, Pseq(Array.interpolation(12, 0.5, 0.125) ++ Array.interpolation(12, 0.125, 0.5), 3),
		\group, ~grp[1],
		\addAction, \addToTail,
	);

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();

	// SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][0], \out, ~gainbus, \mul_sig, ~controlbus[2], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));

	tempo_clock = TempoClock(96/60);
	pattern.play(tempo_clock);

    "85 UPDATE 85.0: Event 85 pattern start.".yield;


	// SHUTDOWN ///////////////////////////////////////////////////////////////
	synths_out.do({|item| item.set(\gate, 0)});
	"85 UPDATE 85.1: Event 85 fading out.".yield;
	tempo_clock.free;
	synths_out.do({|item| item.free});
    synths.do({|item| item.free});
	synth_freeze.free;
	control.do({|item| item.free});
    "85 UPDATE 85.2: Event 85 kill stage complete. Event finished.".postln;
}));


// EVENT 87 - PATTERN
e.put("e87", Routine({
	var control, control_specs,	pattern, synth_freeze, synths, synths_out, tempo_clock;
    var freeze_release_time;
    freeze_release_time = 2;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.95, 0.95, 0.95], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.05, 0.05, 0.05], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// the samples to play
	pattern = Pbind(\instrument, \sampler_adsr,
		\buf, Pseq([
			~samples["viola.pizz"]["ff"]["a"]["74"]["buffer"],
		], inf),
		\transpose, Pswitch1([Pseq([1], inf), Pseq(Array.interpolation(8, -0.5.midiratio, 1) ++ Array.interpolation(8, 1, -0.5.midiratio), inf)], Pseq([0, 1], inf)),
		\pan_mode, 1,
		\pos, Pwhite(-0.4, 0.4, inf),
		\out, ~audiobus[0][0],
		\mul, 0.25,
		\dur, Pseq(Array.interpolation(16, 0.5, 0.125) ++ Array.interpolation(16, 0.125, 0.5), 3),
		\group, ~grp[1],
		\addAction, \addToTail,
	);

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();

	// SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][0], \out, ~gainbus, \mul_sig, ~controlbus[2], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));

	tempo_clock = TempoClock(96/60);
	pattern.play(tempo_clock);

    "87 UPDATE 87.0: Event 87 pattern start.".yield;


	// SHUTDOWN ///////////////////////////////////////////////////////////////
	synths_out.do({|item| item.set(\gate, 0)});
	"87 UPDATE 87.1: Event 87 fading out.".yield;
	tempo_clock.free;
	synths_out.do({|item| item.free});
    synths.do({|item| item.free});
	synth_freeze.free;
	control.do({|item| item.free});
    "87 UPDATE 87.2: Event 87 kill stage complete. Event finished.".postln;
}));


// EVENT 88 - PATTERN
e.put("e88", Routine({
	var control, control_specs,	pattern, synth_freeze, synths, synths_out, tempo_clock;
    var freeze_release_time;
    freeze_release_time = 2;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.95, 0.95, 0.95], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.05, 0.05, 0.05], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// the samples to play
	pattern = Pbind(\instrument, \sampler_adsr,
		\buf, Pseq([
			~samples["viola.pizz"]["ff"]["g"]["55"]["buffer"],
		], inf),
		\pan_mode, 1,
		\pos, Pwhite(-0.4, 0.4, inf),
		\out, ~audiobus[0][0],
		\mul, Pseq(Array.interpolation(10, 0.25, 0.1), 1),
		\dur, Pseq([0.25], 10),
		\group, ~grp[1],
		\addAction, \addToTail,
	);

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();

	// SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][0], \out, ~gainbus, \mul_sig, ~controlbus[2], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));

	tempo_clock = TempoClock(96/60);
	pattern.play(tempo_clock);

    "88 UPDATE 88.0: Event 88 pattern start.".yield;


	// SHUTDOWN ///////////////////////////////////////////////////////////////
	synths_out.do({|item| item.set(\gate, 0)});
	"88 UPDATE 88.1: Event 88 fading out.".yield;
	tempo_clock.free;
	synths_out.do({|item| item.free});
    synths.do({|item| item.free});
	synth_freeze.free;
	control.do({|item| item.free});
    "88 UPDATE 88.2: Event 88 kill stage complete. Event finished.".postln;
}));


// EVENT 91 - PATTERN
e.put("e91", Routine({
	var control, control_specs,	patterns, synth_freeze, synths, synths_out, tempo_clock;
    var freeze_release_time;
    freeze_release_time = 2;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
        Dictionary["name" -> "control_dry_gain", "levels" -> #[0.95, 0.95, 0.95], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wet_gain", "levels" -> #[0.05, 0.05, 0.05], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// the samples to play
	patterns = List();
	patterns.add(Pbind(\instrument, \sampler_adsr,
		\buf, Pseq([
			~samples["viola.pizz"]["ff"]["g"]["57"]["buffer"],
		], inf),
		\transpose, Pseq(Array.interpolation(16 * 6, 1, -2.midiratio), 1),
		\pan_mode, 1,
		\pos, Pwhite(-0.4, 0.4, inf),
		\out, ~audiobus[0][0],
		\mul, 0.25,
		\dur, Pseq(Array.interpolation(16, 0.5, 0.125) ++ Array.interpolation(16, 0.125, 0.5), 3),
		\group, ~grp[1],
		\addAction, \addToTail,
	));
	patterns.add(Pbind(\instrument, \sampler_adsr,
		\buf, Pseq([
			~samples["viola.pizz"]["ff"]["g"]["55"]["buffer"],
		], inf),
		\pan_mode, 1,
		\pos, Pwhite(-0.4, 0.4, inf),
		\out, ~audiobus[0][0],
		\mul, 0.25,
		\dur, Pseq(Array.interpolation(16, 0.5, 0.125) ++ Array.interpolation(16, 0.125, 0.5), 3),
		\group, ~grp[1],
		\addAction, \addToTail,
	));

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();

	// SENDS
    // Set attack and release time for this event here.
    // Also set dry and wet reverb gain levels here.
	synths_out = List();
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][0], \out, ~gainbus, \mul_sig, ~controlbus[2], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8mul, [\in, ~audiobus[0][0], \out, ~reverbbus[0], \mul_sig, ~controlbus[3], \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));

	tempo_clock = TempoClock(96/60);
	patterns.do{|pattern| pattern.play(tempo_clock, quant: 1)};

    "91 UPDATE 91.0: Event 91 pattern start.".yield;


	// SHUTDOWN ///////////////////////////////////////////////////////////////
	synths_out.do({|item| item.set(\gate, 0)});
	"91 UPDATE 91.1: Event 91 fading out.".yield;
	tempo_clock.free;
	synths_out.do({|item| item.free});
    synths.do({|item| item.free});
	synth_freeze.free;
	control.do({|item| item.free});
    "91 UPDATE 91.2: Event 91 kill stage complete. Event finished.".postln;
}));

)