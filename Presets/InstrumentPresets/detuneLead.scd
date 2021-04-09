(
~instrumentPresetsDictionary[\detuneLead] = [
	\adsrType, \lead,
	\sendGate, true,
	\pitchOpType, \vibrato,
	\oscillatorType, \formant,
	\fxType, \shelvedOverdriveMid,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.25,

	\pitchOp_1_interval, 0.1,
	\pitchOp_1_amount, 0.32,

	\oscillator_mod_1, 0.35,
	\oscillator_mod_2, 0.25,

	\fx_mod_1, 0.9,
	\fx_mod_2, 0.7,

	\filter_1_mod_1, 1,
	\filter_1_mod_2, 0,

	\envelope_mod, 0.7,
	\vol, 1,
	\amp, 2,

];
~callInstrumentPreset.(\detuneLead);
)