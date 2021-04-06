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
	var nextEventBeat = msg[1].postln;
	~linkClock.sched(nextEventBeat - ~cueData[\fillLength],{
		Pfindur(~cueData[\fillLength] + 0.01, Pdef(\fill)).play(~linkClock, quant: 1);
		nil
	})
}, "/trigger1").permanent_(true);


/*Pdef(\simplePluckReverse,
	\dur, 1,
	\note, ~pitchesRootDissonance[\pitches],
)*/