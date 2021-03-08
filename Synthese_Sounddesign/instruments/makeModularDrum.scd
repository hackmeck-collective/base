~makeModularDrum = { |drumTypes, fxTypes,filterTypes|
	var synthDefName =
	drumTypes ++ "_" ++
	fxTypes.asString ++ "_" ++
	filterTypes.asString;

	if(SynthDescLib.match(synthDefName).isNil){
		var drum_function = ~drumTypes[drumTypes];
		var fx_function = ~fxTypes[fxTypes];
		var filter_function = ~filterTypes[filterTypes];

		(SynthDef.new(synthDefName,
			{
				arg gate = 1,
				freq = 440,
				controlbus,
				out,
				send_1,
				send_1_level,
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
				fx_mod_1,
				fx_mod_2,
				filter_mod_1,
				filter_mod_2,
				vol = 0.5,
				time_factor_macro_channel,
				fx_mod_1_macro_channel,
				fx_mod_2_macro_channel,
				filter_mod_1_macro_channel,
				filter_mod_2_macro_channel,
				vol_macro_channel;

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

				var drum, fx, filter, amp;

				time_factor = Select.kr(time_factor_macro_channel,
					[time_factor, macro_1, macro_2, macro_3]);
				fx_mod_1 = Select.kr(fx_mod_1_macro_channel,
					[fx_mod_1, macro_1, macro_2, macro_3]);
				fx_mod_2 = Select.kr(fx_mod_2_macro_channel,
					[fx_mod_2, macro_1, macro_2, macro_3]);
				filter_mod_1 = Select.kr(filter_mod_1_macro_channel,
					[filter_mod_1, macro_1, macro_2, macro_3]);
				filter_mod_2 = Select.kr(filter_mod_2_macro_channel,
					[filter_mod_2, macro_1, macro_2, macro_3]);
				vol = Select.kr(vol_macro_channel,
					[vol, macro_1, macro_2, macro_3, fader]);
				vol = vol.lincurve(0,1,0,0.95,3);

				drum = SynthDef.wrap(
					drum_function,
					prependArgs: [freq, gate,
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

				fx = SynthDef.wrap(
					fx_function,
					prependArgs: [drum, gate, freq, fx_mod_1, fx_mod_2],
				);

				filter = SynthDef.wrap(
					filter_function,
					prependArgs: [fx, gate, freq, filter_mod_1, filter_mod_2],
				);

				amp = filter * vol;

				Out.ar(out, Pan2.ar(amp));
				Out.ar(send_1, Pan2.ar(amp) * send_1_level);

		}).add;
		);
	};
	synthDefName
};