/*~oneShot = { |path|
OSCFunc({ |msg|
var nextEventBeat = msg[1].postln;
~linkClock.sched(nextEventBeat - 1,{
(Pfindur(1.01, Pdef(\hh2) <> Pbindef(\pulse_64) <> Pbindef(\root) )).play(~linkClock, quant: 1);
nil
})
}, path).oneShot
}


~oneShot.("/trigger1")*/


OSCdef(\repeatFill, { |msg|
	var nextEventBeat = msg[1];
	//var schedTime = nextEventBeat - ~linkClock.timeToNextBeat(quant: 1);
	"Next fill in % beats".format(nextEventBeat.postln - ~cueData[\fillLength]).postln;
	Routine({
		(nextEventBeat - ~cueData[\fillLength]).wait;
		~audioBusses.drumsBus.set(\on, 0.postln);
		~cueData[\fillLength].wait;
		~audioBusses.drumsBus.set(\on, 1.postln)
	}).play(~linkClock, quant: 1);
	(Pbind(\out, ~aux_bus) <> Pdef(\fill)).play(~linkClock, quant: [1,0, nextEventBeat - ~cueData[\fillLength]] );
}, '/trigger1').permanent_(true);

~linkClock.timeToNextBeat(quant: 1);

