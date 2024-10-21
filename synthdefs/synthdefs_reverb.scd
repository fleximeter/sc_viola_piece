// File: synthdefs_conv.scd
// Contains synthdefs for convolution

// 8-channel Gverb
SynthDef(\gverb, {
    var sig;
    sig = In.ar(\in.kr(0), 8);
    sig = Array.fill(8, {
        | i |
        GVerb.ar(sig[i], \roomsize.kr(10), \revtime.kr(3), \damping.kr(0.5), \inputbw.kr(0.5), \spread.kr(15), 0, \earlyreflevel.kr(0.7), \taillevel.kr(0.5), 300);
    });
    sig = sig.madd(\mul.kr(1.0), 0);
    Out.ar(\out.kr(0), sig);
}).add;

// 8-channel convolution
// Wet/dry level is specified as a decimal between 0.0 and 1.0
SynthDef(\partconv8, {
    var sig, sig_dry, sig_wet, env;
    env = EnvGen.ar(Env.asr(0.01, 1, 0.1), \gate.kr(1.0));
    sig_dry = In.ar(\in.kr(0), 8);
    sig_wet = Array.fill(8, {|i| PartConv.ar(sig_dry[i], \fft_size.ir(4096), \irbuf.kr(0))});
    sig = Array.fill(8, {|i| Mix([sig_dry[i] * (1 - \wetdry.kr(1)), sig_wet[i] * \wetdry.kr(1)])});
    sig = sig.madd(\mul.kr(1), 0);
    sig = sig * env;
    Out.ar(\out.kr(0), sig);
}).add;

// 8-channel convolution
// 100% wet signal
SynthDef(\partconv8wet, {
    var sig, env;
    env = EnvGen.ar(Env.asr(0.01, 1, 0.1), \gate.kr(1.0));
    sig = In.ar(\in.kr(0), 8);
    sig = Array.fill(8, {|i| PartConv.ar(sig[i], \fft_size.ir(4096), \irbuf.kr(0))});
    sig = sig.madd(\mul.kr(1), 0);
    sig = sig * env;
    Out.ar(\out.kr(0), sig);
}).add;

// 8-channel convolution
// Wet/dry level is modulated with a control signal
SynthDef(\partconv8wetdry, {
    var sig, sig_dry, sig_wet, env, wetdry;
    env = EnvGen.ar(Env.asr(0.01, 1, 0.1), \gate.kr(1.0));
    sig_dry = In.ar(\in.kr(0), 8);
    wetdry = In.kr(\wetdry.kr(0), 1);
    sig_wet = Array.fill(8, {|i| PartConv.ar(sig_dry[i], \fft_size.ir(4096), \irbuf.kr(0))});
    sig = Array.fill(8, {|i| Mix([sig_dry[i] * (1 - wetdry), sig_wet[i] * wetdry])});
    sig = sig.madd(\mul.kr(1), 0);
    sig = sig * env;
    Out.ar(\out.kr(0), sig);
}).add;
