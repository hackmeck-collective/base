"loading simpleSwitch instrument states".postln;

~simpleSwitchInstrState_1 = (
	Pbind(\pitchOp_1_interval, 3.5,
		\pitchOp_1_amount, 0.05,
		\pitchOp_2_interval, 0,
		\pitchOp_2_amount, 0,
		\oscillator_1_mod_1, 1, \oscillator_2_mod_1, 0.5,
		\oscillator_2_level, 0.25,
		\vca_filterLevel, 0,
		\vca_preFilterLevel, 0.5,
		\vca_preFxLevel, 0.5,
		\envelope_mod, 0.6
	)
);

~simpleSwitchInstrState_2 = (
	Pbind(\pitchOp_1_interval, 7,
		\pitchOp_1_amount, 0.05,
		\pitchOp_2_interval, 0,
		\pitchOp_2_amount, 0,
		\oscillator_1_mod_1, 2, \oscillator_2_mod_1, 1,
		\oscillator_2_level, 0.25,
		\vca_filterLevel, 0,
		\vca_preFilterLevel, 1,
		\vca_preFxLevel, 0,
		\envelope_mod, 0.2
	)
);

~simpleSwitchExternal_1 = (
	Pbind(\external1Target, "envelope_mod",
		\external1Target2, "pitchOp_1_interval",
		\external2Target, "oscillator_1_mod_1",
		\external3Target, "oscillator_2_level",
		\external3Target2, "vca_preFilterLevel",
		\external4Target, "",
		\external4Target2, "vca_preFxLevel",
	)
);

~simpleSwitchInstrController_1 = (
	~lcXlCtrBus1Bi.(24, 0.5)
	<> ~lcXlCtrBus2Bi.(25)
	<> ~lcXlCtrBus3Bi.(25)
	<> ~lcXlCtrBus4Bi.(25, -1)
);


~simpleSwitchModTargets_1 = (
	Pbind(\mod1Type, \sampleAndHold,
		\mod1Target, "fx_1_mod_1",

		\mod2Type, \noMod,
		\mod2Target, "",

		\mod3Type, \noMod,
		\mod3Target, "",

		\mod4Type, \noMod,
		\mod4Target, "",
	);
);

~simpleSwitchModsState_1 = (
	Pbind(
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
	);
);
