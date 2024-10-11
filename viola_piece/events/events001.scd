// File: events001.scd
// This file contains individual events starting at measure 1.


// Event 1: add FFT freeze, resonant filtering, and reverb
(
// This event runs the microphone, reverbs, and gain.
// It also includes a pan mapper so that you can run this in stereo or 8-channel.
e.put("main", Routine({
    var synth_mic, synth_reverb, synths;
	synth_reverb = List();
	synths = List();

    // control mic gain with knob 1
	synth_mic = Synth(\mic1mul, [\in, ~mic_zero, \out, ~micbus, \mul_sig, ~faderbus[2]], ~grp[1], \addToTail);

    synth_reverb.add(Synth(\partconv8wet, [\in, ~reverbbus[0], \out, ~gainbus, \fft_size, ~partconv_size, \mul, 1.0, \irbuf, ~convolution_buffers["cathedral"]], ~grp[9], \addToTail));/*
    synth_reverb.add(Synth(\partconv8wet, [\in, ~reverbbus[1], \out, ~gainbus, \fft_size, ~partconv_size, \mul, 1.0, \irbuf, ~convolution_buffers["wine_tank"]], ~grp[9], \addToTail));
    synth_reverb.add(Synth(\partconv8wet, [\in, ~reverbbus[2], \out, ~gainbus, \fft_size, ~partconv_size, \mul, 1.0, \irbuf, ~convolution_buffers["chamber"]], ~grp[9], \addToTail));
    synth_reverb.add(Synth(\partconv8wet, [\in, ~reverbbus[3], \out, ~gainbus, \fft_size, ~partconv_size, \mul, 1.0, \irbuf, ~convolution_buffers["toilet"]], ~grp[9], \addToTail));*/

    // control the gain with knob 2
	synths.add(Synth(\gain8mul, [\in, ~gainbus, \out, ~postprocessingbus[0], \mul, 1, \mul_sig, ~faderbus[3], \limit, -6.dbamp], ~grp[9], \addToTail));

	// the pan mapping (stereo or 8-channel)
	synths.add(Synth(\from8to2, [\in, ~postprocessingbus[0], \out, 0], ~grp[9], \addToTail));
	//synths.add(Synth(\from8to8, [\in, ~postprocessingbus[0], \out, 0], ~grp[9], \addToTail));
    "0 UPDATE 0.0: Main event running.".yield;

	synth_mic.set(\gate, 0);
    synth_reverb.do({|item| item.set(\gate, 0)});
    "0 UPDATE 0.1: Main event kill stage 1 complete.".yield;
    synths.do({|item| item.free});
    synth_mic.free;
    synth_reverb.do({|item| item.free});
    "0 UPDATE 0.2: Main event kill stage 2 complete. Event finished.".postln;
}));

e.put("e1", Routine({
	var control, control_specs,	synth_freeze, synths, synths_out;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_below", "levels" -> #[0.1, 0.1, 0.1], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_below_mul", "levels" -> #[1.0, 5.0, 5.0], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift1", "levels" -> #[4.0, 5.0, 2.5], "times" -> #[6, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift2", "levels" -> #[-0.3, -2.0, -2.5], "times" -> #[6, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synths.add(Synth(\pan1to8, [\in, ~micbus, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail));
	synth_freeze = Synth(\fft_freeze, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \below, 0.01], ~grp[1], \addToTail);
	synths.add(Synth(\pitchshift2_et, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \semitones1, ~controlbus[4], \semitones2, ~controlbus[5]], ~grp[2], \addToTail));
	synths.add(Synth(\passthrough8, [\in, ~audiobus[1][0], \out, ~audiobus[2][0]], ~grp[2], \addToTail));

	// SENDS
    // Set attack and release time for this event here:
	synths_out = List();
	synths_out.add(Synth(\passthrough8, [\in, ~audiobus[2][0], \out, ~reverbbus[0], \mul, 0.1, \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
	synths_out.add(Synth(\passthrough8, [\in, ~audiobus[2][0], \out, ~gainbus, \mul, 0.9, \attack_time, 0.01, \release_time, 0.1], ~grp[5], \addToTail));
    "1 UPDATE 1.0: Event 1 running.".yield;

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

e.put("e2", Routine({
	var control, control_specs,	synth_sound, synth_freeze, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_below", "levels" -> #[30.0, 0.1, 0.1], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_below_mul", "levels" -> #[1.0, 5.0, 5.0], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift1", "levels" -> #[0.1, 0.5, 2.5], "times" -> #[6, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift2", "levels" -> #[-0.1, -0.5, -2.5], "times" -> #[6, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_resonz_freq", "levels" -> #[1760, 2000, 2000], "times" -> #[7, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_resonz_bwr", "levels" -> #[0.05, 0.0001, 0.0001], "times" -> #[6, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_lpf_freq", "levels" -> #[5000, 700, 700], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 0.5, 1.0, 0.5, 0.5], "times" -> #[2, 2, 2, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synth_sound = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1], \mul, 0.2], ~grp[1], \addToTail);
	// synth_sound = Synth(\sampler_pan, [\buf, ~samples["test"]["1"], \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	synth_freeze = Synth(\fft_freeze, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \below, ~controlbus[2]], ~grp[1], \addToTail);
	synths.add(Synth(\fft_magbelow, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \below, ~controlbus[2], \mul_sig, ~controlbus[3]], ~grp[2], \addToTail));
	synths.add(Synth(\pitchshift2_et, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \semitones1, ~controlbus[4], \semitones2, ~controlbus[5]], ~grp[2], \addToTail));
	synths.add(Synth(\passthrough8, [\in, ~audiobus[1][0], \out, ~audiobus[2][0]], ~grp[2], \addToTail));
    synths.add(Synth(\resonz8, [\in, ~audiobus[2][0], \out, ~audiobus[3][0], \freq, ~controlbus[6], \bwr, ~controlbus[7]], ~grp[2], \addToTail));
	// synths.add(Synth(\lpf8, [\in, ~audiobus[3][0], \out, ~audiobus[4][0], \freq, ~controlbus[8]], ~grp[2], \addToTail));
	synths.add(Synth(\passthrough8, [\in, ~audiobus[3][0], \out, ~audiobus[5][0]], ~grp[3], \addToTail));
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[3][0], \out, ~audiobus[5][0], \irbuf, ~convolution_buffers["cathedral"], \mul, 0.01, \wetdry, 1.0], ~grp[5], \addToTail);
    synths.add(Synth(\gain8, [\in, ~audiobus[5][0], \out, ~audiobus[6][0], \level, ~controlbus[9], \limiter, 1], ~grp[4], \addToTail));
	synths.add(Synth(\from8to8, [\in, ~audiobus[6][0], \out, 0], ~grp[5], \addToTail));

	// UPDATE ///////////////////////////////////////////////////////////////
    0.5.wait;
    synth_freeze.set(\freeze, 1.0);

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    // free mic
    5.wait;
    synth_sound.set(\gate, 0);
    synth_freeze.set(\gate, 0);

    // wait for reverb to die down
    4.wait;
	synth_sound.free;
	synth_freeze.free;
    synth_reverb.set(\gate, 0);

	// free everything else
    1.wait;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));

// Event 3: gliss pitch shift harmonization with FFT freeze
e.put("e3", Routine({
	var control, control_specs, synth_sound, synth_freeze, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_pitch_shift1", "levels" -> #[0.0, -1.0, -1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift2", "levels" -> #[0.0, 4.0, 4.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pspan1", "levels" -> #[0.0, 0.5], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_pspan2", "levels" -> #[0.0, -0.5], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_lpf_freq", "levels" -> #[1600, 2600, 2600], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_gain", "levels" -> #[0.2, 0.4, 0.4], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synth_sound = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1], \mul, 0.7], ~grp[1], \addToTail);
	//synth_sound = Synth(\sampler_pan, [\buf, ~samples["test"]["3"], \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	// add processing synths
	synth_freeze = Synth(\fft_freeze, [\in, ~audiobus[0][0], \out, ~audiobus[1][0]], ~grp[1], \addToTail);
	synths.add(Synth(\pitchshift1_et, [\in, ~audiobus[1][0], \out, ~audiobus[2][1], \semitones1, ~controlbus[2]], ~grp[2], \addToTail));
	synths.add(Synth(\pitchshift1_et, [\in, ~audiobus[1][0], \out, ~audiobus[2][2], \semitones1, ~controlbus[3]], ~grp[2], \addToTail));
	synths.add(Synth(\pan8, [\in, ~audiobus[2][1], \out, ~audiobus[3][0], \pos, ~controlbus[4], \width, ~controlbus[1]], ~grp[3], \addToTail));
	synths.add(Synth(\pan8, [\in, ~audiobus[2][2], \out, ~audiobus[3][0], \pos, ~controlbus[5], \width, ~controlbus[1]], ~grp[3], \addToTail));
	// synths.add(Synth(\lpf8, [\in, ~audiobus[3][0], \out, ~audiobus[4][0], \freq, ~controlbus[6]], ~grp[4], \addToTail));
	synths.add(Synth(\passthrough8, [\in, ~audiobus[3][0], \out, ~audiobus[5][0]], ~grp[3], \addToTail));
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[3][0], \out, ~audiobus[5][0], \irbuf, ~convolution_buffers["cathedral"], \mul, 0.01, \wetdry, 1.0], ~grp[5], \addToTail);
    synths.add(Synth(\gain8, [\in, ~audiobus[5][0], \out, ~audiobus[6][0], \level, ~controlbus[7], \limiter, 1], ~grp[6], \addToTail)); // the gain stage comes last
	synths.add(Synth(\from8to8, [\in, ~audiobus[6][0], \out, 0], ~grp[7], \addToTail));

	// STEP THROUGH ROUTINE ///////////////////////////////////////////////////////////////

	// start freeze
    1.yield;
	synth_freeze.set(\freeze, 1.0);
	synth_sound.set(\gate, 0);

	// stop sound
	1.yield;
	synth_sound.free;
	synth_freeze.set(\gate, 0);

	// release reverb
    4.yield;
	synth_freeze.free;
    synth_reverb.set(\gate, 0);

	// release everything else
    1.yield;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));


// Event 4: spectral transformation
e.put("e4", Routine({
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
		Dictionary["name" -> "control_gain", "levels" -> #[2, 2, 1], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synth_sound = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[1][0], \pos, ~controlbus[0], \width, ~controlbus[1], \mul, 1.0], ~grp[1], \addToTail);
	//synth_sound = Synth(\sampler_pan, [\buf, ~samples["test"]["3"], \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	// add processing synths
	//synths.add(Synth(\fft_magsmear, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \bins, ~controlbus[1]], ~grp[1], \addToTail));
	synths.add(Synth(\pitchshift1_et, [\in, ~audiobus[1][0], \out, ~audiobus[2][1], \semitones1, ~controlbus[2]], ~grp[2], \addToTail));
	synths.add(Synth(\pitchshift1_et, [\in, ~audiobus[1][0], \out, ~audiobus[2][2], \semitones1, ~controlbus[3]], ~grp[2], \addToTail));
	synths.add(Synth(\pitchshift1_et, [\in, ~audiobus[1][0], \out, ~audiobus[2][3], \semitones1, ~controlbus[4]], ~grp[2], \addToTail));
	synths.add(Synth(\passthrough8, [\in, ~audiobus[1][0], \out, ~audiobus[3][0]], ~grp[3], \addToTail));
	synths.add(Synth(\pan8, [\in, ~audiobus[2][1], \out, ~audiobus[3][0], \pos, ~controlbus[5], \width, ~controlbus[1]], ~grp[3], \addToTail));
	synths.add(Synth(\pan8, [\in, ~audiobus[2][2], \out, ~audiobus[3][0], \pos, ~controlbus[6], \width, ~controlbus[1]], ~grp[3], \addToTail));
	synths.add(Synth(\pan8, [\in, ~audiobus[2][3], \out, ~audiobus[3][0], \pos, ~controlbus[7], \width, ~controlbus[1]], ~grp[3], \addToTail));
	// synths.add(Synth(\lpf8, [\in, ~audiobus[3][0], \out, ~audiobus[4][0], \freq, ~controlbus[8]], ~grp[4], \addToTail));
	synths.add(Synth(\passthrough8, [\in, ~audiobus[3][0], \out, ~audiobus[5][0]], ~grp[3], \addToTail));
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[3][0], \out, ~audiobus[5][0], \irbuf, ~convolution_buffers["cathedral"], \mul, 0.01, \wetdry, 1.0], ~grp[5], \addToTail);
    synths.add(Synth(\gain8, [\in, ~audiobus[5][0], \out, ~audiobus[6][0], \level, ~controlbus[9], \limiter, 1], ~grp[6], \addToTail)); // the gain stage comes last
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

e.put("e5", Routine({
	var control, control_specs,	synth_sound, synth_freeze, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_below", "levels" -> #[30.0, 0.1, 0.1], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_below_mul", "levels" -> #[1.0, 5.0, 5.0], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift1", "levels" -> #[0.1, 0.5, 2.5], "times" -> #[6, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift2", "levels" -> #[-0.1, -0.5, -2.5], "times" -> #[6, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_resonz_freq", "levels" -> #[1174.659, 2000, 2000], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_resonz_bwr", "levels" -> #[0.5, 0.1, 0.1], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_lpf_freq", "levels" -> #[5000, 700, 700], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 0.5, 1.0, 0.5, 0.5], "times" -> #[2, 2, 2, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synth_sound = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1], \mul, 3.0], ~grp[1], \addToTail);
	// synth_sound = Synth(\sampler_pan, [\buf, ~samples["test"]["1"], \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	synths.add(Synth(\fft_magsmear, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \below, ~controlbus[2], \mul_sig, ~controlbus[3]], ~grp[2], \addToTail));
	synths.add(Synth(\fft_magbelow, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \below, ~controlbus[2], \mul_sig, ~controlbus[3]], ~grp[2], \addToTail));
	synths.add(Synth(\pitchshift2_et, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \semitones1, ~controlbus[4], \semitones2, ~controlbus[5]], ~grp[2], \addToTail));
	synths.add(Synth(\passthrough8, [\in, ~audiobus[1][0], \out, ~audiobus[2][0]], ~grp[2], \addToTail));
    synths.add(Synth(\resonz8, [\in, ~audiobus[2][0], \out, ~audiobus[3][0], \freq, ~controlbus[6], \bwr, ~controlbus[7]], ~grp[2], \addToTail));
	synths.add(Synth(\lpf8, [\in, ~audiobus[3][0], \out, ~audiobus[4][0], \freq, ~controlbus[8]], ~grp[2], \addToTail));
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[4][0], \out, ~audiobus[5][0], \irbuf, ~convolution_buffers["toilet_bowl"], \mul, 1, \wetdry, 0.1], ~grp[3], \addToTail);
    synths.add(Synth(\gain8, [\in, ~audiobus[5][0], \out, ~audiobus[6][0], \level, ~controlbus[9], \limiter, 1], ~grp[4], \addToTail));
	synths.add(Synth(\from8to8, [\in, ~audiobus[6][0], \out, 0], ~grp[5], \addToTail));

	// UPDATE ///////////////////////////////////////////////////////////////
    0.5.wait;
    synth_freeze.set(\freeze, 1.0);

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    // free mic
    5.wait;
    synth_sound.set(\gate, 0);
    synth_freeze.set(\gate, 0);

    // wait for reverb to die down
    4.wait;
	synth_sound.free;
	synth_freeze.free;
    synth_reverb.set(\gate, 0);

	// free everything else
    1.wait;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));

