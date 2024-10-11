// File: event_runner.scd
// Runs events

// reset the events
(
e.keysValuesDo{
	|key, val|
	val.reset;
}
)
~grp = Array.fill(5, {Group.new(s, \addToTail)});

e["m3"].play;
e["m5"].play;
e["m7"].play;
e["m9"].play;
e["m12"].play;
e["m14"].play;
e["m16"].play;
e["m19"].play;
e["m24"].play;
e["m25"].play;
e["m27"].play;

// rehearsal D, sustains
e["m75"].play;
e["m77"].play;
e["m79"].play;
e["m81"].play;
e["m83"].play;
e["m85"].play;
e["m87"].play;
e["m89"].play;
e["m91"].play;
e["m93"].play;

// harmonization with no sustain
e["m95"].play;


e["m97"].play;
e["m99"].play;
e["m3"].play;
e["m3"].play;


e["103"].next;
e["103"].next;
e["103"].next;
e["103"].next;
e["103"].next;


e["m3"].play;
e["m3"].play;
e["m3"].play;
e["m3"].play;

