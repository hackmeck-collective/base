~makeModularSynthDef = { |adsrType, pitchOpType, oscillatorType, fxType, filterType|
	var synthDefName;

	if (pitchOpType.isNil){pitchOpType = \noPitchOp};
	if (fxType.isNil){fxType = \noFx};
	if (filterType.isNil){filterType = \noPitchOp};

	synthDefName =
	adsrType.asString ++ "_" ++
	pitchOpType.asString ++ "_" ++
	oscillatorType.asString ++ "_" ++
	fxType.asString ++ "_" ++
	filterType.asString;

	if(SynthDescLib.match(synthDefName).isNil){
		var envelope_function = ~adsrTypes[adsrType];
		var oscillator_function = ~oscillatorTypes[oscillatorType];
		var pitchOp_function = ~pitchOpTypes[pitchOpType];
		var fx_function = ~fxTypes[fxType];
		var filter_function = ~filterTypes[filterType];

		SynthDef.new(synthDefName,
			{
				arg gate = 1,
				freq = 440,
				controlbus,
				out,
				send_1,
				send_1_level,
				pitchOp_mod_1,
				pitchOp_mod_2,
				oscillator_mod_1,
				oscillator_mod_2,
				fx_mod_1,
				fx_mod_2,
				filter_mod_1,
				filter_mod_2,
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

				var envelope, pitchOp_freq, oscillator, fx, filter, vca;


				// pitchOp_mod_1 = [pitchOp_mod_1, macro_1, macro_2, macro_3].at(pitchOp_mod_1_macro_channel)


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

				vol = vol.lincurve(0,1,0,0.33,3);

				envelope = SynthDef.wrap(
					envelope_function,
					prependArgs: [gate, envelope_mod, beatDuration, syncMultiplier, envCurve],
				);

				pitchOp_freq = SynthDef.wrap(
					pitchOp_function,
					prependArgs: [freq, gate, pitchOp_mod_1, pitchOp_mod_2, beatDuration, syncMultiplier],
				);

				oscillator = Splay.ar(
					SynthDef.wrap(
						oscillator_function,
						prependArgs: [pitchOp_freq, gate, oscillator_mod_1, oscillator_mod_2, beatDuration, syncMultiplier]
					)
				);

				fx = SynthDef.wrap(
					fx_function,
					prependArgs: [oscillator, gate, freq, fx_mod_1, fx_mod_2, beatDuration, syncMultiplier],
				);

				filter = SynthDef.wrap(
					filter_function,
					prependArgs: [fx, gate, freq, filter_mod_1, filter_mod_2, beatDuration, syncMultiplier],
				);

				vca = filter * vol * amp * envelope;

				Out.ar(out, vca);
				Out.ar(send_1, vca * send_1_level);

		}).add;
	};
	synthDefName
};

"make modular synthdef function loaded".postln;