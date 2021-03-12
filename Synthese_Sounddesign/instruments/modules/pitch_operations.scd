(
~pitchOpTypes = (
	noPitchOp: {arg freq = 440;

		freq;
	},

	unisonoDetune: {arg freq = 440,
		gate = 0,
		pitchOp_mod_1 = 0,
		pitchOp_mod_2 = 0;

		var detune_amount = freq * pitchOp_mod_1.lincurve(0,1,0,0.02,3),
		detune_array = [-1,1] * detune_amount;

		freq = freq + detune_array;
	},

	vibrato: {arg freq = 440,
		gate = 0,
		pitchOp_mod_1 = 0,
		pitchOp_mod_2 = 0;

		var speed = pitchOp_mod_1.lincurve(0,1,0.5,10,3),
		amount = freq * pitchOp_mod_1.lincurve(0,1,0.001,0.05,3);

		freq = freq + SinOsc.ar(speed,Rand(),amount);
	},

	vibratoSync: {arg freq = 440,
		gate = 0,
		pitchOp_mod_1 = 0,
		pitchOp_mod_2 = 0,
		beatDuration;

		var speed = 1 / (beatDuration * 4 * pitchOp_mod_2),
		amount = freq * pitchOp_mod_1.lincurve(0,1,0.001,0.05,3);

		freq = freq + SinOsc.ar(speed,Rand(),amount);
	},

	rectArp: {arg freq = 440,
		gate = 0,
		pitchOp_mod_1 = 0,
		pitchOp_mod_2 = 0;

		var speed = pitchOp_mod_2.lincurve(0,1,0.5,10,3),
		amount = freq * pitchOp_mod_1.linlin(0,1,0,24).midiratio;

		freq = freq * (LFPulse.ar(speed, add: 1));
	},

	rectArpSync: {arg freq = 440,
		gate = 0,
		pitchOp_mod_1 = 0,
		pitchOp_mod_2 = 0,
		beatDuration;

		var speed = 1 / (beatDuration * 4 * pitchOp_mod_2),
		amount = freq * pitchOp_mod_1.linlin(0,1,0,24).midiratio;

		freq = freq * (LFPulse.ar(speed, add: 1));
	},

	slide: {arg freq = 440,
		gate = 0,
		pitchOp_mod_1 = 0,
		pitchOp_mod_2 = 0;

		var interval = pitchOp_mod_1.lincurve(0,1,-24,24,0).midiratio,
		time = pitchOp_mod_2.lincurve(0,1,0.01,2,3);

		freq = freq * EnvGen.kr(
			Env.new([interval,1],
				time,
				curve: -4),
			gate: gate)
		;
	},

	slideVibrato: {arg freq = 440,
		gate = 0,
		pitchOp_mod_1 = 0,
		pitchOp_mod_2 = 0;

		var interval = pitchOp_mod_1.lincurve(0,1,-24,24,0).midiratio,
		time = pitchOp_mod_2.lincurve(0,1,0.01,2,3);
		var speed = pitchOp_mod_2.lincurve(0,1,2,8,3),
		amount = freq * pitchOp_mod_2.lincurve(0,1,0.001,0.025,3);

		freq = freq * EnvGen.kr(
			Env.new([interval,1],
				time,
				curve: -4),
			gate: gate) + SinOsc.ar(speed,Rand(),amount)
		;
	},

	fm: {arg freq = 440,
		gate = 0,
		pitchOp_mod_1 = 0,
		pitchOp_mod_2 = 0;

		var amount = pitchOp_mod_1.lincurve(0,1,0,1000,3),
		ratio = freq * pitchOp_mod_2.lincurve(0,1,1,5,3);

		freq = freq + SinOsc.ar(ratio,Rand(),amount);
	},

);
);

"pitch operations: ".post;
~pitchOpTypes.keys.postln;

