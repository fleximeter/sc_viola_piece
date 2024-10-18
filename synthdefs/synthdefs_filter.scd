// File: synthdefs_filter.scd
// Filter synthdefs

//////////////////////////////////////////////////////////////////////////////////////////////
// BANDPASS
//////////////////////////////////////////////////////////////////////////////////////////////

SynthDef(\bpf8, {
    var ctrl_bandwidth, ctrl_freq, sig;
	ctrl_bandwidth = In.kr(\bandwidth.kr(0), 1);
	ctrl_freq = In.kr(\freq.kr(0), 1);
    sig = In.ar(\in.kr(0), 8);
	sig = BPF.ar(sig, ctrl_freq, ctrl_bandwidth / ctrl_freq, 1, \add.kr(0.0));
	sig = sig.madd(\mul.kr(1.0), 0);
	Out.ar(\out.kr(0), sig);
}).add;

//////////////////////////////////////////////////////////////////////////////////////////////
// HIGHPASS
//////////////////////////////////////////////////////////////////////////////////////////////

SynthDef(\hpf8, {
    var ctrl_freq, sig;
	ctrl_freq = In.kr(\freq.kr(0), 1);
    sig = In.ar(\in.kr(0), 8);
    sig = HPF.ar(sig, ctrl_freq, 1, \add.kr(0.0));
	sig = sig.madd(\mul.kr(1.0), 0);
    Out.ar(\out.kr(0), sig);
}).add;

//////////////////////////////////////////////////////////////////////////////////////////////
// LOWPASS
//////////////////////////////////////////////////////////////////////////////////////////////

SynthDef(\lpf8, {
    var ctrl_freq, sig;
	ctrl_freq = In.kr(\freq.kr(0), 1);
    sig = In.ar(\in.kr(0), 8);
    sig = LPF.ar(sig, ctrl_freq, 1, \add.kr(0.0));
	sig = sig.madd(\mul.kr(1.0), 0);
    Out.ar(\out.kr(0), sig);
}).add;


//////////////////////////////////////////////////////////////////////////////////////////////
// OTHER
//////////////////////////////////////////////////////////////////////////////////////////////

// Ringz filter for 8 channels
SynthDef(\ringz8, {
    var ctrl_freq, ctrl_decaytime, sig;
	ctrl_freq = In.kr(\freq.kr(0), 1);
	ctrl_decaytime = In.kr(\decaytime.kr(0), 1);
    sig = In.ar(\in.kr(0), 8);
    sig = Ringz.ar(sig, ctrl_freq, ctrl_decaytime);
	sig = sig.madd(\mul.kr(1.0), 0);
    sig = Limiter.ar(sig, 1.0);
    Out.ar(\out.kr(0), sig);
}).add;

// Resonz filter for 8 channels
SynthDef(\resonz8, {
    var ctrl_freq, ctrl_bwr, sig;
	ctrl_freq = In.kr(\freq.kr(0), 1);
	ctrl_bwr = In.kr(\bwr.kr(0), 1);
    sig = In.ar(\in.kr(0), 8);
    sig = Resonz.ar(sig, ctrl_freq, ctrl_bwr);
   	sig = sig.madd(\mul.kr(1.0), 0);
	sig = Limiter.ar(sig, 1.0);
    Out.ar(\out.kr(0), sig);
}).add;

// Resonz filter for 8 channels, harmonic emphasis based on pitch detection
// You will need to provide some manual amplitude management.
SynthDef(\resonz8_harmonic, {
    var ctrl_bwr, ctrl_harmonic, ctrl_mul, sig, pitch;
	ctrl_bwr = In.kr(\bwr.kr(0), 1);
    ctrl_harmonic = In.kr(\harmonic.kr(0), 1);
	ctrl_mul = In.kr(\mul_sig.kr(0), 1);
	sig = In.ar(\in.kr(0), 8);
	pitch = Pitch.kr(sig, 440, 110, 2000);
	sig = sig * pitch[1].lag(0.5);
	sig = Resonz.ar(sig, pitch[0].lag(0.1) * ctrl_harmonic, ctrl_bwr);
	sig = sig.madd(\mul.kr(1.0), 0);
    sig = Limiter.ar(sig, 1.0);
    Out.ar(\out.kr(0), sig);
}).add;

