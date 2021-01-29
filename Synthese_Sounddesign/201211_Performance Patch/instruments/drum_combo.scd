(
~drumTypes.keysValuesDo{
	arg drumType, drum_function;

	(
		~fxTypes.keysValuesDo{
			arg fxTypes, fx_function;

			var synthDefName =
			drumType.asString ++ "_" ++
			fxTypes.asString;

			(SynthDef.new(synthDefName,
				{
					arg gate = 1,
					freq = 440,
					controlbus,
					out,
					osc1_time = 0.5,
					osc1_time_macro_channel = 3,
					osc1_range,
					osc1_range_macro_channel = 1,
					fx_mod_1 = 0.2,
					fx_mod_1_macro_channel = 0,
					fx_mod_2 = 0.2,
					fx_mod_2_macro_channel = 0;


					/*					pitchOp_mod_1,
					pitchOp_mod_1_macro_channel,
					pitchOp_mod_2,
					pitchOp_mod_2_macro_channel,
					oscillator_mod_1 = 0.25,
					oscillator_mod_1_macro_channel = 2,
					oscillator_mod_2 = 0.25,
					oscillator_mod_2_macro_channel = 0,

					envelope_mod = 0.25,
					envelope_mod_macro_channel = 3;*/

					var note = \note.kr(60,0),
					lpf_freq = 10000;

					var macro_controls = Lag.kr(
						In.kr(
							controlbus,
							4),
						0.1);

					var macro_1 = macro_controls[0],
					macro_2 = macro_controls[1],
					macro_3 = macro_controls[2];

					var fader = macro_controls[3],
					vol = fader.lincurve(0,1,0,0.1,3),
					vol_correct = 1;

					var drum, fx, filter, amp;

					/*					pitchOp_mod_1 = Select.kr(pitchOp_mod_1_macro_channel,
					[pitchOp_mod_1, macro_1, macro_2, macro_3]);
					pitchOp_mod_2 = Select.kr(pitchOp_mod_2_macro_channel,
					[pitchOp_mod_2, macro_1, macro_2, macro_3]);
					oscillator_mod_1 = Select.kr(oscillator_mod_1_macro_channel,
					[oscillator_mod_1, macro_1, macro_2, macro_3]);
					oscillator_mod_2 = Select.kr(oscillator_mod_2_macro_channel,
					[oscillator_mod_2, macro_1, macro_2, macro_3]);

					envelope_mod = Select.kr(envelope_mod_macro_channel,
					[envelope_mod, macro_1, macro_2, macro_3]);*/
					osc1_time = Select.kr(osc1_time_macro_channel,
						[osc1_time, macro_1, macro_2, macro_3]);
					osc1_range = Select.kr(osc1_range_macro_channel,
						[osc1_range, macro_1, macro_2, macro_3]);
					fx_mod_1 = Select.kr(fx_mod_1_macro_channel,
						[fx_mod_1, macro_1, macro_2, macro_3]);
					fx_mod_2 = Select.kr(fx_mod_2_macro_channel,
						[fx_mod_2, macro_1, macro_2, macro_3]);

					drum = SynthDef.wrap(
						drum_function,
						prependArgs: [freq, gate, osc1_time, osc1_range],
					);

					fx = SynthDef.wrap(
						fx_function,
						prependArgs: [drum, gate, freq, fx_mod_1, fx_mod_2],
					);

					amp = fx * vol;

					Out.ar(out, tan(amp));

					synthDefName.post;
					" loaded".postln;

			}).add;
			);
		};
	);
};
)