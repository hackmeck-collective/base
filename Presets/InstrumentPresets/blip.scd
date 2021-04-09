(
~instrumentPresetsDictionary[\blip] = [
	\adsrType, \pluck,
	\sendGate, false,
	\pitchOpType, \unisonoDetune,
	\oscillatorType, \formant,
	\fxType, \overdriveMid,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.1,

	\pitchOp_1_interval, 0.3,
	\pitchOp_1_amount, 0.35,

	\oscillator_mod_1, 0.05,
	\oscillator_mod_2, 0.2,

	\fx_mod_1, 0,
	\fx_mod_2, 0.2,

	\filter_mod_1, 0.4,
	\filter_mod_2, 0,

	\envelope_mod, 0.01,

	\vol, 1,
	\amp, 0.25,
];
~callInstrumentPreset.(\blip);
)