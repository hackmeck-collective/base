"loading simpleSwitch instrument states".postln;

~simpleSwitchInstrState_1 = { |inputPattern|

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

~simpleSwitchInstrState_2 = { |inputPattern|

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

	<> ~lcXlCtrBus1Bi.(2, 0.3)
	<> ~lcXlCtrBus2Bi.(10, 1, 0.25, 1)
	<> ~lcXlCtrBus3Bi.(10, 1, 0.25, 1)
	<> ~lcXlCtrBus4Bi.(10, -1, 0.25, 1)

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
		\external1Target2, "pitchOp_1_interval",*/
		\external2Target, "oscillator_1_mod_1",
		\external3Target, "oscillator_2_level",
		\external3Target2, "vca_preFilterLevel",
		\external4Target, "",
		\external4Target2, "vca_preFxLevel",
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

~simpleSwitchInstrState_3 = { |inputPattern|
Pbind(\out, ~aux_bus,
		\amp, 0.1,
		\spread, 1,
		\centerPos, -0.5,
		\envelope_mod, 0.4,

		\pitchOp_1_interval, 7, //slide
		\pitchOp_1_amount, 0.05,
		\pitchOp_2_interval, 0.1, //vibrato
		\pitchOp_2_amount, 0.5,
		\oscillator_1_mod_1, 2, \oscillator_2_mod_1, 1,
		\oscillator_2_level, 0.5,
		\vca_filterLevel, 0,
		\vca_preFilterLevel, 1,
		\vca_preFxLevel, 0,

	)

	<> ~lcXlCtrBus1Bi.(2, 0.3)
	<> ~lcXlCtrBus2Bi.(10, 1, 0.5, 1)
	<> ~lcXlCtrBus3Bi.(10, 1, 0.25, 1)
	<> ~lcXlCtrBus4Bi.(10, -1, 0.25, 1)

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
		\external1Target, "envelope_mod",
		\external2Target, "oscillator_1_mod_1",
		\external3Target, "oscillator_2_level",
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

~simpleSwitchInstrState_4 = { |inputPattern|

	Pbind(\out, ~aux_bus,
		\amp, 0.1,
		\spread, 1,
		\centerPos, -0.5,
		// \envelope_mod, 0.25,

		// \pitchOp_1_interval, 7, //slide
		// \pitchOp_1_amount, 0.05,
		\pitchOp_2_interval, 0.1, //vibrato
		\pitchOp_2_amount, 0.5,
		\oscillator_1_mod_1, 2, \oscillator_2_mod_1, 1,
		\oscillator_2_level, 0.5,
		\vca_filterLevel, 1,
		\vca_preFilterLevel, 0,
		\vca_preFxLevel, 0,
		\filter_1_mod_1, 0.65,
		\filter_1_mod_2, 0.5,

	)

	<> ~lcXlCtrBus1Bi.(2, 0.3)
	<> ~lcXlCtrBus2Bi.(10, 1, -0.8, 0)
	<> ~lcXlCtrBus3Bi.(10, 1, 0.25, 1)
	<> ~lcXlCtrBus4Bi.(10, -1, 0.25, 1)

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
		/*\external1Target, "envelope_mod",*/
		\external2Target2, "filter_1_mod_1",
		/*\external3Target, "oscillator_2_level",*/
		/*\external3Target2, "oscillator_1_mod_1",*/
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

~simpleSwitchInstrState_5 = { |inputPattern|

	Pbind(\out, ~aux_bus,
		\amp, 0.1,
		\spread, 1,
		\centerPos, -0.5,
		// \envelope_mod, 0.25,

		// \pitchOp_1_interval, 7, //slide
		// \pitchOp_1_amount, 0.05,
		\pitchOp_2_interval, 0.1, //vibrato
		\pitchOp_2_amount, 0.5,
		\oscillator_1_mod_1, 2, \oscillator_2_mod_1, 1,
		\oscillator_2_level, 0.5,
		\vca_filterLevel, 1,
		\vca_preFilterLevel, 0,
		\vca_preFxLevel, 0,
		\filter_1_mod_1, 1,
		\filter_1_mod_2, 0,

	)

	<> ~lcXlCtrBus1Bi.(2, 0.3)
	<> ~lcXlCtrBus2Bi.(10, 1, -0.8, 0)
	<> ~lcXlCtrBus3Bi.(10, 1, 0.25, 1)
	<> ~lcXlCtrBus4Bi.(10, -1, 0.25, 1)

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
		/*\external1Target, "envelope_mod",*/
		/*\external2Target2, "filter_1_mod_1",*/
		/*\external3Target, "oscillator_2_level",*/
		/*\external3Target2, "oscillator_1_mod_1",*/
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

~simpleSwitchInstrState_6 = { |inputPattern|

	Pbind(\out, ~aux_bus,
		\amp, 0.1,
		\spread, 1,
		\centerPos, -0.5,
		// \envelope_mod, 0.25,

		// \pitchOp_1_interval, 7, //slide
		// \pitchOp_1_amount, 0.05,
		\pitchOp_2_interval, 0.1, //vibrato
		\pitchOp_2_amount, 0.5,
		\oscillator_1_mod_1, 4, \oscillator_2_mod_1, 4,
		\oscillator_2_level, 0.5,

	\fx_1_mod_1, 1.11,
	\fx_1_mod_2, 0.3,


		\vca_filterLevel, 1,
		\vca_preFilterLevel, 0,
		\vca_preFxLevel, 0,
		\filter_1_mod_1, 1,
		\filter_1_mod_2, 0,

	)

	<> ~lcXlCtrBus1Bi.(2, 0.3)
	<> ~lcXlCtrBus2Bi.(10, 1, -0.8, 0)
	<> ~lcXlCtrBus3Bi.(10, 1, 0.25, 1)
	<> ~lcXlCtrBus4Bi.(10, -1, 0.25, 1)

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
		/*\external1Target, "envelope_mod",*/
		/*\external2Target2, "filter_1_mod_1",*/
		/*\external3Target, "oscillator_2_level",*/
		/*\external3Target2, "oscillator_1_mod_1",*/
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
