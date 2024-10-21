// File: synthdefs_granulation.scd
// SynthDefs for granulation

// A granulator that takes 10 buffers. You can zero out the extra buffers by providing weights of 0.
SynthDef(\granulator, {
    var buf_arr, env, playback_rate, sig, weights_arr;
    buf_arr = NamedControl.kr(\bufs, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
    weights_arr = NamedControl.kr(\weights, [1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]);
    playback_rate = \transpose.ir(1) * BufRateScale.kr(0);
    sig = GrainBuf.ar(
        numChannels: 8,
        trigger: Select.kr(\trig_type.ar(0), [Impulse.kr(\density.kr(10.0)), Dust.kr(\density.kr(10.0))]),
        dur: WhiteNoise.ar(1).linlin(-1, 1, \dur.kr(0.01) - 0.001, \dur.kr(0.01) + 0.001),
        sndbuf: Select.kr(
            TWindex.kr(Impulse.kr(20), weights_arr),
            buf_arr
        ),
        rate: playback_rate,
        pos: WhiteNoise.ar(1).linlin(-1, 1, \start.kr(0.1), \end.kr(0.9)),
        interp: 2,
        pan: WhiteNoise.ar(1, 1),
        envbufnum: -1,
        maxGrains: 512,
        mul: 1
    );
    sig = BPF.ar(sig, \freq.kr(440.0), \bandwidth.kr(440.0) / \freq.kr(440.0));
    sig = sig.madd(\mul.kr(1), 0);

    Out.ar(\out.kr(0), sig);
}).add;

SynthDef(\granulator_x, {
    var buf_arr, env, playback_rate, sig, weights_arr;
    buf_arr = NamedControl.kr(\bufs, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
    weights_arr = NamedControl.kr(\weights, [1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]);
    playback_rate = \transpose.ir(1) * BufRateScale.kr(0);
    sig = GrainBuf.ar(
        numChannels: 8,
        trigger: Select.kr(\trig_type.ar(0), [Impulse.kr(\density.kr(10.0)), Dust.kr(\density.kr(10.0))]),
        dur: WhiteNoise.ar(1).linlin(-1, 1, \dur.kr(0.01) - 0.001, \dur.kr(0.01) + 0.001),
        sndbuf: Select.kr(
            TWindex.kr(Impulse.kr(20), weights_arr),
            buf_arr
        ),
        rate: playback_rate,
        pos: WhiteNoise.ar(1).linlin(-1, 1, \start.kr(0.1), \end.kr(0.9)),
        interp: 2,
        pan: WhiteNoise.ar(1, 1),
        envbufnum: -1,
        maxGrains: 512,
        mul: 1
    );

    sig = [
        LPF.ar(sig[0], \freq.kr(440.0)),
        sig[1],
        GVerb.ar(sig[2]),
        Resonz.ar(sig[3], \freq.kr(440), 1.0),
        BPF.ar(sig[4], \freq.kr(440), 1.0),
        GVerb.ar(sig[5]),
        HPF.ar(sig[6], \freq.kr(440.0)),
        sig[7],
    ];

    sig = Splay.ar(sig);
    sig = sig.madd(\mul.kr(1), 0);

    Out.ar(\out.kr(0), sig);
}).add;
