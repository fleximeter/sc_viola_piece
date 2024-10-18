// File: events.scd
// This file contains individual events to occur within the piece.

// Event x: add FFT sustain, FFT mag below, filtering, and reverb to live sound
// Note that you will need to use .next when playing this routine to capture the freeze at the right moment!
(
e.put("mx", Routine({
	var control, control_specs,	synth_sound, synth_freeze, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_pv_below", "levels" -> #[1.0, 0.05, 0.02], "times" -> #[10, 10], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_lpf_freq", "levels" -> #[800, 400, 400], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_gain", "levels" -> #[0.2, 6.0, 6.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synth_sound = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1], \mul, 0.5], ~grp[1], \addToTail);
	synth_freeze = Synth(\fft_freeze, [\in, ~audiobus[0][0], \out, ~audiobus[1][0]], ~grp[1], \addToTail);
	synths.add(Synth(\fft_magbelow, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \below, ~controlbus[2]], ~grp[2], \addToTail));
	synths.add(Synth(\lpf8, [\in, ~audiobus[2][0], \out, ~audiobus[3][0], \freq, ~controlbus[3]], ~grp[3], \addToTail));
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[3][0], \out, ~audiobus[4][0], \irbuf, ~convolution_buffers[2], \mul, 1, \wetdry, 0.8], ~grp[4], \addToTail);
	synths.add(Synth(\gain8, [\in, ~audiobus[4][0], \out, ~audiobus[5][0], \level, ~controlbus[3], \limiter, 1], ~grp[5], \addToTail)); // the gain stage comes last
	synths.add(Synth(\from8to8, [\in, ~audiobus[5][0], \out, 0], ~grp[6], \addToTail));

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    // free mic
	2.yield;
	synth_freeze.set(\freeze, 1);
    synth_sound.set(\gate, 0);

	2.yield;
	synth_sound.free;
    synth_freeze.set(\gate, 0);

    // wait for reverb to die down
    2.yield;
	synth_freeze.free;
    synth_reverb.set(\gate, 0);

	// free everything else
    1.yield;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));
)

// Event 3: gliss pitch shift harmonization
(
e.add(Routine({
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
		Dictionary["name" -> "control_gain", "levels" -> #[0.5, 1.0, 1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	//synth_sound = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	synth_sound = Synth(\sampler_pan, [\buf, ~samples["test"]["3"], \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	// add processing synths
	synths.add(Synth(\pitchshift1_et, [\in, ~audiobus[0][0], \out, ~audiobus[1][1], \semitones1, ~controlbus[2]], ~grp[2], \addToTail));
	synths.add(Synth(\pitchshift1_et, [\in, ~audiobus[0][0], \out, ~audiobus[1][2], \semitones1, ~controlbus[3]], ~grp[2], \addToTail));
	synths.add(Synth(\pitchshift1_et, [\in, ~audiobus[0][0], \out, ~audiobus[1][3], \semitones1, ~controlbus[4]], ~grp[2], \addToTail));
	synths.add(Synth(\passthrough8, [\in, ~audiobus[0][0], \out, ~audiobus[2][0]], ~grp[3], \addToTail));
	synths.add(Synth(\pan8, [\in, ~audiobus[1][1], \out, ~audiobus[2][0], \pos, ~controlbus[5], \width, ~controlbus[1]], ~grp[3], \addToTail));
	synths.add(Synth(\pan8, [\in, ~audiobus[1][2], \out, ~audiobus[2][0], \pos, ~controlbus[6], \width, ~controlbus[1]], ~grp[3], \addToTail));
	synths.add(Synth(\pan8, [\in, ~audiobus[1][3], \out, ~audiobus[2][0], \pos, ~controlbus[7], \width, ~controlbus[1]], ~grp[3], \addToTail));
	synths.add(Synth(\lpf8, [\in, ~audiobus[2][0], \out, ~audiobus[3][0], \freq, ~controlbus[8]], ~grp[4], \addToTail));
	synths.add(Synth(\gain8, [\in, ~audiobus[4][0], \level, ~controlbus[9], \limiter, 1, \out, 0], ~grp[6], \addToTail)); // the gain stage comes last

	// add the reverb
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[3][0], \out, ~audiobus[4][0], \irbuf, ~convolution_buffers[2], \mul, 1, \wetdry, 0.3], ~grp[5], \addToTail);

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


// Event 6: pattern accompaniment
(
e.put("mx", Routine({
	var control, control_specs,	synth_sound, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
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
		\mul, 1,
		\dur, Pseq([0.15, 0.15, 0.15, 0.15], inf),
		\group, ~grp[1],
		\addAction, \addToTail,
	);

	synths.add(Synth(\passthrough8, [\in, ~audiobus[0][0], \out, ~audiobus[1][0]], ~grp[2], \addToTail));
	synths.add(Synth(\psdelay1, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \delayint, 0.12, \semitones, -2, \mul, 1], ~grp[2], \addToTail));
	synths.add(Synth(\psdelay1, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \delayint, 0.24, \semitones, 0, \mul, 1], ~grp[2], \addToTail));
	synths.add(Synth(\psdelay1, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \delayint, 0.225, \semitones, -5, \mul, 1], ~grp[2], \addToTail));
	synths.add(Synth(\psdelay1, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \delayint, 0.45, \semitones, -7, \mul, 1], ~grp[2], \addToTail));
	//synth_fft = Synth(\fft_magbelow2, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \threshold, 0.2, \rmfreq, 200, \rmmul, 0.5, \lpf, 4000, \mul, 10], ~grp[2], \addToTail);
    //synth_filter = Synth(\bpf8, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \freq, ~controlbus[0], \mul, ~controlbus[1]], ~grp[2], \addToTail);
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[1][0], \out, ~audiobus[2][0], \irbuf, ~convolution_buffers[2], \mul, 1, \wetdry, 0.2], ~grp[4], \addToTail);
	synths.add(Synth(\gain8, [\in, ~audiobus[2][0], \out, ~audiobus[3][0], \level, ~controlbus[2], \limiter, 1], ~grp[6], \addToTail)); // the gain stage comes last
	synths.add(Synth(\from8to8, [\in, ~audiobus[3][0], \out, 0], ~grp[7], \addToTail));


	t = TempoClock(1);
	p.play(t);
    15.wait;
    //synth_mic.set(\gate, 0);

    // wait for reverb to die down
    10.wait;
    synth_reverb.set(\gate, 0);
    1.wait;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));
)

