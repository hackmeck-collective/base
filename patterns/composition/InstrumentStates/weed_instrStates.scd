"loading weed instrument states".postln;

/*~weedInstrState_1 = { |inputPattern|

	Pbind(\pitchOp_1_interval, 0.1, // vibrato
		\oscillator_1_mod_1, 0.5, // osc1 fm amount
		\oscillator_2_level, 1, // filtered noise level
		\fx_2_mod_2, 0.1, // combfilter decay
		\filterIn_preFxLevel, 1,
		\filterIn_FxLevel, 0,
		\filter_1_mod_1, 0.2, //lpf
		\filter_1_mod_2, 0.03,
		\filter_2_mod_1, 0, //hpf
		\filter_2_mod_2, 0.125,
	)

	<> ~lcXlCtrBus1Bi.(24, 0.5)
	<> ~lcXlCtrBus2Bi.(25)
	<> ~lcXlCtrBus3Bi.(25, 1)
	<> ~lcXlCtrBus4Bi.(25, -1)

	<> Pbind(
		\mod1Amount, 0.075, // combfilter freq

		\mod2Amount, 0.075, // srr freq

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

	<> Pbind(\external2Target, "oscillator_1_mod_1",
		\external2Target2, "oscillator_2_level"
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

};*/

~weedInstrState_0 = (
	Pbind(\pitchOp_1_interval, 0.05, // vibrato
		\oscillator_1_mod_1, 0, // osc1 fm amount
		\oscillator_2_level, 0, // filtered noise level
		\fx_2_mod_2, 0.1, // combfilter decay
		\filterIn_preFxLevel, 1,
		\filterIn_FxLevel, 0,
		\filter_1_mod_1, 0.2, //lpf
		\filter_1_mod_2, 0.03,
		\filter_2_mod_1, 0, //hpf
		\filter_2_mod_2, 0.125,
));

~weedInstrState_1 = (
	Pbind(\pitchOp_1_interval, 0.1, // vibrato
		\oscillator_1_mod_1, 0.5, // osc1 fm amount
		\oscillator_2_level, 1, // filtered noise level
		\fx_2_mod_2, 0.1, // combfilter decay
		\filterIn_preFxLevel, 1,
		\filterIn_FxLevel, 0,
		\filter_1_mod_1, 0.2, //lpf
		\filter_1_mod_2, 0.03,
		\filter_2_mod_1, 0, //hpf
		\filter_2_mod_2, 0.125,
));

~weedInstrExternal_1 = (
	Pbind(\external2Target, "oscillator_1_mod_1",
		\external2Target2, "oscillator_2_level"
	)
);

~weedInstrState_2 = (
	Pbind(\pitchOp_1_interval, 0.1, // vibrato
		\oscillator_1_mod_1, 1, // osc1 fm amount
		\oscillator_2_level, 2, // filtered noise level
		\fx_2_mod_2, 0.1, // combfilter decay
		\filterIn_preFxLevel, 0.5,
		\filterIn_FxLevel, 0.5,
		\filter_1_mod_1, 0.1, //lpf
		\filter_1_mod_2, 0.03,
		\filter_2_mod_1, 0, //hpf
		\filter_2_mod_2, 0.125,
));

~weedInstrExternal_2 = (
	Pbind(\external2Target, "filterIn_FxLevel",
		\external4Target, "filterIn_preFxLevel",
	)
);

~weedInstrState_3 = (
	Pbind(\pitchOp_1_interval, 0.15, // vibrato
		\oscillator_1_mod_1, 1, // osc1 fm amount
		\oscillator_2_level, 2, // filtered noise q
		\fx_2_mod_2, 0.075, // combfilter decay
		\filterIn_preFxLevel, 0.5,
		\filterIn_FxLevel, 0.5,
		\filter_1_mod_1, 0.7, //lpf
		\filter_1_mod_2, 0.03,
		\filter_2_mod_1, 0, //hpf
		\filter_2_mod_2, 0.125,
));

~weedInstrExternal_3 = (
	Pbind(\external2Target, "fx_2_mod_2",
		\external3Target, "filter_1_mod_1",
		\external4Target, "",
	)
);

~weedInstrController_0to2= (
	~lcXlCtrBus1Bi.(24, 0.5)
	<> ~lcXlCtrBus2Bi.(25)
	<> ~lcXlCtrBus3Bi.(25, 1)
	<> ~lcXlCtrBus4Bi.(25, -1)
);


~weedInstrModTargets_1 = (
	Pbind(\mod1Type, \sampleAndHold,
		\mod1Target, "fx_2_mod_1", // combfilter freq

		\mod2Type, \sampleAndHold,
		\mod2Target, "fx_1_mod_1", // srr freq

		\mod3Type, \noMod,
		\mod3Target, "",

		\mod4Type, \noMod,
		\mod4Target, "",
	);
);


~weedInstrModsState_1 = (
	Pbind(
		\mod1Amount, 0.075, // combfilter freq

		\mod2Amount, 0.075, // srr freq

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