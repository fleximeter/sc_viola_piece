// File: synthdefs_general.scd
// General-purpose synthdefs

//////////////////////////////////////////////////////////////////////////////////////////////
// PATCH CABLE
//////////////////////////////////////////////////////////////////////////////////////////////

// 8 channel patch cable
SynthDef(\passthrough8, {
    var sig, env;
    sig = In.ar(\in.kr(0), 8);
    env = EnvGen.ar(Env.asr(\attack_time.ir(0.01), 1, \decay_time.ir(0.1)), \gate.kr(1.0));
    sig = sig * env;
    sig = sig.madd(\mul.kr(1.0), 0);
    Out.ar(\out.kr(0), sig);
}).add;

// 8 channel patch cable
SynthDef(\passthrough8mul, {
    var sig, env, ctrl_mul;
    sig = In.ar(\in.kr(0), 8);
    ctrl_mul = In.kr(\mul_sig.kr(0), 1);
    env = EnvGen.ar(Env.asr(\attack_time.ir(0.01), 1, \decay_time.ir(0.1)), \gate.kr(1.0));
    sig = sig * env * ctrl_mul;
    sig = sig.madd(\mul.kr(1.0), 0);
    Out.ar(\out.kr(0), sig);
}).add;

// stereo mapper
SynthDef(\from8to2, {
    var sig;
    sig = In.ar(\in.kr(0), 8);
       sig = [sig[5], sig[6], sig[7], sig[0], sig[1], sig[2], sig[3], sig[4]];
    sig = Splay.ar(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// ems mapper
SynthDef(\from8to8, {
    var sig;
    sig = In.ar(\in.kr(0), 8);
       sig = [sig[0], sig[1], sig[7], sig[2], sig[6], sig[3], sig[5], sig[4]];
    Out.ar(\out.kr(0), sig);
}).add;

//////////////////////////////////////////////////////////////////////////////////////////////
// PANNERS
//////////////////////////////////////////////////////////////////////////////////////////////

// 8-channel panner from 8 channel signal
SynthDef(\pan8to8, {
    var sig;
    sig = In.ar(\in.kr(0), 8);
    sig = Mix(sig);
    sig = PanAz.ar(8, sig, \pos.kr(0.0), 1.0, \width.kr(2.0), 0.5);
    Out.ar(\out.kr(0), sig);
}).add;

// 8-channel panner with 2 control signals from 8 channel signal
SynthDef(\pan8to8ctrl, {
    var sig, ctrl_pos, ctrl_width;
    sig = In.ar(\in.kr(0), 8);
    ctrl_pos = In.kr(\pos.kr(0), 1);
    ctrl_width = In.kr(\width.kr(0), 1);
    sig = Mix(sig);
    sig = PanAz.ar(8, sig, ctrl_pos, 1.0, ctrl_width, 0.5);
    Out.ar(\out.kr(0), sig);
}).add;

// 8-channel panner with 2 control signals from 1 channel signal
SynthDef(\pan1to8, {
    var sig, env, pos, width;
    sig = In.ar(\in.kr(0), 1);
    pos = In.kr(\pos.kr(0), 1);
    // map the fader 0-1 to 2-8 for pan width
    width = In.kr(\width.kr(0), 1);
    env = EnvGen.ar(Env.asr(\attack_time.kr(0.01), 1, \decay_time.kr(0.5)), \gate.kr(1.0));
    sig = sig * env;
    sig = PanAz.ar(8, sig, pos, 1.0, width, 0.5);
    Out.ar(\out.kr(0), sig);
}).add;

//////////////////////////////////////////////////////////////////////////////////////////////
// SYNTHESIS
//////////////////////////////////////////////////////////////////////////////////////////////

// Karplus-Strong pluck synthesis
SynthDef(\pluck, {
    var sig;
    sig = WhiteNoise.ar(1);
    sig = Pluck.ar(sig, 1.0, 0.1, (\midi.ir(60).midicps).reciprocal, \decaytime.ir(1.0), \coef.ir(0.5));
    sig = PanAz.ar(8, sig, \pos.kr(0.0), 1.0, \width.kr(2.0), 0.5);
    sig = sig.madd(\mul.kr(1.0), 0);
    Out.ar(\out.kr(0), sig);
}).add;

// an interesting sound
SynthDef(\shiny, {
    var sig;
    sig = Saw.ar(\freq.kr(440));
    // band pass array with fluctuating RQ
    sig = Mix([
        BPF.ar(sig, \freq.kr(440), LFNoise1.ar(3).linlin(-1, 1, 0.8, 1.2), 1),
        BPF.ar(sig, \freq.kr(440) * 4, LFNoise1.ar(3).linlin(-1, 1, 0.8, 1.2), 0.3)
    ]);
    // make random high partials pop out
    sig = CombL.ar(sig, 0.2, LFNoise1.ar(3).linlin(-1, 1, 0.00099, 0.00101));
    sig = sig.madd(\mul.kr(1.0), 0);
    Out.ar(0, sig);
}).add;

SynthDef(\shiny_mul, {
    var sig, mul;
    mul = In.kr(\mul.kr(0));
    sig = Saw.ar(\freq.kr(440));
    // band pass array with fluctuating RQ
    sig = Mix([
        BPF.ar(sig, \freq.kr(440), LFNoise1.ar(3).linlin(-1, 1, 0.8, 1.2), 1),
        BPF.ar(sig, \freq.kr(440) * 4, LFNoise1.ar(3).linlin(-1, 1, 0.8, 1.2), 0.3)
    ]);
    // make random high partials pop out
    sig = CombL.ar(sig, 0.2, LFNoise1.ar(3).linlin(-1, 1, 0.00099, 0.00101));
    sig = sig.madd(mul, 0);
    Out.ar(0, sig);
}).add;

//////////////////////////////////////////////////////////////////////////////////////////////
// EFFECTS
//////////////////////////////////////////////////////////////////////////////////////////////

SynthDef(\gain8, {
    var sig;
    sig = In.ar(\in.kr(0), 8);
    sig = Limiter.ar(sig, \limit.kr(0.5));
    sig = sig.madd(\mul.kr(1.0), 0);
    Out.ar(\out.kr(0), sig);
}).add;

SynthDef(\gain8mul, {
    var sig, ctrl_mul;
    sig = In.ar(\in.kr(0), 8);
    ctrl_mul = In.kr(\mul_sig.kr(0), 1);
    sig = Limiter.ar(sig, \limit.kr(0.5));
    sig = sig.madd(\mul.kr(1.0) * ctrl_mul, 0);
    Out.ar(\out.kr(0), sig);
}).add;

//////////////////////////////////////////////////////////////////////////////////////////////
// CONTROLLERS
//////////////////////////////////////////////////////////////////////////////////////////////

SynthDef(\ctrl_env, {
    var sig;
    sig = EnvGen.kr(Env(\levels.ir(#[0, 1, 0]), \times.ir(#[1, 1]), \curve.ir(#[0, 0])));
    Out.kr(\out.kr(0), sig);
}).add;

SynthDef(\ctrl_sin, {
    var sig, mul, add;
    mul = (\high.ir(2.0) - \low.ir(1.0)) / 2;
    add = \high.ir(2.0) - mul;
    sig = SinOsc.kr(\freq.kr(1), \phase.kr(0.0), mul, add);
    Out.kr(\out.kr(0), sig);
}).add;

SynthDef(\ctrl_tri, {
    var sig, mul, add;
    mul = (\high.ir(2.0) - \low.ir(1.0)) / 2;
    add = \high.ir(2.0) - mul;
    sig = LFTri.kr(\freq.kr(1), \phase.kr(0.0), mul, add);
    Out.kr(\out.kr(0), sig);
}).add;

SynthDef(\ctrl_tri2, {
    var sig;
    sig = LFTri.kr(\freq.kr(1), \phase.kr(0.0), \mul.kr(1.0), \add.kr(0.0));
    Out.kr(\out.kr(0), sig);
}).add;
