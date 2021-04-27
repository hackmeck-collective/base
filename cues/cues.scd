~networkEvents = Dictionary.new;

~networkEvents.add(\fill1 -> {|nextEventBeat|
	Routine({
		(nextEventBeat - ~cueData[\fillLength]).wait;
		~audioBusses.drumsBus.set(\on, 0);
		~cueData[\fillLength].wait;
		~audioBusses.drumsBus.set(\on, 1)
	}).play(~linkClock, quant: 1);
	(Pbind(\out, ~aux_bus) <> Pdef(\fill)).play(~linkClock, quant: [1,0, nextEventBeat - ~cueData[\fillLength]] );
	"network event 1".postln;}
);


OSCdef(\networkEvents, { |msg|
	var nextEventBeat = msg[1];
	var eventSymbol = msg[2];
	//var schedTime = nextEventBeat - ~linkClock.timeToNextBeat(quant: 1);
	("Next " ++ eventSymbol ++
		" in % beats".format(nextEventBeat - ~cueData[\fillLength])).postln;
	~networkEvents[eventSymbol].value(nextEventBeat);
}, '/trigger1').permanent_(true);

~linkClock.timeToNextBeat(quant: 1);

OSCdef(\reloadInstruments, { |msg|
	"reloading instr..".postln;
	~instrPreset.loadAll;
}, '/reloadInstruments').permanent_(true);
