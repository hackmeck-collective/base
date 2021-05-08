(
~modSourcesShortcuts = (
	noMod: "no",
	adsrEnv: "ae",
	syncEnv: "se",
	sineSyncLFO: "ss",
	sineLFO: "sl",
	rampSyncLFO: "rs",
	rampLFO: "rl",
	sawLFO: "sw",
	sawSyncLFO: "so",
	triSyncLFO: "ts",
	triLFO: "tl",
	rectSyncLFO: "re",
	rectLFO: "rc",
	sampleAndHold: "sh"
);

~modSources = (
	noMod: {arg freq = 440,
		gate = 1,
		oscillator_mod_1 = 0,
		oscillator_mod_2 = 0;

		var sig;

		sig = 0;

	},



	////////////////////////////// ENVs

	adsrEnv: {arg gate, beatDuration, syncMultiplier, mod1Amount, mod1Rate, attack, decay, sustain, release, envCurve, syncEnvRatio;

		EnvGen.kr(
			Env.adsr(
				attackTime: attack,
				decayTime: decay,
				sustainLevel: sustain,
				releaseTime: release,
				curve: envCurve
			),
			gate: gate,
			doneAction:0);
	},

	syncEnv: {arg gate, beatDuration, syncMultiplier, mod1Amount, mod1Rate, attack, decay, sustain, release, envCurve, syncEnvRatio;

		var amp_a = beatDuration * syncMultiplier * syncEnvRatio,
		amp_r = beatDuration * syncMultiplier * (1 - syncEnvRatio),
		amp_c = envCurve;

		amp_a.postln;
		amp_r.postln;

		EnvGen.kr(
			Env.perc(
				attackTime: amp_a,
				releaseTime: amp_r,
				curve: amp_c
			),
			gate: gate,
			doneAction:0);
	},

	////////////////////////////// LFOs

	sineSyncLFO: {arg gate, beatDuration, syncMultiplier, mod1Amount, mod1Rate, attack, decay, sustain, release;

		var speed = 1 / (beatDuration * 4 * mod1Rate);

		SinOsc.ar(speed,
			// mul: mod1Amount, add: (1 - mod1Amount)
		);

	},

	sineLFO: {arg gate, beatDuration, syncMultiplier, mod1Amount, mod1Rate, attack, decay, sustain, release;

		SinOsc.ar(mod1Rate,
			// mul: mod1Amount, add: (1 - mod1Amount)
		);

	},

	rampSyncLFO: {arg gate, beatDuration, syncMultiplier, mod1Amount, mod1Rate, attack, decay, sustain, release;

		var speed = 1 / (beatDuration * 4 * mod1Rate);

		LFSaw.ar(speed,
			// mul: mod1Amount, add: (1 - mod1Amount)
		);
	},

	rampLFO: {arg gate, beatDuration, syncMultiplier, mod1Amount, mod1Rate, attack, decay, sustain, release;

		LFSaw.ar(mod1Rate,
			// mul: mod1Amount, add: (1 - mod1Amount)
		);
	},

	sawLFO: {arg gate, beatDuration, syncMultiplier, mod1Amount, mod1Rate, attack, decay, sustain, release;

		LFSaw.ar(mod1Rate,
			// mul: mod1Amount, add: (1 - mod1Amount)
		).neg;
	},

	sawSyncLFO: {arg gate, beatDuration, syncMultiplier, mod1Amount, mod1Rate, attack, decay, sustain, release;

		var speed = 1 / (beatDuration * 4 * mod1Rate);

		LFSaw.ar(speed,
			// mul: mod1Amount, add: (1 - mod1Amount)
		).neg;
	},

	triSyncLFO: {arg gate, beatDuration, syncMultiplier, mod1Amount, mod1Rate, attack, decay, sustain, release;

		var speed = 1 / (beatDuration * 4 * mod1Rate);

		LFTri.ar(speed,
			// mul: mod1Amount, add: (1 - mod1Amount)
		);
	},

	triLFO: {arg gate, beatDuration, syncMultiplier, mod1Amount, mod1Rate, attack, decay, sustain, release;

		LFTri.ar(mod1Rate,
			// mul: mod1Amount, add: (1 - mod1Amount)
		);
	},

	rectSyncLFO: {arg gate, beatDuration, syncMultiplier, mod1Amount, mod1Rate, attack, decay, sustain, release;

		var speed = 1 / (beatDuration * 4 * mod1Rate);

		LFPulse.ar(speed,
			mul: 2, add: -1
		);
	},

	rectLFO: {arg gate, beatDuration, syncMultiplier, mod1Amount, mod1Rate, attack, decay, sustain, release;

		LFPulse.ar(mod1Rate,
			mul: 2, add: -1
		);
	},

	sampleAndHold: {arg gate, beatDuration, syncMultiplier, mod1Amount, mod1Rate, attack, decay, sustain, release;

		Latch.ar(WhiteNoise.ar(),gate)
	},

		noise: {arg gate, beatDuration, syncMultiplier, mod1Amount, mod1Rate, attack, decay, sustain, release;

		LFNoise1.kr(100)
	},

);
);


"modSources: ".post;
~modSources.keys.postln;