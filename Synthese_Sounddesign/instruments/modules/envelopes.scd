(
~adsrTypesShortcuts = (
	noEnv: "no",
	rect: "rc",
	pluck: "pl",
	pluckStop: "ps",
	lead: "le",
	pad: "pa",
	sync: "sy"
);

~adsrTypes = (
	noEnv: {var sig;

		sig = 1;
	},

	rect: {arg gate = 0, envelope_mod = 0, beatDuration, syncMultiplier, envCurve = 3;

		EnvGen.kr(
			Env.adsr(
				attackTime: 0,
				decayTime: 0,
				sustainLevel: 1,
				releaseTime: 0,
				curve: 0,
			),
			gate: gate,
			doneAction:2);
	},

	pluck: {arg gate = 0, envelope_mod = 0, beatDuration, syncMultiplier, envCurve = 3;

		var amp_a = envelope_mod.lincurve(0,1,0.001,0.02,3,nil),
		amp_r = envelope_mod.lincurve(0,1,0.05,3,3,nil);
		EnvGen.kr(
			Env.perc(
				attackTime: amp_a,
				releaseTime: amp_r,
				curve: envCurve,
			),
			gate: gate,
			doneAction:2);
	},

	pluckStop: {arg gate = 0, envelope_mod = 0, beatDuration, syncMultiplier, envCurve = 3;

		var amp_a = envelope_mod.lincurve(0,1,0.001,0.02,3,nil),
		amp_d = envelope_mod.lincurve(0,1,0.05,3,3,nil),
		amp_r = amp_d/2 * envelope_mod.lincurve(0,1,0.5,0.01,3,nil);
		EnvGen.kr(
			Env.adsr(
				attackTime: amp_a,
				decayTime: amp_d,
				sustainLevel: 0,
				releaseTime: amp_r,
				curve: envCurve,
			),
			gate: gate,
			doneAction:2);
	},

	lead: {arg gate = 0, envelope_mod = 0, beatDuration, syncMultiplier, envCurve = 3;

		var amp_a = envelope_mod.lincurve(0,1,0.01,0.25,3,nil),
		amp_d = envelope_mod.lincurve(0,1,0.5,0.1,3,nil),
		amp_s = envelope_mod.lincurve(0,1,0.7,1,3,nil),
		amp_r = envelope_mod.lincurve(0,1,0.1,1,3,nil);
		EnvGen.kr(
			Env.adsr(
				attackTime: amp_a,
				decayTime: amp_d,
				sustainLevel: amp_s,
				releaseTime: amp_r,
				curve: envCurve,
			),
			gate: gate,
			doneAction:2);
	},

	pad: {arg gate = 0, envelope_mod = 0, beatDuration, syncMultiplier, envCurve = 3;

		var amp_a = envelope_mod.lincurve(0,1,0.3,3,3,nil),
		amp_d = envelope_mod.lincurve(0,1,0.5,3,3,nil),
		amp_s = envelope_mod.lincurve(0,1,0.7,1,3,nil),
		amp_r = envelope_mod.lincurve(0,1,1,3,3,nil);
		EnvGen.kr(
			Env.adsr(
				attackTime: amp_a,
				decayTime: amp_d,
				sustainLevel: amp_s,
				releaseTime: amp_r,
				curve: envCurve,
			),
			gate: gate,
			doneAction:2);
	},

	sync: {arg gate = 0, envelope_mod = 0, beatDuration, syncMultiplier, envCurve = 3;

		var amp_a = beatDuration * syncMultiplier * envelope_mod,
		amp_r = beatDuration * syncMultiplier * (1 - envelope_mod);

		amp_a.postln;
		amp_r.postln;

		EnvGen.kr(
			Env.perc(
				attackTime: amp_a,
				releaseTime: amp_r,
				curve: envCurve,
			),
			gate: gate,
			doneAction:2);
	},

	adsr: {arg gate = 0, envelope_mod = 0, beatDuration, syncMultiplier, vca_curve = 3,
		vca_attack = 0.01, vca_decay = 0, vca_sustain = 1, vca_release = 0.01;

		EnvGen.kr(
			Env.adsr(
				attackTime: vca_attack,
				decayTime: vca_decay,
				sustainLevel: vca_sustain,
				releaseTime: vca_release,
				curve: vca_curve,
			),
			gate: gate,
			doneAction:2);
	},


);
);

"envelopes: ".post;
~adsrTypes.keys.postln;
