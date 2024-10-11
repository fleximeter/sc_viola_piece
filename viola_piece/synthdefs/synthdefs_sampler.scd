// File: synthdefs_sampler.scd
// SynthDefs for sampling

// This is just a simple PlayBuf
SynthDef(\sampler, {
	var env, playback_rate, sig;
	playback_rate = \transpose.ir(1) * BufRateScale.kr(0);
    sig = PlayBuf.ar(1, \buf.ir(0), playback_rate, doneAction: 2);
    sig = sig.madd(\mul.kr(1), 0);
    Out.ar(\out.kr(0), sig);
}).add;

// This is just a simple PlayBuf with panning
SynthDef(\sampler_pan, {
	var env, playback_rate, sig, ctrl_pos, ctrl_width;
	ctrl_pos = In.kr(\pos.kr(0));
	ctrl_width = In.kr(\width.kr(1));
	playback_rate = \transpose.ir(1) * BufRateScale.kr(0);
    sig = PlayBuf.ar(1, \buf.ir(0), playback_rate, doneAction: 2);
    sig = sig.madd(\mul.kr(1), 0);

	sig = PanAz.ar(8, sig, ctrl_pos, 1.0, ctrl_width, 0.5);
	Out.ar(\out.kr(0), sig);
}).add;

// This is just a simple PlayBuf with ADSR
SynthDef(\sampler_adsr, {
	var env, playback_rate, sig;
	playback_rate = \transpose.ir(1) * BufRateScale.kr(0);
	sig = PlayBuf.ar(1, \buf.ir(0), playback_rate, doneAction: 2);
    env = EnvGen.ar(Env.asr(0.05, 1, 0.05), \gate.kr(1), doneAction: 2);
	sig = PanAz.ar(8, sig, \pos.kr(0.0), 1.0, \width.kr(2.0), 0.5);
	sig = sig * env;
    sig = sig.madd(\mul.kr(1), 0);

	Out.ar(\out.kr(0), sig);
}).add;
