"loading penrose instrument states".postln;

~penroseInstrState_1 = { |inputPattern|

	Pbind(\out, ~melody_bus,
		\spread, 1,
		\centerPos, 0.5,
		\envelope_mod, 0.01,
		\amp, 1.5.dbamp,
		\send_1_level, 0.2,

		\oscillator_2_level, 0.25,
		\oscillator_1_mod_1, 0.4, \oscillator_2_mod_1, 0, //fm amount
		\oscillator_1_mod_2, 1, \oscillator_2_mod_2, 1.3,
		\fx_1_mod_1, 0.35, // bitcrush
		\fx_2_mod_1, 1.1, // srr
		\filter_1_mod_1, 0,
		\vca_filterLevel, 0,
		\vca_preFilterLevel, 0.5,
		\vca_preFxLevel, 0.5,
	)

	<> ~lcXlCtrBus1Bi.(24, 0.5)
	<> ~lcXlCtrBus2Bi.(25)
	<> ~lcXlCtrBus3Bi.(25, 1)
	<> ~lcXlCtrBus4Bi.(25, -1)

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
		/*\external1Target, "envelope_mod",*/
		/*\external2Target, "oscillator_2_level",
		\external2Target2, "oscillator_1_mod_1",*/
	)

	<> Pbind(\mod1Type, \sampleAndHold,
		\mod1Target, "fx_2_mod_1", // combfilter freq

		\mod2Type, \sampleAndHold,
		\mod2Target, "fx_1_mod_1", // srr freq

		\mod3Type, \noMod,
		\mod3Target, "",

		\mod4Type, \noMod,
		\mod4Target, "",
	)

};

~penroseInstrState_2 = { |inputPattern|

	Pbind(\out, ~melody_bus,
		\spread, 1,
		\centerPos, 0.5,
		\envelope_mod, 0.01,
		\amp, -3.dbamp,
		\send_1_level, 0.2,

		\oscillator_2_level, 0.5,
		\oscillator_1_mod_1, 0.8, \oscillator_2_mod_1, 0, //fm amount
		\oscillator_1_mod_2, 2, \oscillator_2_mod_2, 1.3,
		\fx_1_mod_1, 0.25, // bitcrush
		\fx_2_mod_1, 0.5, // srr
		\filter_1_mod_1, 0,
		\vca_filterLevel, 0,
		\vca_preFilterLevel, 0.5,
		\vca_preFxLevel, 0.5,
	)

	<> ~lcXlCtrBus1Bi.(24, 0.5)
	<> ~lcXlCtrBus2Bi.(25)
	<> ~lcXlCtrBus3Bi.(25, 1)
	<> ~lcXlCtrBus4Bi.(25, -1)

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
		/*\external1Target, "envelope_mod",*/
		/*\external2Target, "oscillator_2_mod_1",
		\external2Target2, "oscillator_1_mod_1",
		\external3Target, "oscillator_2_level",
		\external3Target2, "",
		\external4Target, "fx_1_mod_1",*/
		/*\external4Target2, "fx_2_mod_1",*/
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



~penroseInstrState_3 = { |inputPattern|

	Pbind(\out, ~melody_bus,
		\spread, 1,
		\centerPos, 0.5,
		\envelope_mod, 0.1,
		\amp, 1.5.dbamp,
		\send_1_level, 0.2,

		\oscillator_2_level, 0.5,
		\oscillator_1_mod_1, 0.8, \oscillator_2_mod_1, 0, //fm amount
		\oscillator_1_mod_2, 2, \oscillator_2_mod_2, 1.3,
		\fx_1_mod_1, 0.25, // bitcrush
		\fx_2_mod_1, 0.5, // srr
		\filter_1_mod_1, 0,
		\vca_filterLevel, 0,
		\vca_preFilterLevel, 0.5,
		\vca_preFxLevel, 0.5,

		\oscillator_2_level, 0.7,
		\oscillator_1_mod_1, 2, \oscillator_2_mod_1, 2, //fm amount
		\oscillator_1_mod_2, 1.7, \oscillator_2_mod_2, 1.3,
		\fx_1_mod_1, 0.05, // bitcrush
		\fx_2_mod_1, 0.4, // srr
		\filter_1_mod_1, 1,
		\vca_filterLevel, 0,
		\vca_preFilterLevel, 1,
		\vca_preFxLevel, 0,

	)

	<> ~lcXlCtrBus1Bi.(24, 0.5)
	<> ~lcXlCtrBus2Bi.(25)
	<> ~lcXlCtrBus3Bi.(25, 1)
	<> ~lcXlCtrBus4Bi.(25, -1)

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

	<> Pbind(/*\external1Target, "envelope_mod",
		\external2Target, "oscillator_2_mod_1",
		\external2Target2, "oscillator_1_mod_1",
		\external3Target, "oscillator_2_level",
		\external3Target2, "oscillator_2_level",
		\external4Target, "fx_1_mod_1",
		\external4Target2, "fx_2_mod_1"*/
	)

	<> Pbind(\mod1Type, \sampleAndHold,
		\mod1Target, "fx_2_mod_1", // combfilter freq

		\mod2Type, \sampleAndHold,
		\mod2Target, "fx_1_mod_1", // srr freq

		\mod3Type, \noMod,
		\mod3Target, "",

		\mod4Type, \noMod,
		\mod4Target, "",
	)

};

~penroseInstrState_4 = { |inputPattern|

	Pbind(\out, ~melody_bus,
		\spread, 1,
		\centerPos, 0.5,
		\envelope_mod, 0.01,
		\amp,1.5.dbamp,
		\send_1_level, 0.2,

		\oscillator_2_level, 0.25,
		\oscillator_1_mod_1, 0.4, \oscillator_2_mod_1, 0, //fm amount
		\oscillator_1_mod_2, 1, \oscillator_2_mod_2, 1.3,
		\fx_1_mod_1, 0.35, // bitcrush
		\fx_2_mod_1, 1.1, // srr
		\filter_1_mod_1, 0.6,
		\vca_filterLevel, 1,
		\vca_preFilterLevel, 0.5,
		\vca_preFxLevel, 0,
	)

	<> ~lcXlCtrBus1Bi.(1, 0.5)
	<> ~lcXlCtrBus2Bi.(9, -1)
	<> ~lcXlCtrBus3Bi.(9, -1)
	<> ~lcXlCtrBus4Bi.(9, 1)

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
		\external3Target, "vca_preFilterLevel",
		\external3Target2, "oscillator_2_level",
		\external4Target, "vca_filterLevel",
		\external4Target2, "",

	)

	<> Pbind(\mod1Type, \sampleAndHold,
		\mod1Target, "fx_2_mod_1", // combfilter freq

		\mod2Type, \sampleAndHold,
		\mod2Target, "fx_1_mod_1", // srr freq

		\mod3Type, \noMod,
		\mod3Target, "",

		\mod4Type, \noMod,
		\mod4Target, "",
	)

};