// fft freeze and slow pitch shift
// NOTE: UPDATE PITCH SHIFT AND GAIN TIMES BY TIMING THE PERFORMER
e.put("e6", Routine({
	var control, control_specs,	synth_sound, synth_freeze, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_below", "levels" -> #[30.0, 0.1, 0.1], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_below_mul", "levels" -> #[1.0, 5.0, 5.0], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift1", "levels" -> #[0.0, 0.0, 2.5], "times" -> #[6, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift2", "levels" -> #[0.0, -1.0, -1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 2.0, 2.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synth_sound = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1], \mul, 5.0], ~grp[1], \addToTail);
	// synth_sound = Synth(\sampler_pan, [\buf, ~samples["test"]["1"], \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	synth_freeze = Synth(\fft_freeze, [\in, ~audiobus[0][0], \out, ~audiobus[1][0]], ~grp[1], \addToTail);
	synths.add(Synth(\fft_magbelow, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \below, ~controlbus[2], \mul_sig, ~controlbus[3]], ~grp[2], \addToTail));
	synths.add(Synth(\pitchshift2_et, [\in, ~audiobus[2][0], \out, ~audiobus[3][0], \semitones1, ~controlbus[4], \semitones2, ~controlbus[5]], ~grp[2], \addToTail));
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[3][0], \out, ~audiobus[4][0], \irbuf, ~convolution_buffers["toilet_bowl"], \mul, 1, \wetdry, 0.1], ~grp[3], \addToTail);
    synths.add(Synth(\gain8, [\in, ~audiobus[4][0], \out, ~audiobus[5][0], \level, ~controlbus[6], \limiter, 1], ~grp[4], \addToTail));
	synths.add(Synth(\from8to8, [\in, ~audiobus[5][0], \out, 0], ~grp[5], \addToTail));

	// UPDATE ///////////////////////////////////////////////////////////////
    0.5.wait;
    synth_freeze.set(\freeze, 1.0);

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    // free mic and freeze
    5.wait;
    synth_sound.set(\gate, 0);
	1.wait;
	synth_sound.free;
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



