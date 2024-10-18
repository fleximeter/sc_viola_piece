// add reverb to all 8 channels
Synth(\partconv_in_8, [\fft_size, ~fft_size, \in, ~bus2[0], \out, 0, \irbuf, ~conv_bufs[2], \mul, 1, \wetdry, 0.1]);


// Sound experimentation
{
    var sig;
    sig = PlayBuf.ar(1, ~samples["viola.pizz"]["ff"]["g"][60.asString]["buffer"], doneAction: 2) * PlayBuf.ar(1, ~samples["guitar"]["ff"]["g"][60.asString]["buffer"], doneAction: 2) * 2;
    sig!2;
}.play;

{
    var sig;
    sig = PlayBuf.ar(1, ~samples["viola.pizz"]["ff"]["g"][60.asString]["buffer"], doneAction: 2) * SinOsc.ar(84.midicps) * SinOsc.ar(60.midicps);
    sig!2;
}.play;

{
    var sig;
    sig = PlayBuf.ar(1, ~samples["viola.pizz"]["ff"]["g"][60.asString]["buffer"], doneAction: 2);
    sig = CrossoverDistortion.ar(sig, 0.1, 1);
    sig!2;
}.play;


{
    var sig;
    sig = Convolution.ar(PlayBuf.ar(1, ~samples["viola.pizz"]["ff"]["g"][60.asString]["buffer"], doneAction: 2), PlayBuf.ar(1, ~samples["guitar"]["ff"]["g"][60.asString]["buffer"], doneAction:2), mul: 0.1);
    sig!2;
}.play;

{
    var sig;
    sig = PlayBuf.ar(1, ~samples["viola.pizz"]["ff"]["g"][60.asString]["buffer"], doneAction: 2);
    sig!2;
}.play;

{
    var sig;
    sig = PlayBuf.ar(1, ~samples["guitar"]["ff"]["g"][60.asString]["buffer"], doneAction: 2);
    sig!2;
}.play;

{
    var sig;
    sig = Warp1.ar(1, ~samples["viola.pizz"]["ff"]["g"][60.asString]["buffer"], EnvGen.ar(Env([0, 1], [5], [8]), doneAction: 2), 1, 0.2, -1, 8, 0.1);
    sig!2;
}.play;


// Sampler with loop points
(
~synth1 = Synth(\sampler_loop, [
    \sample_buf, ~samples["basstrombone"]["ff"][58.asString]["buffer"],
    \sample_loop1, ~samples["basstrombone"]["ff"][58.asString]["loop_points"][0][0],
    \sample_loop2, ~samples["basstrombone"]["ff"][58.asString]["loop_points"][0][1],
    \atk_dur, (~samples["basstrombone"]["ff"][58.asString]["loop_points"][0][0] - 1000) / s.sampleRate,
    \dur, 10,
    \mul, 0.5,
    \out, 0
]);
~synth2 = Synth(\sampler_loop, [
    \sample_buf, ~samples["basstrombone"]["ff"][62.asString]["buffer"],
    \sample_loop1, ~samples["basstrombone"]["ff"][62.asString]["loop_points"][0][0],
    \sample_loop2, ~samples["basstrombone"]["ff"][62.asString]["loop_points"][0][1],
    \atk_dur, (~samples["basstrombone"]["ff"][62.asString]["loop_points"][0][0] - 1000) / s.sampleRate,
    \dur, 10,
    \mul, 0.5,
    \out, 0
]);
~synth3 = Synth(\sampler_loop, [
    \sample_buf, ~samples["basstrombone"]["ff"][65.asString]["buffer"],
    \sample_loop1, ~samples["basstrombone"]["ff"][65.asString]["loop_points"][0][0],
    \sample_loop2, ~samples["basstrombone"]["ff"][65.asString]["loop_points"][0][1],
    \atk_dur, (~samples["basstrombone"]["ff"][65.asString]["loop_points"][0][0] - 1000) / s.sampleRate,
    \dur, 10,
    \mul, 0.5,
    \out, 0
]);
)
(
~synth4 = Synth(\sampler_loop, [
    \sample_buf, ~samples["basstrombone"]["mf"][36.asString]["buffer"],
    \sample_loop1, ~samples["basstrombone"]["mf"][36.asString]["loop_points"][0][0],
    \sample_loop2, ~samples["basstrombone"]["mf"][36.asString]["loop_points"][0][1],
    \atk_dur, (~samples["basstrombone"]["mf"][36.asString]["loop_points"][0][0] - 1000) / s.sampleRate,
    \dur, 2,
    \mul, 0.5,
    \out, ~bus2[0]
], ~grp[0]);
~synth5 = Synth(\sampler_loop, [
    \sample_buf, ~samples["basstrombone"]["mf"][38.asString]["buffer"],
    \sample_loop1, ~samples["basstrombone"]["mf"][38.asString]["loop_points"][0][0],
    \sample_loop2, ~samples["basstrombone"]["mf"][38.asString]["loop_points"][0][1],
    \atk_dur, (~samples["basstrombone"]["mf"][38.asString]["loop_points"][0][0] - 1000) / s.sampleRate,
    \dur, 2,
    \mul, 0.5,
    \out, ~bus2[0]
], ~grp[0]);
)
~samples["viola.arco"]["ff"]["c"][65.asString]["loop_points"][0][0]

