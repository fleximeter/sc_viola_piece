// File: synthdefs_live_buffer.scd
// This file contains synthdefs for working with mics.

// A mono mic input
SynthDef(\mic1, {
	var sig, env;
	sig = SoundIn.ar(\in.kr(0));
    env = EnvGen.ar(Env.asr(\attack_time.kr(0.01), 1, \release_time.kr(0.1)), \gate.kr(1.0));
    //sig = sig * env;
	sig = sig.madd(\mul.kr(1.0), 0);
	Out.ar(\out.kr(0), sig);
}).add;

// A mono mic input that accepts signals for pan position and width
SynthDef(\mic1pan, {
	var sig, env, ctrl_pos, ctrl_width;
	sig = SoundIn.ar(\in.kr(0)) * \mul.kr(1.0);
	ctrl_pos = In.kr(\pos.kr(0), 1);
	ctrl_width = In.kr(\width.kr(0), 1);
    env = EnvGen.ar(Env.asr(\attack_time.kr(0.01), 1, \release_time.kr(0.1)), \gate.kr(1.0));
    sig = sig * env;
	sig = PanAz.ar(8, sig, ctrl_pos, \level.kr(1.0), ctrl_width, 0.5);
	sig = sig.madd(\mul.kr(1.0), \add.kr(0.0));
	Out.ar(\out.kr(0), sig);
}).add;

// A mono mic input that accepts signals for mul
SynthDef(\mic1mul, {
	var sig, env, ctrl_mul;
	sig = SoundIn.ar(\in.kr(0));
	ctrl_mul = In.kr(\mul_sig.kr(0), 1);
    env = EnvGen.ar(Env.asr(0.01, 1, 0.1), \gate.kr(1.0));
	sig = sig.madd(\mul.kr(1.0) * ctrl_mul * env, 0);
	Out.ar(\out.kr(0), sig);
}).add;

// A stereo mic input
SynthDef(\mic2, {
	var sig, env;
	sig = [SoundIn.ar(\in.kr(0)), SoundIn.ar(\in.kr(0) + 1)];
	sig = Mix(sig);
    env = EnvGen.ar(Env.asr(\attack_time.kr(0.01), 1, \release_time.kr(0.1)), \gate.kr(1.0));
    sig = sig * env;
	sig = PanAz.ar(8, sig, \pos.kr(0.0), \level.kr(1.0), \width.kr(2.0), 0.5);
	sig.madd(\mul.kr(1.0), \add.kr(0));
	Out.ar(\out.kr(0), sig);
}).add;

// A stereo mic input that accepts signals for pan position and width
SynthDef(\mic2pan, {
	var sig, env, ctrl1, ctrl2;
	sig = [SoundIn.ar(\in.kr(0)), SoundIn.ar(\in.kr(0) + 1)];
	sig = Mix(sig);
	ctrl1 = In.kr(\pos.kr(0), 1);
	ctrl2 = In.kr(\width.kr(0), 1);
    env = EnvGen.ar(Env.asr(\attack_time.kr(0.01), 1, \release_time.kr(0.1)), \gate.kr(1.0));
    sig = sig * env;
	sig = PanAz.ar(8, sig, ctrl1, \level.kr(1.0), ctrl2, 0.5);
	sig.madd(\mul.kr(1.0), \add.kr(0));
	Out.ar(\out.kr(0), sig);
}).add;

SynthDef(\buffer_ptr, {
	// A pointer to the current recording location in the buffer
	// buf: The buffer
	// out: The output bus
	// rate: The rate (normally 1, but set to 0 to freeze)
	// t_trig: A trigger to reset the starting point
	var ptr;
    ptr = Phasor.ar(\t_trig.tr(0.0), BufRateScale.kr(\buf.ir(0)) * \rate.kr(1.0), 0, BufFrames.kr(\buf.ir(0)));
    Out.ar(\out.ir(0), ptr);
}).add;

// Writes input sound to a buffer over and over again. Requires a buffer writing pointer synth.
SynthDef(\bufwr1, {
	// ptr_in: The output of a pointer synth
	// mic_in: The output of a mic synth
	// buf: The buffer to write
	var ptr, sig;
    ptr = In.ar(\ptr_in.ir(0), 1);
    sig = SoundIn.ar(\mic_in.ir(0), 1);
    BufWr.ar(sig, \buf.ir(0), ptr);
}).add;

// Writes input sound to a buffer over and over again. Requires a buffer writing pointer synth.
SynthDef(\bufwr2, {
	// ptr_in: The output of a pointer synth
	// mic_in: The output of a mic synth
	// buf: The buffer to write
	var ptr, sig;
    ptr = In.ar(\ptr_in.ir(0), 1);
    sig = SoundIn.ar(\mic_in.ir(0), 2);
    BufWr.ar(sig, \buf.ir(0), ptr);
}).add;

SynthDef(\record1, {
	// Records a mono signal to an audio buffer
	var sig, env;
    sig = SoundIn.ar(\in.kr(0), \mul.kr(1.0));
    env = EnvGen.ar(Env([0, 1, 1, 0], [0.02, \record_dur.ir(1) - 0.04, 0.02]), doneAction: 2);
    RecordBuf.ar(sig * env, \buf.ir(0), \offset.ir(0.0), loop: 0);
}).add;

SynthDef(\record_with_fft1, {
	// Records a mono signal to an audio buffer and also records to a FFT buffer
	var sig, chain;
    sig = SoundIn.ar(\in.kr(0), \mul.kr(1.0));
    chain = FFT(LocalBuf(~fft_size), sig);
    PV_RecordBuf(chain, \buf_fft.ir(0), \offset.ir(0.0), 1.0);
    RecordBuf.ar(sig, \buf.ir(0), \offset.ir(0.0), loop: 0, doneAction: 2);
}).add;

SynthDef(\record_fft1, {
	// Records a mono signal to a FFT buffer
	var sig, chain;
    sig = PlayBuf.ar(1, \buf.ir(0));
    chain = FFT(LocalBuf(~fft_size), sig);
    PV_RecordBuf(chain, \buf_fft.ir(0), \offset.ir(0.0), 1.0);
}).add;

SynthDef(\record2, {
	// Records a mono signal to an audio buffer
	var sig;
    sig = SoundIn.ar([\in.kr(0), \in.kr(0) + 1], \mul.kr(1.0));
    RecordBuf.ar(sig, \buf.ir(0), \offset.ir(0.0), loop: 0, doneAction: 2);
}).add;

SynthDef(\record_with_fft2, {
	// Records a mono signal to an audio buffer and also records to a FFT buffer
	var sig, chain;
    sig = SoundIn.ar([\in.kr(0), \in.kr(0) + 1], \mul.kr(1.0));
    chain = FFT(LocalBuf(~fft_size), sig);
    PV_RecordBuf(chain, \buf_fft.ir(0), \offset.ir(0.0), 1.0);
    RecordBuf.ar(sig, \buf.ir(0), \offset.ir(0.0), loop: 0, doneAction: 2);
}).add;

SynthDef(\record_fft2, {
	// Records a mono signal to a FFT buffer
	var sig, chain;
    sig = PlayBuf.ar(2, \buf.ir(0));
    chain = FFT(LocalBuf(~fft_size), sig);
    PV_RecordBuf(chain, \buf_fft.ir(0), \offset.ir(0.0), 1.0);
}).add;

