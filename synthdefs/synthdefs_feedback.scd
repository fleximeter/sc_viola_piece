// File: synthdefs_feedback.scd
// SynthDefs for feedback

// A more complex feedback synth that brings in mag smoothing and filtering
SynthDef(\fbx, {
    var sig, chain, local, ndelay, ctrl_fb, ctrl_mul, magsmooth, band_freq, current_amp, feedback_limiter;
    ndelay = 4;

    // explicit midi control of mul and feedback values
    ctrl_mul = In.kr(\mul_sig.kr(0));
    ctrl_fb = In.kr(\feedback.kr(0));
    // magsmooth = In.kr(\feedback.kr(0));
    band_freq = In.kr(\freq.kr(0));

    // read the mic
    sig = In.ar(\in.kr(0), 8);

    // fill the feedback path with delays
    local = LocalIn.ar(8) + sig;
    local = Mix(Array.fill(ndelay, { |i|
        DelayL.ar(local, 1, (i+1)/(2*ndelay) + LFNoise1.kr(0.5).linlin(-1, 1, -0.001, 0.001), 2/ndelay)
    }));

	// track the feedback amplitude
	current_amp = Amplitude.kr(local);

	// use a modified hyperbolic secant function to limit the feedback so it won't blow up
	feedback_limiter = 2 / ((3 * current_amp).exp + (-3 * current_amp).exp);

    // spectral processing
    chain = FFT({LocalBuf(~fft_size)}!8, local);
    chain = PV_MagSmooth(chain, 0.2);
	chain = PV_MagSmear(chain, 10);
    local = IFFT(chain);

    local = HPF.ar(local, 100);
	local = BPF.ar(local, band_freq.linlin(0, 1, \low_freq.ir(200), \high_freq.ir(600)), 0.3);

    // make the feedback happen. The feedback can be adjusted manually if it needs to be scaled.
	LocalOut.ar(local * ctrl_fb * \feedback_scaler.kr(1.5) * feedback_limiter);
    local = local.madd(\mul.kr(1) * ctrl_mul, 0);
    Out.ar(\out.kr(0), local);
}).add;


// A more complex feedback synth that brings in mag smoothing and filtering
SynthDef(\fbx2, {
    var sig, chain, local, ndelay, ctrl_fb, ctrl_mul, magsmooth, current_amp, feedback_limiter, band_freq;
    ndelay = 8;

    // Explicit MIDI control of mul and feedback values
    ctrl_mul = In.kr(\mul_sig.kr(0));
    ctrl_fb = In.kr(\feedback.kr(0));
	band_freq = In.kr(\freq.kr(0));

    // Read the mic
    sig = In.ar(\in.kr(0), 8);

    // Fill the feedback path with delays
    local = LocalIn.ar(8) + sig;
    local = Mix(Array.fill(ndelay, { |i|
        DelayL.ar(local, 1, (i+1)/(2*ndelay) + LFNoise1.kr(0.5).linlin(-1, 1, -0.001, 0.001), 2/ndelay)
    }));

	// AUTOMATIC FEEDBACK LIMITER
	// Tracks the amplitude of the feedback path and dumps it into a
	// modified hyperbolic secant function to automatically lower the feedback coefficient.
	current_amp = Amplitude.kr(local, 0.5, 0.5);
	feedback_limiter = 1 / ((6 * current_amp).exp + (-6 * current_amp).exp);

    // Spectral processing
    chain = FFT({LocalBuf(~fft_size)}!8, local);
    chain = PV_MagSmooth(chain, 0.5);
    local = IFFT(chain);

	// Get rid of very low frequencies to avoid annoying rumbles
    local = HPF.ar(local, 100);

    // Prepare the BPF frequency ugen. There are several things at play here.
	// 1) We receive input from the MIDI fader and quantize to the nearest MIDI note
	// 2) We add some slow LF ramp noise to try to counter the tendency for feedback to overly boost a single sine wave
	// 3) We back-convert from MIDI to frequency
    band_freq = (band_freq.linlin(0, 1, \low_freq.ir(200), \high_freq.ir(600)).cpsmidi + LFNoise1.kr(0.5, 5)).midicps.lag(0.5);

	// apply BPF
	local = BPF.ar(
		local,
		band_freq,
		0.3
	);

    // make the feedback happen. The feedback can be adjusted manually if it needs to be scaled.
	LocalOut.ar(local * ctrl_fb * \feedback_scaler.kr(1.5) * feedback_limiter);
    local = local.madd(\mul.kr(1) * ctrl_mul, 0);
    Out.ar(\out.kr(0), local);
}).add;