// Event 8: pitch shift harmonize
(
e.add(Routine({
	var control_pan_pos, control_pan_width, synth_mic, synth_ps, control_ps1, control_ps2, control_ps3, synth_reverb;

	control_pan_pos = Synth(\ctrl_env, [\out, ~controlbus[0], \levels, #[0, 1, -1, 0], \times, #[5, 5, 5], \curves, #[0, 0, 0]], ~grp[0], \addToTail);
	control_pan_width = Synth(\ctrl_env, [\out, ~controlbus[1], \levels, #[2, 4, 2, 1, 4], \times, #[4, 4, 2, 2], \curves, #[0, 0, 0, 0]], ~grp[0], \addToTail);
	control_ps1 = Synth(\ctrl_env, [\out, ~controlbus[2], \levels, #[4, 3.9], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_ps2 = Synth(\ctrl_env, [\out, ~controlbus[3], \levels, #[7, 6.9], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_ps3 = Synth(\ctrl_env, [\out, ~controlbus[4], \levels, #[9, 8.9], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	synth_mic = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	synth_ps = Synth(\pitchshift3_et, [
		\semitones1, ~controlbus[2],
		\semitones2, ~controlbus[3],
		\semitones3, ~controlbus[4],
		\in, ~audiobus[0][0], \out, ~audiobus[1][0]
	], ~grp[2], \addToTail);
    synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[1][0], \out, 0, \irbuf, ~convolution_buffers[2], \mul, 1, \wetdry, 0.2], ~grp[4], \addToTail);

	15.wait;
    synth_mic.set(\gate, 0);

    // wait for reverb to die down
    10.wait;
    synth_reverb.set(\gate, 0);
    1.wait;
	synth_ps.free;
	control_ps1.free;
	control_ps2.free;
	control_ps3.free;
    control_pan_pos.free;
    control_pan_width.free;
}));
)

// Event 9: play samples from library
(
e.add(Routine({
	var control_pan_pos, control_pan_width, synth_ps, synth_reverb;

	p = Pbind(\instrument, \sampler_loop_only,
		\buf, Pseq([
			~samples["basstrombone"]["mf"]["64"]["buffer"],
		], 1),
		\sample_loop1, Pseq([
			~samples["basstrombone"]["mf"]["64"]["loop_points"][0][0],
		], 1),
		\sample_loop2, Pseq([
			~samples["basstrombone"]["mf"]["64"]["loop_points"][0][1],
		], 1),
		\atk_time, 0.5,
		\release_time, 0.5,
		\pan_mode, 1,
		\pos, 0,
		\pan_width, 2,
		\out, ~audiobus[0][0],
		\mul, 0.25,
		\dur, Pseq([5], inf),
		\group, ~grp[1],
		\addAction, \addToTail,
	);

	q = Pbind(\instrument, \sampler_loop_only,
		\buf, Pseq([
			~samples["basstrombone"]["mf"]["61"]["buffer"],
		], 4),
		\sample_loop1, Pseq([
			~samples["basstrombone"]["mf"]["61"]["loop_points"][0][0],
		], 1),
		\sample_loop2, Pseq([
			~samples["basstrombone"]["mf"]["61"]["loop_points"][0][1],
		], 1),
		\atk_time, 0.5,
		\release_time, 0.5,
		\pan_mode, 1,
		\pos, 0,
		\pan_width, 2,
		\out, ~audiobus[0][0],
		\mul, 0.25,
		\dur, Pseq([5], inf),
		\group, ~grp[1],
		\addAction, \addToTail,
	);
	t = TempoClock(48/60);
	p.play(t, quant: 1);
	q.play(t, quant: 1);

	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[0][0], \out, 0, \irbuf, ~convolution_buffers[2], \mul, 1, \wetdry, 0.2], ~grp[4], \addToTail);
    10.wait;
    synth_reverb.set(\gate, 0);
	t.free;
	
}));
)