~penroseInstrState_5 = { |inputPattern|

	Pbind(\out, ~melody_bus,
		\spread, 1,
		\centerPos, 0.5,
		\envelope_mod, 0.01,
		\amp, 4.5.dbamp,
		\send_1_level, 0.2,

		\oscillator_2_level, 0.7,
		\oscillator_1_mod_1, 0.4, \oscillator_2_mod_1, 0, //fm amount
		\oscillator_1_mod_2, 1, \oscillator_2_mod_2, 1.3,
		\fx_1_mod_1, 0.25, // bitcrush
		\fx_2_mod_1, 1.1, // srr
		\filter_1_mod_1, 1,
		\vca_filterLevel, 1,
		\vca_preFilterLevel, 0,
		\vca_preFxLevel, 0,
	)

	<> ~lcXlCtrBus1Bi.(1, 0.5)
	<> ~lcXlCtrBus2Bi.(9, 1)
	<> ~lcXlCtrBus3Bi.(9, 1)
	<> ~lcXlCtrBus4Bi.(9, -1)

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
		/*\external4Target, "vca_preFilterLevel",
		\external4Target2, "oscillator_2_level",
		\external3Target, "vca_filterLevel",*/
		\external3Target2, ""
	)

	<> Pbind(\mod1Type, \sampleAndHold,
		\mod1Target, "fx_2_mod_1", // combfilter freq

		\mod2Type, \sampleAndHold,
		\mod2Target, "fx_1_mod_1", // srr freq

		\mod3Type, \noMod,
		\mod3Target, "",

		\mod4Type, \noMod,
		\mod4Target, "",
	)

};

~penroseInstrState_6 = { |inputPattern|

	Pbind(\out, ~melody_bus,
		\spread, 1,
		\centerPos, 0.5,
		\envelope_mod, 0.01,
		\amp, 0.dbamp,
		\send_1_level, 0.2,

		\oscillator_2_level, 0.7,
		\oscillator_1_mod_1, 1, \oscillator_2_mod_1, 0.6, //fm amount
		\oscillator_1_mod_2, 1, \oscillator_2_mod_2, 1.3,
		\fx_1_mod_1, 0.25, // bitcrush
		\fx_2_mod_1, 1.1, // srr
		\filter_1_mod_1, 0.35,
		\vca_filterLevel, 1,
		\vca_preFilterLevel, 0,
		\vca_preFxLevel, 0,
	)

	<> ~lcXlCtrBus1Bi.(1, 0.5)
	<> ~lcXlCtrBus2Bi.(9, 1)
	<> ~lcXlCtrBus3Bi.(9, 1)
	<> ~lcXlCtrBus4Bi.(9, -1)

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
		/*\external4Target, "vca_preFilterLevel",
		\external4Target2, "oscillator_2_level",
		\external3Target, "vca_filterLevel",*/
		\external3Target2, ""
	)

	<> Pbind(\mod1Type, \sampleAndHold,
		\mod1Target, "fx_2_mod_1", // combfilter freq

		\mod2Type, \sampleAndHold,
		\mod2Target, "fx_1_mod_1", // srr freq

		\mod3Type, \noMod,
		\mod3Target, "",

		\mod4Type, \noMod,
		\mod4Target, "",
	)

};

