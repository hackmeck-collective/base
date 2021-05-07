(
~instrumentPresetsDictionary[\hh2] = [
	\adsrType, \pluck,
	\sendGate, false,
	\envelope_mod, 0.2,

	\octave, 8,
	\drumType, \fmTransientTail,
	\type, \on,
	\controlbus, ~launchcontrol_xl_row_1,
	\out, ~drums_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.1,

	\timbre_ratio, 0.25,
	\body_sweep_ratio, 1,
	\timbre_sweep_ratio, 1,
	\body_time, 0.5,
	\timbre_time, 0.4,
	\transient_time, 0.5,
	\tail_time, 0.5,
	\body_vol, 0.21,
	\timbre_vol, 0.6,
	\transient_vol, 0.75,
	\tail_vol, 1,

	\time_factor, 0.15,
	\punch_factor, 5,

	\fx_mod_1, 1,
	\fx_mod_2, 0.7,

	\filter_mod_1, 0,
	\filter_mod_2, 0,

	\vol, 1,
	\amp, 0.35,
];
~callInstrumentPreset.(\hh2);
)