// BEGIN RUBATO!!



// fft freeze and slow pitch shift
// NOTE: UPDATE PITCH SHIFT AND GAIN TIMES BY TIMING THE PERFORMER
e.put("e7", Routine({
	var control, control_specs,	synth_sound, synth_freeze, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_below", "levels" -> #[30.0, 0.1, 0.1], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_below_mul", "levels" -> #[1.0, 5.0, 5.0], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift1", "levels" -> #[0.0, 0.0, 2.5], "times" -> #[6, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift2", "levels" -> #[0.0, -1.0, -1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 2.0, 2.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synth_sound = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1], \mul, 5.0], ~grp[1], \addToTail);
	// synth_sound = Synth(\sampler_pan, [\buf, ~samples["test"]["1"], \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	synth_freeze = Synth(\fft_freeze, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \release_time, 1.0], ~grp[1], \addToTail);
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[1][0], \out, ~audiobus[4][0], \irbuf, ~convolution_buffers["toilet_bowl"], \mul, 1, \wetdry, 0.1], ~grp[3], \addToTail);
    synths.add(Synth(\gain8, [\in, ~audiobus[4][0], \out, ~audiobus[5][0], \level, ~controlbus[6], \limiter, 1], ~grp[4], \addToTail));
	synths.add(Synth(\from8to8, [\in, ~audiobus[5][0], \out, 0], ~grp[5], \addToTail));

	// FREEZE ///////////////////////////////////////////////////////////////
    0.5.yield;
	synth_freeze.set(\freeze, 1.0);
	synth_sound.set(\gate, 0);

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    // free mic and freeze
	5.yield;
	synth_freeze.set(\gate, 0);
	synth_sound.free;

	// wait for reverb to die down
    4.yield;
	synth_freeze.free;
    synth_reverb.set(\gate, 0);

	// free everything else
    1.yield;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));

