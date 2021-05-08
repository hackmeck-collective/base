(
~instrumentPresetsDictionary[\detunePluck] = [
	\adsrType, \pluck,
	\sendGate, false,
	\pitchOpType, \vibrato,
	\oscillatorType, \formant,
	\fxType, \shelvedOverdriveMid,
	\filterType, \lpf_moog,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.9,

	\pitchOp_1_interval, 0.15,
	\pitchOp_1_amount, 0.7,

	\oscillator_mod_1, 0.35,
	\oscillator_mod_2, 0.25,

	\fx_mod_1, 1,
	\fx_mod_2, 0.7,

	\filter_1_mod_1, 0.7,
	\filter_1_mod_2, 0.2,

	\envelope_mod, 0.7,

	\vol, 1,
	\amp, 0.5,
];
~callInstrumentPreset.(\detunePluck);
)