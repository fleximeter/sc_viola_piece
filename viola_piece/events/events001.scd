// File: events001.scd
// This file contains individual events starting at measure 1.


// FADER 0: NOT USED
// FADER 1: NOT USED
// FADER 2: MIC GAIN
// FADER 3: OUTPUT GAIN
// KNOB 0: WET/DRY BALANCE
// FADER 4: FEEDBACK PERCENT
// FADER 5:
// FADER 6:
// FADER 7:
// FADER 8: BANDPASS CENTER

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

    // control the gain with fader 3
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


// EVENT 9
e.put("e9", Routine({
	var control, control_specs,	synths_freeze, synths;
    var freeze_release_time;
    freeze_release_time = 2;

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
    synths_freeze = List();
	synths.add(Synth(\passthrough8, [\in, ~audiobus[1][0], \out, ~gainbus], ~grp[5], \addToTail));

    // 1 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][0], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["74"]["buffer"]]));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][0], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "9 UPDATE 9.0: Event 9 running and ready for freeze 1 (D5).".yield;
    synths_freeze[0].set(\freeze, 1.0);
    "9 UPDATE 9.1: Event 9 freeze 1 (D5).".yield;

    // 2 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][1], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["g"]["55"]["buffer"]]));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][1], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "9 UPDATE 9.2: Event 9 ready for freeze 2 (G3).".yield;
    synths_freeze[1].set(\freeze, 1.0);
    "9 UPDATE 9.3: Event 9 freeze 2 (G3).\nReady for release 1.".yield;
    synths_freeze[0].set(\gate, 0);
    "9 UPDATE 9.4: Event 9 release 1 (D5).".yield;

    // 3 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][2], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["73"]["buffer"]]));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][2], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "9 UPDATE 9.5: Event 9 ready for freeze 3 (C+5).".yield;
    synths_freeze[2].set(\freeze, 1.0);
    "9 UPDATE 9.6: Event 9 freeze 3 (C+5).".yield;

    // 4 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][3], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["d"]["62"]["buffer"]]));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][3], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "9 UPDATE 9.7: Event 9 ready for freeze 4 (D4).".yield;
    synths_freeze[3].set(\freeze, 1.0);
    "9 UPDATE 9.8: Event 9 freeze 4 (D4).\nReady for release 2.".yield;
    synths_freeze[1].set(\gate, 0);
    "9 UPDATE 9.9: Event 9 release 2 (G3).".yield;

    // 5 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][4], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["a"]["71"]["buffer"]]));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][4], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "9 UPDATE 9.10: Event 9 ready for freeze 5 (B4).".yield;
    synths_freeze[4].set(\freeze, 1.0);
    "9 UPDATE 9.11: Event 9 freeze 5 (B4).\nReady for release 3.".yield;
    synths_freeze[2].set(\gate, 0);
    "9 UPDATE 9.12: Event 9 release 3 (C+5).".yield;

    // 6 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][5], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["d"]["63"]["buffer"]]));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][5], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "9 UPDATE 9.13: Event 9 ready for freeze 6 (D+4).".yield;
    synths_freeze[5].set(\freeze, 1.0);
    "9 UPDATE 9.14: Event 9 freeze 6 (D+4).\nReady for release 4.".yield;
    synths_freeze[3].set(\gate, 0);
    "9 UPDATE 9.15: Event 9 release 4 (D4).".yield;

    // 7 freeze
    synths.add(Synth(\sampler_pan, [\out, ~audiobus[0][6], \pos, 0.0, \width, 2.0, \buf, ~samples["viola.arco"]["mf"]["d"]["65"]["buffer"]]));
    synths_freeze.add(Synth(\fft_freeze, [\in, ~audiobus[0][6], \out, ~audiobus[1][0], \below, 0.2, \release_time, freeze_release_time], ~grp[1], \addToTail));
    "9 UPDATE 9.16: Event 9 ready for freeze 7 (F4).".yield;
    synths_freeze[6].set(\freeze, 1.0);
    "9 UPDATE 9.17: Event 9 freeze 7 (F4).\nReady for final realeases.".yield;
    synths_freeze[4].set(\gate, 0);
    synths_freeze[5].set(\gate, 0);
    synths_freeze[6].set(\gate, 0);
    "9 UPDATE 9.18: Event 9 final realease".yield;

	// SHUTDOWN ///////////////////////////////////////////////////////////////
    synths.do({|item| item.free});
	synths_freeze.do({|item| item.free});
	control.do({|item| item.free});
    "9 UPDATE 9.19: Event 9 kill stage complete. Event finished.".postln;
}));

// EVENT 14
// PS DOWN
e.put("e14", Routine({
	var control, control_specs,	synths;

	// CONTROLS ///////////////////////////////////////////////////////////////
	control_specs = [
		Dictionary["name" -> "sound_pan_pos", "levels" -> #[0.0, 0.0], "times" -> #[20], "curves" -> #[0]],
		Dictionary["name" -> "control_sound_pan_width", "levels" -> #[2.0, 4.0], "times" -> #[20], "curves" -> #[0]],
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
	"14 UPDATE 14.0: Pitch shift in effect.".yield;

	synths[2].set(\gate, 0);
	"14 UPDATE 14.1: Gate closed.".yield;

	synths.do({|item| item.free});
	control.do({|item| item.free});
	"14 UPDATE 14.2: Event 14 kill stage complete. Event finished.".postln;
}));



)