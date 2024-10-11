// File: events_pool.scd
// This file contains a pool of events that might be used in various places.


(
// Event 4: shifting pattern accompaniment
e.put("ex1", Routine({
	var control, control_specs,	synth_sound, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_semitones_1", "levels" -> #[-2.0, -1.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_time_1", "levels" -> #[0.12, 0.09], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_mul_1", "levels" -> #[1.0, 0.5], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_semitones_2", "levels" -> #[0.0, -3.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_time_2", "levels" -> #[0.24, 0.21], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_mul_2", "levels" -> #[0.5, 1.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_semitones_3", "levels" -> #[-5.0, -6.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_time_3", "levels" -> #[0.225, 0.2], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_mul_3", "levels" -> #[0.8, 0.2], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_semitones_4", "levels" -> #[-7.0, -9.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_time_4", "levels" -> #[0.45, 0.35], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_mul_4", "levels" -> #[0.4, 1.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_gain", "levels" -> #[0.5, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	synths = List();

	//synth_mic = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	p = Pbind(\instrument, \sampler_adsr,
		\buf, Pseq([
			~samples["viola.pizz"]["ff"]["c"]["53"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["55"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["57"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["52"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["52"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["52"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["62"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["52"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["48"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["50"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["52"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["53"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["57"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["53"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["55"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["55"]["buffer"]
		], 4),
		\pan_mode, 1,
		\pos, Pwhite(0.0, 2.0, inf),
		\out, ~audiobus[0][0],
		\mul, 0.25,
		\dur, Pseq([0.15, 0.15, 0.15, 0.15], inf),
		\group, ~grp[1],
		\addAction, \addToTail,
	);


	synths.add(Synth(\passthrough8, [\in, ~audiobus[0][0], \out, ~audiobus[1][0]], ~grp[2], \addToTail));
	synths.add(Synth(\psdelay1ctrl_et, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \delayint, ~controlbus[3], \semitones, ~controlbus[2], \mul, 1], ~grp[2], \addToTail));
	synths.add(Synth(\psdelay1ctrl_et, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \delayint, ~controlbus[5], \semitones, ~controlbus[4], \mul, 1], ~grp[2], \addToTail));
	synths.add(Synth(\psdelay1ctrl_et, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \delayint, ~controlbus[7], \semitones, ~controlbus[6], \mul, 1], ~grp[2], \addToTail));
	synths.add(Synth(\psdelay1ctrl_et, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \delayint, ~controlbus[9], \semitones, ~controlbus[8], \mul, 1], ~grp[2], \addToTail));
	//synth_fft = Synth(\fft_magbelow2, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \threshold, 0.2, \rmfreq, 200, \rmmul, 0.5, \lpf, 4000, \mul, 10], ~grp[2], \addToTail);
    //synth_filter = Synth(\bpf8, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \freq, ~controlbus[0], \mul, ~controlbus[1]], ~grp[2], \addToTail);

	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[1][0], \out, ~audiobus[2][0], \irbuf, ~convolution_buffers["toilet_bowl"], \mul, 1, \wetdry, 0.1], ~grp[4], \addToTail);
	synths.add(Synth(\gain8, [\in, ~audiobus[2][0], \out, ~audiobus[3][0], \level, ~controlbus[10], \limiter, 1], ~grp[6], \addToTail)); // the gain stage comes last
	synths.add(Synth(\from8to8, [\in, ~audiobus[3][0], \out, 0], ~grp[7], \addToTail));

	t = TempoClock(1);
	p.play(t);
    15.wait;
    //synth_mic.set(\gate, 0);

    // wait for reverb to die down
    2.wait;
    synth_reverb.set(\gate, 0);
    1.wait;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));

// Event 5: add variable comb delay, filtering, and reverb to recorded sound
e.put("ex2", Routine({
	var control, control_specs,	synth_sound, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_comb_time", "levels" -> #[0.1, 0.05, 0.1, 0.15, 0.15], "times" -> #[1, 1, 1, 10], "curves" -> #[0, 0, 0, 0]],
		Dictionary["name" -> "control_hpf_freq", "levels" -> #[200, 400, 400], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_gain", "levels" -> #[0.5, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synth_sound = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	synths.add(Synth(\passthrough8, [\in, ~audiobus[0][0], \out, ~audiobus[1][0]], ~grp[2], \addToTail));
	synths.add(Synth(\randpandelay6, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \delayint, 0.2], ~grp[2], \addToTail));
	synths.add(Synth(\hpf8, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \freq, ~controlbus[3]], ~grp[2], \addToTail));
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[2][0], \out, ~audiobus[3][0], \irbuf, ~convolution_buffers[2], \mul, 1, \wetdry, 0.1], ~grp[4], \addToTail);
	synths.add(Synth(\gain8, [\in, ~audiobus[3][0], \out, ~audiobus[4][0], \level, ~controlbus[4], \limiter, 1], ~grp[5], \addToTail)); // the gain stage comes last
	synths.add(Synth(\from8to8, [\in, ~audiobus[4][0], \out, 0], ~grp[6], \addToTail));

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    // free mic
    5.wait;
    synth_sound.set(\gate, 0);

    // wait for reverb to die down
    4.wait;
	synth_sound.free;
    synth_reverb.set(\gate, 0);

	// free everything else
    1.wait;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));

e.put("ex3", Routine({
	var control, control_specs,	synth_sound, synth_freeze, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_below", "levels" -> #[30.0, 1.0, 1.0], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift1", "levels" -> #[0.1, 0.5, 2.5], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift2", "levels" -> #[-0.1, -0.5, -2.5], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_resonz_freq", "levels" -> #[1174.659, 2000, 2000], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_resonz_bwr", "levels" -> #[0.5, 0.1, 0.1], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_stretch", "levels" -> #[1, 20, 1, 1], "times" -> #[10, 5, 100], "curves" -> #[0, 0, 0]],
		Dictionary["name" -> "control_lpf_freq", "levels" -> #[800, 400, 400], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wetdry", "levels" -> #[0.0, 0.05, 0.9, 0.5], "times" -> #[1, 4, 20], "curves" -> #[0, 0, 0]],
		Dictionary["name" -> "control_gain", "levels" -> #[3.0, 1.5, 3.0, 1.5, 1.5], "times" -> #[2, 2, 2, 100], "curves" -> #[0, 0, 0, 0]]
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	//synth_sound = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	synth_sound = Synth(\sampler_pan, [\buf, ~samples["test"]["2"], \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	synth_freeze = Synth(\fft_freeze, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \below, ~controlbus[2]], ~grp[1], \addToTail);
	synths.add(Synth(\pitchshift2_et, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \semitones1, ~controlbus[3], \semitones2, ~controlbus[4]], ~grp[2], \addToTail));
	synths.add(Synth(\passthrough8, [\in, ~audiobus[1][0], \out, ~audiobus[2][0]], ~grp[2], \addToTail));
    synths.add(Synth(\resonz8, [\in, ~audiobus[2][0], \out, ~audiobus[3][0], \freq, ~controlbus[5], \bwr, ~controlbus[6]], ~grp[2], \addToTail));
	synths.add(Synth(\fft_magsmear, [\in, ~audiobus[3][0], \out, ~audiobus[4][0], \bins, ~controlbus[7]], ~grp[2], \addToTail));
	synths.add(Synth(\lpf8, [\in, ~audiobus[4][0], \out, ~audiobus[5][0], \freq, ~controlbus[8]], ~grp[2], \addToTail));
	synth_reverb = Synth(\partconv8wetdry, [\fft_size, ~partconv_size, \in, ~audiobus[5][0], \out, ~audiobus[6][0], \irbuf, ~convolution_buffers["wine_tank"], \mul, 1, \wetdry, ~controlbus[9]], ~grp[3], \addToTail);
    synths.add(Synth(\gain8, [\in, ~audiobus[6][0], \out, ~audiobus[7][0], \level, ~controlbus[10], \limiter, 1], ~grp[4], \addToTail));
	synths.add(Synth(\from8to8, [\in, ~audiobus[7][0], \out, 0], ~grp[5], \addToTail));

	// UPDATE ///////////////////////////////////////////////////////////////
    0.5.wait;
    synth_freeze.set(\freeze, 1.0);

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    // free mic
    5.wait;
    //synth_sound.set(\gate, 0);
    synth_freeze.set(\gate, 0);

    // wait for reverb to die down
    4.wait;
	synth_freeze.free;
    synth_reverb.set(\gate, 0);

	// free everything else
    1.wait;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));


// explicit sampler for accel/decel
e.put("accel_decel", Routine({
	var control, control_specs,	synth_sound, synth_freeze, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_resonz_freq", "levels" -> #[1320, 1320, 1320], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_resonz_bwr", "levels" -> #[0.5, 0.1, 0.1], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_wetdry", "levels" -> #[0.0, 0.01, 0.02, 0.03], "times" -> #[1, 4, 20], "curves" -> #[0, 0, 0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 1.0, 1.0, 1.0, 1.0], "times" -> #[2, 2, 2, 100], "curves" -> #[0, 0, 0, 0]]
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();

	// the samples to play
	p = Pbind(\instrument, \sampler_adsr,
		\buf, Pseq([
			~samples["viola.pizz"]["ff"]["a"]["69"]["buffer"],
		], inf),
		\pan_mode, 1,
		\pos, Pwhite(0.0, 2.0, inf),
		\out, ~audiobus[0][0],
		\mul, 0.25,
		\dur, Pseq(Array.interpolation(12, 0.5, 0.125) ++ Array.interpolation(12, 0.125, 0.5), 3),
		\group, ~grp[1],
		\addAction, \addToTail,
	);

    synths.add(Synth(\resonz8, [\in, ~audiobus[0][0], \out, ~audiobus[5][0], \freq, ~controlbus[2], \bwr, ~controlbus[3]], ~grp[2], \addToTail));
	synth_reverb = Synth(\partconv8wetdry, [\fft_size, ~partconv_size, \in, ~audiobus[5][0], \out, ~audiobus[6][0], \irbuf, ~convolution_buffers["wine_tank"], \mul, 1, \wetdry, ~controlbus[4]], ~grp[3], \addToTail);
    synths.add(Synth(\gain8, [\in, ~audiobus[6][0], \out, ~audiobus[7][0], \level, ~controlbus[5], \limiter, 1], ~grp[4], \addToTail));
	synths.add(Synth(\from8to2, [\in, ~audiobus[7][0], \out, 0], ~grp[5], \addToTail));

	t = TempoClock(1);
	p.play(t);
	15.wait;

	// free reverb
	synth_reverb.set(\gate, 0);

	// free everything else
    1.wait;
	t.free;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));

// Event: shifting pattern playing
e.put("pattern_improv", Routine({
	var control, control_specs,	synth_sound, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_semitones_1", "levels" -> #[4.0, 5.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_time_1", "levels" -> #[0.5, 0.4], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_mul_1", "levels" -> #[1.0, 0.5], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_semitones_2", "levels" -> #[-5.0, -4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_time_2", "levels" -> #[0.8, 0.9], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_mul_2", "levels" -> #[0.5, 1.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_semitones_3", "levels" -> #[1.0, 2.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_time_3", "levels" -> #[2.0, 1.8], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_mul_3", "levels" -> #[1.0, 0.5], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_semitones_4", "levels" -> #[-1.0, -2.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_time_4", "levels" -> #[1.3, 1.5], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_delay_mul_4", "levels" -> #[1.0, 0.5], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_gain", "levels" -> #[0.5, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	synths = List();

	// microtonal pattern
	p = Pbind(\instrument, \sampler_adsr,
		\buf, Pseq([
			~samples["viola.pizz"]["ff"]["c"]["55"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["59"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["69"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["65"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["64"]["buffer"], //+
			~samples["viola.pizz"]["ff"]["c"]["65"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["59"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["55"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["54"]["buffer"], //+
			~samples["viola.pizz"]["ff"]["c"]["57"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["64"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["65"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["54"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["57"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["61"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["68"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["72"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["71"]["buffer"], //+
			~samples["viola.pizz"]["ff"]["c"]["72"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["62"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["65"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["62"]["buffer"],
			~samples["viola.pizz"]["ff"]["c"]["61"]["buffer"], //+
			~samples["viola.pizz"]["ff"]["c"]["62"]["buffer"]
		], 4),
		\transpose, Pseq([1, 1, 1, 1, 0.5.midiratio, 1, 1, 1, 0.5.midiratio, 1, 1, 1, 1, 1, 1, 1, 1, 0.5.midiratio, 1, 1, 1, 1, 0.5.midiratio, 1], inf),
		\pan_mode, 1,
		\pos, Pwhite(0.0, 2.0, inf),
		\out, ~audiobus[0][0],
		\mul, 0.25,
		\dur, Pseq([0.15, 0.15, 0.15, 0.15], inf),
		\group, ~grp[1],
		\addAction, \addToTail,
	);

	synths.add(Synth(\passthrough8, [\in, ~audiobus[0][0], \out, ~audiobus[1][0]], ~grp[2], \addToTail));
	synths.add(Synth(\psdelay1ctrl_et, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \semitones, ~controlbus[2], \delayint, ~controlbus[3], \mul, ~controlbus[4]], ~grp[2], \addToTail));
	synths.add(Synth(\psdelay1ctrl_et, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \semitones, ~controlbus[5], \delayint, ~controlbus[6], \mul, ~controlbus[7]], ~grp[2], \addToTail));
	synths.add(Synth(\psdelay1ctrl_et, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \semitones, ~controlbus[8], \delayint, ~controlbus[9], \mul, ~controlbus[10]], ~grp[2], \addToTail));
	synths.add(Synth(\psdelay1ctrl_et, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \semitones, ~controlbus[11], \delayint, ~controlbus[12], \mul, ~controlbus[13]], ~grp[2], \addToTail));
	//synth_fft = Synth(\fft_magbelow2, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \threshold, 0.2, \rmfreq, 200, \rmmul, 0.5, \lpf, 4000, \mul, 10], ~grp[2], \addToTail);
    //synth_filter = Synth(\bpf8, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \freq, ~controlbus[0], \mul, ~controlbus[1]], ~grp[2], \addToTail);

	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[1][0], \out, ~audiobus[2][0], \irbuf, ~convolution_buffers["toilet_bowl"], \mul, 1, \wetdry, 0.1], ~grp[4], \addToTail);
	synths.add(Synth(\gain8, [\in, ~audiobus[2][0], \out, ~audiobus[3][0], \level, ~controlbus[14], \limiter, 1], ~grp[6], \addToTail)); // the gain stage comes last
	synths.add(Synth(\from8to8, [\in, ~audiobus[3][0], \out, 0], ~grp[7], \addToTail));

	t = TempoClock(1);
	p.play(t);
    15.wait;
    //synth_mic.set(\gate, 0);

    // wait for reverb to die down
    2.wait;
    synth_reverb.set(\gate, 0);
    1.wait;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));


// Event: pitch shift
e.put("octaves", Routine({
	var control, control_specs,	synth_sound, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_gain", "levels" -> #[0.2, 0.4, 0.4], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synth_sound = Synth(\mic1panmul, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1], \mul_sig, ~knobbus[0], \mul, 0.5], ~grp[1], \addToTail);
	synths.add(Synth(\pitchshift, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \ratio, 2], ~grp[3], \addToTail));
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[1][0], \out, ~audiobus[5][0], \irbuf, ~convolution_buffers["cathedral"], \mul, 1, \wetdry, 0.1], ~grp[5], \addToTail);
	synths.add(Synth(\gain8, [\in, ~audiobus[5][0], \out, ~audiobus[6][0], \level, ~controlbus[9], \limiter, -12.dbamp], ~grp[6], \addToTail)); // the gain stage comes last
	synths.add(Synth(\from8to8, [\in, ~audiobus[6][0], \out, 0], ~grp[7], \addToTail));

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    // free mic
    8.wait;
    synth_sound.set(\gate, 0);

    // wait for reverb to die down
    4.wait;
	synth_sound.free;
    synth_reverb.set(\gate, 0);

	// free everything else
    1.wait;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));

// Event: feedback
e.put("feedback", Routine({
	var control, control_specs,	synth_sound, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_pitch_shift1", "levels" -> #[0.0, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift2", "levels" -> #[4.0, 5.0, 5.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift3", "levels" -> #[0.0, -1.0, -1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pspan1", "levels" -> #[0.5, 0.5], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_pspan2", "levels" -> #[1.0, 1.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_pspan3", "levels" -> #[1.5, 1.5], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_lpf_freq", "levels" -> #[1600, 2600, 2600], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_gain", "levels" -> #[0.2, 0.4, 0.4], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synth_sound = Synth(\mic1panmul, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1], \mul_sig, ~knobbus[0], \mul, 0.5], ~grp[1], \addToTail);
	//synth_sound = Synth(\sampler_pan, [\buf, ~samples["test"]["3"], \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	// add processing synths
	synths.add(Synth(\fb1, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \mul_sig, ~faderbus[4], \feedback, ~faderbus[5], \freq, ~faderbus[8]], ~grp[3], \addToTail));
	synth_reverb = Synth(\partconv8wetdry, [\fft_size, ~partconv_size, \in, ~audiobus[1][0], \out, ~audiobus[5][0], \irbuf, ~convolution_buffers["cathedral"], \mul, 1, \wetdry, ~knobbus[1]], ~grp[5], \addToTail);
    synths.add(Synth(\gain8, [\in, ~audiobus[5][0], \out, ~audiobus[6][0], \level, ~controlbus[9], \limiter, -12.dbamp], ~grp[6], \addToTail)); // the gain stage comes last
	synths.add(Synth(\from8to8, [\in, ~audiobus[6][0], \out, 0], ~grp[7], \addToTail));

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    // free mic
    8.wait;
    synth_sound.set(\gate, 0);
    // wait for reverb to die down
    4.wait;
	synth_sound.free;
    synth_reverb.set(\gate, 0);
	// free everything else
    1.wait;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));

)

