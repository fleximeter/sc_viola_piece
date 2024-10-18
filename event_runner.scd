// File: event_runner.scd
// Runs events

// reset the events
~event_func_list = [
	{e["e1alt"].next.postln},
	{e["e1alt"].next.postln},
	{e["e1alt"].next.postln},
	{e["e2alt"].next.postln},
	{e["e2alt"].next.postln},
	{e["e1alt"].next.postln},  // free event 1 while event 2 is running
	{e["e2alt"].next.postln},
	{e["e3alt"].next.postln},
	{e["e3alt"].next.postln},
	{e["e2alt"].next.postln},  // free event 2 while event 3 is running
	{e["e3alt"].next.postln},
	{e["e4"].next.postln},
	{e["e3alt"].next.postln},  // free event 3 while event 4 is running
	{e["e1"].next.postln},
	{e["e1"].next.postln},
	{e["e1"].next.postln},
	{e["e1"].next.postln},
	{e["e1"].next.postln},
	{e["e1"].next.postln},
	{e["e1"].next.postln},
	{e["e1"].next.postln},
];

