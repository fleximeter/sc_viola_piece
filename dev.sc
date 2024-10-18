e["main"].next;
e["e1"].next;  // x5
e["e1alt"].next;  // x5
e["e2"].next;
e["e2alt"].next;  // x5
e["e3"].next;  // x5
e["e3alt"].next;  // x5
e["e4"].next;
e["e5"].next;
e["e6"].next;
e["e7alt"].next;
e["e9"].next;
e["e14"].next;
e["e17"].next;
e["e18"].next;
e["e24"].next;
e["e28"].next;
e["e31"].next;
e["e33"].next;
e["e35"].next;
e["e45"].next;
e["e18"].next;
e["e18"].next;
e["e18"].next;
e["e18"].next;
e["e68"].play;
e["e69"].play;
e["e70"].play;
e["e72"].play;
e["e73"].play;
e["e75"].next;
e["e76"].next;
e["e79"].next;
e["e82a"].next;
e["e82b"].next;
e["e83"].next;
e["e96"].next;
e["e98"].next;
e["e101"].next;
e["e105"].next;
e["e128"].next;
e["ex5"].next;
e["ex6"].next;
e["octaves"].next;
e["feedback"].next;


~event_counter = 0;

// check sound
{PanAz.ar(8, SinOsc.ar(440, 0, 0.1, 0), 0.5, 1, 2.0)}.play;


// test signal flow
(
SynthDef(\delay, {
	var sig;
	sig = In.ar(~micbus);
	sig = DelayL.ar(sig, 1, 0.5);
	Out.ar(\out.kr(0), sig);
}).add;
)

z = Synth(\mic1, [\in, ~mic_zero, \out, ~micbus], addAction: \addToTail);
x = Synth(\delay, [\out, ~gainbus], ~grp[3], \addToTail);
x.free;
