(
~instrumentPresetsDictionary[\variedLeads] = [
	\adsrType, \lead,
	\pitchOpType, Pseq ([\slide,\vibrato], inf).asStream,
	\oscillatorType, Pseq([\fm, \pulsar, \basic], inf).asStream,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.5,

	\pitchOp_1_interval, 7,
	\pitchOp_1_amount, 0.5,

	\oscillator_mod_1, 0.5,
	\oscillator_mod_2, 0,

	\fx_mod_1, 1,
	\fx_mod_2, 1,

	\filter_1_mod_1, 0,
	\filter_1_mod_2, 0.5,

	\envelope_mod, 0.3,

	\vol, 1,
	\amp, 0.25,
];
~callInstrumentPreset.(\variedLeads);
)