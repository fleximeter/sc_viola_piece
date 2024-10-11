// File: synthdefs_pitchshift.scd
// Pitch shift synthdefs

////////////////////////////////////////////////////////////
// RATIO-BASED PITCH SHIFTS
//
// These pitch shifts are based on ratios. 
////////////////////////////////////////////////////////////

// Pitch shift (vanilla)
SynthDef(\pitchshift, {
    var sig;
	sig = In.ar(\in.kr(0), 8);
	sig = PitchShift.ar(sig, 0.1, \ratio.kr(1), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0));
    Out.ar(\out.kr(0), sig);
}).add;

// Pitch shift with 2 control signals (1 shift and 1 amplitude)
SynthDef(\pitchshift1mul, {
    var ctrl_shift, ctrl_amp, sig;
	ctrl_shift = In.kr(\ratio.kr(1), 1);
	ctrl_amp = In.kr(\mul.kr(1), 1);
	sig = In.ar(\in.kr(0), 8);
	sig = PitchShift.ar(sig, 0.1, ctrl_shift, \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0));
	sig = sig * ctrl_amp;
    Out.ar(\out.kr(0), sig);
}).add;

// Pitch shift with 1 control signal and 1 shift, and ASR envelope
SynthDef(\pitchshift1env, {
    var ctrl, sig, env;
	ctrl = In.kr(\ratio1.kr(1), 1);
	sig = In.ar(\in.kr(0), 8);
	sig = PitchShift.ar(sig, 0.1, ctrl, \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0));
    env = EnvGen.ar(Env.asr(\attack_time.kr(0.01), 1, \release_time.kr(1.0)), \gate.kr(1.0));
	sig = sig * env;
	Out.ar(\out.kr(0), sig);
}).add;

// Pitch shift with 1 control signal and 1 shift
SynthDef(\pitchshift1, {
    var ctrl, sig;
	ctrl = In.kr(\ratio1.kr(1), 1);
	sig = In.ar(\in.kr(0), 8);
	sig = PitchShift.ar(sig, 0.1, ctrl, \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0));
    Out.ar(\out.kr(0), sig);
}).add;

// Pitch shift with 2 control signals and 2 shifts
SynthDef(\pitchshift2, {
    var ctrl, sig, sig_out;
	ctrl = [
		In.kr(\ratio1.kr(1), 1),
		In.kr(\ratio2.kr(1), 1)
	];
	sig = In.ar(\in.kr(0), 8);
    sig_out = [
		PitchShift.ar(sig, 0.1, ctrl[0], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[1], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0))
	];
	sig_out = Mix(sig_out);
    Out.ar(\out.kr(0), sig_out);
}).add;

// Pitch shift with 3 control signals and 3 shifts
SynthDef(\pitchshift3, {
    var ctrl, sig, sig_out;
	ctrl = [
		In.kr(\ratio1.kr(1), 1),
		In.kr(\ratio2.kr(1), 1),
		In.kr(\ratio3.kr(1), 1)
	];
	sig = In.ar(\in.kr(0), 8);
    sig_out = [
		PitchShift.ar(sig, 0.1, ctrl[0], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[1], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[2], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0))
	];
	sig_out = Mix(sig_out);
    Out.ar(\out.kr(0), sig_out);
}).add;

// Pitch shift with 4 control signals and 4 shifts
SynthDef(\pitchshift4, {
    var ctrl, sig, sig_out;
	ctrl = [
		In.kr(\ratio1.kr(1), 1),
		In.kr(\ratio2.kr(1), 1),
		In.kr(\ratio3.kr(1), 1),
		In.kr(\ratio4.kr(1), 1)
	];
	sig = In.ar(\in.kr(0), 8);
    sig_out = [
		PitchShift.ar(sig, 0.1, ctrl[0], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[1], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[2], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[3], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0))
	];
	sig_out = Mix(sig_out);
    Out.ar(\out.kr(0), sig_out);
}).add;

// Pitch shift with 5 control signals and 5 shifts
SynthDef(\pitchshift5, {
    var ctrl, sig, sig_out;
	ctrl = [
		In.kr(\ratio1.kr(1), 1),
		In.kr(\ratio2.kr(1), 1),
		In.kr(\ratio3.kr(1), 1),
		In.kr(\ratio4.kr(1), 1),
		In.kr(\ratio5.kr(1), 1)
    ];
	sig = In.ar(\in.kr(0), 8);
    sig_out = [
		PitchShift.ar(sig, 0.1, ctrl[0], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[1], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[2], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[3], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[4], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0))
	];
	sig_out = Mix(sig_out);
    Out.ar(\out.kr(0), sig_out);
}).add;