// fft freeze and slow pitch shift
// NOTE: UPDATE PITCH SHIFT AND GAIN TIMES BY TIMING THE PERFORMER
e.put("e8", Routine({
	var control, control_specs,	synth_sound, synth_freeze, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_below", "levels" -> #[30.0, 0.1, 0.1], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_below_mul", "levels" -> #[1.0, 5.0, 5.0], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift1", "levels" -> #[0.0, 0.0, 2.5], "times" -> #[6, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift2", "levels" -> #[0.0, -1.0, -1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 2.0, 2.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synth_sound = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][1], \pos, ~controlbus[0], \width, ~controlbus[1], \mul, 5.0], ~grp[1], \addToTail);
	// synth_sound = Synth(\sampler_pan, [\buf, ~samples["test"]["1"], \out, ~audiobus[0][1], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	synth_freeze = Synth(\fft_freeze, [\in, ~audiobus[0][1], \out, ~audiobus[1][1], \release_time, 1.0], ~grp[1], \addToTail);
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[1][1], \out, ~audiobus[4][1], \irbuf, ~convolution_buffers["toilet_bowl"], \mul, 1, \wetdry, 0.1], ~grp[3], \addToTail);
    synths.add(Synth(\gain8, [\in, ~audiobus[4][1], \out, ~audiobus[5][1], \level, ~controlbus[6], \limiter, 1], ~grp[4], \addToTail));
	synths.add(Synth(\from8to8, [\in, ~audiobus[5][1], \out, 0], ~grp[5], \addToTail));

	// FREEZE 1 ///////////////////////////////////////////////////////////////
    0.5.yield;
	synth_freeze.set(\freeze, 1.0);
	synth_sound.set(\gate, 0);

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    // free mic and freeze
	5.yield;
	synth_freeze.set(\gate, 0);
	synth_sound.free;

	// wait for reverb to die down
    4.yield;
	synth_freeze.free;
    synth_reverb.set(\gate, 0);

	// free everything else
    1.yield;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));

