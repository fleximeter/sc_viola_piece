// File: synthdefs_sampler.scd
// SynthDefs for sampling

// This is just a simple PlayBuf with panning
SynthDef(\sampler_pan, {
    var playback_rate, sig;
    playback_rate = \transpose.ir(1) * BufRateScale.kr(\buf.ir(0));
    sig = PlayBuf.ar(1, \buf.ir(0), playback_rate);
    sig = sig.madd(\mul.kr(1), 0);
    sig = PanAz.ar(8, sig, \pos.kr(0.0), 1.0, \width.kr(2.0), 0.5);
    Out.ar(\out.kr(0), sig);
}).add;

// This is just a simple PlayBuf with ASR for pbind. It frees automatically.
SynthDef(\sampler_asr_pbind, {
    var env, playback_rate, sig;
    playback_rate = \transpose.ir(1) * BufRateScale.kr(\buf.ir(0));
    sig = PlayBuf.ar(1, \buf.ir(0), playback_rate);
    env = EnvGen.ar(Env.asr(0.05, 1, 0.05), \gate.kr(1), doneAction: 2);
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

// Sampler for doing the recorded version of the piece
// Accepts control for volume level (which you can use the quneo for)
// Outputs to the micbus, as well as two other outs (for gain and reverb)
SynthDef(\sampler_out3, {
    var ctrl_mul, playback_rate, sig, pan_sig;
    playback_rate = \transpose.ir(1) * BufRateScale.kr(\buf.ir(0));
    ctrl_mul = In.kr(\mul_sig.kr(0), 1);
    sig = PlayBuf.ar(1, \buf.ir(0), playback_rate, doneAction: 2);
    sig = sig.madd(\mul.kr(1) * ctrl_mul, 0);
    pan_sig = PanAz.ar(8, sig, \pos.kr(0.0), 1.0, \width.kr(2.0), 0.5);
    Out.ar(~micbus, sig);
    Out.ar(~recordbus1, sig);
    Out.ar(\out.kr(0), pan_sig);
}).add;
