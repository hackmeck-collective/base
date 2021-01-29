(
~drumTypes = (
	sineSweep: {arg freq = 440, gate = 1, osc1_time = 0.5, osc1_range = 0;

		var sweep, envelope;
		osc1_time = osc1_time.lincurve(0,1,0.25,1,3);
		osc1_range = osc1_range.linlin(0,1,0,36).midiratio;

		sweep = osc1_range * EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: osc1_time/10,
				curve: -7
			),
			gate: gate);

		envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: osc1_time,
				curve: -2
			),
			gate: gate,
			doneAction:2);

		SinOsc.ar(freq + (freq*sweep)) * envelope;
	},

	snare: {arg freq = 440, gate = 1, osc1_time = 0.5, osc1_range = 0;

		var sweep, envelope;
		osc1_time = osc1_time.lincurve(0,1,0.15,0.5,3);
		osc1_range = osc1_range.linlin(0,1,0,36).midiratio;

		sweep = osc1_range * EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: osc1_time/10,
				curve: 2
			),
			gate: gate);

		envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: osc1_time,
				curve: -4
			),
			gate: gate,
			doneAction:2);

		(Pulse.ar(freq + (freq*sweep),0.5*(1-(sweep*0.8))) * envelope);
	},

	whiteNoise: {arg freq = 440, gate = 1, osc1_time = 0.5, osc1_range = 0;

		var sweep, envelope,
		env_time = osc1_time.lincurve(0,1,0.005,0.25,3),
		env_curve = osc1_time.lincurve(0,1,-4,4,7);
		osc1_range = osc1_range.linlin(0,1,2000,7500);

		envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: env_time,
				curve: -4
			),
			gate: gate,
			doneAction:2);

		BHiPass4.ar(WhiteNoise.ar(4) * envelope, osc1_range,2);
	},
)
)
