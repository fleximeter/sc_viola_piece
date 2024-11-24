// File: synthdefs_fft.scd
// SynthDefs for FFT work

SynthDef(\fft_freeze_old, {
    var sig, chain, env;
    sig = In.ar(\in.kr(0), 8);
    chain = FFT({LocalBuf(~fft_size)}!8, sig);
    chain = PV_Freeze(chain, \freeze.kr(0.0));
    chain = PV_MagAbove(chain, \above.kr(0.15));  // this gets rid of noise; set parameter based on sound
    sig = IFFT(chain);
    env = EnvGen.ar(Env.asr(\attack_time.ir(0.01), 1.0, \release_time.ir(0.5), -2), \gate.kr(1.0));

    // trick to make the sound feel alive
	sig = sig * LFNoise1.ar(LFNoise1.kr(10).linlin(-1, 1, 2, 3)).linlin(-1, 1, 1 - \amp_fluctuation.ir(0.1), 1 + \amp_fluctuation.ir(0.1));

    sig = sig * env;
    sig = sig.madd(\mul.kr(1.0), 0);
    Out.ar(\out.kr(0), sig);
}).add;

// An adjusted FFT freeze that automatically calculates the amount of denoising to do.
// This is useful because the input signal will vary in level.
SynthDef(\fft_freeze, {
    var sig, chain, env, mag, max;
    sig = In.ar(\in.kr(0), 8);
    chain = FFT({LocalBuf(~fft_size)}!8, sig);

	// Perform the freeze before calculating the peak FFT value
	chain = PV_Freeze(chain, \freeze.kr(0.0));

	// Get the peak FFT value for each of the LocalBufs
    mag = FFTPeak.kr(chain);
	mag = [mag[0][1], mag[0][1], mag[0][1], mag[0][1], mag[0][1], mag[0][1], mag[0][1], mag[0][1]];
	max = ArrayMax.kr(mag).lag(0.2);

	// Remove bins below 10% of the peak value
	chain = PV_MagAbove(chain, \above_frac.kr(0.1) * max[0]);
    sig = IFFT(chain);
    env = EnvGen.ar(Env.asr(\attack_time.ir(0.01), 1.0, \release_time.ir(0.5), -2), \gate.kr(1.0));

    // trick to make the sound feel alive
	sig = sig * LFNoise1.ar(LFNoise1.kr(10).linlin(-1, 1, 2, 3)).linlin(-1, 1, 1 - \amp_fluctuation.ir(0.1), 1 + \amp_fluctuation.ir(0.1));

    sig = sig * env;
    sig = sig.madd(\mul.kr(1.0), 0);
    Out.ar(\out.kr(0), sig);
}).add;


