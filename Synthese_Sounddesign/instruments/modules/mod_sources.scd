(
~modSources = (
	noMod: {arg freq = 440,
		gate = 1,
		oscillator_mod_1 = 0,
		oscillator_mod_2 = 0;

		var sig;

		sig = 0;

	},

);
);


"modSources: ".post;
~modSources.keys.postln;