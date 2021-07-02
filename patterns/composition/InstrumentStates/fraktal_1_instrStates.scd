"loading penrose instrument states".postln;

~fraktal_1_InstrState_1 = { |inputPattern|

	Pbind(\out, ~melody_bus,
		\amp, 0.1,
		\spread, 1,
		\centerPos, 0.5,
		\envelope_mod, 0.2,

		// \slide,
		\pitchOp_1_interval, 1,
		\pitchOp_1_amount, 0.15,

		// \vibrato,
		\pitchOp_2_interval, 0.1,
		\pitchOp_2_amount, 0.1,

		// \fm,
		\oscillator_1_mod_1, 0.4,
		\oscillator_1_mod_2, 1.03,

		// \fm,
		\oscillator_2_mod_1, 0.3,
		\oscillator_2_mod_2, 1.9,

		// \sampleRateReduction
		\fx_2_mod_1, 0.5,
		\fx_2_mod_2, 0.25,

		\vca_filterLevel, 0,
		\vca_preFilterLevel, 0.5,
		\vca_preFxLevel, 0.5,
	)

	<> ~lcXlCtrBus1Bi.(3, 0.5)
	<> ~lcXlCtrBus2Bi.(11)
	<> ~lcXlCtrBus3Bi.(11, 1)
	<> ~lcXlCtrBus4Bi.(11, -1)

	<> Pbind(
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
		\mod2Target, "oscillator_1_mod_2",
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

		\mod4Type, \noMod, //\sineLFO, 36 -> 32%
		\mod4Target, "", //"filter_1_mod_1",
		\mod4Amount, 0.1,
		\mod4Rate, 0.1,
		\mod4attack, 1,
		\mod4decay, 1,
		\mod4sustain, 0.5,
		\mod4release, 1,
		\mod4EnvCurve, 2,
		\mod4syncEnvRatio, 0,
		\mod4ControlbusChannel, 3,)

	<> inputPattern

	<> Pbind(
		/*\external1Target, "envelope_mod",*/
		\external2Target, "oscillator_2_mod_1",
		\external2Target2, "oscillator_1_mod_1",
		\external3Target, "vca_preFilterLevel",
		/*\external3Target2, "send_1_level",*/
		\external4Target, "vca_preFxLevel",
	)

	<> Pbind(\mod1Type, \adsrEnv,
		\mod1Target, "oscillator_1_mod_1",

		\mod2Type, \adsrEnv,
		\mod2Target, "oscillator_1_mod_2",

		\mod3Type, \sampleAndHold,
		\mod3Target, "fx_2_mod_1",

		\mod4Type, \noMod, //\sineLFO, 36 -> 32%
		\mod4Target, "", //"filter_1_mod_1",
	)

};

~fraktal_1_InstrState_2 = { |inputPattern|

	Pbind(\out, ~melody_bus,
		\amp, 0.35,
		\spread, 1,
		\centerPos, 0.5,
		\envelope_mod, 0.01,

		// \slide,
		\pitchOp_1_interval, 1,
		\pitchOp_1_amount, 0.15,

		// \vibrato,
		\pitchOp_2_interval, 0.1,
		\pitchOp_2_amount, 0.1,

		// \fm,
		\oscillator_1_mod_1, 0.7,
		\oscillator_1_mod_2, 1.03,

		// \fm,
		\oscillator_2_mod_1, 0.5,
		\oscillator_2_mod_2, 1.9,

		// \sampleRateReduction
		\fx_2_mod_1, 0.5,
		\fx_2_mod_2, 0.25,

		\vca_filterLevel, 0,
		\vca_preFilterLevel, 1,
		\vca_preFxLevel, 0,
	)

	<> ~lcXlCtrBus1Bi.(3, 0.5)
	<> ~lcXlCtrBus2Bi.(11)
	<> ~lcXlCtrBus3Bi.(11, 1)
	<> ~lcXlCtrBus4Bi.(11, -1)

	<> Pbind(
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
		\mod2Target, "oscillator_1_mod_2",
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

		\mod4Type, \noMod, //\sineLFO, 36 -> 32%
		\mod4Target, "", //"filter_1_mod_1",
		\mod4Amount, 0.1,
		\mod4Rate, 0.1,
		\mod4attack, 1,
		\mod4decay, 1,
		\mod4sustain, 0.5,
		\mod4release, 1,
		\mod4EnvCurve, 2,
		\mod4syncEnvRatio, 0,
		\mod4ControlbusChannel, 3,)

	<> inputPattern

	<> Pbind(
		/*\external1Target, "envelope_mod",*/
		/*\external2Target, "oscillator_2_mod_1",
		\external2Target2, "oscillator_1_mod_1",
		\external3Target, "vca_preFilterLevel",
		\external4Target, "vca_preFxLevel",*/
	)

	<> Pbind(\mod1Type, \adsrEnv,
		\mod1Target, "oscillator_1_mod_1",

		\mod2Type, \adsrEnv,
		\mod2Target, "oscillator_1_mod_2",

		\mod3Type, \sampleAndHold,
		\mod3Target, "fx_2_mod_1",

		\mod4Type, \noMod, //\sineLFO, 36 -> 32%
		\mod4Target, "", //"filter_1_mod_1",
	)

};

