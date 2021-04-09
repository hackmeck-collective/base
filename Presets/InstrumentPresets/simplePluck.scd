(
~instrumentPresetsDictionary[\simplePluck] = [
	\adsrType, \pluck,
	\sendGate, false,
	\pitchOpType, \slide,
	\oscillatorType, \fm,
	\oscillatorType_2, \fm,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.25,

	\pitchOp_1_interval, 0.55,
	\pitchOp_1_amount, 0.1,

	\oscillator_mod_1, 0.45,
	\oscillator_mod_2, 0.001,

	\oscillator_2_mod_1, 0.15,
	\oscillator_2_mod_2, 0.01,

	\fx_mod_1, 1,
	\fx_mod_2, 1,

	\filter_1_mod_1, 0.75,
	\filter_1_mod_2, 0.4,

	\envelope_mod, 0.7,
	\vol, 1,
	\amp, 0.2,
];
~callInstrumentPreset.(\simplePluck);
)