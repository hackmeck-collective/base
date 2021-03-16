~oneShot = { |path|
	OSCFunc({ |msg|
		var nextEventBeat = msg[1].postln;
		~linkClock.sched(nextEventBeat - 1,{
			(Pfindur(1.01, Pdef(\hh2) <> Pbindef(\pulse_64) <> Pbindef(\root) )).play(~linkClock, quant: 1);
			nil
		})
	}, path).oneShot
}


~oneShot.("/trigger1")

~repeatOsc = { |path|
	OSCFunc({ |msg|
		var nextEventBeat = msg[1].postln;
		~linkClock.sched(nextEventBeat - 1,{
			(Pfindur(1.01, Pdef(\simplePluckReverse,
				\dur, 1,
				\note, ~pitchesRootDissonance[\pitches],
			))).play(~linkClock, quant: 1);
			nil
		})
	}, path)
}

~oscFunc = ~repeatOsc.("/trigger1")