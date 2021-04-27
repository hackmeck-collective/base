(
~instrumentPresetsDictionary[\sd3] = [
	\adsrType, \pluck,
	\sendGate, false,
	\envelope_mod, 0.2,

	\octave, 5,
	\pitchOpType, \unisonoDetune,
	\drumType, \fmTransientTail,
	\fxType, \sampleRateReduction,
	\type, \on,
	\controlbus, ~launchcontrol_xl_row_1,
	\out, ~drums_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0,

	\pitchOp_1_interval, 12,
	\pitchOp_1_amount, 0.25,

	\timbre_ratio, 0.45,
	\body_sweep_ratio, 1,
	\timbre_sweep_ratio, 0.25,
	\body_time, 0.5,
	\timbre_time, 0.5,
	\transient_time, 0.15,
	\tail_time, 0.75,
	\body_vol, 1,
	\timbre_vol, 0.25,
	\transient_vol, 1,
	\tail_vol, 0.65,
	\time_factor, 0.01,
	\punch_factor, 2,

	\fx_mod_1, 1,
	\fx_mod_2, 0.7,

	\filter_1_mod_1, 1,
	\filter_1_mod_2, 0,

	\vol, 1,
	\amp, 1,
];
~callInstrumentPreset.(\sd3);
)