"loading weed instrument states".postln;

~clickInstrState_1 = { |inputPattern|

	Pbind(\out, ~drums_bus,
		\envelope_mod, 0,
		\amp, 0.dbamp,
		\spread, 1,
		\centerPos, Pseq([0, -0.35, 0.35, 0.7, -0.7], inf),

		\filter_1_mod_1, 1, //bpf
		\filter_1_mod_2, 0.25,

		\send_1, ~ef_reverb,
		\send_1_level, 0.1,
		\send_2, ~grainDelay_1,
		\send_2_level, 0.25,
		\send_3, ~granulator_1,
		\send_3_level, 0,
		\send_4, ~beatRepeat_1,
		\send_4_level, 0,
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
	)
};


~clickInstrState_2 = { |inputPattern|

	Pbind(\out, ~drums_bus,
		\envelope_mod, 0,
		\amp, 0.15,
		\spread, 1,
		\centerPos, Pseq([0, -0.5, 0.5, 1, -1], inf),

		\filter_1_mod_1, 1, //bpf
		\filter_1_mod_2, 0.25,

		\send_1, ~ef_reverb,
		\send_1_level, 0.5,
		\send_2, ~grainDelay_1,
		\send_2_level, 1,
		\send_3, ~granulator_1,
		\send_3_level, 0,
		\send_4, ~beatRepeat_1,
		\send_4_level, 0,
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
	)
};

~clickInstrState_3 = { |inputPattern|

	Pbind(\out, ~drums_bus,
		\envelope_mod, 0,
		\amp, 3.dbamp,
		\spread, 1,
		\centerPos, Pseq([0, -0.35, 0.35, 0.7, -0.7], inf),

		\filter_1_mod_1, 1, //bpf
		\filter_1_mod_2, 0.25,

		\send_1, ~ef_reverb,
		\send_1_level, 0.1,
		\send_2, ~grainDelay_1,
		\send_2_level, 0.25,
		\send_3, ~granulator_1,
		\send_3_level, 0,
		\send_4, ~beatRepeat_1,
		\send_4_level, 0,
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
	)
};

~clickInstrState_4 = { |inputPattern|

	Pbind(\out, ~drums_bus,
		\envelope_mod, 0,
		\amp, 3.dbamp,
		\spread, 1,
		\centerPos, Pseq([0, -0.5, 0.5, 1, -1], inf),

		\filter_1_mod_1, 1, //bpf
		\filter_1_mod_2, 0.25,

		\send_1, ~ef_reverb,
		\send_1_level, 0.5,
		\send_2, ~grainDelay_1,
		\send_2_level, 1,
		\send_3, ~granulator_1,
		\send_3_level, 0,
		\send_4, ~beatRepeat_1,
		\send_4_level, 0,
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
	)
};

~clickInstrState_5 = { |inputPattern|

	Pbind(\out, ~drums_bus,
		\envelope_mod, 0,
		\amp, 3.dbamp,
		\spread, 1,
		\centerPos, Pseq([0, -0.5, 0.5, 1, -1], inf),

		\filter_1_mod_1, 0.2, //bpf
		\filter_1_mod_2, 0.7,

		\send_1, ~ef_reverb,
		\send_1_level, 0.12,
		\send_2, ~grainDelay_1,
		\send_2_level, 0.1,
		\send_3, ~granulator_1,
		\send_3_level, 0,
		\send_4, ~beatRepeat_1,
		\send_4_level, 0,
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
	)
};