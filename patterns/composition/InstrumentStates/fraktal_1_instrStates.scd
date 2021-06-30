"loading penrose instrument states".postln;

~fraktal_1_InstrState_1 = { |inputPattern|

	Pbind(\out, ~aux_bus,

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

		\envelope_mod, 0.2,
	)

	<> ~lcXlCtrBus1Bi.(24, 0.5)
	<> ~lcXlCtrBus2Bi.(25)
	<> ~lcXlCtrBus3Bi.(25, 1)
	<> ~lcXlCtrBus4Bi.(25, -1)

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
		\external1Target, "envelope_mod",
		\external2Target, "oscillator_2_mod_1",
		\external2Target2, "oscillator_1_mod_1",
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
