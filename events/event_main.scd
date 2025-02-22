// File: event_main.scd
// This file contains the main event.

// FADER 0: NOT USED
// FADER 1: NOT USED
// FADER 2: MIC GAIN
// FADER 3: OUTPUT GAIN
// KNOB 0: PAN POS
// KNOB 1: PAN WIDTH
// FADER 4: FEEDBACK PERCENT
// FADER 5:
// FADER 6:
// FADER 7:
// FADER 8: BANDPASS CENTER

// This event runs the microphone, reverbs, and gain.
// It also includes a pan mapper so that you can run this in stereo or 8-channel.
e.put("main", Routine({
    var synth_mic, synth_reverb, synths, date, date_tag;
    synth_reverb = List();
    synths = List();

    // control mic gain with fader 3
    synth_mic = Synth(\mic1mul, [\in, ~mic_zero, \out, ~micbus, \mul_sig, ~faderbus[2]], ~grp[0], \addToTail);

    synth_reverb.add(Synth(\partconv8wet, [\in, ~reverbbus[0], \out, ~gainbus, \fft_size, ~partconv_size, \mul, 1.0, \irbuf, ~convolution_buffers["cathedral"]], ~grp[~grp.size-1], \addToTail));
    synth_reverb.add(Synth(\partconv8wet, [\in, ~reverbbus[1], \out, ~gainbus, \fft_size, ~partconv_size, \mul, 1.0, \irbuf, ~convolution_buffers["wine_tank"]], ~grp[~grp.size-1], \addToTail));
    synth_reverb.add(Synth(\partconv8wet, [\in, ~reverbbus[2], \out, ~gainbus, \fft_size, ~partconv_size, \mul, 1.0, \irbuf, ~convolution_buffers["chamber"]], ~grp[~grp.size-1], \addToTail));
    synth_reverb.add(Synth(\partconv8wet, [\in, ~reverbbus[3], \out, ~gainbus, \fft_size, ~partconv_size, \mul, 1.0, \irbuf, ~convolution_buffers["toilet"]], ~grp[~grp.size-1], \addToTail));

    // control the gain with fader 4
    synths.add(Synth(\gain8mul, [\in, ~gainbus, \out, ~postprocessingbus[0], \mul, ~global_gain, \mul_sig, ~faderbus[3], \limit, -6.dbamp], ~grp[~grp.size-1], \addToTail));

    // the pan mapping (stereo or 8-channel)
    // for the 8-channel version, we also send to a stereo recording bus
	if(~out_channels == 8,
		{
            synths.add(Synth(\from8to8, [\in, ~postprocessingbus[0], \out, 0], ~grp[~grp.size-1], \addToTail));
            synths.add(Synth(\from8to2, [\in, ~postprocessingbus[0], \out, ~recordbus2, \mul, 8.dbamp], ~grp[~grp.size-1], \addToTail));

        },
		{
            synths.add(Synth(\from8to2, [\in, ~postprocessingbus[0], \out, 0], ~grp[~grp.size-1], \addToTail));
        }
	);
    "0 UPDATE 0.0: Main event running.".yield;

    // cleanup
    Routine({
        synth_mic.set(\gate, 0);
        1.wait;
        synth_reverb.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths.do({|item| item.free});
        synth_mic.free;
        synth_reverb.do({|item| item.free});
        "0 UPDATE 0.2: Main event kill stage 2 complete. Event finished.".postln;
    }).play;
    "0 UPDATE 0.1: Main event kill stage 1 complete.".postln;
}));

