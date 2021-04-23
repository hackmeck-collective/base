(
~pitchOpTypes = (
	noPitchOp: {arg pitchOp_freq = 440;

		pitchOp_freq;
	},

	unisonoDetune: {arg pitchOp_freq = 440,
		gate = 0,
		interval = 0;

		var detune_amount = [interval.midiratio,interval.midiratio.reciprocal],
		detune_array = pitchOp_freq * detune_amount;

		pitchOp_freq = pitchOp_freq + detune_array;
	},

	slide: {arg pitchOp_freq = 440,
		gate = 0,
		interval = 0,
		amount = 0;

		var time = amount.lincurve(0,1,0.01,2,3,nil);

		interval = interval.midiratio;

		pitchOp_freq = pitchOp_freq * EnvGen.kr(
			Env.new([interval,1],
				time,
				curve: -4),
			gate: gate)
		;
	},

	fm: {arg freq = 440,
		gate = 0,
		interval = 0,
		amount = 0
		;

		var ratio = freq * interval.midiratio;

		amount = amount.lincurve(0,1,0,1000,3,nil);

		freq = freq * SinOsc.ar(ratio,Rand(),amount);
	},

	vibrato: {arg freq = 440,
		gate = 0,
		interval = 0,
		amount = 0;

		var speed = amount.lincurve(0,1,0.5,10,3,nil);

		freq = freq * SinOsc.ar(speed,Rand(),interval).midiratio;
	},

	vibratoSync: {arg freq = 440,
		gate = 0,
		interval = 0,
		amount = 1,
		beatDuration;

		var speed = 1 / (beatDuration * 4 * amount);

		freq = freq * SinOsc.ar(speed,Rand(),interval).midiratio;
	},

	rectArp: {arg freq = 440,
		gate = 0,
		interval = 0,
		amount = 1;

		var speed = amount.lincurve(0,1,0.5,10,3,nil);

		freq = freq * LFPulse.ar(speed, mul: interval).midiratio;
	},

	rectArpSync: {arg freq = 440,
		gate = 0,
		interval = 0,
		amount = 1,
		beatDuration;

		var speed = 1 / (beatDuration * 4 * amount);

		freq = freq * LFPulse.ar(speed, mul: interval).midiratio;
	},



);
);

"pitch operations: ".post;
~pitchOpTypes.keys.postln;

