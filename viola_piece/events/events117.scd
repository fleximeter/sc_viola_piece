// File: events117.scd
// This file contains individual events starting at measure 117.

(
// Event 0: measure 3
// Description: Sustain with harmonization
e.add("m117" -> Routine({
	var control_pitch_shift1, control_pitch_shift2, control_pitch_shift3, control_pan, control_width;
	var synth_mic, synth_pitch_shift, synth_conv;

	// pan position from 0 to 2 and width from 2 to 4. 2 is minimum to avoid dropping out between speaker pairs.
	control_pan = Synth(\ctrl_env, [\out, ~controlbus[0], \levels, #[0.0, 2.0, 2.0], \times, #[6.5, 5], \curves, #[3, 0]], ~grp[0], \addToTail);
	control_width = Synth(\ctrl_env, [\out, ~controlbus[1], \levels, #[2.0, 4.0, 4.0], \times, #[6.5, 5], \curves, #[3, 0]], ~grp[0], \addToTail);

	// pitch shift control signals, in semitones
	control_pitch_shift1 = Synth(\ctrl_env, [\out, ~controlbus[2], \levels, #[0.0, 0.0, 0.0], \times, #[4, 10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift2 = Synth(\ctrl_env, [\out, ~controlbus[3], \levels, #[0.0, 4.0, 4.0], \times, #[4, 10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift3 = Synth(\ctrl_env, [\out, ~controlbus[4], \levels, #[0.0, 7.0, 7.0], \times, #[4, 10], \curves, #[0]], ~grp[0], \addToTail);

	// mic input
	synth_mic = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);

	// sustain
	synth_conv = Synth(\partconv8, [\fft_size, ~fft_size, \in, ~audiobus[0][0], \out, ~audiobus[1][0], \irbuf, ~convolution_buffers["brownnoise_medium_3"], \mul, 0.25, \wetdry, 0.8], ~grp[2], \addToTail);

	// pitch shift
	synth_pitch_shift = Synth(\pitchshift3, [
		\in, ~audiobus[1][0], \out, 0,
		\semitones1, ~controlbus[2], \semitones2, ~controlbus[3], \semitones3, ~controlbus[4], \semitones4, ~controlbus[5],
		\mul, 1, \timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);

    // free mic
    4.wait;
    synth_mic.set(\gate, 0);

    // wait for reverb to die down
    4.wait;
    synth_conv.set(\gate, 0);
    1.wait;
	control_pan.free;
	control_width.free;
	control_pitch_shift1.free;
	control_pitch_shift2.free;
	control_pitch_shift3.free;
	synth_pitch_shift.free;
}));

)