// A variant for the video recording
e.put("main_02_23_25", Routine({
    var synth_mic, synth_reverb, synths;
    synth_reverb = List();
    synths = List();

    // control mic gain with fader 3
    synth_mic = Synth(\mic1mul, [\in, ~mic_zero, \out, ~micbus, \mul_sig, ~faderbus[2]], ~grp[0], \addToTail);

    synth_reverb.add(Synth(\partconv8wet, [\in, ~reverbbus[0], \out, ~gainbus, \fft_size, ~partconv_size, \mul, 1.0, \irbuf, ~convolution_buffers["cathedral"]], ~grp[~grp.size-1], \addToTail));
    synth_reverb.add(Synth(\partconv8wet, [\in, ~reverbbus[1], \out, ~gainbus, \fft_size, ~partconv_size, \mul, 1.0, \irbuf, ~convolution_buffers["wine_tank"]], ~grp[~grp.size-1], \addToTail));
    synth_reverb.add(Synth(\partconv8wet, [\in, ~reverbbus[2], \out, ~gainbus, \fft_size, ~partconv_size, \mul, 1.0, \irbuf, ~convolution_buffers["chamber"]], ~grp[~grp.size-1], \addToTail));
    synth_reverb.add(Synth(\partconv8wet, [\in, ~reverbbus[3], \out, ~gainbus, \fft_size, ~partconv_size, \mul, 1.0, \irbuf, ~convolution_buffers["toilet"]], ~grp[~grp.size-1], \addToTail));

    // control the gain with fader 4
    synths.add(Synth(\gain8mul, [\in, ~gainbus, \out, ~postprocessingbus[0], \mul, ~global_gain, \mul_sig, ~faderbus[3], \limit, -6.dbamp], ~grp[~grp.size-1], \addToTail));

	// map all of the mic audio and the electronics audio to the appropriate mono recording buses
	synths.add(Synth(\record_map, [
		\mic, ~micbus,
		\electronics, ~postprocessingbus[0],
		\out_mic, ~recordbus_mono[0],
		\out_electronics1, ~recordbus_mono[1],
		\out_electronics2, ~recordbus_mono[2],
		\out_electronics3, ~recordbus_mono[3],
		\out_electronics4, ~recordbus_mono[4],
		\out_electronics5, ~recordbus_mono[5],
		\out_electronics6, ~recordbus_mono[6],
		\out_electronics7, ~recordbus_mono[7],
		\out_electronics8, ~recordbus_mono[8],
	], ~grp[~grp.size-1], \addToTail));

	// terminate any recordings that may be occurring
    if(r[0].isRecording, {
		r.do(|recorder| {recorder.stopRecording});
        "STOPPED RECORDING".postln;
	});

	// get the current date and time to tag the recordings
	date = Date.getDate;
	dateTag = "_" ++ date.year ++ "_" ++ date.month ++ "_" ++ date.day ++ "_" ++ date.hour ++ "_" ++ date.minute ++ "_" ++ date.second;

	// record the outputs
	r[0].record(PathName(~root_sample_dir ++ "samples/recording" ++ dateTag ++ "_mic.wav").fullPath, ~recordbus_mono[0], 1);
	r[1].record(PathName(~root_sample_dir ++ "samples/recording" ++ dateTag ++ "_electronics_ch1.wav").fullPath, ~recordbus_mono[1], 1);
	r[2].record(PathName(~root_sample_dir ++ "samples/recording" ++ dateTag ++ "_electronics_ch2.wav").fullPath, ~recordbus_mono[2], 1);
	r[3].record(PathName(~root_sample_dir ++ "samples/recording" ++ dateTag ++ "_electronics_ch3.wav").fullPath, ~recordbus_mono[3], 1);
	r[4].record(PathName(~root_sample_dir ++ "samples/recording" ++ dateTag ++ "_electronics_ch4.wav").fullPath, ~recordbus_mono[4], 1);
	r[5].record(PathName(~root_sample_dir ++ "samples/recording" ++ dateTag ++ "_electronics_ch5.wav").fullPath, ~recordbus_mono[5], 1);
	r[6].record(PathName(~root_sample_dir ++ "samples/recording" ++ dateTag ++ "_electronics_ch6.wav").fullPath, ~recordbus_mono[6], 1);
	r[7].record(PathName(~root_sample_dir ++ "samples/recording" ++ dateTag ++ "_electronics_ch7.wav").fullPath, ~recordbus_mono[7], 1);
	r[8].record(PathName(~root_sample_dir ++ "samples/recording" ++ dateTag ++ "_electronics_ch8.wav").fullPath, ~recordbus_mono[8], 1);

    // the pan mapping (stereo or 8-channel)
    synths.add(Synth(\from8to2, [\in, ~postprocessingbus[0], \out, 0], ~grp[~grp.size-1], \addToTail));
	"0 UPDATE 0.0: Main event (2-23-25) running *and recording*.".yield;

    // cleanup
    Routine({
        synth_mic.set(\gate, 0);
        1.wait;
        synth_reverb.do({|item| item.set(\gate, 0)});
        1.5.wait;
        synths.do({|item| item.free});
        synth_mic.free;
        synth_reverb.do({|item| item.free});
		r.do(|recorder| {recorder.stopRecording});
		"Recording stopped.".postln;
        "0 UPDATE 0.2: Main event (2-23-25) kill stage 2 complete. Event finished.".postln;
    }).play;
    "0 UPDATE 0.1: Main event (2-23-25) kill stage 1 complete.".postln;
}));