// Pitch shift with 6 control signals and 6 shifts
SynthDef(\pitchshift6, {
    var ctrl, sig, sig_out;
	ctrl = [
		In.kr(\ratio1.kr(1), 1),
		In.kr(\ratio2.kr(1), 1),
		In.kr(\ratio3.kr(1), 1),
		In.kr(\ratio4.kr(1), 1),
		In.kr(\ratio5.kr(1), 1),
		In.kr(\ratio6.kr(1), 1)
	];
	sig = In.ar(\in.kr(0), 8);
    sig_out = [
		PitchShift.ar(sig, 0.1, ctrl[0], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[1], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[2], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[3], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[4], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[5], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0))
	];
	sig_out = Mix(sig_out);
    Out.ar(\out.kr(0), sig_out);
}).add;

// Pitch shift with 7 control signals and 7 shifts
SynthDef(\pitchshift7, {
    var ctrl, sig, sig_out;
	ctrl = [
		In.kr(\ratio1.kr(1), 1),
		In.kr(\ratio2.kr(1), 1),
		In.kr(\ratio3.kr(1), 1),
		In.kr(\ratio4.kr(1), 1),
		In.kr(\ratio5.kr(1), 1),
		In.kr(\ratio6.kr(1), 1),
		In.kr(\ratio7.kr(1), 1)
	];
	sig = In.ar(\in.kr(0), 8);
    sig_out = [
		PitchShift.ar(sig, 0.1, ctrl[0], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[1], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[2], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[3], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[4], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[5], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[6], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0))
	];
	sig_out = Mix(sig_out);
    Out.ar(\out.kr(0), sig_out);
}).add;

// Pitch shift with 8 control signals and 8 shifts
SynthDef(\pitchshift8, {
    var ctrl, sig, sig_out;
	ctrl = [
		In.kr(\ratio1.kr(1), 1),
		In.kr(\ratio2.kr(1), 1),
		In.kr(\ratio3.kr(1), 1),
		In.kr(\ratio4.kr(1), 1),
		In.kr(\ratio5.kr(1), 1),
		In.kr(\ratio6.kr(1), 1),
		In.kr(\ratio7.kr(1), 1),
		In.kr(\ratio8.kr(1), 1)
	];
	sig = In.ar(\in.kr(0), 8);
    sig_out = [
		PitchShift.ar(sig, 0.1, ctrl[0], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[1], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[2], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[3], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[4], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[5], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[6], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[7], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0))
	];
	sig_out = Mix(sig_out);
    Out.ar(\out.kr(0), sig_out);
}).add;

// Pitch shift with 9 control signals and 9 shifts
SynthDef(\pitchshift9, {
    var ctrl, sig, sig_out;
	ctrl = [
		In.kr(\ratio1.kr(1), 1),
		In.kr(\ratio2.kr(1), 1),
		In.kr(\ratio3.kr(1), 1),
		In.kr(\ratio4.kr(1), 1),
		In.kr(\ratio5.kr(1), 1),
		In.kr(\ratio6.kr(1), 1),
		In.kr(\ratio7.kr(1), 1),
		In.kr(\ratio8.kr(1), 1),
		In.kr(\ratio9.kr(1), 1)
	];
	sig = In.ar(\in.kr(0), 8);
    sig_out = [
		PitchShift.ar(sig, 0.1, ctrl[0], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[1], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[2], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[3], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[4], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[5], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[6], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[7], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[8], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0))
	];
	sig_out = Mix(sig_out);
    Out.ar(\out.kr(0), sig_out);
}).add;

// Pitch shift with 10 control signals and 10 shifts
SynthDef(\pitchshift10, {
    var ctrl, sig, sig_out;
	ctrl = [
		In.kr(\ratio1.kr(1), 1),
		In.kr(\ratio2.kr(1), 1),
		In.kr(\ratio3.kr(1), 1),
		In.kr(\ratio4.kr(1), 1),
		In.kr(\ratio5.kr(1), 1),
		In.kr(\ratio6.kr(1), 1),
		In.kr(\ratio7.kr(1), 1),
		In.kr(\ratio8.kr(1), 1),
		In.kr(\ratio9.kr(1), 1),
		In.kr(\ratio10.kr(1), 1)
	];
	sig = In.ar(\in.kr(0), 8);
    sig_out = [
		PitchShift.ar(sig, 0.1, ctrl[0], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[1], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[2], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[3], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[4], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[5], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[6], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[7], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[8], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, ctrl[9], \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0))
	];
	sig_out = Mix(sig_out);
    Out.ar(\out.kr(0), sig_out);
}).add;

