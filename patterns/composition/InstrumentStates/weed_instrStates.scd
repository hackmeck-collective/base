"loading weed instrument states".postln;

~weedInstrState_1 = { |inputPattern|

	Pbind(\out, ~chords_bus,
		\amp, 0.5,
		\spread, 1,
		\centerPos, 0,
		\envCurve, 3,
		\vca_attack, 0.75,
		\vca_sustain, 1,
		\vca_release, 2,

		\pitchOp_1_interval, 0.1, // vibrato
		\oscillator_1_mod_1, 0.5, // osc1 fm amount
		\oscillator_2_level, 0.7, // filtered noise level
		\fx_2_mod_2, 0.1, // combfilter decay
		\filterIn_preFxLevel, 1,
		\filterIn_FxLevel, 0,
		\filter_1_mod_1, 0.2, //lpf
		\filter_1_mod_2, 0.03,
		\filter_2_mod_1, 0, //hpf
		\filter_2_mod_2, 0.125,
	)

	<> ~lcXlCtrBus1Bi.(0, 1, -0.5, 0) //"% = % + (% * ext.linlin(0,1, external3min, external3max) * external3Amount)"
	<> ~lcXlCtrBus2Bi.(8)
	<> ~lcXlCtrBus3Bi.(8, 0.9)
	<> ~lcXlCtrBus4Bi.(8, -1)

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

	<> Pbind(
		/*\external1Target, "vca_attack",*/
		\external1Target2, "vca_release",
		\external2Target, "oscillator_1_mod_1",
		\external3Target, "oscillator_2_level",
		\external4Target, "oscillator_1_level"
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

~weedInstrState_2 = { |inputPattern|

	Pbind(\out, ~chords_bus,
		\amp, 0.35,
		\spread, 1,
		\centerPos, 0,
		\envCurve, 3,
		\vca_attack, 1,
		\vca_sustain, 1,
		\vca_release, 2,

		\pitchOp_1_interval, 0.1, // vibrato
		\oscillator_1_mod_1, 1, // osc1 fm amount
		\oscillator_2_level, 2, // filtered noise level
		\fx_2_mod_2, 0.1, // combfilter decay
		\filterIn_preFxLevel, 0.5,
		\filterIn_FxLevel, 0.5,
		\filter_1_mod_1, 0.1, //lpf
		\filter_1_mod_2, 0.03,
		\filter_2_mod_1, 0, //hpf
		\filter_2_mod_2, 0.125,
	)

	<> ~lcXlCtrBus1Bi.(0, 1, -0.5, 0) //"% = % + (% * ext.linlin(0,1, external3min, external3max) * external3Amount)"
	<> ~lcXlCtrBus2Bi.(8)
	<> ~lcXlCtrBus3Bi.(8, 0.9)
	<> ~lcXlCtrBus4Bi.(8, -1)

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

	<> Pbind(/*\external1Target, "vca_attack",*/
		/*\external1Target2, "vca_release",*/
		\external2Target, "filterIn_FxLevel",
		\external4Target, "filterIn_preFxLevel",
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

~weedInstrState_2_short = { |inputPattern|

	Pbind(\out, ~chords_bus,
		\amp, 0.25,
		\spread, 1,
		\centerPos, 0,
		\envCurve, 3,
		\vca_attack, 0.25,
		\vca_sustain, 1,
		\vca_release, 0.75,

		\pitchOp_1_interval, 0.1, // vibrato
		\oscillator_1_mod_1, 1, // osc1 fm amount
		\oscillator_2_level, 2, // filtered noise level
		\fx_2_mod_2, 0.1, // combfilter decay
		\filterIn_preFxLevel, 0.5,
		\filterIn_FxLevel, 0.5,
		\filter_1_mod_1, 0.2, //lpf
		\filter_1_mod_2, 0.03,
		\filter_2_mod_1, 0.1, //hpf
		\filter_2_mod_2, 0.125,
	)

	<> ~lcXlCtrBus1Bi.(0, 1, -0.5, 0) //"% = % + (% * ext.linlin(0,1, external3min, external3max) * external3Amount)"
	<> ~lcXlCtrBus2Bi.(8)
	<> ~lcXlCtrBus3Bi.(8, 0.9)
	<> ~lcXlCtrBus4Bi.(8, -1)

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

	<> Pbind(/*\external1Target, "vca_attack",*/
		/*\external1Target2, "vca_release",*/
		\external2Target, "filterIn_FxLevel",
		\external4Target, "filterIn_preFxLevel",
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

~weedInstrState_3 = { |inputPattern|

	Pbind(
		\out, ~chords_bus,
		\amp, 0.25,
		\spread, 1,
		\centerPos, 0,
		\envCurve, 3,
		\vca_attack, 0.25,
		\vca_sustain, 1,
		\vca_release, 0.75,

		\pitchOp_1_interval, 0.1, // vibrato
		\oscillator_1_mod_1, 0.5, // osc1 fm amount
		\oscillator_2_level, 0.1, // filtered noise level
		\fx_2_mod_2, 0.15, // combfilter decay
		\filterIn_preFxLevel, 1,
		\filterIn_FxLevel, 0,
		\filter_1_mod_1, 0.3, //lpf
		\filter_1_mod_2, 0.2,
		\filter_2_mod_1, 0, //hpf
		\filter_2_mod_2, 0.4,
	)

	<> ~lcXlCtrBus1Bi.(0, 1, -0.5, 0) //"% = % + (% * ext.linlin(0,1, external3min, external3max) * external3Amount)"
	<> ~lcXlCtrBus2Bi.(8)
	<> ~lcXlCtrBus3Bi.(8, 0.9)
	<> ~lcXlCtrBus4Bi.(8, -1)


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

	<> Pbind(/*\external2Target, "filterIn_FxLevel",
		\external4Target, "filterIn_preFxLevel",*/
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