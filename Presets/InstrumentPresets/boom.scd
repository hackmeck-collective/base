(
~instrumentPresetsDictionary[\boom] = [
	\octave, Pxrand([2,3,4],inf),
	\adsrType, \pluck,
	\sendGate, false,
	\pitchOpType, \slide,
	\oscillatorType, \fm,
	\oscillatorType_2, \filteredNoise,
	\fxType, \shelvedOverdriveSoft,
	\filterType, \hpf_12,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.35,

	\pitchOp_1_interval, 0.8,
	\pitchOp_1_amount, 0.8,

	\oscillator_mod_1, 0.9,
	\oscillator_mod_2, 1,
	\oscillator_1_level, 0.5,

	\oscillator_2_mod_1, 0.45,
	\oscillator_2_mod_2, 0,
	\oscillator_2_level, 1,

	\fx_mod_1, 0.01,
	\fx_mod_2, 0.3,

	\filter_mod_1, 0.01,
	\filter_mod_2, 0.2,

	\envelope_mod, 0.95,

	\vol, 1,
	\amp, 1,
];
~callInstrumentPreset.(\boom);
)