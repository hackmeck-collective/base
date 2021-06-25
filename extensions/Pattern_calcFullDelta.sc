+ Pattern {
	calcFullDelta { |cpuTimeThresh = 0.1|
		var sumDur = 0;
		var startTime = thisThread.seconds;
		var str = this.asStream;
		while { (thisThread.seconds - startTime) < cpuTimeThresh }
		{
			var nextEv = str.next(());
			if(nextEv.notNil){
				sumDur = sumDur + nextEv.delta;
			}{
				^sumDur
			}
		};
		"cpu time run out".postln;
		^nil
	}
}