////////////////////////////////////////////////////////////
// EQUAL TEMPERED PITCH SHIFTS
//
// These pitch shifts are in equal tempered semitones. 
////////////////////////////////////////////////////////////

// Pitch shift (vanilla)
SynthDef(\pitchshift_et, {
    var sig;
	sig = In.ar(\in.kr(0), 8);
	sig = PitchShift.ar(sig, 0.1, 2 ** (\semitones.kr(0) / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0));
    Out.ar(\out.kr(0), sig);
}).add;

// Pitch shift with 2 control signals (1 shift and 1 amplitude)
SynthDef(\pitchshift1mul_et, {
    var ctrl_shift, ctrl_amp, sig;
	ctrl_shift = In.kr(\semitones.kr(0), 1);
	ctrl_amp = In.kr(\mul.kr(1), 1);
	sig = In.ar(\in.kr(0), 8);
	sig = PitchShift.ar(sig, 0.1, 2 ** (ctrl_shift / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0));
	sig = sig * ctrl_amp;
    Out.ar(\out.kr(0), sig);
}).add;

// Pitch shift with 1 control signal and 1 shift
SynthDef(\pitchshift1_et, {
    var ctrl, sig;
	ctrl = In.kr(\semitones1.kr(0), 1);
	sig = In.ar(\in.kr(0), 8);
	sig = PitchShift.ar(sig, 0.1, 2 ** (ctrl / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0));
    Out.ar(\out.kr(0), sig);
}).add;

// Pitch shift with 2 control signals and 2 shifts
SynthDef(\pitchshift2_et, {
    var ctrl, sig, sig_out;
	ctrl = [
		In.kr(\semitones1.kr(0), 1),
		In.kr(\semitones2.kr(1), 1)
	];
	sig = In.ar(\in.kr(0), 8);
    sig_out = [
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[0] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[1] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0))
	];
	sig_out = Mix(sig_out);
    Out.ar(\out.kr(0), sig_out);
}).add;

// Pitch shift with 3 control signals and 3 shifts
SynthDef(\pitchshift3_et, {
    var ctrl, sig, sig_out;
	ctrl = [
		In.kr(\semitones1.kr(0), 1),
		In.kr(\semitones2.kr(1), 1),
		In.kr(\semitones3.kr(2), 1)
	];
	sig = In.ar(\in.kr(0), 8);
    sig_out = [
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[0] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[1] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[2] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0))
	];
	sig_out = Mix(sig_out);
    Out.ar(\out.kr(0), sig_out);
}).add;

// Pitch shift with 4 control signals and 4 shifts
SynthDef(\pitchshift4_et, {
    var ctrl, sig, sig_out;
	ctrl = [
		In.kr(\semitones1.kr(0), 1),
		In.kr(\semitones2.kr(1), 1),
		In.kr(\semitones3.kr(2), 1),
		In.kr(\semitones4.kr(3), 1)
	];
	sig = In.ar(\in.kr(0), 8);
    sig_out = [
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[0] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[1] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[2] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[3] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0))
	];
	sig_out = Mix(sig_out);
    Out.ar(\out.kr(0), sig_out);
}).add;

// Pitch shift with 5 control signals and 5 shifts
SynthDef(\pitchshift5_et, {
    var ctrl, sig, sig_out;
	ctrl = [
		In.kr(\semitones1.kr(0), 1),
		In.kr(\semitones2.kr(1), 1),
		In.kr(\semitones3.kr(2), 1),
		In.kr(\semitones4.kr(3), 1),
		In.kr(\semitones5.kr(4), 1)
	];
	sig = In.ar(\in.kr(0), 8);
    sig_out = [
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[0] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[1] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[2] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[3] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[4] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0))
	];
	sig_out = Mix(sig_out);
    Out.ar(\out.kr(0), sig_out);
}).add;

