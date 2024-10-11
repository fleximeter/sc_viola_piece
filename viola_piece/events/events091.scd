// File: events091.scd
// This file contains individual events starting at measure 91.

// measure 91
e.add("m91" -> Routine({
	// Basic duration controls
	var prevailing_tempo = 60/48;
	var event_duration = 5 * prevailing_tempo;
	var mic_duration = 2 * prevailing_tempo;

	var control_pitch_shift_semitones_1, control_pitch_shift_semitones_2, control_pitch_shift_semitones_3, control_pitch_shift_semitones_4, control_pitch_shift_semitones_5, control_pitch_shift_mul_1, control_pitch_shift_mul_2, control_pitch_shift_mul_3, control_pitch_shift_mul_4, control_pitch_shift_mul_5, control_pan, control_width, control_lpf_freq;

	var synth_mic, synth_pitch_shift1, synth_pitch_shift2, synth_pitch_shift3, synth_pitch_shift4, synth_pitch_shift5, synth_conv, synth_filter;

	// pan position from 0 to 2 and width from 2 to 4. 2 is minimum to avoid dropping out between speaker pairs.
	control_pan = Synth(\ctrl_env, [\out, ~controlbus[0], \levels, #[0.0, 2.0, 2.0], \times, #[6.5, 5], \curves, #[3, 0]], ~grp[0], \addToTail);
	control_width = Synth(\ctrl_env, [\out, ~controlbus[1], \levels, #[2.0, 4.0, 4.0], \times, #[6.5, 5], \curves, #[3, 0]], ~grp[0], \addToTail);

	// pitch shift control signals, in semitones. This is going up the harmonic series, so not exact semitones.
	control_pitch_shift_semitones_1 = Synth(\ctrl_env, [\out, ~controlbus[2], \levels, #[0.0, 0.0], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_2 = Synth(\ctrl_env, [\out, ~controlbus[3], \levels, #[27.86, 27.86], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_3 = Synth(\ctrl_env, [\out, ~controlbus[4], \levels, #[31.02, 31.02], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_4 = Synth(\ctrl_env, [\out, ~controlbus[5], \levels, #[33.69, 33.69], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	// pitch shift amplitude signals. It takes time for the upper partials to emerge.
	control_pitch_shift_mul_1 = Synth(\ctrl_env, [\out, ~controlbus[7], \levels, #[1.0, 1.0], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_2 = Synth(\ctrl_env, [\out, ~controlbus[8], \levels, #[0.0, 0.3, 0.0], \times, #[2, 4], \curves, #[0, 0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_3 = Synth(\ctrl_env, [\out, ~controlbus[9], \levels, #[0.0, 0.25, 0.0], \times, #[2, 4], \curves, #[0, 0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_4 = Synth(\ctrl_env, [\out, ~controlbus[10], \levels, #[0.0, 0.2, 0.0], \times, #[2, 4], \curves, #[0, 0]], ~grp[0], \addToTail);

	control_lpf_freq = Synth(\ctrl_env, [\out, ~controlbus[11], \levels, #[880.0, 660.0, 880.0], \times, #[5, 5], \curves, #[-1, 0]], ~grp[0], \addToTail);

	// mic input
	synth_mic = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);

	// sustain
	synth_conv = Synth(\partconv8, [\fft_size, ~fft_size, \in, ~audiobus[0][0], \out, ~audiobus[1][0], \irbuf, ~convolution_buffers["brownnoise_slow_6"], \mul, 0.15, \wetdry, 0.8], ~grp[2], \addToTail);

	// pitch shift: 5 separate synths because we want complete control over each shift,
	// including over the amplitude of each shift
	synth_pitch_shift1 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[2], \mul, ~controlbus[7],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);
	synth_pitch_shift2 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[3], \mul, ~controlbus[8],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);
	synth_pitch_shift3 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[4], \mul, ~controlbus[9],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);
	synth_pitch_shift4 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[5], \mul, ~controlbus[10],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);

	// take the upper partials off of the sound to prevent excessive brightness
	synth_filter = Synth(\lpf8, [\in, ~audiobus[2][0], \out, 0, \freq, ~controlbus[11]], ~grp[4], \addToTail);

	// free mic
    mic_duration.wait;
    synth_mic.set(\gate, 0);

    // wait for event to finish, then free convolution
	(event_duration - mic_duration + 1).wait;
    synth_conv.set(\gate, 0);

	// free effects after slight delay
	1.wait;
	control_pan.free;
	control_width.free;
	synth_pitch_shift1.free;
	synth_pitch_shift2.free;
	synth_pitch_shift3.free;
	synth_pitch_shift4.free;
	synth_pitch_shift5.free;
	synth_filter.free;
	control_lpf_freq.free;
	control_pitch_shift_semitones_1.free;
	control_pitch_shift_semitones_2.free;
	control_pitch_shift_semitones_3.free;
	control_pitch_shift_semitones_4.free;
	control_pitch_shift_mul_1.free;
	control_pitch_shift_mul_2.free;
	control_pitch_shift_mul_3.free;
	control_pitch_shift_mul_4.free;
}));

// measure 93
e.add("m93" -> Routine({
	// Basic duration controls
	var prevailing_tempo = 60/48;
	var event_duration = 5 * prevailing_tempo;
	var mic_duration = 2 * prevailing_tempo;

	var control_pitch_shift_semitones_1, control_pitch_shift_semitones_2, control_pitch_shift_semitones_3, control_pitch_shift_semitones_4, control_pitch_shift_semitones_5, control_pitch_shift_mul_1, control_pitch_shift_mul_2, control_pitch_shift_mul_3, control_pitch_shift_mul_4, control_pitch_shift_mul_5, control_pan, control_width, control_lpf_freq;

	var synth_mic, synth_pitch_shift1, synth_pitch_shift2, synth_pitch_shift3, synth_pitch_shift4, synth_pitch_shift5, synth_conv, synth_filter;

	// pan position from 0 to 2 and width from 2 to 4. 2 is minimum to avoid dropping out between speaker pairs.
	control_pan = Synth(\ctrl_env, [\out, ~controlbus[0], \levels, #[0.0, 2.0, 2.0], \times, #[6.5, 5], \curves, #[3, 0]], ~grp[0], \addToTail);
	control_width = Synth(\ctrl_env, [\out, ~controlbus[1], \levels, #[2.0, 4.0, 4.0], \times, #[6.5, 5], \curves, #[3, 0]], ~grp[0], \addToTail);

	// pitch shift control signals, in semitones. This is going up the harmonic series, so not exact semitones.
	control_pitch_shift_semitones_1 = Synth(\ctrl_env, [\out, ~controlbus[2], \levels, #[0.0, 0.0], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_2 = Synth(\ctrl_env, [\out, ~controlbus[3], \levels, #[27.86, 27.86], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_3 = Synth(\ctrl_env, [\out, ~controlbus[4], \levels, #[31.02, 31.02], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_4 = Synth(\ctrl_env, [\out, ~controlbus[5], \levels, #[33.69, 33.69], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	// pitch shift amplitude signals. It takes time for the upper partials to emerge.
	control_pitch_shift_mul_1 = Synth(\ctrl_env, [\out, ~controlbus[7], \levels, #[1.0, 1.0], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_2 = Synth(\ctrl_env, [\out, ~controlbus[8], \levels, #[0.0, 0.3, 0.0], \times, #[2, 4], \curves, #[0, 0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_3 = Synth(\ctrl_env, [\out, ~controlbus[9], \levels, #[0.0, 0.25, 0.0], \times, #[2, 4], \curves, #[0, 0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_4 = Synth(\ctrl_env, [\out, ~controlbus[10], \levels, #[0.0, 0.2, 0.0], \times, #[2, 4], \curves, #[0, 0]], ~grp[0], \addToTail);

	control_lpf_freq = Synth(\ctrl_env, [\out, ~controlbus[11], \levels, #[880.0, 660.0, 880.0], \times, #[5, 5], \curves, #[-1, 0]], ~grp[0], \addToTail);

	// mic input
	synth_mic = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);

	// sustain
	synth_conv = Synth(\partconv8, [\fft_size, ~fft_size, \in, ~audiobus[0][0], \out, ~audiobus[1][0], \irbuf, ~convolution_buffers["whitenoise_slow_3"], \mul, 0.15, \wetdry, 0.8], ~grp[2], \addToTail);

	// pitch shift: 5 separate synths because we want complete control over each shift,
	// including over the amplitude of each shift
	synth_pitch_shift1 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[2], \mul, ~controlbus[7],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);
	synth_pitch_shift2 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[3], \mul, ~controlbus[8],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);
	synth_pitch_shift3 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[4], \mul, ~controlbus[9],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);
	synth_pitch_shift4 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[5], \mul, ~controlbus[10],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);

	// take the upper partials off of the sound to prevent excessive brightness
	synth_filter = Synth(\lpf8, [\in, ~audiobus[2][0], \out, 0, \freq, ~controlbus[11]], ~grp[4], \addToTail);

	// free mic
    mic_duration.wait;
    synth_mic.set(\gate, 0);

    // wait for event to finish, then free convolution
	(event_duration - mic_duration + 1).wait;
    synth_conv.set(\gate, 0);

	// free effects after slight delay
	1.wait;
	control_pan.free;
	control_width.free;
	synth_pitch_shift1.free;
	synth_pitch_shift2.free;
	synth_pitch_shift3.free;
	synth_pitch_shift4.free;
	synth_pitch_shift5.free;
	synth_filter.free;
	control_lpf_freq.free;
	control_pitch_shift_semitones_1.free;
	control_pitch_shift_semitones_2.free;
	control_pitch_shift_semitones_3.free;
	control_pitch_shift_semitones_4.free;
	control_pitch_shift_mul_1.free;
	control_pitch_shift_mul_2.free;
	control_pitch_shift_mul_3.free;
	control_pitch_shift_mul_4.free;
}));

// measure 95
e.add("m95" -> Routine({
	// Basic duration controls
	var prevailing_tempo = 60/48;
	var event_duration = 5 * prevailing_tempo;
	var mic_duration = 2 * prevailing_tempo;

	var control_pitch_shift_semitones_1, control_pitch_shift_semitones_2, control_pitch_shift_semitones_3, control_pitch_shift_semitones_4, control_pitch_shift_semitones_5, control_pitch_shift_mul_1, control_pitch_shift_mul_2, control_pitch_shift_mul_3, control_pitch_shift_mul_4, control_pitch_shift_mul_5, control_pan, control_width, control_lpf_freq;

	var synth_mic, synth_pitch_shift1, synth_pitch_shift2, synth_pitch_shift3, synth_pitch_shift4, synth_pitch_shift5, synth_conv, synth_filter;

	// pan position from 0 to 2 and width from 2 to 4. 2 is minimum to avoid dropping out between speaker pairs.
	control_pan = Synth(\ctrl_env, [\out, ~controlbus[0], \levels, #[0.0, 2.0, 2.0], \times, #[6.5, 5], \curves, #[3, 0]], ~grp[0], \addToTail);
	control_width = Synth(\ctrl_env, [\out, ~controlbus[1], \levels, #[2.0, 4.0, 4.0], \times, #[6.5, 5], \curves, #[3, 0]], ~grp[0], \addToTail);

	// pitch shift control signals, in semitones. This is going up the harmonic series, so not exact semitones.
	control_pitch_shift_semitones_1 = Synth(\ctrl_env, [\out, ~controlbus[2], \levels, #[0.0, 0.0], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_2 = Synth(\ctrl_env, [\out, ~controlbus[3], \levels, #[27.86, 27.86], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_3 = Synth(\ctrl_env, [\out, ~controlbus[4], \levels, #[31.02, 31.02], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_4 = Synth(\ctrl_env, [\out, ~controlbus[5], \levels, #[33.69, 33.69], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	// pitch shift amplitude signals. It takes time for the upper partials to emerge.
	control_pitch_shift_mul_1 = Synth(\ctrl_env, [\out, ~controlbus[7], \levels, #[1.0, 1.0], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_2 = Synth(\ctrl_env, [\out, ~controlbus[8], \levels, #[0.0, 0.3, 0.0], \times, #[2, 4], \curves, #[0, 0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_3 = Synth(\ctrl_env, [\out, ~controlbus[9], \levels, #[0.0, 0.25, 0.0], \times, #[2, 4], \curves, #[0, 0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_4 = Synth(\ctrl_env, [\out, ~controlbus[10], \levels, #[0.0, 0.2, 0.0], \times, #[2, 4], \curves, #[0, 0]], ~grp[0], \addToTail);

	control_lpf_freq = Synth(\ctrl_env, [\out, ~controlbus[11], \levels, #[880.0, 660.0, 880.0], \times, #[5, 5], \curves, #[-1, 0]], ~grp[0], \addToTail);

	// mic input
	synth_mic = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);

	// sustain
	synth_conv = Synth(\partconv8, [\fft_size, ~fft_size, \in, ~audiobus[0][0], \out, ~audiobus[1][0], \irbuf, ~convolution_buffers["brownnoise_medium_3"], \mul, 0.15, \wetdry, 0.8], ~grp[2], \addToTail);

	// pitch shift: 5 separate synths because we want complete control over each shift,
	// including over the amplitude of each shift
	synth_pitch_shift1 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[2], \mul, ~controlbus[7],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);
	synth_pitch_shift2 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[3], \mul, ~controlbus[8],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);
	synth_pitch_shift3 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[4], \mul, ~controlbus[9],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);
	synth_pitch_shift4 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[5], \mul, ~controlbus[10],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);

	// take the upper partials off of the sound to prevent excessive brightness
	synth_filter = Synth(\lpf8, [\in, ~audiobus[2][0], \out, 0, \freq, ~controlbus[11]], ~grp[4], \addToTail);

	// free mic
    mic_duration.wait;
    synth_mic.set(\gate, 0);

    // wait for event to finish, then free convolution
	(event_duration - mic_duration + 1).wait;
    synth_conv.set(\gate, 0);

	// free effects after slight delay
	1.wait;
	control_pan.free;
	control_width.free;
	synth_pitch_shift1.free;
	synth_pitch_shift2.free;
	synth_pitch_shift3.free;
	synth_pitch_shift4.free;
	synth_pitch_shift5.free;
	synth_filter.free;
	control_lpf_freq.free;
	control_pitch_shift_semitones_1.free;
	control_pitch_shift_semitones_2.free;
	control_pitch_shift_semitones_3.free;
	control_pitch_shift_semitones_4.free;
	control_pitch_shift_mul_1.free;
	control_pitch_shift_mul_2.free;
	control_pitch_shift_mul_3.free;
	control_pitch_shift_mul_4.free;
}));

// measure 97
e.add("m97" -> Routine({
	// Basic duration controls
	var prevailing_tempo = 60/48;
	var event_duration = 5 * prevailing_tempo;
	var mic_duration = 2 * prevailing_tempo;

	var control_pitch_shift_semitones_1, control_pitch_shift_semitones_2, control_pitch_shift_semitones_3, control_pitch_shift_semitones_4, control_pitch_shift_semitones_5, control_pitch_shift_mul_1, control_pitch_shift_mul_2, control_pitch_shift_mul_3, control_pitch_shift_mul_4, control_pitch_shift_mul_5, control_pan, control_width, control_lpf_freq;

	var synth_mic, synth_pitch_shift1, synth_pitch_shift2, synth_pitch_shift3, synth_pitch_shift4, synth_pitch_shift5, synth_conv, synth_filter;

	// pan position from 0 to 2 and width from 2 to 4. 2 is minimum to avoid dropping out between speaker pairs.
	control_pan = Synth(\ctrl_env, [\out, ~controlbus[0], \levels, #[0.0, 2.0, 2.0], \times, #[6.5, 5], \curves, #[3, 0]], ~grp[0], \addToTail);
	control_width = Synth(\ctrl_env, [\out, ~controlbus[1], \levels, #[2.0, 4.0, 4.0], \times, #[6.5, 5], \curves, #[3, 0]], ~grp[0], \addToTail);

	// pitch shift control signals, in semitones. This is going up the harmonic series, so not exact semitones.
	control_pitch_shift_semitones_1 = Synth(\ctrl_env, [\out, ~controlbus[2], \levels, #[0.0, 0.0], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_2 = Synth(\ctrl_env, [\out, ~controlbus[3], \levels, #[27.86, 27.86], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_3 = Synth(\ctrl_env, [\out, ~controlbus[4], \levels, #[31.02, 31.02], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_4 = Synth(\ctrl_env, [\out, ~controlbus[5], \levels, #[33.69, 33.69], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	// pitch shift amplitude signals. It takes time for the upper partials to emerge.
	control_pitch_shift_mul_1 = Synth(\ctrl_env, [\out, ~controlbus[7], \levels, #[1.0, 1.0], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_2 = Synth(\ctrl_env, [\out, ~controlbus[8], \levels, #[0.0, 0.3, 0.0], \times, #[2, 4], \curves, #[0, 0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_3 = Synth(\ctrl_env, [\out, ~controlbus[9], \levels, #[0.0, 0.25, 0.0], \times, #[2, 4], \curves, #[0, 0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_4 = Synth(\ctrl_env, [\out, ~controlbus[10], \levels, #[0.0, 0.2, 0.0], \times, #[2, 4], \curves, #[0, 0]], ~grp[0], \addToTail);

	control_lpf_freq = Synth(\ctrl_env, [\out, ~controlbus[11], \levels, #[880.0, 660.0, 880.0], \times, #[5, 5], \curves, #[-1, 0]], ~grp[0], \addToTail);

	// mic input
	synth_mic = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);

	// sustain
	synth_conv = Synth(\partconv8, [\fft_size, ~fft_size, \in, ~audiobus[0][0], \out, ~audiobus[1][0], \irbuf, ~convolution_buffers["brownnoise_medium_3"], \mul, 0.15, \wetdry, 0.8], ~grp[2], \addToTail);

	// pitch shift: 5 separate synths because we want complete control over each shift,
	// including over the amplitude of each shift
	synth_pitch_shift1 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[2], \mul, ~controlbus[7],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);
	synth_pitch_shift2 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[3], \mul, ~controlbus[8],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);
	synth_pitch_shift3 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[4], \mul, ~controlbus[9],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);
	synth_pitch_shift4 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[5], \mul, ~controlbus[10],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);

	// take the upper partials off of the sound to prevent excessive brightness
	synth_filter = Synth(\lpf8, [\in, ~audiobus[2][0], \out, 0, \freq, ~controlbus[11]], ~grp[4], \addToTail);

	// free mic
    mic_duration.wait;
    synth_mic.set(\gate, 0);

    // wait for event to finish, then free convolution
	(event_duration - mic_duration + 1).wait;
    synth_conv.set(\gate, 0);

	// free effects after slight delay
	1.wait;
	control_pan.free;
	control_width.free;
	synth_pitch_shift1.free;
	synth_pitch_shift2.free;
	synth_pitch_shift3.free;
	synth_pitch_shift4.free;
	synth_pitch_shift5.free;
	synth_filter.free;
	control_lpf_freq.free;
	control_pitch_shift_semitones_1.free;
	control_pitch_shift_semitones_2.free;
	control_pitch_shift_semitones_3.free;
	control_pitch_shift_semitones_4.free;
	control_pitch_shift_mul_1.free;
	control_pitch_shift_mul_2.free;
	control_pitch_shift_mul_3.free;
	control_pitch_shift_mul_4.free;
}));

// measure 99
e.add("m99" -> Routine({
	// Basic duration controls
	var prevailing_tempo = 60/48;
	var event_duration = 5 * prevailing_tempo;
	var mic_duration = 2 * prevailing_tempo;

	var control_pitch_shift_semitones_1, control_pitch_shift_semitones_2, control_pitch_shift_semitones_3, control_pitch_shift_semitones_4, control_pitch_shift_semitones_5, control_pitch_shift_mul_1, control_pitch_shift_mul_2, control_pitch_shift_mul_3, control_pitch_shift_mul_4, control_pitch_shift_mul_5, control_pan, control_width, control_lpf_freq;

	var synth_mic, synth_pitch_shift1, synth_pitch_shift2, synth_pitch_shift3, synth_pitch_shift4, synth_pitch_shift5, synth_conv, synth_filter;

	// pan position from 0 to 2 and width from 2 to 4. 2 is minimum to avoid dropping out between speaker pairs.
	control_pan = Synth(\ctrl_env, [\out, ~controlbus[0], \levels, #[0.0, 2.0, 2.0], \times, #[6.5, 5], \curves, #[3, 0]], ~grp[0], \addToTail);
	control_width = Synth(\ctrl_env, [\out, ~controlbus[1], \levels, #[2.0, 4.0, 4.0], \times, #[6.5, 5], \curves, #[3, 0]], ~grp[0], \addToTail);

	// pitch shift control signals, in semitones. This is going up the harmonic series, so not exact semitones.
	control_pitch_shift_semitones_1 = Synth(\ctrl_env, [\out, ~controlbus[2], \levels, #[0.0, 0.0], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_2 = Synth(\ctrl_env, [\out, ~controlbus[3], \levels, #[27.86, 27.86], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_3 = Synth(\ctrl_env, [\out, ~controlbus[4], \levels, #[31.02, 31.02], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_4 = Synth(\ctrl_env, [\out, ~controlbus[5], \levels, #[33.69, 33.69], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	// pitch shift amplitude signals. It takes time for the upper partials to emerge.
	control_pitch_shift_mul_1 = Synth(\ctrl_env, [\out, ~controlbus[7], \levels, #[1.0, 1.0], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_2 = Synth(\ctrl_env, [\out, ~controlbus[8], \levels, #[0.0, 0.3, 0.0], \times, #[2, 4], \curves, #[0, 0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_3 = Synth(\ctrl_env, [\out, ~controlbus[9], \levels, #[0.0, 0.25, 0.0], \times, #[2, 4], \curves, #[0, 0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_4 = Synth(\ctrl_env, [\out, ~controlbus[10], \levels, #[0.0, 0.2, 0.0], \times, #[2, 4], \curves, #[0, 0]], ~grp[0], \addToTail);

	control_lpf_freq = Synth(\ctrl_env, [\out, ~controlbus[11], \levels, #[880.0, 660.0, 880.0], \times, #[5, 5], \curves, #[-1, 0]], ~grp[0], \addToTail);

	// mic input
	synth_mic = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);

	// sustain
	synth_conv = Synth(\partconv8, [\fft_size, ~fft_size, \in, ~audiobus[0][0], \out, ~audiobus[1][0], \irbuf, ~convolution_buffers["brownnoise_medium_3"], \mul, 0.15, \wetdry, 0.8], ~grp[2], \addToTail);

	// pitch shift: 5 separate synths because we want complete control over each shift,
	// including over the amplitude of each shift
	synth_pitch_shift1 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[2], \mul, ~controlbus[7],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);
	synth_pitch_shift2 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[3], \mul, ~controlbus[8],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);
	synth_pitch_shift3 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[4], \mul, ~controlbus[9],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);
	synth_pitch_shift4 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[5], \mul, ~controlbus[10],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);

	// take the upper partials off of the sound to prevent excessive brightness
	synth_filter = Synth(\lpf8, [\in, ~audiobus[2][0], \out, 0, \freq, ~controlbus[11]], ~grp[4], \addToTail);

	// free mic
    mic_duration.wait;
    synth_mic.set(\gate, 0);

    // wait for event to finish, then free convolution
	(event_duration - mic_duration + 1).wait;
    synth_conv.set(\gate, 0);

	// free effects after slight delay
	1.wait;
	control_pan.free;
	control_width.free;
	synth_pitch_shift1.free;
	synth_pitch_shift2.free;
	synth_pitch_shift3.free;
	synth_pitch_shift4.free;
	synth_pitch_shift5.free;
	synth_filter.free;
	control_lpf_freq.free;
	control_pitch_shift_semitones_1.free;
	control_pitch_shift_semitones_2.free;
	control_pitch_shift_semitones_3.free;
	control_pitch_shift_semitones_4.free;
	control_pitch_shift_mul_1.free;
	control_pitch_shift_mul_2.free;
	control_pitch_shift_mul_3.free;
	control_pitch_shift_mul_4.free;
}));

// measure 101
e.add("m101" -> Routine({
	// Basic duration controls
	var prevailing_tempo = 60/48;
	var event_duration = 5 * prevailing_tempo;
	var mic_duration = 2 * prevailing_tempo;

	var control_pitch_shift_semitones_1, control_pitch_shift_semitones_2, control_pitch_shift_semitones_3, control_pitch_shift_semitones_4, control_pitch_shift_semitones_5, control_pitch_shift_mul_1, control_pitch_shift_mul_2, control_pitch_shift_mul_3, control_pitch_shift_mul_4, control_pitch_shift_mul_5, control_pan, control_width, control_lpf_freq;

	var synth_mic, synth_pitch_shift1, synth_pitch_shift2, synth_pitch_shift3, synth_pitch_shift4, synth_pitch_shift5, synth_conv, synth_filter;

	// pan position from 0 to 2 and width from 2 to 4. 2 is minimum to avoid dropping out between speaker pairs.
	control_pan = Synth(\ctrl_env, [\out, ~controlbus[0], \levels, #[0.0, 2.0, 2.0], \times, #[6.5, 5], \curves, #[3, 0]], ~grp[0], \addToTail);
	control_width = Synth(\ctrl_env, [\out, ~controlbus[1], \levels, #[2.0, 4.0, 4.0], \times, #[6.5, 5], \curves, #[3, 0]], ~grp[0], \addToTail);

	// pitch shift control signals, in semitones. This is going up the harmonic series, so not exact semitones.
	control_pitch_shift_semitones_1 = Synth(\ctrl_env, [\out, ~controlbus[2], \levels, #[0.0, 0.0], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_2 = Synth(\ctrl_env, [\out, ~controlbus[3], \levels, #[27.86, 27.86], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_3 = Synth(\ctrl_env, [\out, ~controlbus[4], \levels, #[31.02, 31.02], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_4 = Synth(\ctrl_env, [\out, ~controlbus[5], \levels, #[33.69, 33.69], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	// pitch shift amplitude signals. It takes time for the upper partials to emerge.
	control_pitch_shift_mul_1 = Synth(\ctrl_env, [\out, ~controlbus[7], \levels, #[1.0, 1.0], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_2 = Synth(\ctrl_env, [\out, ~controlbus[8], \levels, #[0.0, 0.3, 0.0], \times, #[2, 4], \curves, #[0, 0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_3 = Synth(\ctrl_env, [\out, ~controlbus[9], \levels, #[0.0, 0.25, 0.0], \times, #[2, 4], \curves, #[0, 0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_4 = Synth(\ctrl_env, [\out, ~controlbus[10], \levels, #[0.0, 0.2, 0.0], \times, #[2, 4], \curves, #[0, 0]], ~grp[0], \addToTail);

	control_lpf_freq = Synth(\ctrl_env, [\out, ~controlbus[11], \levels, #[880.0, 660.0, 880.0], \times, #[5, 5], \curves, #[-1, 0]], ~grp[0], \addToTail);

	// mic input
	synth_mic = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);

	// sustain
	synth_conv = Synth(\partconv8, [\fft_size, ~fft_size, \in, ~audiobus[0][0], \out, ~audiobus[1][0], \irbuf, ~convolution_buffers["brownnoise_medium_3"], \mul, 0.15, \wetdry, 0.8], ~grp[2], \addToTail);

	// pitch shift: 5 separate synths because we want complete control over each shift,
	// including over the amplitude of each shift
	synth_pitch_shift1 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[2], \mul, ~controlbus[7],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);
	synth_pitch_shift2 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[3], \mul, ~controlbus[8],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);
	synth_pitch_shift3 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[4], \mul, ~controlbus[9],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);
	synth_pitch_shift4 = Synth(\pitchshift1mul, [
		\in, ~audiobus[1][0], \out, ~audiobus[2][0],
		\semitones, ~controlbus[5], \mul, ~controlbus[10],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[3], \addToTail);

	// take the upper partials off of the sound to prevent excessive brightness
	synth_filter = Synth(\lpf8, [\in, ~audiobus[2][0], \out, 0, \freq, ~controlbus[11]], ~grp[4], \addToTail);

	// free mic
    mic_duration.wait;
    synth_mic.set(\gate, 0);

    // wait for event to finish, then free convolution
	(event_duration - mic_duration + 1).wait;
    synth_conv.set(\gate, 0);

	// free effects after slight delay
	1.wait;
	control_pan.free;
	control_width.free;
	synth_pitch_shift1.free;
	synth_pitch_shift2.free;
	synth_pitch_shift3.free;
	synth_pitch_shift4.free;
	synth_pitch_shift5.free;
	synth_filter.free;
	control_lpf_freq.free;
	control_pitch_shift_semitones_1.free;
	control_pitch_shift_semitones_2.free;
	control_pitch_shift_semitones_3.free;
	control_pitch_shift_semitones_4.free;
	control_pitch_shift_mul_1.free;
	control_pitch_shift_mul_2.free;
	control_pitch_shift_mul_3.free;
	control_pitch_shift_mul_4.free;
}));

// measure 103
e.add("m103" -> Routine({
	// Basic duration controls
	var prevailing_tempo = 60/48;
	var event_duration = 5 * prevailing_tempo;
	var mic_duration = 2 * prevailing_tempo;

	var control_pitch_shift_semitones_1, control_pitch_shift_semitones_2, control_pitch_shift_semitones_3, control_pitch_shift_semitones_4, control_pitch_shift_mul_1, control_pitch_shift_mul_2, control_pitch_shift_mul_3, control_pitch_shift_mul_4, control_pan, control_width, control_lpf_freq;

	var synth_mic, synth_pitch_shift1, synth_pitch_shift2, synth_pitch_shift3, synth_pitch_shift4, synth_reverb, synth_filter;

	// 0. CONTROL SIGNALS

	// pan position from 0 to 2 and width from 2 to 4. 2 is minimum to avoid dropping out between speaker pairs.
	control_pan = Synth(\ctrl_env, [\out, ~controlbus[0], \levels, #[0.0, 2.0, 2.0], \times, #[6.5, 5], \curves, #[3, 0]], ~grp[0], \addToTail);
	control_width = Synth(\ctrl_env, [\out, ~controlbus[1], \levels, #[2.0, 4.0, 4.0], \times, #[6.5, 5], \curves, #[3, 0]], ~grp[0], \addToTail);

	// pitch shift control signals, in semitones. This is going up the harmonic series, so not exact semitones.
	control_pitch_shift_semitones_1 = Synth(\ctrl_env, [\out, ~controlbus[2], \levels, #[-3, -3], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_2 = Synth(\ctrl_env, [\out, ~controlbus[3], \levels, #[-7, -7], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_semitones_3 = Synth(\ctrl_env, [\out, ~controlbus[4], \levels, #[-9, -9], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);

	// pitch shift amplitude signals. It takes time for the upper partials to emerge.
	control_pitch_shift_mul_1 = Synth(\ctrl_env, [\out, ~controlbus[5], \levels, #[1.0, 1.0], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_2 = Synth(\ctrl_env, [\out, ~controlbus[6], \levels, #[1.0, 1.0], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);
	control_pitch_shift_mul_3 = Synth(\ctrl_env, [\out, ~controlbus[7], \levels, #[1.0, 1.0], \times, #[10], \curves, #[0]], ~grp[0], \addToTail);

	// controls the filter cutoff
	control_lpf_freq = Synth(\ctrl_env, [\out, ~controlbus[8], \levels, #[880.0, 660.0, 880.0], \times, #[5, 5], \curves, #[-1, 0]], ~grp[0], \addToTail);


	// 1. MIC INPUT
	synth_mic = Synth(\mic1pan, [\in, ~mic_zero, \out, ~audiobus[0][0], \pos, ~controlbus[0], \width, ~controlbus[1]], ~grp[1], \addToTail);

	// 2. PITCH SHIFT
	// 4 separate synths because we want complete control over each shift,
	// including over the amplitude of each shift
	synth_pitch_shift1 = Synth(\pitchshift1mul, [
		\in, ~audiobus[0][0], \out, ~audiobus[1][0],
		\semitones, ~controlbus[2], \mul, ~controlbus[5],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[2], \addToTail);
	synth_pitch_shift2 = Synth(\pitchshift1mul, [
		\in, ~audiobus[0][0], \out, ~audiobus[1][0],
		\semitones, ~controlbus[3], \mul, ~controlbus[6],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[2], \addToTail);
	synth_pitch_shift3 = Synth(\pitchshift1mul, [
		\in, ~audiobus[0][0], \out, ~audiobus[1][0],
		\semitones, ~controlbus[4], \mul, ~controlbus[7],
		\timeDispersion, 0.01, \pitchDispersion, 0], ~grp[2], \addToTail);

	// 3. LOW PASS FILTER
	// take the upper partials off of the sound to prevent excessive brightness
	synth_filter = Synth(\lpf8, [\in, ~audiobus[1][0], \out, ~audiobus[2][0], \freq, ~controlbus[8]], ~grp[3], \addToTail);

	// 4. REVERB
	synth_reverb = Synth(\partconv8, [\fft_size, ~fft_size, \in, ~audiobus[2][0], \out, 0, \irbuf, ~convolution_buffers["alesis_large1"], \mul, 0.25, \wetdry, 0.2], ~grp[4], \addToTail);


	// CLEANUP

	// A. FREE MIC
	1.yield;
    synth_mic.set(\gate, 0);

	// B. FREE REVERB
	1.yield;
	synth_reverb.set(\gate, 0);

	// C. FREE EFFECTS
	1.yield;
	control_pan.free;
	control_width.free;
	synth_pitch_shift1.free;
	synth_pitch_shift2.free;
	synth_pitch_shift3.free;
	synth_filter.free;

	// D. FREE CONTROL SIGNALS
	control_lpf_freq.free;
	control_pitch_shift_semitones_1.free;
	control_pitch_shift_semitones_2.free;
	control_pitch_shift_semitones_3.free;
	control_pitch_shift_mul_1.free;
	control_pitch_shift_mul_2.free;
	control_pitch_shift_mul_3.free;
}));
