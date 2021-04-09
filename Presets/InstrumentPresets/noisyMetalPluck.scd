(
~instrumentPresetsDictionary[\noisyMetalPluck] = [
	\adsrType, \pluck,
	\sendGate, false,
	\pitchOpType, \fm,
	\oscillatorType, \filteredNoise,
	\oscillatorType2, \basic,
	\fxType, \shelvedOverdriveSoft,
	\filterType, \hpf_12,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.7,

	\pitchOp_1_interval, 0.35,
	\pitchOp_1_amount, 0.3,

	\oscillator_mod_1, 0.002,
	\oscillator_mod_2, 0,

	\fx_mod_1, 0.35,
	\fx_mod_2, 0.7,

	\filter_1_mod_1, 0.03,
	\filter_1_mod_2, 0.5,

	\envelope_mod, 0.6,

	\vol, 1,
	\amp, 0.35,
];
~callInstrumentPreset.(\noisyMetalPluck);
)