// fft freeze and slow pitch shift
// NOTE: UPDATE PITCH SHIFT AND GAIN TIMES BY TIMING THE PERFORMER
e.put("e9", Routine({
	var control, control_specs,	synth_sound, synth_freeze, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_below", "levels" -> #[30.0, 0.1, 0.1], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_below_mul", "levels" -> #[1.0, 5.0, 5.0], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift1", "levels" -> #[0.0, 0.0, 2.5], "times" -> #[6, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift2", "levels" -> #[0.0, -1.0, -1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 2.0, 2.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synth_sound = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][2], \pos, ~controlbus[0], \width, ~controlbus[1], \mul, 5.0], ~grp[1], \addToTail);
	// synth_sound = Synth(\sampler_pan, [\buf, ~samples["test"]["1"], \out, ~audiobus[0][1], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	synth_freeze = Synth(\fft_freeze, [\in, ~audiobus[0][2], \out, ~audiobus[1][2], \release_time, 1.0], ~grp[1], \addToTail);
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[1][2], \out, ~audiobus[4][2], \irbuf, ~convolution_buffers["toilet_bowl"], \mul, 1, \wetdry, 0.1], ~grp[3], \addToTail);
    synths.add(Synth(\gain8, [\in, ~audiobus[4][2], \out, ~audiobus[5][2], \level, ~controlbus[6], \limiter, 1], ~grp[4], \addToTail));
	synths.add(Synth(\from8to8, [\in, ~audiobus[5][2], \out, 0], ~grp[5], \addToTail));

	// FREEZE 1 ///////////////////////////////////////////////////////////////
    0.5.yield;
	synth_freeze.set(\freeze, 1.0);
	synth_sound.set(\gate, 0);

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    // free mic and freeze
	5.yield;
	synth_freeze.set(\gate, 0);
	synth_sound.free;

	// wait for reverb to die down
    4.yield;
	synth_freeze.free;
    synth_reverb.set(\gate, 0);

	// free everything else
    1.yield;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));

