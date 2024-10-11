// File: start.scd
//
// This file manages loading all required dependency files and executing them
// in preparation for running individual events.

(
// Loads files and establishes basic globals
~file_loader = {
    // It is necessary to set the root directory because we might be loading samples
    // from a different location depending on the computer
    //~root_sample_dir = "D:/";  // for desktop at home
    //~root_sample_dir = "C:/Users/jeffr/";  // for laptop
    ~root_sample_dir = "/Users/jmartin50/";  // for studio Mac

    // Basic useful constants
    ~partconv_size = 512;  // project-wide STFT window size for convolution
    ~fft_size = 2048;  // project-wide STFT window size
    ~mic_zero = 8;     // the zero mic - NOTE on the RME in the studio it is 8!

    // Global buffers
    ~bufs = Array.fill(20, {Buffer.alloc(s, 20 * s.sampleRate)});    // buffers for sampling live audio

    // The event dictionary
    e = Dictionary();

    // A global synth list. This is needed if an event is to be manually stopped after it is started.
    // This is because some events cannot run for a specified time.
	~synths = List();

    // Specify file paths for other code to load automatically. Note that since the event code can be
    // so long for individual events, it is necessary to split it into multiple files.
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "synthdefs/synthdefs_delay.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "synthdefs/synthdefs_feedback.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "synthdefs/synthdefs_fft.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "synthdefs/synthdefs_filter.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "synthdefs/synthdefs_general.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "synthdefs/synthdefs_granulation.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "synthdefs/synthdefs_live_buffer.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "synthdefs/synthdefs_pitchshift.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "synthdefs/synthdefs_reverb.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "synthdefs/synthdefs_sampler.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "sample_defs/samples.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "midi_controller.scd").load;
    //(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "events/events001.scd").load;
    //(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "events/events049.scd").load;
    //(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "events/events075.scd").load;
    //(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "events/events091.scd").load;
    //(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "events/events111.scd").load;
    //(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "events/events117.scd").load;
    //(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "events/events130.scd").load;
    //(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "events/events148.scd").load;
};

// Prepare impulse response buffers for PartConv
~convolution_setup = {(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "sample_defs/convolution_setup.scd").load};

// Make buses
~bus_maker = {
    // buses heading to synths in Group 0. This is separate so it is clear when a signal
    // is a control signal. Control signals are mono.
    ~controlbus = Array.fill(40, {Bus.control(s, 1)});
    ~faderbus = Array.fill(9, {Bus.control(s, 1)});
    ~knobbus = Array.fill(2, {Bus.control(s, 1)});
    ~micbus = Bus.audio(s, 1);
    ~reverbbus = Array.fill(10, {Bus.audio(s, 8)});
    ~gainbus = Bus.audio(s, 8);
    ~postprocessingbus = Array.fill(5, {Bus.audio(s, 8)});

    // Audio bus arrays. Audio signals are 8-channel.
    ~audiobus = [
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
    ];
};

// Make groups
~group_maker = {
    // Four groups:
    //  - group 0 for control
    //  - group 1 for sound in/production
    //  - group 2 for effects 1
    //  - group 3 for effects 2
    //  - group 4 for effects 3
    ~grp = Array.fill(10, {Group.new(s, \addToTail)});
};
)

// Manually load things
~bus_maker.();
~file_loader.();
~group_maker.();
~convolution_setup.();


// Alternatively, this can be done automatically
s.waitForBoot({
    ~file_loader.();
    s.sync;
    ~convolution_setup.();
    ~bus_maker.();
    s.sync;
});
