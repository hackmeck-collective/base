(
~modTargets = (
	noModTargets: {
		0;
	},

	oscillator_mod_2: {arg mod1, oscillator_mod_2;

		oscillator_mod_2 = oscillator_mod_2 + (oscillator_mod_2 * mod1);

	},
	/*pitchOp_mod_1,
	pitchOp_mod_2,
	pitchOp_2_mod_1,
	pitchOp_2_mod_2,
	oscillator_mod_1,
	oscillator_mod_2,
	oscillator_2_mod_1,
	oscillator_2_mod_2,

	timbre_ratio,
	body_sweep_ratio,
	timbre_sweep_ratio,
	body_time,
	timbre_time,
	transient_time,
	tail_time,
	body_vol,
	timbre_vol,
	transient_vol,
	tail_vol,
	time_factor,
	punch_factor,

	timbre_ratio_2,
	body_sweep_ratio_2,
	timbre_sweep_ratio_2,
	body_time_2,
	timbre_time_2,
	transient_time_2,
	tail_time_2,
	body_vol_2,
	timbre_vol_2,
	transient_vol_2,
	tail_vol_2,
	time_factor_2,
	punch_factor_2,

	fx_mod_1,
	fx_mod_2,
	fx_2_mod_1,
	fx_2_mod_2,
	filter_mod_1,
	filter_mod_2,
	filter_2_mod_1,
	filter_2_mod_2,

	envelope_mod,

	vol,
	*/
);
);


"modTargets: ".post;
~modTargets.keys.postln;