// fft freeze and slow pitch shift
// NOTE: UPDATE PITCH SHIFT AND GAIN TIMES BY TIMING THE PERFORMER
e.put("e10", Routine({
	var control, control_specs,	synth_sound, synth_freeze, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_below", "levels" -> #[30.0, 0.1, 0.1], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_below_mul", "levels" -> #[1.0, 5.0, 5.0], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift1", "levels" -> #[0.0, 0.0, 2.5], "times" -> #[6, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift2", "levels" -> #[0.0, -1.0, -1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 2.0, 2.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synth_sound = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][3], \pos, ~controlbus[0], \width, ~controlbus[1], \mul, 5.0], ~grp[1], \addToTail);
	// synth_sound = Synth(\sampler_pan, [\buf, ~samples["test"]["1"], \out, ~audiobus[0][1], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	synth_freeze = Synth(\fft_freeze, [\in, ~audiobus[0][3], \out, ~audiobus[1][3], \release_time, 1.0], ~grp[1], \addToTail);
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[1][3], \out, ~audiobus[4][3], \irbuf, ~convolution_buffers["toilet_bowl"], \mul, 1, \wetdry, 0.1], ~grp[3], \addToTail);
    synths.add(Synth(\gain8, [\in, ~audiobus[4][1], \out, ~audiobus[5][3], \level, ~controlbus[6], \limiter, 1], ~grp[4], \addToTail));
	synths.add(Synth(\from8to8, [\in, ~audiobus[5][3], \out, 0], ~grp[5], \addToTail));

	// FREEZE 1 ///////////////////////////////////////////////////////////////
    0.5.yield;
	synth_freeze.set(\freeze, 1.0);
	synth_sound.set(\gate, 0);

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    // free mic and freeze
	5.yield;
	synth_freeze.set(\gate, 0);
	synth_sound.free;

	// wait for reverb to die down
    4.yield;
	synth_freeze.free;
    synth_reverb.set(\gate, 0);

	// free everything else
    1.yield;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));

// fft freeze and slow pitch shift
// NOTE: UPDATE PITCH SHIFT AND GAIN TIMES BY TIMING THE PERFORMER
e.put("e11", Routine({
	var control, control_specs,	synth_sound, synth_freeze, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_below", "levels" -> #[30.0, 0.1, 0.1], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_below_mul", "levels" -> #[1.0, 5.0, 5.0], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift1", "levels" -> #[0.0, 0.0, 2.5], "times" -> #[6, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift2", "levels" -> #[0.0, -1.0, -1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 2.0, 2.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synth_sound = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][4], \pos, ~controlbus[0], \width, ~controlbus[1], \mul, 5.0], ~grp[1], \addToTail);
	// synth_sound = Synth(\sampler_pan, [\buf, ~samples["test"]["1"], \out, ~audiobus[0][1], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	synth_freeze = Synth(\fft_freeze, [\in, ~audiobus[0][4], \out, ~audiobus[1][4], \release_time, 1.0], ~grp[1], \addToTail);
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[1][4], \out, ~audiobus[4][4], \irbuf, ~convolution_buffers["toilet_bowl"], \mul, 1, \wetdry, 0.1], ~grp[3], \addToTail);
    synths.add(Synth(\gain8, [\in, ~audiobus[4][4], \out, ~audiobus[5][4], \level, ~controlbus[6], \limiter, 1], ~grp[4], \addToTail));
	synths.add(Synth(\from8to8, [\in, ~audiobus[5][4], \out, 0], ~grp[5], \addToTail));

	// FREEZE 1 ///////////////////////////////////////////////////////////////
    0.5.yield;
	synth_freeze.set(\freeze, 1.0);
	synth_sound.set(\gate, 0);

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    // free mic and freeze
	5.yield;
	synth_freeze.set(\gate, 0);
	synth_sound.free;

	// wait for reverb to die down
    4.yield;
	synth_freeze.free;
    synth_reverb.set(\gate, 0);

	// free everything else
    1.yield;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));

