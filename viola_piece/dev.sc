~mic_zero = 8;

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
e["e18"].next;
e["e19"].next;
e["e85"].next;
e["e87"].next;
e["e88"].next;
e["e91"].next;
e["e68"].play;
e["e69"].play;
e["e19"].next;
e["e19"].next;
e["e19"].next;
e["ex3"].next;
e["ex4"].next;
e["ex5"].next;
e["ex6"].next;
e["octaves"].next;
e["feedback"].next;

~grp = Array.fill(10, {Group.new(s, \addToTail)});
e.keysValuesDo({|key, val| val.reset});  // reset all events


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