~penroseInstrState_7 = { |inputPattern|

	Pbind(\out, ~melody_bus,
		\spread, 1,
		// \centerPos, 0.5,
		\envelope_mod, 0,
		\amp, 3.dbamp,
		\send_1_level, 0.05,

		\oscillator_2_level, 0.7,
		\oscillator_1_mod_1, 1.4, \oscillator_2_mod_1, 0.7, //fm amount
		\oscillator_1_mod_2, 1, \oscillator_2_mod_2, 1.3,
		\fx_1_mod_1, 0.35, // bitcrush
		\fx_2_mod_1, 0.43, // srr
		\filter_1_mod_1, 0.8,
		\vca_filterLevel, 1,
		\vca_preFilterLevel, 0,
		\vca_preFxLevel, 0,
	)

	<> ~lcXlCtrBus1Bi.(1, 0.5)
	<> ~lcXlCtrBus2Bi.(9, 1)
	<> ~lcXlCtrBus3Bi.(9, 1)
	<> ~lcXlCtrBus4Bi.(9, -1)

	<> Pbind(
		\mod1Amount, 0.15,
		\mod1Rate, 0.25,
		\mod1attack, 1,
		\mod1decay, 1,
		\mod1sustain, 0.5,
		\mod1release, 1,
		\mod1EnvCurve, 2,
		\mod1syncEnvRatio, 0,

		\mod2Amount, -0.4,
		\mod2Rate, 0.25,
		\mod2attack, 0,
		\mod2decay, 0.15,
		\mod2sustain, 0,
		\mod2release, 0.12,
		\mod2EnvCurve, 2,
		\mod2syncEnvRatio, 0,

		\mod3Amount, -0.9,
		// \mod3Rate, 0.0625,
		\mod3attack, 0.125,
		\mod3decay, 0,
		\mod3sustain, 1,
		\mod3release, 2,
		\mod3EnvCurve, -7,
		\mod3syncEnvRatio, 0,

		\mod4Amount, -0.95,
		// \mod4Rate, 0.1,
		\mod4attack, 0.25,
		\mod4decay, 0,
		\mod4sustain, 1,
		\mod4release, 2,
		\mod4EnvCurve, 1,
		\mod4syncEnvRatio, 0,
	)

	<> inputPattern

	<> Pbind(
		/*\external4Target, "vca_preFilterLevel",
		\external4Target2, "oscillator_2_level",
		\external3Target, "vca_filterLevel",*/
		\external3Target2, ""
	)

	<> Pbind(\mod1Type, \sampleAndHold,
		\mod1Target, "fx_2_mod_1", // combfilter freq

		\mod2Type, \sampleAndHold,
		\mod2Target, "fx_1_mod_1", // srr freq

		\mod3Type, \adsrEnv,
		\mod3Target, "filter_1_mod_1",

		\mod4Type, \adsrEnv,
		\mod4Target, "amp",
	)

};

~penroseInstrState_8 = { |inputPattern|

	Pbind(\out, ~melody_bus,
		\spread, 1,
		// \centerPos, 0.5,
		\envelope_mod, 0,
		\amp, 3.dbamp,
		\send_1_level, 0.1,

		\oscillator_2_level, 0.7,
		\oscillator_1_mod_1, 1, \oscillator_2_mod_1, 0.3, //fm amount
		\oscillator_1_mod_2, 1, \oscillator_2_mod_2, 1.3,
		\fx_1_mod_1, 0.25, // bitcrush
		\fx_2_mod_1, 0.6, // srr
		\filter_1_mod_1, 1,
		\vca_filterLevel, 0.7,
		\vca_preFilterLevel, 0,
		\vca_preFxLevel, 0,
	)

	<> ~lcXlCtrBus1Bi.(1, 0.5)
	<> ~lcXlCtrBus2Bi.(1, 1)
	<> ~lcXlCtrBus3Bi.(1, 1, -0.47, 1)
	<> ~lcXlCtrBus4Bi.(1, 1, 0.75, 0)

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

		\mod3Amount, -0.9,
		// \mod3Rate, 0.0625,
		\mod3attack, 0.125,
		\mod3decay, 0,
		\mod3sustain, 1,
		\mod3release, 2,
		\mod3EnvCurve, -7,
		\mod3syncEnvRatio, 0,

		\mod4Amount, -0.95,
		// \mod4Rate, 0.1,
		\mod4attack, 0.25,
		\mod4decay, 0,
		\mod4sustain, 1,
		\mod4release, 2,
		\mod4EnvCurve, 1,
		\mod4syncEnvRatio, 0,
	)

	<> inputPattern

	<> Pbind(
		\external4Target, "amp",
		\external3Target, "filter_1_mod_1",

	)

	<> Pbind(\mod1Type, \sampleAndHold,
		\mod1Target, "fx_2_mod_1", // combfilter freq

		\mod2Type, \sampleAndHold,
		\mod2Target, "fx_1_mod_1", // srr freq

		\mod3Type, \adsrEnv,
		\mod3Target, "filter_1_mod_1",

		\mod4Type, \adsrEnv,
		\mod4Target, "amp",
	)

};