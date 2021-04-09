(
~instrumentPresetsDictionary[\arpBass] = [
	\octave, 2,
	\adsrType, \lead,
	\sendGate, true,
	\pitchOpType, \rectArpSync,
	\oscillatorType, \basic,
	\fxType, \shelvedOverdriveSoft,
	\controlbus, ~launchcontrol_xl_row_3,
	\out, ~chords_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.1,

	\pitchOp_1_interval, 12,
	\pitchOp_1_amount, 1/32,

	\oscillator_mod_1, 0.5,
	\oscillator_mod_2, 0.35,

	\fx_mod_1, 0.5,
	\fx_mod_2, 0.2,

	\envelope_mod, 0.1,
	\vol, 1,
	\amp, 0.15,
];
~callInstrumentPreset.(\arpBass);
)