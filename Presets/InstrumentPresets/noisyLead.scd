(
~instrumentPresetsDictionary[\noisyLead] = [
	\adsrType, \lead,
	\sendGate, true,
	\pitchOpType, \unisonoDetune,
	\oscillatorType, \filteredNoise,
	\fxType, \overdriveSoft,
	\filterType, \hpf_12,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.3,

	\pitchOp_1_interval, 0.3,
	\pitchOp_1_amount, 0.1,

	\oscillator_mod_1, 0.009,
	\oscillator_mod_2, 0,

	\fx_mod_1, 0.5,
	\fx_mod_2, 0.2,

	\filter_1_mod_1, 0.03,
	\filter_1_mod_2, 0.5,

	\envelope_mod, 0.1,
	\vol, 1,
	\amp, 0.25,
];
~callInstrumentPreset.(\noisyLead);
)