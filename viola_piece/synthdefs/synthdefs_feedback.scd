// File: synthdefs_feedback.scd
// SynthDefs for feedback

SynthDef(\fb0, {
	var sig, chain, local, ndelay, ctrl_fb, ctrl_mul;
	ndelay = 4;

	// explicit midi control of mul and feedback values
	ctrl_mul = In.kr(\mul_sig.kr(0));
	ctrl_fb = In.kr(\feedback.kr(0));

    // read the mic
	sig = In.ar(\in.kr(0), 8);

    // fill the feedback path with delays
	local = LocalIn.ar(8) + sig;
	local = Mix(Array.fill(ndelay, { |i|
		DelayL.ar(local, 1, (i+1)/(2*ndelay) + LFNoise1.kr(0.5).linlin(-1, 1, -0.001, 0.001), 2/ndelay)
	}));

    // limit the output volume
	local = Compander.ar(local, local, -18.dbamp, 1, 0.2);

    // make the feedback happen
    LocalOut.ar(local * ctrl_fb * 1.5);

	local = local.madd(\mul.kr(1) * ctrl_mul, 0);
    local = Limiter.ar(local, -12.dbamp);
	Out.ar(\out.kr(0), local);
}).add;

// A more complex feedback synth that brings in mag smoothing and filtering
SynthDef(\fb1, {
	var sig, chain, local, ndelay, ctrl_fb, ctrl_mul, magsmooth, band_freq;
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

    // spectral processing
    chain = FFT({LocalBuf(~fft_size)}!8, local);
    chain = PV_MagSmooth(chain, 0.5);
    local = IFFT(chain);

    local = LeakDC.ar(local);
    local = HPF.ar(local, 100);
    local = BPF.ar(local, band_freq.linlin(0, 1, 200, 600));

    // limit the output volume
	local = Compander.ar(local, local, -18.dbamp, 1, 0.2);

    // make the feedback happen
    LocalOut.ar(local * ctrl_fb * 1.5);
	local = local.madd(\mul.kr(1) * ctrl_mul, 0);
    local = Limiter.ar(local, -12.dbamp);
	Out.ar(\out.kr(0), local);
}).add;

// A more complex feedback synth that brings in mag smoothing and filtering
SynthDef(\fb2, {
	var sig, chain, local, ndelay, ctrl_fb, ctrl_mul, magsmooth, band_freq;
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

    // spectral processing
    chain = FFT({LocalBuf(~fft_size)}!8, local);
    chain = PV_MagSmooth(chain, 0.5);
	chain = PV_MagSmear(chain, 3);
    local = IFFT(chain);

    local = LeakDC.ar(local);
    local = HPF.ar(local, 100);
	// insert resonant peaks
    local = Mix([Resonz.ar(local, \freq1.kr(440), 1.0), Resonz.ar(local, \freq2.kr(660), 1.0)]);

    // limit the output volume
	local = Compander.ar(local, local, -18.dbamp, 1, 0.2);

    // make the feedback happen
    LocalOut.ar(local * ctrl_fb * 1.5);
	local = local.madd(\mul.kr(1) * ctrl_mul, 0);
    local = Limiter.ar(local, -12.dbamp);
	Out.ar(\out.kr(0), local);
}).add;