// An adjusted FFT freeze that automatically calculates the amount of denoising to do.
// This is useful because the input signal will vary in level.
SynthDef(\fft_freeze2, {
    var sig, chain, env, env2, mag, max;
    sig = In.ar(\in.kr(0), 8);
    chain = FFT({LocalBuf(~fft_size)}!8, sig);

	// Perform the freeze before calculating the peak FFT value
	chain = PV_Freeze(chain, \freeze.kr(0.0));

	// Get the peak FFT value for each of the LocalBufs
    mag = FFTPeak.kr(chain);
	mag = [mag[0][1], mag[0][1], mag[0][1], mag[0][1], mag[0][1], mag[0][1], mag[0][1], mag[0][1]];
	max = ArrayMax.kr(mag).lag(0.2);

	// Remove bins below 10% of the peak value
	chain = PV_MagAbove(chain, \above_frac.kr(0.1) * max[0]);
    sig = IFFT(chain);

    // shape volume
    env2 = EnvGen.ar(Env(\levels.ir(#[0, 1, 1, 0]), \times.ir(#[0.01, 5, 0.01]), \lin));

    env = EnvGen.ar(Env.asr(\attack_time.ir(0.01), 1.0, \release_time.ir(0.5), -2), \gate.kr(1.0));

    // trick to make the sound feel alive
	sig = sig * LFNoise1.ar(LFNoise1.kr(10).linlin(-1, 1, 2, 3)).linlin(-1, 1, 1 - \amp_fluctuation.ir(0.1), 1 + \amp_fluctuation.ir(0.1));

    sig = sig * env * env2;
    sig = sig.madd(\mul.kr(1.0), 0);
    Out.ar(\out.kr(0), sig);
}).add;

// An adjusted FFT freeze that automatically calculates the amount of denoising to do.
// This is useful because the input signal will vary in level.
// This modified freeze has an additional level adjustment parameter with lag.
SynthDef(\fft_freeze_level_adjust, {
    var sig, chain, env, mag, max;
    sig = In.ar(\in.kr(0), 8);
    chain = FFT({LocalBuf(~fft_size)}!8, sig);

	// Perform the freeze before calculating the peak FFT value
	chain = PV_Freeze(chain, \freeze.kr(0.0));

	// Get the peak FFT value for each of the LocalBufs
    mag = FFTPeak.kr(chain);
	mag = [mag[0][1], mag[0][1], mag[0][1], mag[0][1], mag[0][1], mag[0][1], mag[0][1], mag[0][1]];
	max = ArrayMax.kr(mag).lag(0.2);

	// Remove bins below 10% of the peak value
	chain = PV_MagAbove(chain, \above_frac.kr(0.1) * max[0]);
    sig = IFFT(chain);
    env = EnvGen.ar(Env.asr(\attack_time.ir(0.01), 1.0, \release_time.ir(0.5), -2), \gate.kr(1.0));

    // trick to make the sound feel alive
	sig = sig * LFNoise1.ar(LFNoise1.kr(10).linlin(-1, 1, 2, 3)).linlin(-1, 1, 1 - \amp_fluctuation.ir(0.1), 1 + \amp_fluctuation.ir(0.1));

    sig = sig * env;
	sig = sig.madd(\mul.kr(1.0, \mul_lag.kr(1)), 0);
    Out.ar(\out.kr(0), sig);
}).add;

SynthDef(\fft_magfreeze, {
    var sig, chain, env;
    sig = In.ar(\in.kr(0), 8);
    chain = FFT({LocalBuf(~fft_size)}!8, sig);
    chain = PV_MagFreeze(chain, \freeze.kr(0.0));
    chain = PV_MagAbove(chain, \above.kr(0.15));  // this gets rid of noise; set parameter based on sound
    sig = IFFT(chain);
    env = EnvGen.ar(Env.asr(\attack_time.ir(0.01), 1.0, \release_time.ir(0.5), -2), \gate.kr(1.0));

    // trick to make the sound feel alive
    sig = sig * LFNoise1.ar(LFNoise1.kr(10).linlin(-1, 1, 2, 3)).linlin(-1, 1, 1 - \amp_fluctuation.ir(0.1), 1 + \amp_fluctuation.ir(0.1));

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

SynthDef(\fft_magsmear_pbind, {
    var sig, env, env_mul, chain;
    sig = In.ar(\in.kr(0), 8);
    env = EnvGen.kr(Env([0, 20, 0, 40, 0, 60, 0, 20, 0], [6, 2, 6, 2, 10, 2, 10, 2]));
    env_mul = EnvGen.kr(Env([1, 1.5, 1, 2, 1, 2.5, 1, 1.5, 1], [6, 2, 6, 2, 10, 2, 10, 2], [2, -2, 2, -2, 2, -2, 2, -2]));
    chain = FFT({LocalBuf(~fft_size)}!8, sig);
    chain = PV_MagSmear(chain, env);
    sig = IFFT(chain);
    sig = sig * env_mul;
    sig = sig.madd(\mul.kr(1.0), 0);
    Out.ar(\out.kr(0), sig);
}).add;

// get highest magnitude bins
SynthDef(\fft_magabove, {
    var sig, chain, ctrl_above;
    sig = In.ar(\in.kr(0), 8);
    ctrl_above = In.kr(\above.kr(0), 1);
    chain = FFT({LocalBuf(~fft_size)}!8, sig);
    chain = PV_MagAbove(chain, ctrl_above);
    sig = IFFT(chain, 1);
    sig = sig.madd(\mul.kr(1.0), 0);
    Out.ar(\out.kr(0), sig);
}).add;

// get lowest magnitude bins
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
    sig = sig * LFNoise1.ar(LFNoise1.kr(10).linlin(-1, 1, 2, 3)).linlin(-1, 1, 1 - \amp_fluctuation.ir(0.1), 1 + \amp_fluctuation.ir(0.1));

    sig = sig * env;
    sig = sig.madd(\mul.kr(1.0), 0);
    Out.ar(0, sig!2);
}).add;
