// File: start.scd
//
// This file manages loading all required dependency files and executing them
// in preparation for running individual events.

(
// Set important server things here.
Server.default.options.memSize_(1024*1024);
Server.default.options.numBuffers_(8192);
//Server.default.options.inDevice_("Fireface UFX (23703107)");
//Server.default.options.outDevice_("Fireface UFX (23703107)");
Server.default.options.inDevice_("Fireface UFX III (24134250)");
Server.default.options.outDevice_("Fireface UFX III (24134250)");
Server.default.options.sampleRate_(44100);
Server.default.options.numAudioBusChannels_(2048);
Server.default.options.numOutputBusChannels_(8);
Server.default.options.numInputBusChannels_(16);
Server.default.options.hardwareBufferSize_(256);
Server.supernova;


// Loads files and establishes basic globals
~file_loader = {
    // Basic useful constants
    ~partconv_size = 512;  // project-wide STFT window size for convolution
    ~fft_size = 4096;  // project-wide STFT window size
    ~mic_zero = 9;     // the zero mic - NOTE on the RME in the studio it is 8!
	~out_channels = 8;  // the number of out channels
    ~root_sample_dir = PathName(thisProcess.nowExecutingPath).parentPath;
    ~record_num = -1;
    r = Array.fill(2, {Recorder(s)});

    // gain can be adjusted here on a global level
    ~global_gain = 0.dbamp;

    // Global buffers
    ~bufs = Array.fill(20, {Buffer.alloc(s, 20 * s.sampleRate)});    // buffers for sampling live audio

    // The event dictionary
    e = Dictionary();
    ~event_counter = 0;  // the event counter for executing in order

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
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "synthdefs/synthdefs_pitchshift.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "synthdefs/synthdefs_reverb.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "synthdefs/synthdefs_sampler.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "sample_defs/samples.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "midi_controller.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "events/event_main.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "events/events001.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "events/events009.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "events/events025.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "events/events047.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "events/events068.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "events/events084.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "events/events106.scd").load;
    (PathName.new(thisProcess.nowExecutingPath).parentPath ++ "events/event_runner.scd").load;
};

// Prepare impulse response buffers for PartConv
~convolution_setup = {(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "sample_defs/convolution_setup.scd").load};

// Make buses
~bus_maker = {
    // Control buses come in 3 groups so that successive events
    // do not share the same control buses. This prevents some
    // annoying bus writes.
    ~controlbus_grp1 = Array.fill(20, {Bus.control(s, 1)});
    ~controlbus_grp2 = Array.fill(20, {Bus.control(s, 1)});
    ~controlbus_grp3 = Array.fill(20, {Bus.control(s, 1)});

    // Buses for the MIDI controller
    ~faderbus = Array.fill(9, {Bus.control(s, 1)});
    ~knobbus = Array.fill(2, {Bus.control(s, 1)});

    // Buses for the main event that manages the mic and the reverb
    ~micbus = Bus.audio(s, 1);
    ~reverbbus = Array.fill(10, {Bus.audio(s, 8)});
    ~gainbus = Bus.audio(s, 8);
    ~postprocessingbus = Array.fill(5, {Bus.audio(s, 8)});

    // Audio bus arrays. Audio signals are 8-channel.
    // The audio buses also come in 3 groups so that successive
    // events do not share the same audio buses.
    ~audiobus_grp1 = [
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
    ];
    ~audiobus_grp2 = [
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
    ];
    ~audiobus_grp3 = [
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
        Array.fill(10, {Bus.audio(s, 8)}),
    ];

    ~recordbus1 = Bus.audio(s, 1);
    ~recordbus2 = Bus.audio(s, 2);
    ~recordbus8 = Bus.audio(s, 8);
};

// Make groups
~group_maker = {
    ~grp = Array.fill(6, {Group.new(s, \addToTail)});
};

// Reset all events except the main event
~event_counter_reset = {
    ~event_counter = 0;
    ~piece_index = 0;
    "--------------------------------------\nEvent counter reset to 0.\n--------------------------------------".postln;
    nil
};

// Resets all events except the main event
~partial_reset = {
    e.keysValuesDo({|key, val| if(key != "main", {val.reset})});  // reset all events but main
    "--------------------------------------\nPartial reset performed.\n--------------------------------------".postln;
    nil
};

// Performs a Cmd+., resets all events, and recreates groups.
~full_reset = {
    Routine({
        CmdPeriod.run;
        0.1.wait;
        e.keysValuesDo({|key, val| val.reset});  // reset all events including main
        ~grp = Array.fill(10, {Group.new(s, \addToTail)});
        e["main"].next;
    }).play;
    ~event_counter = 0;
    ~piece_index = 0;
    "--------------------------------------\nFull reset performed.\n--------------------------------------".postln;
    nil
};

// Performs a reset for all events, except main, where the measure number of the event
// is greater than or equal to the specified measure number. This allows starting
// partway through the piece.
~reset_to_event = {
    | num |
    // Reset each event that is numbered
    e.keysValuesDo({
        |key, val|
        var result;
        result = key.findRegexp("[0-9]+");
        if(result.size > 0, {
            var eventnum;
            eventnum = result[0][1].asInteger;
            // Only reset the targeted event and all events after it.
            // The events preceding it need to be killed.
            if(eventnum >= num, {
                val.reset;
            }, {
                val.stop;
            });
        });
    });

    // Update the event counter so that it points at the targeted event
    i = 0;
    ~event_counter = 0;
    while({
        var regex, val;
        regex = ~event_order_list[i][0].findRegexp("[0-9]+");
        if(regex.size == 0, {true}, {
            val = regex[0][1].asInteger;
            val < num
        })
    }, {
        ~event_counter = ~event_counter + 1;
        i = i + 1;
    });
    ("--------------------------------------\nReset to measure " ++ num ++ ".\n--------------------------------------").postln;
    nil
};


// Manually load things
/*~bus_maker.();
~file_loader.();
~group_maker.();
~convolution_setup.();
*/

// Alternatively, this can be done automatically
s.waitForBoot({
    ~bus_maker.();
    ~file_loader.();
    s.sync;
    ~group_maker.();
    ~convolution_setup.();
    s.sync;
    s.meter;
    s.plotTree;
    e["main"].next;
});
)
