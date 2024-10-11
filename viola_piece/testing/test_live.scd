// Live buffers
~buf2 = Array.fill(10, {Buffer.alloc(s, s.sampleRate * 2, 1)});
~buf4 = Array.fill(10, {Buffer.alloc(s, s.sampleRate * 4, 1)});
~buf6 = Array.fill(10, {Buffer.alloc(s, s.sampleRate * 6, 1)});
~buf8 = Array.fill(10, {Buffer.alloc(s, s.sampleRate * 8, 1)});
~buf10 = Array.fill(10, {Buffer.alloc(s, s.sampleRate * 10, 1)});


// Play the same sample over and over again with some detuning
// NOTE! You must change the input channel if you're using the studio setup
(
p = Pbind(
    \instrument, Pseq([\record_mono, Pseq([\sampler_adsr], inf)], 1),
    \in, 8,
    \buf, ~buf2[0],
    \transpose, Pseq([1, Pwhite(-1.5.midiratio, 1.5.midiratio)], inf),
    \record_dur, Pseq([~buf2[0].numFrames / ~buf2[0].sampleRate], inf),
    \dur, Pseq([1], inf),
    \legato, Pseq([~buf2[0].numFrames / ~buf2[0].sampleRate, Pseq([1.2], inf)], 1),
	\pos, Pseq([-1/8, Pseq([1/8, 3/8, 5/8, 7/8, 9/8, 11/8, 13/8, 15/8], inf)], 1),
	\pan_mode, 1
);
)

t = TempoClock.new(120/60);
p.play(t);


Synth(\sampler, [\buf, ~buf2[0], \pos, 0]);