// File: impulse_generator.scd
// Date: 4/13/24
// This file is used to generate impulse responses for PartConv

// The noise synthdef for generating the impulse sound
SynthDef(\noisegen, {
	var sig, env;
	sig = WhiteNoise.ar(-6.dbamp);
	env = EnvGen.ar(Env(\levels.ir(#[0, 1, 1, 0]), \times.ir(#[0.05, 0.1, 4]), \curves.ir(#[1, 0, -1])), doneAction: 2);
	sig = BPF.ar(sig, LFTri.ar(XLine.kr(2, 8, \line.kr(4)), 0, 1500, 1700), \rq.kr(2));
	sig = sig * env;
	Out.ar(0, sig!2);
}).add;


// Record the impulse response to disk. Make sure you set the duration properly!
s.record("D:/Recording/Samples/Impulse_Responses/sc/whitenoise/medium_vibrato/noise_6.wav", duration: 6 + 0.52);
Synth(\noisegen, [\levels, #[0, 1, 1, 0], \times, #[0.02, 6, 0.5], \curves, #[2, 0, -4], \rq, 2, \line, 6]);