// fft freeze and slow pitch shift
// NOTE: UPDATE PITCH SHIFT AND GAIN TIMES BY TIMING THE PERFORMER
e.put("e12", Routine({
	var control, control_specs,	synth_sound, synth_freeze, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_below", "levels" -> #[30.0, 0.1, 0.1], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_below_mul", "levels" -> #[1.0, 5.0, 5.0], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift1", "levels" -> #[0.0, 0.0, 2.5], "times" -> #[6, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift2", "levels" -> #[0.0, -1.0, -1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 2.0, 2.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synth_sound = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][5], \pos, ~controlbus[0], \width, ~controlbus[1], \mul, 5.0], ~grp[1], \addToTail);
	// synth_sound = Synth(\sampler_pan, [\buf, ~samples["test"]["1"], \out, ~audiobus[0][1], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	synth_freeze = Synth(\fft_freeze, [\in, ~audiobus[0][5], \out, ~audiobus[1][5], \release_time, 1.0], ~grp[1], \addToTail);
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[1][5], \out, ~audiobus[4][5], \irbuf, ~convolution_buffers["toilet_bowl"], \mul, 1, \wetdry, 0.1], ~grp[3], \addToTail);
    synths.add(Synth(\gain8, [\in, ~audiobus[4][5], \out, ~audiobus[5][5], \level, ~controlbus[6], \limiter, 1], ~grp[4], \addToTail));
	synths.add(Synth(\from8to8, [\in, ~audiobus[5][5], \out, 0], ~grp[5], \addToTail));

	// FREEZE 1 ///////////////////////////////////////////////////////////////
    0.5.yield;
	synth_freeze.set(\freeze, 1.0);
	synth_sound.set(\gate, 0);

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    // free mic and freeze
	5.yield;
	synth_freeze.set(\gate, 0);
	synth_sound.free;

	// wait for reverb to die down
    4.yield;
	synth_freeze.free;
    synth_reverb.set(\gate, 0);

	// free everything else
    1.yield;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));

// fft freeze and slow pitch shift
// NOTE: UPDATE PITCH SHIFT AND GAIN TIMES BY TIMING THE PERFORMER
e.put("e13", Routine({
	var control, control_specs,	synth_sound, synth_freeze, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_below", "levels" -> #[30.0, 0.1, 0.1], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_below_mul", "levels" -> #[1.0, 5.0, 5.0], "times" -> #[5, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift1", "levels" -> #[0.0, 0.0, 2.5], "times" -> #[6, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_pitch_shift2", "levels" -> #[0.0, -1.0, -1.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 2.0, 2.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synth_sound = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][6], \pos, ~controlbus[0], \width, ~controlbus[1], \mul, 5.0], ~grp[1], \addToTail);
	// synth_sound = Synth(\sampler_pan, [\buf, ~samples["test"]["1"], \out, ~audiobus[0][1], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	synth_freeze = Synth(\fft_freeze, [\in, ~audiobus[0][6], \out, ~audiobus[1][6], \release_time, 1.0], ~grp[1], \addToTail);
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[1][6], \out, ~audiobus[4][6], \irbuf, ~convolution_buffers["toilet_bowl"], \mul, 1, \wetdry, 0.1], ~grp[3], \addToTail);
    synths.add(Synth(\gain8, [\in, ~audiobus[4][1], \out, ~audiobus[5][6], \level, ~controlbus[6], \limiter, 1], ~grp[4], \addToTail));
	synths.add(Synth(\from8to8, [\in, ~audiobus[5][6], \out, 0], ~grp[5], \addToTail));

	// FREEZE 1 ///////////////////////////////////////////////////////////////
    0.5.yield;
	synth_freeze.set(\freeze, 1.0);
	synth_sound.set(\gate, 0);

	// Hide the freeze, then bring it back later
	5.yield;
	synth_sound.free;
	synth_freeze.set(\gate, 0);
	synth_freeze.set(\attack_time, 0.5);

	// Bring the freeze back
	5.yield;
	synth_freeze.set(\gate, 1);

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    // free mic and freeze
	5.yield;
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

// accompaniment in lower fifths
e.put("e14", Routine({
	var control, control_specs,	synth_sound, synth_reverb, synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_shift_ratio", "levels" -> #[0.66666666667, 0.66666666667], "times" -> #[100], "curves" -> #[0]],
		Dictionary["name" -> "control_gain", "levels" -> #[1.0, 2.0, 2.0], "times" -> #[10, 100], "curves" -> #[0, 0]],
	];

	control = Array.fill(control_specs.size, {
		| i |
		Synth(\ctrl_env, [\out, ~controlbus[i], \levels, control_specs[i]["levels"], \times, control_specs[i]["times"], \curves, control_specs[i]["curves"]], ~grp[0]);
	});

	// SYNTHS ///////////////////////////////////////////////////////////////
	synths = List();
	synth_sound = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][7], \pos, ~controlbus[0], \width, ~controlbus[1], \mul, 5.0], ~grp[1], \addToTail);
	// synth_sound = Synth(\sampler_pan, [\buf, ~samples["test"]["1"], \out, ~audiobus[0][1], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);
	synths.add(Synth(\pitchshift1env, [\in, ~audiobus[0][8], \out, ~audiobus[1][8], \ratio1, ~controlbus[2], \attack_time, 1.0, \release_time, 1.0], ~grp[2], \addToTail));
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[1][8], \out, ~audiobus[4][8], \irbuf, ~convolution_buffers["toilet_bowl"], \mul, 1, \wetdry, 0.1], ~grp[3], \addToTail);
    synths.add(Synth(\gain8, [\in, ~audiobus[4][8], \out, ~audiobus[5][8], \level, ~controlbus[3], \limiter, 1], ~grp[4], \addToTail));
	synths.add(Synth(\from8to8, [\in, ~audiobus[5][8], \out, 0], ~grp[5], \addToTail));


	// SHUTDOWN ///////////////////////////////////////////////////////////////
    // free mic
	5.yield;
	synth_sound.set(\gate, 0);

	// free reverb
	1.yield;
    synth_reverb.set(\gate, 0);
	synth_sound.free;

	// free everything else
    1.yield;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));



