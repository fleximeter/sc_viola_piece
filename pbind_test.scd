(
SynthDef(\test, {
	var sig;
	sig = Pluck.ar(WhiteNoise.ar(1), 1, 0.2, \freq.kr(440).reciprocal, 2, 0.5, \mul.kr(0.1));
	Out.ar(0, sig!2);
}).add;
)

Synth(\test);

p = Pbind(\instrument, \test,
	\midinote, Pseq([60, 62, 64], inf),
	\mul, Pseq([0.1, 0.05, 0.025], inf)
);

p = Pbind(\instrument, \test,
	\midinote, Pswitch1([Pseq([60], inf), Pseq([62, 63, 64], inf)], Pseq([0, 1], inf)),
	);


p = Pbind(\instrument, \test,
	\midinote, Pswitch1([Pseq([72], inf), Pseq(Array.interpolation(8, 71, 72) ++ Array.interpolation(8, 72, 71), inf)], Pseq([0, 1], inf)),
	\dur, Pseq(Array.interpolation(16, 0.5, 0.125) ++ Array.interpolation(16, 0.125, 0.5), 2)
	);


p.play;


