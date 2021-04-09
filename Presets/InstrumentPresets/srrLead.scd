(
~instrumentPresetsDictionary[\srrLead] = [
	\adsrType, \lead,
	\sendGate, true,
	\pitchOpType, \unisonoDetune,
	\oscillatorType, \fm,
	\fxType, \sampleRateReduction,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.2,

	\pitchOp_1_interval, 0.25,
	\pitchOp_1_amount, 0.1,

	\oscillator_mod_1, 0.7,
	\oscillator_mod_2, 0.02,

	\fx_mod_1, 0.5,
	\fx_mod_2, 1,

	\filter_1_mod_1, 1,
	\filter_1_mod_2, 0,

	\envelope_mod, 0,
	\vol, 1,
	\amp, 0.25,
];
~callInstrumentPreset.(\srrLead);
)