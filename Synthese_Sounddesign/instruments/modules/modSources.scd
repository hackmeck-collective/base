(
~modSources = (
	noMod: {arg freq = 440,
		gate = 1,
		oscillator_mod_1 = 0,
		oscillator_mod_2 = 0;

		var sig;

		sig = 0;

	},

	sineSyncLFO: {arg gate, beatDuration, syncMultiplier, mod1Amount, mod1Rate, attack, decay, sustain, release;

		var speed = 1 / (beatDuration * 4 * mod1Rate);

		SinOsc.ar(speed, mul: mod1Amount, add: (1 - mod1Amount));

	},

	sineLFO: {arg gate, beatDuration, syncMultiplier, mod1Amount, mod1Rate, attack, decay, sustain, release;

		SinOsc.ar(mod1Rate, mul: mod1Amount, add: (1 - mod1Amount));

	},
);
);


"modSources: ".post;
~modSources.keys.postln;