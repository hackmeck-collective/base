(
~pitchOpTypes = (
	unisonoDetune: {arg freq = 440, pitchOp_mod_1 = 0;

		var detune_amount = freq * pitchOp_mod_1.lincurve(0,1,0,0.05,3),
		detune_array = (-2..2) * detune_amount;

		freq = freq * detune_array;
	},

	vibrato: {arg freq = 440, pitchOp_mod_1 = 0;

		var speed = pitchOp_mod_1.lincurve(0,1,0.5,10,3),
		amount = freq * pitchOp_mod_1.lincurve(0,1,0.01,0.05,3);

		freq = freq + SinOsc.ar(speed,Rand(),amount);
	},

	fm: {arg freq = 440,
		pitchOp_mod_1 = 0,
		pitchOp_mod_2 = 0;

		var amount = pitchOp_mod_1.lincurve(0,1,0,100,3),
		ratio = freq * pitchOp_mod_2.lincurve(0,1,1,5,3);

		freq = freq + SinOsc.ar(ratio,Rand(),amount);
	},

	slide: {arg freq = 440,
		gate = 0,
		pitchOp_mod_1 = 0,
		pitchOp_mod_2 = 0;

		var interval = pitchOp_mod_1.lincurve(0,1,-24,24,3).midiratio,
		time = pitchOp_mod_2.lincurve(0,1,0.01,2,3);

		freq = freq * EnvGen.kr(
			Env.new([interval,1],
				time,
				curve: -4),
			gate: gate)
		;
	},
);
)
