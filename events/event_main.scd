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
    var synth_mic, synth_reverb, synths;
	synth_reverb = List();
	synths = List();

    // control mic gain with fader 3
	synth_mic = Synth(\mic1mul, [\in, ~mic_zero, \out, ~micbus, \mul_sig, ~faderbus[2]], ~grp[0], \addToTail);

    synth_reverb.add(Synth(\partconv8wet, [\in, ~reverbbus[0], \out, ~gainbus, \fft_size, ~partconv_size, \mul, 1.0, \irbuf, ~convolution_buffers["cathedral"]], ~grp[~grp.size-1], \addToTail));/*
    synth_reverb.add(Synth(\partconv8wet, [\in, ~reverbbus[1], \out, ~gainbus, \fft_size, ~partconv_size, \mul, 1.0, \irbuf, ~convolution_buffers["wine_tank"]], ~grp[~grp.size-1], \addToTail));
    synth_reverb.add(Synth(\partconv8wet, [\in, ~reverbbus[2], \out, ~gainbus, \fft_size, ~partconv_size, \mul, 1.0, \irbuf, ~convolution_buffers["chamber"]], ~grp[~grp.size-1], \addToTail));
    synth_reverb.add(Synth(\partconv8wet, [\in, ~reverbbus[3], \out, ~gainbus, \fft_size, ~partconv_size, \mul, 1.0, \irbuf, ~convolution_buffers["toilet"]], ~grp[~grp.size-1], \addToTail));*/

    // control the gain with fader 4
	synths.add(Synth(\gain8mul, [\in, ~gainbus, \out, ~postprocessingbus[0], \mul, 1, \mul_sig, ~faderbus[3], \limit, -6.dbamp], ~grp[~grp.size-1], \addToTail));

	// the pan mapping (stereo or 8-channel)
	//synths.add(Synth(\from8to2, [\in, ~postprocessingbus[0], \out, 0], ~grp[~grp.size-1], \addToTail));
	synths.add(Synth(\from8to8, [\in, ~postprocessingbus[0], \out, 0], ~grp[~grp.size-1], \addToTail));
    "0 UPDATE 0.0: Main event running.".yield;

	synth_mic.set(\gate, 0);
    synth_reverb.do({|item| item.set(\gate, 0)});
    "0 UPDATE 0.1: Main event kill stage 1 complete.".yield;
    synths.do({|item| item.free});
    synth_mic.free;
    synth_reverb.do({|item| item.free});
    "0 UPDATE 0.2: Main event kill stage 2 complete. Event finished.".postln;
}));
