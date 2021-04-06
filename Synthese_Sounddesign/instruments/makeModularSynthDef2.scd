~makeModularSynthDef ={|
	adsrType = \noEnv,
	pitchOpType = \noPitchOp,
	oscillatorType = \noOscillator,
	fxType = \noFx,
	filterType = \noFilter,
	pitchOpType_2 = \noPitchOp,
	oscillatorType_2 = \noOscillator,
	fxType_2 = \noFx,
	filterType_2 = \noFilter,
	drumType = \noDrum,
	drumType_2 = \noDrum,
	mod1Type = \noMod,
	mod1Target = "",
	mod2Type = \noMod,
	mod2Target = "",
	mod3Type = \noMod,
	mod3Target = "",
	mod4Type = \noMod,
	mod4Target = "",
	external1Target = "",
	external2Target = "",
	external3Target = "",
	external4Target = ""
	|

	var newFunc = {|
		adsrType = \noEnv,
		pitchOpType = \noPitchOp,
		oscillatorType = \noOscillator,
		fxType = \noFx,
		filterType = \noFilter,
		pitchOpType_2 = \noPitchOp,
		oscillatorType_2 = \noOscillator,
		fxType_2 = \noFx,
		filterType_2 = \noFilter,
		drumType = \noDrum,
		drumType_2 = \noDrum,
		mod1Type = \noMod,
		mod1Target = "",
		mod2Type = \noMod,
		mod2Target = "",
		mod3Type = \noMod,
		mod3Target = "",
		mod4Type = \noMod,
		mod4Target = "",
		external1Target = "",
		external2Target = "",
		external3Target = "",
		external4Target = ""
		|

		var synthDefName, mod1TargetLine = "";

		synthDefName =
		adsrType.asString ++ "_" ++
		pitchOpType.asString ++ "_" ++
		pitchOpType_2.asString ++ "_" ++
		oscillatorType.asString ++ "_" ++
		oscillatorType_2.asString ++ "_" ++
		drumType.asString ++ "_" ++
		drumType_2.asString ++ "_" ++
		fxType.asString ++ "_" ++
		fxType_2.asString ++ "_" ++
		filterType.asString ++ "_" ++
		filterType_2.asString ++ "_" ++
		mod1Type.asString ++ "-" ++ "to" ++ "-" ++
		mod1Target ++ "_" ++
		mod2Type.asString ++ "-" ++ "to" ++ "-" ++
		mod2Target ++ "_" ++
		mod3Type.asString ++ "-" ++ "to" ++ "-" ++
		mod3Target ++ "_" ++
		mod4Type.asString ++ "-" ++ "to" ++ "-" ++
		mod4Target ++ "_" ++
		"controlbus-to-" ++
		external1Target ++ "-" ++
		external2Target ++ "-" ++
		external3Target ++ "-" ++
		external4Target;

		if(SynthDescLib.match(synthDefName).isNil){
			var envelope_function = ~adsrTypes[adsrType];
			var oscillator_function = ~oscillatorTypes[oscillatorType];
			var pitchOp_function = ~pitchOpTypes[pitchOpType];
			var fx_function = ~fxTypes[fxType];
			var filter_function = ~filterTypes[filterType];
			var oscillator_function_2 = ~oscillatorTypes[oscillatorType_2];
			var pitchOp_function_2 = ~pitchOpTypes[pitchOpType_2];
			var fx_function_2 = ~fxTypes[fxType_2];
			var filter_function_2 = ~filterTypes[filterType_2];
			var drum_function = ~drumTypes[drumType];
			var drum_function_2 = ~drumTypes[drumType_2];
			var mod1_function = ~modSources[mod1Type];
			var mod2_function = ~modSources[mod2Type];
			var mod3_function = ~modSources[mod3Type];
			var mod4_function = ~modSources[mod4Type];

			SynthDef.new(synthDefName,
				{
					arg gate = 1,
					freq = 440,
					controlbus,
					out,
					send_1,
					send_1_level,
					send_2,
					send_2_level,

					pitchOp_mod_1,
					pitchOp_mod_2,
					pitchOp_2_mod_1,
					pitchOp_2_mod_2,

					oscillator_mod_1,
					oscillator_mod_2,
					oscillator_2_mod_1,
					oscillator_2_mod_2,
					oscillator_1_level = 1,
					oscillator_2_level = 1,

					timbre_ratio,
					body_sweep_ratio,
					timbre_sweep_ratio,
					body_time,
					timbre_time,
					transient_time,
					tail_time,
					body_vol,
					timbre_vol,
					transient_vol,
					tail_vol,
					time_factor,
					punch_factor,
					drum_1_level = 1,

					timbre_ratio_2,
					body_sweep_ratio_2,
					timbre_sweep_ratio_2,
					body_time_2,
					timbre_time_2,
					transient_time_2,
					tail_time_2,
					body_vol_2,
					timbre_vol_2,
					transient_vol_2,
					tail_vol_2,
					time_factor_2,
					punch_factor_2,
					drum_2_level = 1,

					fx_1_input_gain = 1,
					fx_mod_1,
					fx_mod_2,
					fx_2_mod_1,
					fx_2_mod_2,
					filter_mod_1,
					filter_mod_2,
					filter_2_mod_1,
					filter_2_mod_2,

					envelope_mod,

					vol = 0.5,

					pitchOp_mod_2_macro_channel,
					pitchOp_mod_1_macro_channel,
					oscillator_mod_1_macro_channel,
					oscillator_mod_2_macro_channel,
					fx_mod_1_macro_channel,
					fx_mod_2_macro_channel,
					filter_mod_1_macro_channel,
					filter_mod_2_macro_channel,
					envelope_mod_macro_channel,

					time_factor_macro_channel,
					time_factor_macro_channel_2,

					external1Amount,
					external2Amount,
					external3Amount,
					external4Amount,

					mod1Amount,
					mod1Rate,
					mod1attack = 1,
					mod1decay = 1,
					mod1sustain = 0.5,
					mod1release = 1,
					mod1EnvCurve = 2,
					mod1syncEnvRatio = 0,
					mod1ControlbusChannel = 0,

					mod2Amount,
					mod2Rate,
					mod2attack = 1,
					mod2decay = 1,
					mod2sustain = 0.5,
					mod2release = 1,
					mod2EnvCurve = 2,
					mod2syncEnvRatio = 0,
					mod2ControlbusChannel = 1,

					mod3Amount,
					mod3Rate,
					mod3attack = 1,
					mod3decay = 1,
					mod3sustain = 0.5,
					mod3release = 1,
					mod3EnvCurve = 2,
					mod3syncEnvRatio = 0,
					mod3ControlbusChannel = 2,

					mod4Amount,
					mod4Rate,
					mod4attack = 1,
					mod4decay = 1,
					mod4sustain = 0.5,
					mod4release = 1,
					mod4EnvCurve = 2,
					mod4syncEnvRatio = 0,
					mod4ControlbusChannel = 3,

					vol_macro_channel,
					beatDuration,
					syncMultiplier,
					envCurve,
					amp;

					var note = \note.kr(60,0);

					var external = Lag.kr(
						In.kr(
							controlbus,
							4),
						0.1);

					var dummy,
					envelope,
					mod1, mod2, mod3, mod4,
					pitchOp_freq, pitchOp_freq_2,
					oscillator, oscillator_2,
					fx, fx_2,
					filter, filter_2,
					drum, drum_2,
					vca;

					vol = vol.lincurve(0,1,0,0.5,3);

					"external1TargetPlaceholder";
					"externa21TargetPlaceholder";
					"externa31TargetPlaceholder";
					"externa41TargetPlaceholder";

					mod1 = SynthDef.wrap(
						mod1_function,
						prependArgs: [gate, beatDuration, syncMultiplier, mod1Amount, mod1Rate, mod1attack, mod1decay, mod1sustain, mod1release, mod1EnvCurve, mod1syncEnvRatio, controlbus, mod1ControlbusChannel],
					);

					"mod1TargetPlaceholder";
					/*"mod1Target_2Placeholder";
					"mod1Target_3Placeholder";
					"mod1Target_4Placeholder";*/

					mod2 = SynthDef.wrap(
						mod2_function,
						prependArgs: [gate, beatDuration, syncMultiplier, mod2Amount, mod2Rate, mod2attack, mod2decay, mod2sustain, mod2release, mod2EnvCurve, mod2syncEnvRatio, controlbus, mod2ControlbusChannel],
					);

					"mod2TargetPlaceholder";

					mod3 = SynthDef.wrap(
						mod3_function,
						prependArgs: [gate, beatDuration, syncMultiplier, mod3Amount, mod3Rate, mod3attack, mod3decay, mod3sustain, mod3release, mod3EnvCurve, mod3syncEnvRatio, controlbus, mod3ControlbusChannel],
					);

					"mod3TargetPlaceholder";

					mod4 = SynthDef.wrap(
						mod4_function,
						prependArgs: [gate, beatDuration, syncMultiplier, mod4Amount, mod4Rate, mod4attack, mod4decay, mod4sustain, mod4release, mod4EnvCurve, mod4syncEnvRatio, controlbus, mod4ControlbusChannel],
					);

					"mod4TargetPlaceholder";

					envelope = SynthDef.wrap(
						envelope_function,
						prependArgs: [gate, envelope_mod, beatDuration, syncMultiplier, envCurve],
					);

					pitchOp_freq = SynthDef.wrap(
						pitchOp_function,
						prependArgs: [freq, gate, pitchOp_mod_1, pitchOp_mod_2, beatDuration, syncMultiplier],
					);

					pitchOp_freq_2 = SynthDef.wrap(
						pitchOp_function_2,
						prependArgs: [pitchOp_freq, gate, pitchOp_2_mod_1, pitchOp_2_mod_2, beatDuration, syncMultiplier],
					);

					oscillator = SynthDef.wrap(
						oscillator_function,
						prependArgs: [pitchOp_freq_2, gate, oscillator_mod_1, oscillator_mod_2, beatDuration, syncMultiplier]);

					oscillator_2 = SynthDef.wrap(
						oscillator_function_2,
						prependArgs: [pitchOp_freq_2, gate, oscillator_2_mod_1, oscillator_2_mod_2, beatDuration, syncMultiplier])
					;

					drum = SynthDef.wrap(
						drum_function,
						prependArgs: [pitchOp_freq_2, gate,
							timbre_ratio,
							body_sweep_ratio,
							timbre_sweep_ratio,
							body_time,
							timbre_time,
							transient_time,
							tail_time,
							body_vol,
							timbre_vol,
							transient_vol,
							tail_vol,
							time_factor,
							punch_factor,
						],
					);

					drum_2 = SynthDef.wrap(
						drum_function_2,
						prependArgs: [pitchOp_freq_2, gate,
							timbre_ratio_2,
							body_sweep_ratio_2,
							timbre_sweep_ratio_2,
							body_time_2,
							timbre_time_2,
							transient_time_2,
							tail_time_2,
							body_vol_2,
							timbre_vol_2,
							transient_vol_2,
							tail_vol_2,
							time_factor_2,
							punch_factor_2,
						],
					);

					fx = SynthDef.wrap(
						fx_function,
						prependArgs: [
							Splay.ar(
								(oscillator * oscillator_1_level) +
								(oscillator_2 * oscillator_2_level) +
								(drum * drum_1_level) +
								(drum_2 * drum_2_level)
							) * fx_1_input_gain,
							gate, freq, fx_mod_1, fx_mod_2, beatDuration, syncMultiplier],
					);

					fx_2 = SynthDef.wrap(
						fx_function_2,
						prependArgs: [fx, gate, freq, fx_2_mod_1, fx_2_mod_2, beatDuration, syncMultiplier],
					);

					filter = SynthDef.wrap(
						filter_function,
						prependArgs: [fx_2, gate, freq, filter_mod_1, filter_mod_2, beatDuration, syncMultiplier],
					);

					filter_2 = SynthDef.wrap(
						filter_function_2,
						prependArgs: [filter, gate, freq, filter_2_mod_1, filter_2_mod_2, beatDuration, syncMultiplier],
					);

					vca = filter_2 * vol * amp * envelope;

					Out.ar(out, vca);
					Out.ar(send_1, vca * send_1_level);
					Out.ar(send_2, vca * send_2_level);
				}
			).add;
		};
		synthDefName;
	}.asCompileString
	.replace("\"external1TargetPlaceholder\"",
		if(external1Target.isEmpty){
			external1Target = "dummy"
		}{
			"% = % + (% * external[0] * external1Amount)".format(external1Target, external1Target, external1Target)
		}
	).replace("\"external2TargetPlaceholder\"",
		if(external2Target.isEmpty){
			external2Target = "dummy"
		}{
			"% = % + (% * external[1] * external2Amount)".format(external2Target, external2Target, external2Target)
		}
	).replace("\"external3TargetPlaceholder\"",
		if(external3Target.isEmpty){
			external3Target = "dummy"
		}{
			"% = % + (% * external[2] * external3Amount)".format(external3Target, external3Target, external3Target)
		}
	).replace("\"external4TargetPlaceholder\"",
		if(external4Target.isEmpty){
			external4Target = "dummy"
		}{
			"% = % + (% * external[3] * external4Amount)".format(external4Target, external4Target, external4Target)
		}
	).replace("\"mod1TargetPlaceholder\"",
		if(mod1Target.isEmpty){
			mod1Target = "dummy"
		}{
			"% = % + (% * mod1 * mod1Amount)".format(mod1Target, mod1Target, mod1Target)
		}
	).replace("\"mod2TargetPlaceholder\"",
		if(mod2Target.isEmpty){
			mod2Target = "dummy"
		}{
			"% = % + (% * mod2 * mod2Amount)".format(mod2Target, mod2Target, mod2Target)
		}
	).replace("\"mod3TargetPlaceholder\"",
		if(mod3Target.isEmpty){
			mod3Target = "dummy"
		}{
			"% = % + (% * mod3 * mod3Amount)".format(mod3Target, mod3Target, mod3Target)
		}
	).replace("\"mod4TargetPlaceholder\"",
		if(mod4Target.isEmpty){
			mod4Target = "dummy"
		}{
			"% = % + (% * mod4 * mod4Amount)".format(mod4Target, mod4Target, mod4Target)
		}
	)
	.interpret;
	newFunc.(adsrType,
		pitchOpType,
		oscillatorType,
		fxType,
		filterType,
		pitchOpType_2,
		oscillatorType_2,
		fxType_2,
		filterType_2,
		drumType,
		drumType_2,
		mod1Type,
		mod1Target,
		mod2Type,
		mod2Target,
		mod3Type,
		mod3Target,
		mod4Type,
		mod4Target
	)
};

"make modular synthdef function loaded".postln;