~fraktal_1_InstrState_3 = { |inputPattern|

	Pbind(\out, ~melody_bus,
		\amp, 0.3,
		\spread, 1,
		\centerPos, 0.5,
		\envelope_mod, 0.001,
		\send_1_level, 0.02,

		// \slide,
		\pitchOp_1_interval, 1,
		\pitchOp_1_amount, 0.15,

		// \vibrato,
		\pitchOp_2_interval, 0.1,
		\pitchOp_2_amount, 0.1,

		// \fm,
		\oscillator_1_mod_1, 1,
		\oscillator_1_mod_2, 1.03,

		// \fm,
		\oscillator_2_mod_1, 0.5,
		\oscillator_2_mod_2, 1.9,

		// \sampleRateReduction
		\fx_2_mod_1, 0.5,
		\fx_2_mod_2, 0.25,

		\vca_filterLevel, 0,
		\vca_preFilterLevel, 0.5,
		\vca_preFxLevel, 0.5,
	)

	<> ~lcXlCtrBus1Bi.(3, 0.5)
	<> ~lcXlCtrBus2Bi.(11, 1, 0, 1)
	<> ~lcXlCtrBus3Bi.(11, 1, -0.75, 1)
	<> ~lcXlCtrBus4Bi.(11, 1, 1, -0.75)

	<> Pbind(
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
		\mod2Target, "oscillator_1_mod_2",
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

		\mod4Type, \noMod, //\sineLFO, 36 -> 32%
		\mod4Target, "", //"filter_1_mod_1",
		\mod4Amount, 0.1,
		\mod4Rate, 0.1,
		\mod4attack, 1,
		\mod4decay, 1,
		\mod4sustain, 0.5,
		\mod4release, 1,
		\mod4EnvCurve, 2,
		\mod4syncEnvRatio, 0,
		\mod4ControlbusChannel, 3,)

	<> inputPattern

	<> Pbind(
		/*\external1Target, "envelope_mod",*/
		\external2Target, "oscillator_2_mod_1",
		\external2Target2, "oscillator_1_mod_1",
		\external3Target, "vca_preFilterLevel",
		\external4Target, "vca_preFxLevel",

	)

	<> Pbind(\mod1Type, \adsrEnv,
		\mod1Target, "oscillator_1_mod_1",

		\mod2Type, \adsrEnv,
		\mod2Target, "oscillator_1_mod_2",

		\mod3Type, \sampleAndHold,
		\mod3Target, "fx_2_mod_1",

		\mod4Type, \noMod, //\sineLFO, 36 -> 32%
		\mod4Target, "", //"filter_1_mod_1",
	)

};

