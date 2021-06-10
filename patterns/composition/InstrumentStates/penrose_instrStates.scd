"loading penrose instrument states".postln;

~penroseInstrState_1 = (
Pbind(\oscillator_2_level, 0.25,
		\oscillator_1_mod_1, 0.4, \oscillator_2_mod_1, 0, //fm amount
		\oscillator_1_mod_2, 1, \oscillator_2_mod_2, 1.3,
		\fx_1_mod_1, 0.5, // bitcrush
		\fx_2_mod_1, 1, // srr
		\filter_1_mod_1, 0,
		\vca_filterLevel, 0,
		\vca_preFilterLevel, 0,
		\vca_preFxLevel, 1,
));

~penroseInstrState_maxCrush = (
	Pbind(\oscillator_2_level, 0.7,
		\oscillator_1_mod_1, 2, \oscillator_2_mod_1, 2, //fm amount
		\oscillator_1_mod_2, 1.7, \oscillator_2_mod_2, 1.3,
		\fx_1_mod_1, 0.1, // bitcrush
		\fx_2_mod_1, 0.4, // srr
		\filter_1_mod_1, 1,
		\vca_filterLevel, 0,
		\vca_preFilterLevel, 1,
		\vca_preFxLevel, 0,

));

~penroseInstrState_maxCrushTo1 = (
	Pbind(\oscillator_2_level, 0.7,
		\oscillator_1_mod_1, 1, \oscillator_2_mod_1, 1, //fm amount
		\oscillator_1_mod_2, 1.7, \oscillator_2_mod_2, 1.3,
		\fx_1_mod_1, 0.3, // bitcrush
		\fx_2_mod_1, 0.7, // srr
		\filter_1_mod_1, 1,
		\vca_filterLevel, 0,
		\vca_preFilterLevel, 1,
		\vca_preFxLevel, 0,

));

~penroseInstrState_maxCrushTo1_Controller = (
	~lcXlCtrBus1Bi.(24, 0.5)
	<> ~lcXlCtrBus2Bi.(25)
	<> ~lcXlCtrBus3Bi.(25, 1)
	<> ~lcXlCtrBus4Bi.(25, -0.4)
);

~penroseInstrState_maxCrushTo1_External = (
	Pbind(\external1Target, "envelope_mod",
		\external2Target, "oscillator_2_mod_1",
		\external2Target2, "oscillator_1_mod_1",
		\external3Target, "oscillator_2_level",
		\external3Target2, "oscillator_2_level",
		\external4Target, "fx_1_mod_1",
		\external4Target2, "fx_2_mod_1",
	)
);

~penroseInstrModTargets_2 = (
	Pbind(\mod1Type, \sampleAndHold,
		\mod1Target, "fx_2_mod_1",

		\mod2Type, \adsrEnv,
		\mod2Target, "fx_1_mod_1",

		\mod3Type, \noMod,
		\mod3Target, "",

		\mod4Type, \noMod,
		\mod4Target, "",
	);
);

~penroseInstrModsState_2 = (
	Pbind(
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
	);
);