// Event 19: pattern accompaniment
e.put("e19", Routine({
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

	synth_sound = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1], \mul, 5], ~grp[1], \addToTail);
	//synths.add(Synth(\passthrough8, [\in, ~audiobus[0][0], \out, ~audiobus[1][0]], ~grp[2], \addToTail));
	synths.add(Synth(\psdelay1_et, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \delayint, 2.857142857142857, \semitones, 0, \mul, 1], ~grp[2], \addToTail));
	synths.add(Synth(\psdelay1_et, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \delayint, 5.714285714285714, \semitones, 0, \mul, 1], ~grp[2], \addToTail));
	//synth_fft = Synth(\fft_magbelow2, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \threshold, 0.2, \rmfreq, 200, \rmmul, 0.5, \lpf, 4000, \mul, 10], ~grp[2], \addToTail);
    //synth_filter = Synth(\bpf8, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \freq, ~controlbus[0], \mul, ~controlbus[1]], ~grp[2], \addToTail);
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[1][0], \out, ~audiobus[2][0], \irbuf, ~convolution_buffers["toilet_bowl"], \mul, 1, \wetdry, 0.1], ~grp[4], \addToTail);
	synths.add(Synth(\gain8, [\in, ~audiobus[2][0], \out, ~audiobus[3][0], \level, ~controlbus[2], \limiter, 1], ~grp[6], \addToTail)); // the gain stage comes last
	synths.add(Synth(\from8to8, [\in, ~audiobus[3][0], \out, 0], ~grp[7], \addToTail));


	15.wait;
    synth_sound.set(\gate, 0);

    // wait for reverb to die down
    10.wait;
	synth_sound.free;
    synth_reverb.set(\gate, 0);
    1.wait;
	synth_reverb.free;
	synths.do({|item| item.free});
	control.do({|item| item.free});
}));



// Event 3: pattern accompaniment
e.put("ex", Routine({
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
		\mul, 0.25,
		\dur, Pseq([0.15, 0.15, 0.15, 0.15], inf),
		\group, ~grp[1],
		\addAction, \addToTail,
	);

	synths.add(Synth(\passthrough8, [\in, ~audiobus[0][0], \out, ~audiobus[1][0]], ~grp[2], \addToTail));
	synths.add(Synth(\psdelay1_et, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \delayint, 0.12, \semitones, -2, \mul, 1], ~grp[2], \addToTail));
	synths.add(Synth(\psdelay1_et, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \delayint, 0.24, \semitones, 0, \mul, 1], ~grp[2], \addToTail));
	synths.add(Synth(\psdelay1_et, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \delayint, 0.225, \semitones, -5, \mul, 1], ~grp[2], \addToTail));
	synths.add(Synth(\psdelay1_et, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \delayint, 0.45, \semitones, -7, \mul, 1], ~grp[2], \addToTail));
	//synth_fft = Synth(\fft_magbelow2, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \threshold, 0.2, \rmfreq, 200, \rmmul, 0.5, \lpf, 4000, \mul, 10], ~grp[2], \addToTail);
    //synth_filter = Synth(\bpf8, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \freq, ~controlbus[0], \mul, ~controlbus[1]], ~grp[2], \addToTail);
	synth_reverb = Synth(\partconv8, [\fft_size, ~partconv_size, \in, ~audiobus[1][0], \out, ~audiobus[2][0], \irbuf, ~convolution_buffers[2], \mul, 1, \wetdry, 0.1], ~grp[4], \addToTail);
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