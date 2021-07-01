"loading weed instrument states".postln;

~bdBuzzInstrState_1 = { |inputPattern|

	Pbind(\out, ~drums_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.0025,
	\envelope_mod, 0.1,
	\envCurve, 10,
	\amp, 0.75,

	// \pitchOpType, \slide,
	\pitchOp_1_interval, 24,
	\pitchOp_1_amount, 0.1,

	// \oscillatorType, \basic,
	\oscillator_1_mod_1, 0.01,
	\oscillator_1_mod_2, 0.05,
	\oscillator_1_level, 1,
	\oscillator_1_transpose, -36,

	// \oscillatorType_2, \fm,
	\oscillator_2_mod_1, 4,
	\oscillator_2_mod_2, 0.3,
	\oscillator_2_level, 0.5,
	\oscillator_1_transpose, -12,

	// \drumType, \bodyTimbreTransientTail,
	\timbre_ratio, 0.45,
	\body_sweep_ratio, 1,
	\timbre_sweep_ratio, 0.25,
	\body_time, 0.5,
	\timbre_time, 0.5,
	\transient_time, 0.3,
	\tail_time, 0.75,
	\body_vol, 0.75,
	\timbre_vol, 0,
	\transient_vol, 0.5,
	\tail_vol, 0,
	\time_factor, 0.001,
	\punch_factor, 2,
	\drum_1_level, 0.2,

	// \fxType, \overdriveSoft,
	\fx_1_input_gain, 1,
	\fx_1_mod_1, 0.1,
	\fx_1_mod_2, 0.25,

	// \fxType_2, \noFx,
	\fx_2_mod_1, 0.25,
	\fx_2_mod_2, 0.25,

	\filterType, \lpf_12,
	\filter_1_mod_1, 1.2,
	\filter_1_mod_2, 0.5,

	\vca_filterLevel, 1,
	\vca_preFilterLevel, 0,
	\vca_preFxLevel, 0,
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


