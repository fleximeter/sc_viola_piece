e["main"].next;
e["e1"].next;  // x5
e["e1alt"].next;  // x5
e["e2"].next;
e["e2alt"].next;  // x5
e["e3"].next;  // x5
e["e3alt"].next;  // x5
e["e4"].next;
e["e5"].next;
e["e6"].next;
e["e7alt"].next;
e["e9"].next;
e["e14"].next;
e["e17"].next;
e["e18"].next;
e["e24"].next;
e["e28"].next;
e["e31"].next;
e["e33"].next;
e["e35"].next;
e["e45"].next;
e["e18"].next;
e["e18"].next;
e["e18"].next;
e["e18"].next;
e["e68"].play;
e["e69"].play;
e["e70"].play;
e["e72"].play;
e["e73"].play;
e["e75"].next;
e["e76"].next;
e["e79"].next;
e["e82a"].next;
e["e82b"].next;
e["e83"].next;
e["e96"].next;
e["e98"].next;
e["e101"].next;
e["e105"].next;
e["e128"].next;
e["ex5"].next;
e["ex6"].next;
e["octaves"].next;
e["feedback"].next;

~samples["piece"][~piece_index]["path"]
~piece_index = 0
~event_counter = 0;
~reset_to_event.(64);
~event_counter.postln;
~global_gain = 6.dbamp;

// check sound
{PanAz.ar(8, SinOsc.ar(440, 0, 0.1, 0), 0.5, 1, 2.0)}.play;


// test signal flow
(
SynthDef(\delay, {
    var sig;
    sig = In.ar(~micbus);
    sig = DelayL.ar(sig, 1, 0.5);
    Out.ar(\out.kr(0), sig);
}).add;
)

z = Synth(\mic1, [\in, ~mic_zero, \out, ~micbus], addAction: \addToTail);
x = Synth(\delay, [\out, ~gainbus], ~grp[3], \addToTail);
x.free;


// Performs a reset for all events, except main, where the measure number of the event
// is greater than or equal to the specified measure number. This allows starting
// partway through the piece.
~reset_to_event = {
    | num |
    e.keysValuesDo({
        |key, val|
        var result;
        result = key.findRegexp("[0-9]+");
        if(result.size > 0, {
            var eventnum;
            eventnum = result[0][1].asInteger;
            if(eventnum >= num, {
                val.reset;
            }, {
                val.stop;
            });
        });
    });
    i = 0;
    ~event_counter = 0;
    while({
        var regex, val;
        regex = ~event_order_list[i][0].findRegexp("[0-9]+");
        if(regex.size == 0,
        {true},
        {
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



// Performs a Cmd+., resets all events, and recreates groups.
~full_reset = {
    Routine({
        CmdPeriod.run;
        0.5.wait;
        e.keysValuesDo({|key, val| val.reset});  // reset all events including main
        ~grp = Array.fill(10, {Group.new(s, \addToTail)});
        e["main"].next;
    }).play;
    ~event_counter = 0;
    "--------------------------------------\nFull reset performed.\n--------------------------------------".postln;
    nil
};