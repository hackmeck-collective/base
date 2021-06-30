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
	external4Target = "",
	external1Target2 = "",
	external2Target2 = "",
	external3Target2 = "",
	external4Target2 = "",
	pattern1Target = "",
	pattern2Target = "",
	pattern3Target = "",
	pattern4Target = ""
	|
	var synthDefName, modNameSum, mod1TargetLine = "";

	synthDefName =
	~adsrTypesShortcuts[adsrType] ++
	~pitchOpTypesShortcuts[pitchOpType] ++
	~pitchOpTypesShortcuts[pitchOpType_2] ++
	~oscillatorTypesShortcuts[oscillatorType] ++
	~oscillatorTypesShortcuts[oscillatorType_2] ++
	~drumTypesShortcuts[drumType] ++
	~drumTypesShortcuts[drumType_2] ++
	~fxTypesShortcuts[fxType] ++
	~fxTypesShortcuts[fxType_2] ++
	~filterTypesShortcuts[filterType] ++
	~filterTypesShortcuts[filterType_2];

	modNameSum =
	mod1Type.asString ++
	mod1Target ++
	mod2Type.asString ++
	mod2Target ++
	mod3Type.asString ++
	mod3Target ++
	mod4Type.asString ++
	mod4Target ++
	external1Target ++
	external2Target ++
	external3Target ++
	external4Target ++
	external1Target2 ++
	external2Target2 ++
	external3Target2 ++
	external4Target2 ++
	pattern1Target ++
	pattern2Target ++
	pattern3Target ++
	pattern4Target;

	modNameSum = (modNameSum.ascii.sum*(1..modNameSum.ascii.size)/modNameSum.ascii.size).sum.asInteger.asString;

	synthDefName = synthDefName ++ modNameSum;

	if(SynthDescLib.match(synthDefName).isNil){

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
			external4Target = "",
			external1Target2 = "",
			external2Target2 = "",
			external3Target2 = "",
			external4Target2 = "",
			pattern1Target = "",
			pattern2Target = "",
			pattern3Target = "",
			pattern4Target = "",
			synthDefName
			|


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
					out,
					send_1,
					send_1_level,
					send_2,
					send_2_level,
					send_3,
					send_3_level,
					send_4,
					send_4_level,
					spread,
					centerPos,

					pitchOp_1_interval,
					pitchOp_1_amount,
					pitchOp_2_interval,
					pitchOp_2_amount,
					glide = 0,

					oscillator_1_mod_1,
					oscillator_1_mod_2,
					oscillator_1_mod_3,
					oscillator_1_mod_4,
					oscillator_1_buffer,
					oscillator_1_bufferPos,
					oscillator_1_level = 1,
					oscillator_2_mod_1,
					oscillator_2_mod_2,
					oscillator_2_mod_3,
					oscillator_2_mod_4,
					oscillator_2_buffer,
					oscillator_2_bufferPos,
					oscillator_2_level = 1,

					oscillator_1_transpose = 0,
					oscillator_2_transpose = 0,

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
					fx_1_mod_1,
					fx_1_mod_2,
					fx_2_mod_1,
					fx_2_mod_2,

					filterIn_preFxLevel = 0,
					filterIn_FxLevel = 1,
					filter_1_mod_1,
					filter_1_mod_2,
					filter_1_hz_offset,
					filter_2_mod_1,
					filter_2_mod_2,
					filter_2_hz_offset,

					envelope_mod,
					vca_attack,
					vca_decay,
					vca_sustain,
					vca_release,
					envCurve,

					vca_filterLevel = 1,
					vca_preFilterLevel = 0,
					vca_preFxLevel = 0,

					vol = 0.5,

					controlbus1 = ~dummybus.index,
					controlbus2 = ~dummybus.index,
					controlbus3 = ~dummybus.index,
					controlbus4 = ~dummybus.index,
					controlbus_vol = ~dummybus.index,

					external1Amount,
					external2Amount,
					external3Amount,
					external4Amount,
					external1Amount2,
					external2Amount2,
					external3Amount2,
					external4Amount2,

					external1min,
					external1max,
					external2min,
					external2max,
					external3min,
					external3max,
					external4min,
					external4max,

					pattern1In,
					pattern2In,
					pattern3In,
					pattern4In,

					pattern1Amount,
					pattern2Amount,
					pattern3Amount,
					pattern4Amount,

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
					amp;

					var note = \note.kr(60,0);

					var external1 = Lag.kr(
						In.kr(controlbus1),
						0.1);

					var external2 = Lag.kr(
						In.kr(controlbus2),
						0.1);

					var external3 = Lag.kr(
						In.kr(controlbus3),
						0.1);

					var external4 = Lag.kr(
						In.kr(controlbus4),
						0.1);

					var external_vol = Lag.kr(
						In.kr(controlbus_vol),
						0.1);

					var dummy,
					envelope,
					mod1, mod2, mod3, mod4,
					pitchOp_freq, pitchOp_freq_2,
					oscillator, oscillator_2,
					preFxSig,
					fx, fx_2,
					filter, filter_2,
					drum, drum_2,
					vca;

					case
					{out.isNil} {"ERROR: out bus is nil - there will be no sound".postln}
					{send_1.isNil} {"ERROR: send_1 bus is nil - there will be no sound".postln}
					{send_2.isNil} {"ERROR: send_2 bus is nil - there will be no sound".postln}
					{true}{nil};

					freq = Lag.kr(freq, glide);

					vol = vol.lincurve(0,1,0,0.5,3);

					"external1TargetPlaceholder";
					"external2TargetPlaceholder";
					"external3TargetPlaceholder";
					"external4TargetPlaceholder";

					"external1Target2Placeholder";
					"external2Target2Placeholder";
					"external3Target2Placeholder";
					"external4Target2Placeholder";

					"pattern1TargetPlaceholder";
					"pattern2TargetPlaceholder";
					"pattern3TargetPlaceholder";
					"pattern4TargetPlaceholder";

					mod1 = SynthDef.wrap(
						mod1_function,
						prependArgs: [gate, beatDuration, syncMultiplier, mod1Amount, mod1Rate, mod1attack, mod1decay, mod1sustain, mod1release, mod1EnvCurve, mod1syncEnvRatio],
					);

					"mod1TargetPlaceholder";
					/*"mod1Target_2Placeholder";
					"mod1Target_3Placeholder";
					"mod1Target_4Placeholder";*/

					mod2 = SynthDef.wrap(
						mod2_function,
						prependArgs: [gate, beatDuration, syncMultiplier, mod2Amount, mod2Rate, mod2attack, mod2decay, mod2sustain, mod2release, mod2EnvCurve, mod2syncEnvRatio],
					);

					"mod2TargetPlaceholder";

					mod3 = SynthDef.wrap(
						mod3_function,
						prependArgs: [gate, beatDuration, syncMultiplier, mod3Amount, mod3Rate, mod3attack, mod3decay, mod3sustain, mod3release, mod3EnvCurve, mod3syncEnvRatio],
					);

					"mod3TargetPlaceholder";

					mod4 = SynthDef.wrap(
						mod4_function,
						prependArgs: [gate, beatDuration, syncMultiplier, mod4Amount, mod4Rate, mod4attack, mod4decay, mod4sustain, mod4release, mod4EnvCurve, mod4syncEnvRatio],
					);

					"mod4TargetPlaceholder";

					envelope = SynthDef.wrap(
						envelope_function,
						prependArgs: [gate, envelope_mod, beatDuration, syncMultiplier, envCurve, vca_attack, vca_decay, vca_sustain, vca_release],
					);

					pitchOp_freq = SynthDef.wrap(
						pitchOp_function,
						prependArgs: [freq, gate, pitchOp_1_interval, pitchOp_1_amount, beatDuration, syncMultiplier],
					);

					pitchOp_freq_2 = SynthDef.wrap(
						pitchOp_function_2,
						prependArgs: [pitchOp_freq, gate, pitchOp_2_interval, pitchOp_2_amount, beatDuration, syncMultiplier],
					);

					oscillator = SynthDef.wrap(
						oscillator_function,
						prependArgs:
						[pitchOp_freq_2 * oscillator_1_transpose.midiratio,
							gate,
							oscillator_1_mod_1, oscillator_1_mod_2, oscillator_1_mod_3, oscillator_1_mod_4,
							oscillator_1_buffer, oscillator_1_bufferPos]
					);

					oscillator_2 = SynthDef.wrap(
						oscillator_function_2,
						prependArgs:
						[pitchOp_freq_2 * oscillator_2_transpose.midiratio,
							gate,
							oscillator_2_mod_1, oscillator_2_mod_2, oscillator_2_mod_3, oscillator_2_mod_4,
							oscillator_2_buffer, oscillator_2_bufferPos]
					);

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

					preFxSig = Splay.ar(
						(oscillator * oscillator_1_level) +
						(oscillator_2 * oscillator_2_level) +
						(drum * drum_1_level) +
						(drum_2 * drum_2_level)
					);

					fx = SynthDef.wrap(
						fx_function,
						prependArgs: [preFxSig * fx_1_input_gain,
							gate, freq, fx_1_mod_1, fx_1_mod_2, beatDuration, syncMultiplier],
					);

					fx_2 = SynthDef.wrap(
						fx_function_2,
						prependArgs: [fx, gate, freq, fx_2_mod_1, fx_2_mod_2, beatDuration, syncMultiplier],
					);

					filter = SynthDef.wrap(
						filter_function,
						prependArgs: [(fx_2 * filterIn_FxLevel) + (preFxSig * filterIn_preFxLevel), gate, freq, filter_1_mod_1, filter_1_mod_2, filter_1_hz_offset, beatDuration, syncMultiplier],
					);

					filter_2 = SynthDef.wrap(
						filter_function_2,
						prependArgs: [filter, gate, freq, filter_2_mod_1, filter_2_mod_2, filter_2_hz_offset, beatDuration, syncMultiplier],
					);

					vca = ((filter_2 * vca_filterLevel) + (fx_2 * vca_preFilterLevel) + (preFxSig * vca_preFxLevel)) * vol * amp * external_vol * envelope;

					vca = Splay.ar(vca, spread: spread, center: centerPos);

					Out.ar(out, vca);
					Out.ar(send_1, vca * send_1_level);
					Out.ar(send_2, vca * send_2_level);
					Out.ar(send_3, vca * send_3_level);
					Out.ar(send_4, vca * send_4_level);
				}
			).add;
		}.asCompileString
		.replace("\"pattern1TargetPlaceholder\"",
			if(pattern1Target.isEmpty){
				pattern1Target = "dummy"
			}{
				"% = % + (% * pattern1In * pattern1Amount)".format(pattern1Target, pattern1Target, pattern1Target)
			}
		).replace("\"pattern2TargetPlaceholder\"",
			if(pattern2Target.isEmpty){
				pattern2Target = "dummy"
			}{
				"% = % + (% * pattern2In * pattern2Amount)".format(pattern2Target, pattern2Target, pattern2Target)
			}
		).replace("\"pattern3TargetPlaceholder\"",
			if(pattern3Target.isEmpty){
				pattern3Target = "dummy"
			}{
				"% = % + (% * pattern3In * pattern3Amount)".format(pattern3Target, pattern3Target, pattern3Target)
			}
		).replace("\"pattern4TargetPlaceholder\"",
			if(pattern4Target.isEmpty){
				pattern4Target = "dummy"
			}{
				"% = % + (% * pattern4In * pattern4Amount)".format(pattern4Target, pattern4Target, pattern4Target)
			}
		).replace("\"external1TargetPlaceholder\"",
			if(external1Target.isEmpty){
				external1Target = "dummy"
			}{
				"% = % + (% * external1.linlin(0,1, external1min, external1max) * external1Amount)".format(external1Target, external1Target, external1Target)
			}
		).replace("\"external2TargetPlaceholder\"",
			if(external2Target.isEmpty){
				external2Target = "dummy"
			}{
				"% = % + (% * external2.linlin(0,1, external2min, external2max) * external2Amount)".format(external2Target, external2Target, external2Target)
			}
		).replace("\"external3TargetPlaceholder\"",
			if(external3Target.isEmpty){
				external3Target = "dummy"
			}{
				"% = % + (% * external3.linlin(0,1, external3min, external3max) * external3Amount)".format(external3Target, external3Target, external3Target)
			}
		).replace("\"external4TargetPlaceholder\"",
			if(external4Target.isEmpty){
				external4Target = "dummy"
			}{
				"% = % + (% * external4.linlin(0,1, external4min, external4max) * external4Amount)".format(external4Target, external4Target, external4Target)
			}
		).replace("\"external1Target2Placeholder\"",
			if(external1Target2.isEmpty){
				external1Target2 = "dummy"
			}{
				"% = % + (% * external1.linlin(0,1, external1min, external1max) * external1Amount)".format(external1Target2, external1Target2, external1Target2)
			}
		).replace("\"external2Target2Placeholder\"",
			if(external2Target2.isEmpty){
				external2Target2 = "dummy"
			}{
				"% = % + (% * external2.linlin(0,1, external2min, external2max) * external2Amount)".format(external2Target2, external2Target2, external2Target2)
			}
		).replace("\"external3Target2Placeholder\"",
			if(external3Target2.isEmpty){
				external3Target2 = "dummy"
			}{
				"% = % + (% * external3.linlin(0,1, external3min, external3max) * external3Amount)".format(external3Target2, external3Target2, external3Target2)
			}
		).replace("\"external4Target2Placeholder\"",
			if(external4Target2.isEmpty){
				external4Target2 = "dummy"
			}{
				"% = % + (% * external4.linlin(0,1, external4min, external4max) * external4Amount)".format(external4Target2, external4Target2, external4Target2)
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
		).interpret;
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
			mod4Target,
			external1Target,
			external2Target,
			external3Target,
			external4Target,
			external1Target2,
			external2Target2,
			external3Target2,
			external4Target2,
			pattern1Target,
			pattern2Target,
			pattern3Target,
			pattern4Target,
			synthDefName
		)
	};
	synthDefName
};

"make modular synthdef function loaded".postln;

