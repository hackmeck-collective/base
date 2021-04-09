(
~instrumentPresetsDictionary[\lfoTest] = [
	\adsrType, \lead,
	\sendGate, true,
	\pitchOpType, \slide,
	\oscillatorType, \fm,
	\oscillatorType_2, \fm,
	\fxType, \overdriveSoft,
	\filterType, \lpf_moog,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0,

	\pitchOp_1_interval, 7,
	\pitchOp_1_amount, 0.1,

	\oscillator_mod_1, 0.9,
	\oscillator_mod_2, 0.5,

	\oscillator_2_mod_1, 0.9,
	\oscillator_2_mod_2, 0.01,

	\fx_mod_1, 0,
	\fx_mod_2, 1,

	\filter_1_mod_1, 0.45,
	\filter_1_mod_2, 0.4,

	\envelope_mod, 0.7,
	\vol, 1,
	\amp, 0.6,
	\mod1Type, \adsrEnv,
	\mod1Amount, 1,
	\mod1Rate, 1/16,
	\mod1Target, "filter_1_mod_1",
	\mod2Type, \sineSyncLFO,
	\mod2Amount, 0.5,
	\mod2Rate, 3,
	\mod2Target, "oscillator_mod_2",
	\mod3Type, \sineSyncLFO,
	\mod3Amount, 0.3,
	\mod3Rate, 1/24,
	\mod3Target, "oscillator_2_mod_2",
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
];
~callInstrumentPreset.(\lfoTest);
)