~synth1 = Synth(\sampler_loop, [
    \sample_buf, ~samples["viola.arco"]["ff"]["c"][58.asString]["buffer"],
    \sample_loop1, ~samples["viola.arco"]["ff"]["c"][58.asString]["loop_points"][0][0],
    \sample_loop2, ~samples["viola.arco"]["ff"]["c"][58.asString]["loop_points"][0][1],
    \sample_buf_rate, ~samples["viola.arco"]["ff"]["c"][58.asString]["buffer"].sampleRate,
    \dur, 10,
    \mul, 0.5,
    \out, 0
]);
~synth2 = Synth(\sampler_loop, [
    \sample_buf, ~samples["viola.arco"]["ff"]["c"][62.asString]["buffer"],
    \sample_loop1, ~samples["viola.arco"]["ff"]["c"][62.asString]["loop_points"][0][0],
    \sample_loop2, ~samples["viola.arco"]["ff"]["c"][62.asString]["loop_points"][0][1],
    \atk_dur, (~samples["viola.arco"]["ff"]["c"][62.asString]["loop_points"][0][0] - 1000) / s.sampleRate,
    \dur, 10,
    \mul, 0.5,
    \out, 0
]);
~synth3 = Synth(\sampler_loop, [
    \sample_buf, ~samples["viola.arco"]["ff"]["c"][65.asString]["buffer"],
    \sample_loop1, ~samples["viola.arco"]["ff"]["c"][65.asString]["loop_points"][0][0],
    \sample_loop2, ~samples["viola.arco"]["ff"]["c"][65.asString]["loop_points"][0][1],
    \atk_dur, (~samples["viola.arco"]["ff"]["c"][65.asString]["loop_points"][0][0] - 1000) / s.sampleRate,
    \dur, 10,
    \mul, 0.5,
    \out, 0
]);




// Transformation
~synth1 = Synth(\sampler_conv, [\buf1, ~samples["viola.pizz"]["ff"]["g"][60.asString]["buffer"], \buf2, ~samples["guitar"]["ff"]["g"][60.asString]["buffer"], \mix, 0, \out, 0], ~grp[1]);
~synth1 = Synth(\sampler_conv, [\buf1, ~samples["viola.pizz"]["ff"]["g"][60.asString]["buffer"], \buf2, ~samples["guitar"]["ff"]["g"][60.asString]["buffer"], \mix, 0.1, \out, 0], ~grp[1]);
~synth1 = Synth(\sampler_conv, [\buf1, ~samples["viola.pizz"]["ff"]["g"][60.asString]["buffer"], \buf2, ~samples["guitar"]["ff"]["g"][60.asString]["buffer"], \mix, 0.2, \out, 0], ~grp[1]);
~synth1 = Synth(\sampler_conv, [\buf1, ~samples["viola.pizz"]["ff"]["g"][60.asString]["buffer"], \buf2, ~samples["guitar"]["ff"]["g"][60.asString]["buffer"], \mix, 0.3, \out, 0], ~grp[1]);
~synth1 = Synth(\sampler_conv, [\buf1, ~samples["viola.pizz"]["ff"]["g"][60.asString]["buffer"], \buf2, ~samples["guitar"]["ff"]["g"][60.asString]["buffer"], \mix, 0.4, \out, 0], ~grp[1]);
~synth1 = Synth(\sampler_conv, [\buf1, ~samples["viola.pizz"]["ff"]["g"][60.asString]["buffer"], \buf2, ~samples["guitar"]["ff"]["g"][60.asString]["buffer"], \mix, 0.5, \out, 0], ~grp[1]);
~synth1 = Synth(\sampler_conv, [\buf1, ~samples["viola.pizz"]["ff"]["g"][60.asString]["buffer"], \buf2, ~samples["guitar"]["ff"]["g"][60.asString]["buffer"], \mix, 0.55, \out, 0], ~grp[1]);
~synth1 = Synth(\sampler_conv, [\buf1, ~samples["viola.pizz"]["ff"]["g"][60.asString]["buffer"], \buf2, ~samples["guitar"]["ff"]["g"][60.asString]["buffer"], \mix, 0.6, \out, 0], ~grp[1]);
~synth1 = Synth(\sampler_conv, [\buf1, ~samples["viola.pizz"]["ff"]["g"][60.asString]["buffer"], \buf2, ~samples["guitar"]["ff"]["g"][60.asString]["buffer"], \mix, 0.65, \out, 0], ~grp[1]);
~synth1 = Synth(\sampler_conv, [\buf1, ~samples["viola.pizz"]["ff"]["g"][60.asString]["buffer"], \buf2, ~samples["guitar"]["ff"]["g"][60.asString]["buffer"], \mix, 0.8, \out, 0], ~grp[1]);
~synth1 = Synth(\sampler_conv, [\buf1, ~samples["viola.pizz"]["ff"]["g"][60.asString]["buffer"], \buf2, ~samples["guitar"]["ff"]["g"][60.asString]["buffer"], \mix, 1, \out, 0], ~grp[1]);