// Pitch shift with 6 control signals and 6 shifts
SynthDef(\pitchshift6_et, {
    var ctrl, sig, sig_out;
	ctrl = [
		In.kr(\semitones1.kr(0), 1),
		In.kr(\semitones2.kr(1), 1),
		In.kr(\semitones3.kr(2), 1),
		In.kr(\semitones4.kr(3), 1),
		In.kr(\semitones5.kr(4), 1),
		In.kr(\semitones6.kr(5), 1)
	];
	sig = In.ar(\in.kr(0), 8);
    sig_out = [
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[0] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[1] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[2] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[3] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[4] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[5] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0))
	];
	sig_out = Mix(sig_out);
    Out.ar(\out.kr(0), sig_out);
}).add;

// Pitch shift with 7 control signals and 7 shifts
SynthDef(\pitchshift7_et, {
    var ctrl, sig, sig_out;
	ctrl = [
		In.kr(\semitones1.kr(0), 1),
		In.kr(\semitones2.kr(1), 1),
		In.kr(\semitones3.kr(2), 1),
		In.kr(\semitones4.kr(3), 1),
		In.kr(\semitones5.kr(4), 1),
		In.kr(\semitones6.kr(5), 1),
		In.kr(\semitones7.kr(6), 1)
	];
	sig = In.ar(\in.kr(0), 8);
    sig_out = [
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[0] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[1] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[2] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[3] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[4] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[5] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[6] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0))
	];
	sig_out = Mix(sig_out);
    Out.ar(\out.kr(0), sig_out);
}).add;

// Pitch shift with 8 control signals and 8 shifts
SynthDef(\pitchshift8_et, {
    var ctrl, sig, sig_out;
	ctrl = [
		In.kr(\semitones1.kr(0), 1),
		In.kr(\semitones2.kr(1), 1),
		In.kr(\semitones3.kr(2), 1),
		In.kr(\semitones4.kr(3), 1),
		In.kr(\semitones5.kr(4), 1),
		In.kr(\semitones6.kr(5), 1),
		In.kr(\semitones7.kr(6), 1),
		In.kr(\semitones8.kr(7), 1)
	];
	sig = In.ar(\in.kr(0), 8);
    sig_out = [
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[0] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[1] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[2] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[3] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[4] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[5] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[6] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[7] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0))
	];
	sig_out = Mix(sig_out);
    Out.ar(\out.kr(0), sig_out);
}).add;

// Pitch shift with 9 control signals and 9 shifts
SynthDef(\pitchshift9_et, {
    var ctrl, sig, sig_out;
	ctrl = [
		In.kr(\semitones1.kr(0), 1),
		In.kr(\semitones2.kr(1), 1),
		In.kr(\semitones3.kr(2), 1),
		In.kr(\semitones4.kr(3), 1),
		In.kr(\semitones5.kr(4), 1),
		In.kr(\semitones6.kr(5), 1),
		In.kr(\semitones7.kr(6), 1),
		In.kr(\semitones8.kr(7), 1),
		In.kr(\semitones9.kr(8), 1)
	];
	sig = In.ar(\in.kr(0), 8);
    sig_out = [
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[0] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[1] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[2] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[3] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[4] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[5] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[6] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[7] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[8] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0))
	];
	sig_out = Mix(sig_out);
    Out.ar(\out.kr(0), sig_out);
}).add;

// Pitch shift with 10 control signals and 10 shifts
SynthDef(\pitchshift10_et, {
    var ctrl, sig, sig_out;
	ctrl = [
		In.kr(\semitones1.kr(0), 1),
		In.kr(\semitones2.kr(1), 1),
		In.kr(\semitones3.kr(2), 1),
		In.kr(\semitones4.kr(3), 1),
		In.kr(\semitones5.kr(4), 1),
		In.kr(\semitones6.kr(5), 1),
		In.kr(\semitones7.kr(6), 1),
		In.kr(\semitones8.kr(7), 1),
		In.kr(\semitones9.kr(8), 1),
		In.kr(\semitones10.kr(9), 1)
	];
	sig = In.ar(\in.kr(0), 8);
    sig_out = [
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[0] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[1] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[2] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[3] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[4] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[5] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[6] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[7] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[8] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)),
		PitchShift.ar(sig, 0.1, 2 ** (ctrl[9] / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0))
	];
	sig_out = Mix(sig_out);
    Out.ar(\out.kr(0), sig_out);
}).add;
