(
SynthDef(\fun, {
	var sig, chain;
	sig = SoundIn.ar(8);
	sig = [CombL.ar(sig, 20, LFNoise1.kr(0.2, 0.05, 0.1), 15),
		CombL.ar(sig, 20, LFNoise1.kr(0.15, 0.05, 0.1), 15),
		CombL.ar(sig, 20, LFNoise1.kr(0.1, 0.05, 0.1), 15),
		CombL.ar(sig, 20, LFNoise1.kr(0.05, 0.05, 0.1), 15)
	];
	sig = Splay.ar(sig);
	chain = FFT({LocalBuf(2048)}!2, sig);
	chain = PV_MagAbove(chain, MouseY.kr(0.1, 1.0));
	sig = IFFT(chain);
	sig = [CombL.ar(sig, 20, LFNoise1.kr(0.2, 0.05, 0.1), 15),
		CombL.ar(sig, 20, LFNoise1.kr(0.15, 0.05, 0.1), 15),
		CombL.ar(sig, 20, LFNoise1.kr(0.1, 0.05, 0.1), 15),
		CombL.ar(sig, 20, LFNoise1.kr(0.05, 0.05, 0.1), 15)
	];
	sig = Splay.ar(sig);
	sig = sig.madd(\mul.kr(1.0), 0);
	Out.ar(0, sig);
}).add;
)

Synth(\fun, [\mul, 1.0]);

(
SynthDef(\test, {
	var sig, local;
	sig = SoundIn.ar(8, 1);
	local = LocalIn.ar(1) + sig;
	local = DelayN.ar(local, 0.2, 0.2);
	LocalOut.ar(local * 0.8);
	Out.ar(0, sig!2);
}).add;
)

z = Synth(\test);
z.free;


(
{
    var source, local;

    source = Decay.ar(Impulse.ar(0.3), 0.1) * WhiteNoise.ar(0.1);
    local = LocalIn.ar(2) + [source, 0]; // read feedback, add to source
    local = DelayN.ar(local, 0.2, 0.1); // delay sound

    // reverse channels to give ping pong effect, apply decay factor
    LocalOut.ar(local.reverse * 0.9);

    local
}.play;
)

(
{
    var local, in, amp, chain, freq;

	in = SoundIn.ar(8, 4).dup;

    amp = Amplitude.kr(Mix.ar(in));
	freq = Pitch.kr(in);
	freq[0].poll;
	freq[1].poll;
    in = in * (amp > 1e-4); // noise gate

    local = LocalIn.ar(2);
	local = Resonz.ar(local, freq[0].lag(0.1), 1);
    local = OnePole.ar(local, 0.4);
    local = OnePole.ar(local, -0.08);
    local = Rotate2.ar(local[0], local[1], 0.2);

	local = Mix([
		DelayN.ar(local, 0.25, 0.25),
		DelayN.ar(local, 0.25, 0.125)
	]);
    local = LeakDC.ar(local);
    local = ((local + in) * 0.1).softclip;

    LocalOut.ar(local);
    local * 0.8;
}.play;
)