// Patterns - 8 channel
x = Pbind(
    \instrument, \sampler,
    \buf, Pseq([
        ~samples["viola.pizz"]["ff"]["g"][60.asString]["buffer"],
        ~samples["viola.pizz"]["ff"]["g"][62.asString]["buffer"],
        ~samples["viola.pizz"]["ff"]["d"][64.asString]["buffer"],
        ~samples["viola.pizz"]["ff"]["d"][65.asString]["buffer"],
        ~samples["viola.pizz"]["ff"]["d"][67.asString]["buffer"],
        ~samples["viola.pizz"]["ff"]["g"][69.asString]["buffer"],
        ~samples["viola.pizz"]["ff"]["a"][71.asString]["buffer"]], inf),
    \dur, Pseq([0.33, 0.33, 0.34], inf),
    \mul, Pseq([0.5, 0.8], inf),
	\pan_mode, 0,
	// \pos, Pseq([-1/8, Pseq([1/8, 3/8, 5/8, 7/8, 9/8, 11/8, 13/8, 15/8], inf)], 1),
	\pos, Pseq([0, Pwhite(-1, 1, inf)], 1),
    \out, ~bus2[0]
);

y = Pbind(
    \instrument, \sampler,
    \buf, Pseq([
        ~samples["viola.pizz"]["ff"]["g"][62.asString]["buffer"],
        ~samples["viola.pizz"]["ff"]["g"][59.asString]["buffer"],
        ~samples["viola.pizz"]["ff"]["d"][68.asString]["buffer"],
        ~samples["viola.pizz"]["ff"]["d"][64.asString]["buffer"],
        ~samples["viola.pizz"]["ff"]["d"][62.asString]["buffer"],
        ~samples["viola.pizz"]["ff"]["d"][67.asString]["buffer"],
        ~samples["viola.pizz"]["ff"]["g"][66.asString]["buffer"]], inf),
    \dur, Pseq([0.25, 0.25], inf),
    \mul, Pseq([0.5, 0.8], inf),
	\pan_mode, 0,
	// \pos, Pseq([-1/8, Pseq([3/8, 1/8, 15/8, 13/8, 11/8, 9/8, 7/8, 5/8], inf)], 1),
   	\pos, Pseq([0, Pwhite(-1, 1, inf)], 1),
    \out, ~bus2[0]
);

// waveshaping
~sig = Signal.newClear(1025);

(
~sig.waveFill({
    | x, old, i |

    // change this number to increase distortion. numbers like 1.08, 1.16, 1.24, 1.32, etc. work.
    var exponent = 1;
    var base = 2 * x - 1;

    // this garbage is necessary because supercollider can't handle negative numbers with exponents well
    if(base >= 0, {
        base.pow(exponent);
    }, {
        -1 * ((-1 * base).pow(exponent));
    });
}, 0, 1);
)
~shape_buf = Buffer.alloc(s, 2048);
~shape_buf.sendCollection(~sig.asWavetableNoWrap);
~grp = Array.fill(4, {Group.new(s, \addToTail)});
w = Synth(\shape, [\in, ~bus2[0], \out, ~bus3[0], \shape_buf, ~shape_buf, \mul, 0.01], ~grp[2], \addToTail);
v = Synth(\partconv_in_8, [\fft_size, ~fft_size, \in, ~bus3[0], \out, 0, \irbuf, ~conv_bufs[2], \mul, 1, \wetdry, 0.1], ~grp[3]);

v.set(\wetdry, 0.2)
// play the pbinds
t = TempoClock.new(120/60);
x.play(t, quant: 1);
y.play(t, quant: 1);

