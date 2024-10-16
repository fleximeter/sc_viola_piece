// File: event_runner.scd
// Runs events

// reset the events
~event_func_list = [
	{e["e1alt"].next},
	{e["e1alt"].next},
	{e["e1alt"].next},
	{e["e2alt"].next},
	{e["e2alt"].next},
	{e["e1alt"].next},  // free event 1 while event 2 is running
	{e["e2alt"].next},
	{e["e3alt"].next},
	{e["e3alt"].next},
	{e["e2alt"].next},  // free event 2 while event 3 is running
	{e["e3alt"].next},
	{e["e4"].next},
	{e["e3alt"].next},  // free event 3 while event 4 is running
	{e["e1"].next},
	{e["e1"].next},
	{e["e1"].next},
	{e["e1"].next},
	{e["e1"].next},
	{e["e1"].next},
	{e["e1"].next},
	{e["e1"].next},
];

