(
~instrumentPresetsDictionary[\simpleBass] = [
	\octave, 3,
	\adsrType, \lead,
	\sendGate, true,
	\pitchOpType, \slide,
	\oscillatorType, \basic,
	\fxType, \shelvedOverdriveSoft,
	//\controlbus, ~launchcontrol_xl_row_3,
	\out, ~chords_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.1,

	\pitchOp_1_interval, 1,
	\pitchOp_1_amount, 0.1,

	\oscillator_mod_1, 0.5,
	\oscillator_mod_2, 0.35,

	\fx_mod_1, 0.5,
	\fx_mod_2, 0.2,

	\filter_1_mod_1, 0,
	\filter_1_mod_2, 0.5,

	\envelope_mod, 0.2,

	\vol, 1,
	\amp, 0.25,
];
~callInstrumentPreset.(\simpleBass);
)