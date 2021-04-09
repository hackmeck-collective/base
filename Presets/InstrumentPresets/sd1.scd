(
~instrumentPresetsDictionary[\sd1] = [
	\octave, 4,
	\drumType, \bodyTimbreTransientTail,
	\fxType, \overdriveSoft,
	\type, \on,
	\controlbus, ~launchcontrol_xl_row_1,
	\out, ~drums_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0,

	\timbre_ratio, 0.4,
	\body_sweep_ratio, 1,
	\timbre_sweep_ratio, 1,
	\body_time, 0.75,
	\timbre_time, 0.75,
	\transient_time, 0.5,
	\tail_time, 1,
	\body_vol, 1,
	\timbre_vol, 0.45,
	\transient_vol, 1,
	\tail_vol, 0.5,
	\time_factor, 0.01,
	\punch_factor, 6,

	\fx_mod_1, 0.2,
	\fx_mod_2, 0.7,
	\filter_1_mod_1, 1,
	\filter_1_mod_2, 0,

	\vol, 1,
	\amp, 0.8,
];
~callInstrumentPreset.(\sd1);
)