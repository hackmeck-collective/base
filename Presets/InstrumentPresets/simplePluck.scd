(
~instrumentPresetsDictionary[\simplePluck] = [
	\adsrType, \pluck,
	\sendGate, false,
	\pitchOpType, \slide,
	\oscillatorType, \fm,
	\oscillatorType_2, \fm,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.25,

	\pitchOp_1_interval, 0.55,
	\pitchOp_1_amount, 0.1,

	\oscillator_mod_1, 0.3,
	\oscillator_mod_2, 0.001,

	\oscillator_2_mod_1, 0.15,
	\oscillator_2_mod_2, 0.01,

	\fx_mod_1, 1,
	\fx_mod_2, 1,

	\filter_1_mod_1, 0.75,
	\filter_1_mod_2, 0.4,

	\envelope_mod, 0.7,
	\vol, 1,
	\amp, 0.2,

	\mod1Type, \adsrEnv,
	\mod1Target, "oscillator_mod_1",
	\mod1Amount, 0.7,
	\mod1Rate, 0.35,
	\mod1attack, 0,
	\mod1decay, 0.5,
	\mod1sustain, 0,
	\mod1release, 1,
	\mod1EnvCurve, 5,
	\mod1syncEnvRatio, 0.25,
	\mod1ControlbusChannel, 0,

	\mod2Type, \adsrEnv,
	\mod2Target, "oscillator_mod_2",
	\mod2Amount, 5,
	\mod2Rate, 0.2,
	\mod2attack, 0,
	\mod2decay, 0.15,
	\mod2sustain, 0,
	\mod2release, 1,
	\mod2EnvCurve, 7,
	\mod2syncEnvRatio, 0,
	\mod2ControlbusChannel, 1,

];
~callInstrumentPreset.(\simplePluck);
)