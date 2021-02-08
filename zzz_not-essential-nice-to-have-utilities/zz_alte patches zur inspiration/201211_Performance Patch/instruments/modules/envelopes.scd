(
~adsrTypes = (
	pluck: {arg gate = 0, envelope_mod = 0;

		var amp_a = envelope_mod.lincurve(0,1,0.001,0.02,3),
		amp_r = envelope_mod.lincurve(0,1,0.05,3,3),
		amp_c = envelope_mod.lincurve(0,1,1,-4,3);
		EnvGen.kr(
			Env.perc(
				attackTime: amp_a,
				releaseTime: amp_r,
				curve: amp_c
			),
			gate: gate,
			doneAction:2);
	},

	lead: {arg gate = 0, envelope_mod = 0;

		var amp_a = envelope_mod.lincurve(0,1,0.01,0.25,3),
		amp_d = envelope_mod.lincurve(0,1,0.5,0.1,3),
		amp_s = envelope_mod.lincurve(0,1,0.7,1,3),
		amp_r = envelope_mod.lincurve(0,1,0.1,1,3),
		amp_c = envelope_mod.lincurve(0,1,3,-4,3);
		EnvGen.kr(
			Env.adsr(
				attackTime: amp_a,
				decayTime: amp_d,
				sustainLevel: amp_s,
				releaseTime: amp_r,
				curve: amp_c
			),
			gate: gate,
			doneAction:2);
	},

	pad: {arg gate = 0, envelope_mod = 0;

		var amp_a = envelope_mod.lincurve(0,1,0.3,3,3),
		amp_d = envelope_mod.lincurve(0,1,0.5,3,3),
		amp_s = envelope_mod.lincurve(0,1,0.7,1,3),
		amp_r = envelope_mod.lincurve(0,1,1,3,3),
		amp_c = 3;
		EnvGen.kr(
			Env.adsr(
				attackTime: amp_a,
				decayTime: amp_d,
				sustainLevel: amp_s,
				releaseTime: amp_r,
				curve: amp_c
			),
			gate: gate,
			doneAction:2);
	},
);
)