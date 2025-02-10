e["e70"].play;

~reset_to_event.(4);
~event_counter.postln;

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

Synth(\fb1, [\in, ~audiobus_grp3[0][0], \out, ~audiobus_grp3[1][0], \mul_sig, ~faderbus[4], \feedback, ~faderbus[5], \freq, ~faderbus[8], \low_freq, 50.midicps, \high_freq, 108.midicps], ~grp[2], \addToTail));


(
z = Synth(\fbx, [\in, ~micbus, \out, ~gainbus, \mul_sig, ~faderbus[4], \feedback, ~faderbus[5], \freq, ~faderbus[8], \low_freq, 40.midicps, \high_freq, 80.midicps, \feedback_scaler, 2], ~grp[2]);
)
z.free;