~buf_audio = Buffer.alloc(s, 5 * s.sampleRate, 1);
~buf_fft = Buffer.alloc(s, ~buf_audio.duration.calcPVRecSize(~fft_size, 0.5, ~buf_audio.sampleRate), 1);

~synth1 = Synth(\record_mono_with_fft, [\in, 8, \buf, ~buf_audio, \buf_fft, ~buf_fft]);

~synth = Synth(\sampler, [\buf, ~buf_audio]);
~synth = Synth(\fft_sustain, [\buf_fft, ~buf_fft, \point, 0.4, \point_mode, 1]);

~buf_audio.getn(44100, 100, {|i| i.postln;})

x = Synth(\sampler, [\buf, ~samples["basstrombone"]["mf"]["48"]["buffer"], \out, ~bus[0][0], \panmode, 1, \mul, 0.5]);
y = Synth(\fft_magbelow1, [\in, ~bus[0][0], \out, 0, \threshold, 0.4, \mul, 5, \lpf, 3000]);