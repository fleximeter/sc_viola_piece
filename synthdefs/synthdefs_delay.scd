// File: synthdefs_delay.scd
// Delay synthdefs

// delay
SynthDef(\delay1, {
    var sig, dur;
    dur = \num_beats.ir(1) * 60 / \tempo.ir(60);
    sig = In.ar(\in.kr(0), 8);
    sig = DelayL.ar(sig, 10, dur);
    sig = sig.madd(\mul.kr(1.0), \add.kr(0.0));
    Out.ar(\out.kr(0), sig);
}).add;

// 3 delays with pan
SynthDef(\pandelay3, {
    var sig, delay_sig, num_delays, pan;
    num_delays = 3;
    pan = \pan.kr(#[0, 3, 2]);
    sig = In.ar(\in.kr(0), 8);
    sig = Mix(sig);
    sig = Array.fill(num_delays, {
        | i |
        var delaysig;
        delaysig = DelayL.ar(sig, 10, \delayint.kr(0.2) * (i+1), (num_delays - i) / num_delays);
        PanAz.ar(8, delaysig, pan[i], 1, 2.0, 0.5);
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 4 delays with pan
SynthDef(\pandelay4, {
    var sig, delay_sig, num_delays, pan;
    num_delays = 4;
    pan = \pan.kr(#[0, 3, 2, 3]);
    sig = In.ar(\in.kr(0), 8);
    sig = Mix(sig);
    sig = Array.fill(num_delays, {
        | i |
        var delaysig;
        delaysig = DelayL.ar(sig, 10, \delayint.kr(0.2) * (i+1), (num_delays - i) / num_delays);
        PanAz.ar(8, delaysig, pan[i], 1, 2.0, 0.5);
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 5 delays with pan
SynthDef(\pandelay5, {
    var sig, delay_sig, num_delays, pan;
    num_delays = 5;
    pan = \pan.kr(#[0, 3, 2, 1, 2]);
    sig = In.ar(\in.kr(0), 8);
    sig = Mix(sig);
    sig = Array.fill(num_delays, {
        | i |
        var delaysig;
        delaysig = DelayL.ar(sig, 10, \delayint.kr(0.2) * (i+1), (num_delays - i) / num_delays);
        PanAz.ar(8, delaysig, pan[i], 1, 2.0, 0.5);
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 6 delays with pan
SynthDef(\pandelay6, {
    var sig, delay_sig, num_delays, pan;
    num_delays = 6;
    pan = \pan.kr(#[0, 3, 2, 0, 2, 1]);
    sig = In.ar(\in.kr(0), 8);
    sig = Mix(sig);
    sig = Array.fill(num_delays, {
        | i |
        var delaysig;
        delaysig = DelayL.ar(sig, 10, \delayint.kr(0.2) * (i+1), (num_delays - i) / num_delays);
        PanAz.ar(8, delaysig, pan[i], 1, 2.0, 0.5);
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 7 delays with pan
SynthDef(\pandelay7, {
    var sig, delay_sig, num_delays, pan;
    num_delays = 7;
    pan = \pan.kr(#[0, 3, 2, 2, 0, 3, 1]);
    sig = In.ar(\in.kr(0), 8);
    sig = Mix(sig);
    sig = Array.fill(num_delays, {
        | i |
        var delaysig;
        delaysig = DelayL.ar(sig, 10, \delayint.kr(0.2) * (i+1), (num_delays - i) / num_delays);
        PanAz.ar(8, delaysig, pan[i], 1, 2.0, 0.5);
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 8 delays with pan
SynthDef(\pandelay8, {
    var sig, delay_sig, num_delays, pan;
    num_delays = 8;
    pan = \pan.kr(#[0, 3, 2, 1, 0, 1, 3, 1]);
    sig = In.ar(\in.kr(0), 8);
    sig = Mix(sig);
    sig = Array.fill(num_delays, {
        | i |
        var delaysig;
        delaysig = DelayL.ar(sig, 10, \delayint.kr(0.2) * (i+1), (num_delays - i) / num_delays);
        PanAz.ar(8, delaysig, pan[i], 1, 2.0, 0.5);
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 3 delays with pan
SynthDef(\randpandelay3, {
    var sig, delay_sig, num_delays;
    num_delays = 3;
    sig = In.ar(\in.kr(0), 8);
    sig = Mix(sig);
    sig = Array.fill(num_delays, {
        | i |
        var delaysig;
        delaysig = DelayL.ar(sig, 10, \delayint.kr(0.2) * (i+1), (num_delays - i) / num_delays);
        PanAz.ar(8, delaysig, rrand(0.0, 2.0), 1, 2.0, 0.5);
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 4 delays with pan
SynthDef(\randpandelay4, {
    var sig, delay_sig, num_delays;
    num_delays = 4;
    sig = In.ar(\in.kr(0), 8);
    sig = Mix(sig);
    sig = Array.fill(num_delays, {
        | i |
        var delaysig;
        delaysig = DelayL.ar(sig, 10, \delayint.kr(0.2) * (i+1), (num_delays - i) / num_delays);
        PanAz.ar(8, delaysig, rrand(0.0, 2.0), 1, 2.0, 0.5);
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 5 delays with pan
SynthDef(\randpandelay5, {
    var sig, delay_sig, num_delays;
    num_delays = 5;
    sig = In.ar(\in.kr(0), 8);
    sig = Mix(sig);
    sig = Array.fill(num_delays, {
        | i |
        var delaysig;
        delaysig = DelayL.ar(sig, 10, \delayint.kr(0.2) * (i+1), (num_delays - i) / num_delays);
        PanAz.ar(8, delaysig, rrand(0.0, 2.0), 1, 2.0, 0.5);
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 6 delays with pan
SynthDef(\randpandelay6, {
    var sig, delay_sig, num_delays;
    num_delays = 6;
    sig = In.ar(\in.kr(0), 8);
    sig = Mix(sig);
    sig = Array.fill(num_delays, {
        | i |
        var delaysig;
        delaysig = DelayL.ar(sig, 10, \delayint.kr(0.2) * (i+1), (num_delays - i) / num_delays);
        PanAz.ar(8, delaysig, rrand(0.0, 2.0), 1, 2.0, 0.5);
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 7 delays with pan
SynthDef(\randpandelay7, {
    var sig, delay_sig, num_delays;
    num_delays = 7;
   sig = In.ar(\in.kr(0), 8);
    sig = Mix(sig);
    sig = Array.fill(num_delays, {
        | i |
        var delaysig;
        delaysig = DelayL.ar(sig, 10, \delayint.kr(0.2) * (i+1), (num_delays - i) / num_delays);
        PanAz.ar(8, delaysig, rrand(0.0, 2.0);, 1, 2.0, 0.5);
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 8 delays with pan
SynthDef(\randpandelay8, {
    var sig, delay_sig, num_delays;
    num_delays = 8;
    sig = In.ar(\in.kr(0), 8);
    sig = Mix(sig);
    sig = Array.fill(num_delays, {
        | i |
        var delaysig;
        delaysig = DelayL.ar(sig, 10, \delayint.kr(0.2) * (i+1), (num_delays - i) / num_delays);
        PanAz.ar(8, delaysig, rrand(0.0, 2.0), 1, 2.0, 0.5);
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

//////////////////////////////////////////////////////////////////////////////////
// Ratio-based pitch shift delays
//////////////////////////////////////////////////////////////////////////////////

// 1 delay with constant pitch shift in a provided number of semitones. Max delay 3 seconds. Useful for patterning.
SynthDef(\psdelay1, {
    var sig;
    sig = In.ar(\in.kr(0), 8);
    sig = DelayL.ar(
        PitchShift.ar(sig, 0.1, \ratio.kr(1), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004)),
        3,
        \delayint.kr(1.0),
        \mul.kr(1.0),
    );
    Out.ar(\out.kr(0), sig);
}).add;

// 1 delay with constant pitch shift in a provided number of semitones. Max delay 3 seconds. Useful for patterning.
// This delay allows modulating of pitch shift and delay interval.
SynthDef(\psdelay1ctrl, {
    var sig, ctrl_shift, ctrl_int, ctrl_mul;
    sig = In.ar(\in.kr(0), 8);
    ctrl_shift = In.kr(\ratio.kr(1), 1);
    ctrl_int = In.kr(\delayint.kr(0), 1);
    ctrl_mul = In.kr(\mul.kr(0), 1);
    sig = DelayL.ar(
        PitchShift.ar(sig, 0.1, ctrl_shift, \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004)),
        3,
        ctrl_int,
        ctrl_mul,
    );
    Out.ar(\out.kr(0), sig);
}).add;

// 3 delays with steady pitch shift in a provided number of semitones
SynthDef(\psdelay3, {
    var sig, num_delays;
    num_delays = 3;
    sig = In.ar(\in.kr(0), 8);
    sig = Array.fill(num_delays, {
        | i |
        DelayL.ar(
            PitchShift.ar(
                sig, 0.1, \ratio.kr(1) * (i+1) / num_delays,
                \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)
            ),
            10,
            \delayint.kr(0.2) * (i+1),
            (num_delays - i) / num_delays
        );
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 4 delays with steady pitch shift in a provided number of semitones
SynthDef(\psdelay4, {
    var sig, num_delays;
    num_delays = 4;
    sig = In.ar(\in.kr(0), 8);
    sig = Array.fill(num_delays, {
        | i |
        DelayL.ar(
            PitchShift.ar(
                sig, 0.1, \ratio.kr(1) * (i+1) / num_delays,
                \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)
            ),
            10,
            \delayint.kr(0.2) * (i+1),
            (num_delays - i) / num_delays
        );
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 5 delays with steady pitch shift in a provided number of semitones
SynthDef(\psdelay5, {
    var sig, num_delays;
    num_delays = 5;
    sig = In.ar(\in.kr(0), 8);
    sig = Array.fill(num_delays, {
        | i |
        DelayL.ar(
            PitchShift.ar(
                sig, 0.1, \ratio.kr(1) * (i+1) / num_delays,
                \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)
            ),
            10,
            \delayint.kr(0.2) * (i+1),
            (num_delays - i) / num_delays
        );
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 6 delays with steady pitch shift in a provided number of semitones
SynthDef(\psdelay6, {
    var sig, num_delays;
    num_delays = 6;
    sig = In.ar(\in.kr(0), 8);
    sig = Array.fill(num_delays, {
        | i |
        DelayL.ar(
            PitchShift.ar(
                sig, 0.1, \ratio.kr(1) * (i+1) / num_delays,
                \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)
            ),
            10,
            \delayint.kr(0.2) * (i+1),
            (num_delays - i) / num_delays
        );
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 7 delays with steady pitch shift in a provided number of semitones
SynthDef(\psdelay7, {
    var sig, num_delays;
    num_delays = 7;
    sig = In.ar(\in.kr(0), 8);
    sig = Array.fill(num_delays, {
        | i |
        DelayL.ar(
            PitchShift.ar(
                sig, 0.1, \ratio.kr(1) * (i+1) / num_delays,
                \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)
            ),
            10,
            \delayint.kr(0.2) * (i+1),
            (num_delays - i) / num_delays
        );
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 8 delays with steady pitch shift in a provided number of semitones
SynthDef(\psdelay8, {
    var sig, num_delays;
    num_delays = 8;
    sig = In.ar(\in.kr(0), 8);
    sig = Array.fill(num_delays, {
        | i |
        DelayL.ar(
            PitchShift.ar(
                sig, 0.1, \ratio.kr(1) * (i+1) / num_delays,
                \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)
            ),
            10,
            \delayint.kr(0.2) * (i+1),
            (num_delays - i) / num_delays
        );
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

//////////////////////////////////////////////////////////////////////////////////
// Equal-tempered pitch shift delays
//////////////////////////////////////////////////////////////////////////////////

// 1 delay with constant pitch shift in a provided number of semitones. Max delay 3 seconds. Useful for patterning.
SynthDef(\psdelay1_et, {
    var sig;
    sig = In.ar(\in.kr(0), 8);
    sig = DelayL.ar(
        PitchShift.ar(sig, 0.1, 2 ** (\semitones.kr(0) / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004)),
        3,
        \delayint.kr(1.0),
        \mul.kr(1.0),
    );
    Out.ar(\out.kr(0), sig);
}).add;

// 1 delay with constant pitch shift in a provided number of semitones. Max delay 3 seconds. Useful for patterning.
// This delay allows modulating of pitch shift and delay interval.
SynthDef(\psdelay1ctrl_et, {
    var sig, ctrl_semitones, ctrl_int, ctrl_mul;
    sig = In.ar(\in.kr(0), 8);
    ctrl_semitones = In.kr(\semitones.kr(0), 1);
    ctrl_int = In.kr(\delayint.kr(0), 1);
    ctrl_mul = In.kr(\mul.kr(0), 1);
    sig = DelayL.ar(
        PitchShift.ar(sig, 0.1, 2 ** (ctrl_semitones / 12), \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004)),
        3,
        ctrl_int,
        ctrl_mul,
    );
    Out.ar(\out.kr(0), sig);
}).add;

// 3 delays with steady pitch shift in a provided number of semitones
SynthDef(\psdelay3_et, {
    var sig, num_delays;
    num_delays = 3;
    sig = In.ar(\in.kr(0), 8);
    sig = Array.fill(num_delays, {
        | i |
        DelayL.ar(
            PitchShift.ar(
                sig, 0.1, 2 ** ((\semitones.kr(0) * (i+1) / num_delays) / 12),
                \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)
            ),
            10,
            \delayint.kr(0.2) * (i+1),
            (num_delays - i) / num_delays
        );
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 4 delays with steady pitch shift in a provided number of semitones
SynthDef(\psdelay4_et, {
    var sig, num_delays;
    num_delays = 4;
    sig = In.ar(\in.kr(0), 8);
    sig = Array.fill(num_delays, {
        | i |
        DelayL.ar(
            PitchShift.ar(
                sig, 0.1, 2 ** ((\semitones.kr(0) * (i+1) / num_delays) / 12),
                \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)
            ),
            10,
            \delayint.kr(0.2) * (i+1),
            (num_delays - i) / num_delays
        );
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 5 delays with steady pitch shift in a provided number of semitones
SynthDef(\psdelay5_et, {
    var sig, num_delays;
    num_delays = 5;
    sig = In.ar(\in.kr(0), 8);
    sig = Array.fill(num_delays, {
        | i |
        DelayL.ar(
            PitchShift.ar(
                sig, 0.1, 2 ** ((\semitones.kr(0) * (i+1) / num_delays) / 12),
                \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)
            ),
            10,
            \delayint.kr(0.2) * (i+1),
            (num_delays - i) / num_delays
        );
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 6 delays with steady pitch shift in a provided number of semitones
SynthDef(\psdelay6_et, {
    var sig, num_delays;
    num_delays = 6;
    sig = In.ar(\in.kr(0), 8);
    sig = Array.fill(num_delays, {
        | i |
        DelayL.ar(
            PitchShift.ar(
                sig, 0.1, 2 ** ((\semitones.kr(0) * (i+1) / num_delays) / 12),
                \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)
            ),
            10,
            \delayint.kr(0.2) * (i+1),
            (num_delays - i) / num_delays
        );
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 7 delays with steady pitch shift in a provided number of semitones
SynthDef(\psdelay7_et, {
    var sig, num_delays;
    num_delays = 7;
    sig = In.ar(\in.kr(0), 8);
    sig = Array.fill(num_delays, {
        | i |
        DelayL.ar(
            PitchShift.ar(
                sig, 0.1, 2 ** ((\semitones.kr(0) * (i+1) / num_delays) / 12),
                \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)
            ),
            10,
            \delayint.kr(0.2) * (i+1),
            (num_delays - i) / num_delays
        );
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

// 8 delays with steady pitch shift in a provided number of semitones
SynthDef(\psdelay8_et, {
    var sig, num_delays;
    num_delays = 8;
    sig = In.ar(\in.kr(0), 8);
    sig = Array.fill(num_delays, {
        | i |
        DelayL.ar(
            PitchShift.ar(
                sig, 0.1, 2 ** ((\semitones.kr(0) * (i+1) / num_delays) / 12),
                \pitchDispersion.kr(0.0), \timeDispersion.kr(0.004), \mul.kr(1.0)
            ),
            10,
            \delayint.kr(0.2) * (i+1),
            (num_delays - i) / num_delays
        );
    });
    sig = Mix(sig);
    Out.ar(\out.kr(0), sig);
}).add;

//////////////////////////////////////////////////////////////////////////////////
// Comb delays
//////////////////////////////////////////////////////////////////////////////////

// Comb delay
SynthDef(\combdelay, {
    var sig;
    sig = In.ar(\in.kr(0), 8);
    sig = CombL.ar(sig, 10, \delaytime.kr(0.2), \decaytime.kr(5.0), \mul.kr(1.0));
    Out.ar(\out.kr(0), sig);
}).add;

// Variable comb delay
SynthDef(\varcombdelay, {
    var ctrl, sig;
    ctrl = In.kr(\time.kr(0), 1);
    sig = In.ar(\in.kr(0), 8);
    sig = CombL.ar(sig, 10, ctrl, \decaytime.kr(5.0), \mul.kr(1.0));
    Out.ar(\out.kr(0), sig);
}).add;
