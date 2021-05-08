(
~instrumentPresetsDictionary[\simplePluck] = [
	\adsrType, \pluck,
	\sendGate, false,

	\oscillatorType, \fm,
	\oscillatorType_2, \fm,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.5,

	\pitchOpType, \slide,
	\pitchOp_1_interval, 1,
	\pitchOp_1_amount, 0.35,

	\pitchOpType_2, \vibrato,
	\pitchOp_2_interval, 0.3,
	\pitchOp_2_amount, 0.1,

	\oscillator_mod_1, 0.4,
	\oscillator_mod_2, 1.03,

	\oscillator_2_mod_1, 0.3,
	\oscillator_2_mod_2, 1.9,

	\fxType, \noFx,
	\fx_1_input_gain, 0.75,
	\fx_mod_1, 1.7,
	\fx_mod_2, 0.05,

	\fxType_2, \sampleRateReduction,
	\fx_2_mod_1, 0.5,
	\fx_2_mod_2, 0.25,

	\filterType, \noFilter, // \noFilter, \lpf_moog, \lpf_24, \lpf_12, \hpf_24, \hpf_12, \bpf, \notch, \lo_shelf, \hi_shelf,
	\filter_1_mod_1, 0.4,
	\filter_1_mod_2, 0.4,

	\envCurve, 2,
	\envelope_mod, 0.3,
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

	\mod2Type, \noMod, //\adsrEnv,
	\mod2Target, "", //"oscillator_mod_2",
	\mod2Amount, 5,
	\mod2Rate, 0.2,
	\mod2attack, 0,
	\mod2decay, 0.15,
	\mod2sustain, 0,
	\mod2release, 1,
	\mod2EnvCurve, 7,
	\mod2syncEnvRatio, 0,
	\mod2ControlbusChannel, 1,

	\mod3Type, \sampleAndHold,
	\mod3Target, "fx_2_mod_1",
	\mod3Amount, 0.05,
	\mod3Rate, 1/48,
	\mod3attack, 1,
	\mod3decay, 1,
	\mod3sustain, 0.5,
	\mod3release, 1,
	\mod3EnvCurve, 2,
	\mod3syncEnvRatio, 0,
	\mod3ControlbusChannel, 2,

	\mod4Type, \sineLFO,
	\mod4Target, "filter_1_mod_1",
	\mod4Amount, 0.1,
	\mod4Rate, 0.1,
	\mod4attack, 1,
	\mod4decay, 1,
	\mod4sustain, 0.5,
	\mod4release, 1,
	\mod4EnvCurve, 2,
	\mod4syncEnvRatio, 0,
	\mod4ControlbusChannel, 3,

];
~callInstrumentPreset.(\simplePluck);
)