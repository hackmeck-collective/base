(
~instrumentPresetsDictionary[\guitarCloud] = [
	\adsrType, \pad,
	\pitchOpType, \unisonoDetune,
	\oscillatorType, \grainCloudGuitar,
	\filterType, \lpf_moog,
	\controlbus, ~launchcontrol_xl_row_6,
	\out, ~chords_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.75,

	\pitchOp_1_interval, 0.3,
	\pitchOp_1_amount, 0,

	\oscillator_mod_1, 0.5,
	\oscillator_mod_2, 0,

	\fx_mod_1, 0,
	\fx_mod_2, 0,

	\filter_1_mod_1, 1,
	\filter_1_mod_2, 0,

	\envelope_mod, 1,

	\vol, 1,
	\amp, 5,
];
~callInstrumentPreset.(\guitarCloud);
)