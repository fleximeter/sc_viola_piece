(
SynthDef(\test, {
	var sig, chain, pitch;
	sig = SoundIn.ar(0);
	chain = FFT(LocalBuf(2048), sig);
	chain = PV_Freeze(chain, \freeze.kr(0.0));
	sig = IFFT(chain);
	pitch = Pitch.kr(sig, 10);
	sig = Resonz.ar(sig, pitch.lag(1.0) * \harmonic.kr(1.0).lag(1.0), \bwr.kr(1.0));
	sig = sig.madd(\mul.kr(1.0), \add.kr(0.0));
	Out.ar(0, sig!2);
}).add;
)

z = Synth(\test);
z.set(\freeze, 1.0);
z.set(\harmonic, 5.0);
z.set(\bwr, 0.001);
z.set(\mul, 500);

(
{
	var sig;
	sig = SinOsc.ar(440);
	Pitch.kr(sig).poll;
}.play;
)