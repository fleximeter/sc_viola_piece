// File: synthdefs_sampler.scd
// SynthDefs for sampling

// This is just a simple PlayBuf
SynthDef(\sampler, {
	var env, playback_rate, sig;
	playback_rate = \transpose.ir(1) * BufRateScale.kr(\buf.ir(0));
    sig = PlayBuf.ar(1, \buf.ir(0), playback_rate);
    sig = sig.madd(\mul.kr(1), 0);
    Out.ar(\out.kr(0), sig);
}).add;

// This is just a simple PlayBuf with panning
SynthDef(\sampler_pan, {
	var playback_rate, sig;
	playback_rate = \transpose.ir(1) * BufRateScale.kr(\buf.ir(0));
    sig = PlayBuf.ar(1, \buf.ir(0), playback_rate);
    sig = sig.madd(\mul.kr(1), 0);
	sig = PanAz.ar(8, sig, \pos.kr(0.0), 1.0, \width.kr(2.0), 0.5);
	Out.ar(\out.kr(0), sig);
}).add;

// This is just a simple PlayBuf with ADSR
SynthDef(\sampler_adsr, {
	var env, playback_rate, sig;
	playback_rate = \transpose.ir(1) * BufRateScale.kr(\buf.ir(0));
	sig = PlayBuf.ar(1, \buf.ir(0), playback_rate);
    env = EnvGen.ar(Env.asr(0.05, 1, 0.05), \gate.kr(1));
	sig = PanAz.ar(8, sig, \pos.kr(0.0), 1.0, \width.kr(2.0), 0.5);
	sig = sig * env;
    sig = sig.madd(\mul.kr(1), 0);
	Out.ar(\out.kr(0), sig);
}).add;

// This is just a simple PlayBuf with fixed envelope
SynthDef(\sampler_env, {
	var env, playback_rate, sig;
	playback_rate = \transpose.ir(1) * BufRateScale.kr(\buf.ir(0));
	sig = PlayBuf.ar(1, \buf.ir(0), playback_rate);
    env = EnvGen.ar(Env([0, 1, 1, 0], [\attack_time.ir(0.01), \dur.ir(1) - \attack_time.ir(0.01) - \release_time.ir(0.01), \release_time.ir(0.01)], \lin));
	sig = PanAz.ar(8, sig, \pos.kr(0.0), 1.0, \width.kr(2.0), 0.5);
	sig = sig * env;
    sig = sig.madd(\mul.kr(1), 0);
	Out.ar(\out.kr(0), sig);
}).add;
