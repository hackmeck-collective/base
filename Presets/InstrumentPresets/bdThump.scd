(
~instrumentPresetsDictionary[\bdThump] = [
	\octave, 3,
	\drumType, \fmTransientTail,
	\fxType, \shelvedOverdriveSoft,
	\filterType, \lpf_24,
	\type, \on,
	\controlbus, ~launchcontrol_xl_row_1,
	\out, ~drums_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0,

	\timbre_ratio, 0.99,
	\body_sweep_ratio, 0.99,
	\timbre_sweep_ratio, 0.99,
	\body_time, 0.1,
	\timbre_time, 0.1,
	\transient_time, 0.7,
	\tail_time, 0.2,
	\body_vol, 1,
	\timbre_vol, 0.57,
	\transient_vol, 0.2,
	\tail_vol, 0.5,
	\time_factor, 0.8,
	\punch_factor, 6,

	\fx_mod_1, 0.2,
	\fx_mod_2, 0.1,

	\filter_1_mod_1, 0.65,
	\filter_1_mod_2, 0.4,

	\vol, 1,
	\amp, 2.35
];
~callInstrumentPreset.(\bdThump);
)