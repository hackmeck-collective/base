"loading fuge instrument states".postln;

~fugeInstrState_0 = { |inputPattern|

	Pbind(\out, ~melody_bus,
		\amp, 6.dbamp,
		\spread, 1,
		\centerPos, 0,
		\send_1_level, 0.5,

		\oscillator_2_level, 0.4,
		\oscillator_1_mod_1, 1, \oscillator_2_mod_1, 0.4, //fm amount
		\oscillator_1_mod_2, 1.7, \oscillator_2_mod_2, 1.3,
		\fx_1_mod_1, 0.7, // bitcrush
		\fx_2_mod_1, 1.1, // srr
		\filter_1_mod_1, 1,
		\filter_1_mod_2, 0.5,
		\vca_filterLevel, 0,
		\vca_preFilterLevel, 0.25,
		\vca_preFxLevel, 0,
)
	<> ~lcXlCtrBus1Bi.(24, 0.5)
	<> ~lcXlCtrBus2Bi.(25)
	<> ~lcXlCtrBus3Bi.(25, 1)
	<> ~lcXlCtrBus4Bi.(25, -0.4)

	<> Pbind(
		\mod1Amount, 0.075,
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

	/*<> Pbind(\external1Target, "envelope_mod",
		\external2Target, "oscillator_2_mod_1",
		\external2Target2, "oscillator_1_mod_1",
		\external3Target, "oscillator_2_level",
		\external3Target2, "oscillator_2_level",
		\external4Target, "fx_1_mod_1",
		\external4Target2, "fx_2_mod_1",
	)*/
	<> Pbind(\mod1Type, \sampleAndHold,
		\mod1Target, "fx_2_mod_1",

		\mod2Type, \adsrEnv,
		\mod2Target, "fx_1_mod_1",

		\mod3Type, \noMod,
		\mod3Target, "",

		\mod4Type, \noMod,
		\mod4Target, "",
	)

};

~fugeInstrState_1 = { |inputPattern|

	Pbind(\out, ~melody_bus,

		\oscillator_2_level, 0.7,
		\oscillator_1_mod_1, 1, \oscillator_2_mod_1, 1, //fm amount
		\oscillator_1_mod_2, 1.7, \oscillator_2_mod_2, 1.3,
		\fx_1_mod_1, 0.3, // bitcrush
		\fx_2_mod_1, 0.7, // srr
		\filter_1_mod_1, 1,
		\vca_filterLevel, 0,
		\vca_preFilterLevel, 1,
		\vca_preFxLevel, 0,
)
	<> ~lcXlCtrBus1Bi.(24, 0.5)
	<> ~lcXlCtrBus2Bi.(24)
	<> ~lcXlCtrBus3Bi.(24, 1)
	<> ~lcXlCtrBus4Bi.(24, -0.4)

	<> Pbind(
		\mod1Amount, 0.075,
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
		\external2Target, "oscillator_2_mod_1",
		\external2Target2, "oscillator_1_mod_1",
		\external3Target, "oscillator_2_level",
		\external3Target2, "oscillator_2_level",
		\external4Target, "fx_1_mod_1",
		\external4Target2, "fx_2_mod_1",
	)
	<> Pbind(\mod1Type, \sampleAndHold,
		\mod1Target, "fx_2_mod_1",

		\mod2Type, \adsrEnv,
		\mod2Target, "fx_1_mod_1",

		\mod3Type, \noMod,
		\mod3Target, "",

		\mod4Type, \noMod,
		\mod4Target, "",
	)

};

~fugeInstrState_2 = { |inputPattern|

	Pbind(\out, ~melody_bus,

		\oscillator_2_level, 0.8,
		\oscillator_1_mod_1, 1.5, \oscillator_2_mod_1, 1.2, //fm amount
		\oscillator_1_mod_2, 1.7, \oscillator_2_mod_2, 1.3,
		\fx_1_mod_1, 0.22, // bitcrush
		\fx_2_mod_1, 0.6, // srr
		\filter_1_mod_1, 1,
		\vca_filterLevel, 0,
		\vca_preFilterLevel, 1,
		\vca_preFxLevel, 0,
)
	<> ~lcXlCtrBus1Bi.(25, 0.5)
	<> ~lcXlCtrBus2Bi.(25)
	<> ~lcXlCtrBus3Bi.(25, 1)
	<> ~lcXlCtrBus4Bi.(25, -0.4)

	<> Pbind(
		\mod1Amount, 0.075,
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
		\external2Target, "oscillator_2_mod_1",
		\external2Target2, "oscillator_1_mod_1",
		\external3Target, "oscillator_2_level",
		\external3Target2, "oscillator_2_level",
		\external4Target, "fx_1_mod_1",
		\external4Target2, "fx_2_mod_1",
	)
	<> Pbind(\mod1Type, \sampleAndHold,
		\mod1Target, "fx_2_mod_1",

		\mod2Type, \adsrEnv,
		\mod2Target, "fx_1_mod_1",

		\mod3Type, \noMod,
		\mod3Target, "",

		\mod4Type, \noMod,
		\mod4Target, "",
	)

};

~fugeInstrState_3 = { |inputPattern|

	Pbind(\out, ~melody_bus,

		\oscillator_2_level, 0.7,
		\oscillator_1_mod_1, 2, \oscillator_2_mod_1, 1.5, //fm amount
		\oscillator_1_mod_2, 1.7, \oscillator_2_mod_2, 1.3,
		\fx_1_mod_1, 0.2, // bitcrush
		\fx_2_mod_1, 0.55, // srr
		\filter_1_mod_1, 1,
		\vca_filterLevel, 0,
		\vca_preFilterLevel, 1,
		\vca_preFxLevel, 0,
)
	<> ~lcXlCtrBus1Bi.(26, 0.5)
	<> ~lcXlCtrBus2Bi.(26)
	<> ~lcXlCtrBus3Bi.(26, 1)
	<> ~lcXlCtrBus4Bi.(26, -0.4)

	<> Pbind(
		\mod1Amount, 0.075,
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
		\external2Target, "oscillator_2_mod_1",
		\external2Target2, "oscillator_1_mod_1",
		\external3Target, "oscillator_2_level",
		\external3Target2, "oscillator_2_level",
		\external4Target, "fx_1_mod_1",
		\external4Target2, "fx_2_mod_1",
	)
	<> Pbind(\mod1Type, \sampleAndHold,
		\mod1Target, "fx_2_mod_1",

		\mod2Type, \adsrEnv,
		\mod2Target, "fx_1_mod_1",

		\mod3Type, \noMod,
		\mod3Target, "",

		\mod4Type, \noMod,
		\mod4Target, "",
	)

};

~fugeInstrState_4 = { |inputPattern|

	Pbind(\out, ~melody_bus,

		\oscillator_2_level, 1,
		\oscillator_1_mod_1, 3, \oscillator_2_mod_1, 2, //fm amount
		\oscillator_1_mod_2, 1.7, \oscillator_2_mod_2, 1.3,
		\fx_1_mod_1, 0.1, // bitcrush
		\fx_2_mod_1, 0.4, // srr
		\filter_1_mod_1, 1,
		\vca_filterLevel, 0,
		\vca_preFilterLevel, 1,
		\vca_preFxLevel, 0,
)
	<> ~lcXlCtrBus1Bi.(27, 0.5)
	<> ~lcXlCtrBus2Bi.(27)
	<> ~lcXlCtrBus3Bi.(27, 1)
	<> ~lcXlCtrBus4Bi.(27, -0.4)

	<> Pbind(
		\mod1Amount, 0.075,
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
		\external2Target, "oscillator_2_mod_1",
		\external2Target2, "oscillator_1_mod_1",
		\external3Target, "oscillator_2_level",
		\external3Target2, "oscillator_2_level",
		\external4Target, "fx_1_mod_1",
		\external4Target2, "fx_2_mod_1",
	)
	<> Pbind(\mod1Type, \sampleAndHold,
		\mod1Target, "fx_2_mod_1",

		\mod2Type, \adsrEnv,
		\mod2Target, "fx_1_mod_1",

		\mod3Type, \noMod,
		\mod3Target, "",

		\mod4Type, \noMod,
		\mod4Target, "",
	)

};