~fraktal_1_InstrState_4 = { |inputPattern|

	Pbind(\out, ~melody_bus,
		\amp, 0.3,
		\spread, 1,
		\centerPos, 0.5,
		\envelope_mod, 0.1,
		\send_1_level, 0.02,

		// \slide,
		\pitchOp_1_interval, 1,
		\pitchOp_1_amount, 0.05,

		// \vibrato,
		\pitchOp_2_interval, 0,
		\pitchOp_2_amount, 0,

		// \fm,
		\oscillator_1_mod_1, 1,
		\oscillator_1_mod_2, 1.03,

		// \fm,
		\oscillator_2_mod_1, 0.5,
		\oscillator_2_mod_2, 1.9,

		// \sampleRateReduction
		\fx_2_mod_1, 0.5,
		\fx_2_mod_2, 0.25,

		\vca_filterLevel, 0,
		\vca_preFilterLevel, 0.5,
		\vca_preFxLevel, 0.5,
	)

	<> ~lcXlCtrBus1Bi.(3, 0.5)
	<> ~lcXlCtrBus2Bi.(11, 1, 0, 1)
	<> ~lcXlCtrBus3Bi.(11, 1, -0.75, 1)
	<> ~lcXlCtrBus4Bi.(11, 1, 1, -0.75)

	<> Pbind(
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
		\mod2Target, "oscillator_1_mod_2",
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

		\mod4Type, \noMod, //\sineLFO, 36 -> 32%
		\mod4Target, "", //"filter_1_mod_1",
		\mod4Amount, 0.1,
		\mod4Rate, 0.1,
		\mod4attack, 1,
		\mod4decay, 1,
		\mod4sustain, 0.5,
		\mod4release, 1,
		\mod4EnvCurve, 2,
		\mod4syncEnvRatio, 0,
		\mod4ControlbusChannel, 3,)

	<> inputPattern

	<> Pbind(
		/*\external1Target, "envelope_mod",*/
		\external2Target, "oscillator_2_mod_1",
		\external2Target2, "oscillator_1_mod_1",
		\external3Target, "vca_preFilterLevel",
		\external4Target, "vca_preFxLevel",

	)

	<> Pbind(\mod1Type, \adsrEnv,
		\mod1Target, "oscillator_1_mod_1",

		\mod2Type, \adsrEnv,
		\mod2Target, "oscillator_1_mod_2",

		\mod3Type, \sampleAndHold,
		\mod3Target, "fx_2_mod_1",

		\mod4Type, \noMod, //\sineLFO, 36 -> 32%
		\mod4Target, "", //"filter_1_mod_1",
	)

};

~fraktal_1_sd_InstrState_1 = { |inputPattern|

	Pbind(\out, ~aux_bus,
		\amp, 0.15,
		\spread, 1,
		\centerPos, -0.5,
		\envelope_mod, 0.4,

		\pitchOp_1_interval, 7, //slide
		\pitchOp_1_amount, 0.05,
		\pitchOp_2_interval, 0.1, //vibrato
		\pitchOp_2_amount, 0.5,
		\oscillator_1_mod_1, 1.5, \oscillator_2_mod_1, 0.5,
		\oscillator_2_level, 0.25,
		\vca_filterLevel, 0,
		\vca_preFilterLevel, 0.5,
		\vca_preFxLevel, 0.5,

	)

	<> ~lcXlCtrBus1Bi.(2, 0.8)
	<> ~lcXlCtrBus2Bi.(10)
	<> ~lcXlCtrBus3Bi.(10)
	<> ~lcXlCtrBus4Bi.(10, -1)

	<> Pbind(
		\mod1Amount, 0.01,
		\mod1Rate, 0.25,
		\mod1attack, 1,
		\mod1decay, 1,
		\mod1sustain, 0.5,
		\mod1release, 1,
		\mod1EnvCurve, 2,
		\mod1syncEnvRatio, 0,

		\mod2Amount, -0.2,
		\mod2Rate, 0.25,
		\mod2attack, 0,
		\mod2decay, 0.15,
		\mod2sustain, 0,
		\mod2release, 0.12,
		\mod2EnvCurve, 2,
		\mod2syncEnvRatio, 0,

		\mod3Amount, 0.25,
		\mod3Rate, 0.25,
		\mod3attack, 1,
		\mod3decay, 1,
		\mod3sustain, 0.5,
		\mod3release, 1,
		\mod3EnvCurve, 2,
		\mod3syncEnvRatio, 0,

		\mod4Amount, 0.25,
		\mod4Rate, 0.25,
		\mod4attack, 1,
		\mod4decay, 1,
		\mod4sustain, 0.5,
		\mod4release, 1,
		\mod4EnvCurve, 2,
		\mod4syncEnvRatio, 0,
	)

	<> inputPattern

	<> Pbind(
		/*\external1Target, "envelope_mod",
		\external1Target2, "pitchOp_1_interval",
		\external2Target, "oscillator_1_mod_1",
		\external3Target, "oscillator_2_level",
		\external3Target2, "vca_preFilterLevel",
		\external4Target, "",
		\external4Target2, "vca_preFxLevel",*/
	)

	<> Pbind(\mod1Type, \sampleAndHold,
		\mod1Target, "fx_1_mod_1",

		\mod2Type, \noMod,
		\mod2Target, "",

		\mod3Type, \noMod,
		\mod3Target, "",

		\mod4Type, \noMod,
		\mod4Target, "",
	)

};
