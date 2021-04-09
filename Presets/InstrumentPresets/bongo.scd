(
~instrumentPresetsDictionary[\bongo] = [
	\octave, 5,
	\drumType, \fmTransientTail,
	\fxType, \sampleRateReduction,
	\type, \on,
	\controlbus, ~launchcontrol_xl_row_1,
	\out, ~drums_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.2,

	\timbre_ratio, 0.45,
	\body_sweep_ratio, 1,
	\timbre_sweep_ratio, 0.25,
	\body_time, 0.5,
	\timbre_time, 1,
	\transient_time, 0.15,
	\tail_time, 0.75,
	\body_vol, 1,
	\timbre_vol, 1,
	\transient_vol, 1,
	\tail_vol, 0,
	\time_factor, 0.01,
	\punch_factor, 2,

	\fx_mod_1, 1,
	\fx_mod_2, 0.7,

	\vol, 1,
	\amp, 0.3,
];
~callInstrumentPreset.(\bongo);
)