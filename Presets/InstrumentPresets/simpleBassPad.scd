(
~instrumentPresetsDictionary[\simpleBassPad] = [
	\adsrType, \pad,
	\sendGate, true,
	\pitchOpType, \slide,
	\oscillatorType, \basic,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~chords_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 1,

	\pitchOp_1_interval, 0.3,
	\pitchOp_1_amount, 0.3,

	\oscillator_mod_1, 0.25,
	\oscillator_mod_2, 0.5,

	\fx_mod_1, 0.1,
	\fx_mod_2, 1,

	\filter_1_mod_1, 1,
	\filter_1_mod_2, 0.5,

	\envelope_mod, 0.75,
	\vol, 1,
	\amp, 1,
];
~callInstrumentPreset.(\simpleBassPad);
)