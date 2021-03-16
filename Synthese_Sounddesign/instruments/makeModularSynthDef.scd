~makeModularSynthDef = {
	|adsrType, pitchOpType, oscillatorType, fxType, filterType, pitchOpType_2, oscillatorType_2, fxType_2, filterType_2, drumType, drumType_2|

	var synthDefName;

	if (adsrType.isNil){adsrType = \noEnv};

	if (pitchOpType.isNil){pitchOpType = \noPitchOp};
	if (oscillatorType.isNil){oscillatorType = \noOscillator};
	if (fxType.isNil){fxType = \noFx};
	if (filterType.isNil){filterType = \noFilter};

	if (pitchOpType_2.isNil){pitchOpType_2 = \noPitchOp};
	if (oscillatorType_2.isNil){oscillatorType_2 = \noOscillator};
	if (fxType_2.isNil){fxType_2 = \noFx};
	if (filterType_2.isNil){filterType_2 = \noFilter};

	if (drumType.isNil){drumType = \noDrum};
	if (drumType_2.isNil){drumType_2 = \noDrum};

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
	filterType_2.asString;

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

				vol_macro_channel,
				beatDuration,
				syncMultiplier,
				envCurve,
				amp;

				var note = \note.kr(60,0);

				var macro_controls = Lag.kr(
					In.kr(
						controlbus,
						4),
					0.1);

				var macro_1 = macro_controls[0],
				macro_2 = macro_controls[1],
				macro_3 = macro_controls[2],
				fader = macro_controls[3];

				var envelope, pitchOp_freq, pitchOp_freq_2, oscillator, oscillator_2, fx, fx_2, filter, filter_2, drum, drum_2, vca;

				pitchOp_mod_1 = Select.kr(pitchOp_mod_1_macro_channel,
					[pitchOp_mod_1, macro_1, macro_2, macro_3]);
				pitchOp_mod_2 = Select.kr(pitchOp_mod_2_macro_channel,
					[pitchOp_mod_2, macro_1, macro_2, macro_3]);
				oscillator_mod_1 = Select.kr(oscillator_mod_1_macro_channel,
					[oscillator_mod_1, macro_1, macro_2, macro_3]);
				oscillator_mod_2 = Select.kr(oscillator_mod_2_macro_channel,
					[oscillator_mod_2, macro_1, macro_2, macro_3]);
				fx_mod_1 = Select.kr(fx_mod_1_macro_channel,
					[fx_mod_1, macro_1, macro_2, macro_3]);
				fx_mod_2 = Select.kr(fx_mod_2_macro_channel,
					[fx_mod_2, macro_1, macro_2, macro_3]);
				filter_mod_1 = Select.kr(filter_mod_1_macro_channel,
					[filter_mod_1, macro_1, macro_2, macro_3]);
				filter_mod_2 = Select.kr(filter_mod_2_macro_channel,
					[filter_mod_2, macro_1, macro_2, macro_3]);
				envelope_mod = Select.kr(envelope_mod_macro_channel,
					[envelope_mod, macro_1, macro_2, macro_3]);
				vol = Select.kr(vol_macro_channel,
					[vol, macro_1, macro_2, macro_3, fader]);

				vol = vol.lincurve(0,1,0,0.5,3);

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
					prependArgs: [Splay.ar(oscillator + oscillator_2 + drum + drum_2), gate, freq, fx_mod_1, fx_mod_2, beatDuration, syncMultiplier],
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
				//Out.ar(send_2, vca * send_2_level);

		}).add;
	};
	synthDefName
};

"make modular synthdef function loaded".postln;