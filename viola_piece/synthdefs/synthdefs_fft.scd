// File: synthdefs_fft.scd
// SynthDefs for FFT work

SynthDef(\fft_freeze, {
	var sig, chain, env;
	sig = In.ar(\in.kr(0), 8);
	chain = FFT({LocalBuf(~fft_size)}!8, sig);
	chain = PV_Freeze(chain, \freeze.kr(0.0));
    chain = PV_MagAbove(chain, \above.kr(0.15));  // this gets rid of noise; set parameter based on sound
	sig = IFFT(chain);
	env = EnvGen.ar(Env.asr(\attack_time.ir(0.01), 1.0, \release_time.ir(0.5), -2), \gate.kr(1.0));
	
    // trick to make the sound feel alive
	sig = sig * LFNoise1.ar(LFNoise1.kr(10).linlin(-1, 1, 2, 3)).linlin(-1, 1, 0.9, 1);
    
    sig = sig * env;
	sig = sig.madd(\mul.kr(1.0), 0);
	Out.ar(\out.kr(0), sig);
}).add;

SynthDef(\fft_magsmear, {
	var sig, bins, chain;
	sig = In.ar(\in.kr(0), 8);
	bins = In.kr(\bins.kr(0), 1);
	chain = FFT({LocalBuf(~fft_size)}!8, sig);
	chain = PV_MagSmear(chain, bins);
	sig = IFFT(chain);
	sig = sig.madd(\mul.kr(1.0), 0);
	Out.ar(\out.kr(0), sig);
}).add;

// get lowest magnitude bins and scale them
SynthDef(\fft_magbelow, {
	var sig, chain, ctrl_below;
    sig = In.ar(\in.kr(0), 8);
	ctrl_below = In.kr(\below.kr(0), 1);
	chain = FFT({LocalBuf(~fft_size)}!8, sig);
    chain = PV_MagBelow(chain, ctrl_below);
	sig = IFFT(chain, 1);
	sig = sig.madd(\mul.kr(1.0), 0);
	Out.ar(\out.kr(0), sig);
}).add;

// freeze and bring out a harmonic
SynthDef(\fft_freeze_with_harmonic_emphasis, {
	var sig, chain, pitch, env;
	sig = SoundIn.ar(0);
	chain = FFT(LocalBuf(2048), sig);
	chain = PV_Freeze(chain, \freeze.kr(0.0));
    chain = PV_MagAbove(chain, \above.kr(0.15));  // this gets rid of noise; set parameter based on sound
	sig = IFFT(chain);
	pitch = Pitch.kr(sig, 10);
	sig = Resonz.ar(sig, pitch.lag(1.0) * \harmonic.kr(1.0).lag(1.0), \bwr.kr(1.0));
    env = EnvGen.ar(Env.asr(\attack_time.ir(0.01), 1.0, \release_time.ir(0.5), -2), \gate.kr(1.0));
	
    // trick to make the sound feel alive
	sig = sig * LFNoise1.ar(LFNoise1.kr(10).linlin(-1, 1, 2, 3)).linlin(-1, 1, 0.9, 1);
    
    sig = sig * env;
	sig = sig.madd(\mul.kr(1.0), 0);
	Out.ar(0, sig!2);
}).add;
