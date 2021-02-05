MIDIdef.cc('cc_monitor',
{
	arg vel, num, chan, src;
	["cc",chan,num,vel,src].postln;
}).permanent_(true);

"CC Monitor".postln;