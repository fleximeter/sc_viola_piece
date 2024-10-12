(
// add temporary samples
~samples["test"] = Dictionary.new;
~samples["test"].putPairs(["1", Buffer.read(s, ~root_sample_dir ++ "Recording/Compositions/viola_piece/frag1.wav"), "2", Buffer.read(s, ~root_sample_dir ++ "Recording/Compositions/viola_piece/frag2.wav"), "3", Buffer.read(s, ~root_sample_dir ++ "Recording/Compositions/viola_piece/frag3.wav"), "4", Buffer.read(s, ~root_sample_dir ++ "Recording/Compositions/viola_piece/frag4.wav"), "5", Buffer.read(s, ~root_sample_dir ++ "Recording/Compositions/viola_piece/frag5.wav"), "6", Buffer.read(s, ~root_sample_dir ++ "Recording/Compositions/viola_piece/frag6.wav"), "7", Buffer.read(s, ~root_sample_dir ++ "Recording/Compositions/viola_piece/frag7.wav")]);
)


// free all buffers
Buffer.freeAll;
~mic_zero = 8;

e["main"].next;
e["e1"].next;  // x5
e["e1alt"].next;  // x5
e["e2"].next;
e["e3"].next;  // x5
e["e4"].next;
e["e5"].next;
e["e6"].next;
e["e7"].next;
e["e9"].next;
e["e14"].next;
e["ex"].play;
e["ex2"].play;
e["ex3"].next;
e["ex4"].next;
e["ex5"].next;
e["ex6"].next;
e["octaves"].next;
e["feedback"].next;

~grp = Array.fill(10, {Group.new(s, \addToTail)});
e.keysValuesDo({|key, val| val.reset});  // reset all events
e["e1alt"].reset;
{PanAz.ar(8, SinOsc.ar(440, 0, 0.1, 0), 0.5, 1, 2.0)}.play;  // to check sound

SynthDef(\delay, {
	var sig;
	sig = In.ar(~micbus);
	sig = DelayL.ar(sig, 1, 0.5);
	Out.ar(\out.kr(0), sig);
}).add;

z = Synth(\mic1, [\in, ~mic_zero, \out, ~micbus], addAction: \addToTail);
x = Synth(\delay, [\out, ~gainbus], ~grp[3], \addToTail);
x.free;

~convolution_buffers["cathedral"]