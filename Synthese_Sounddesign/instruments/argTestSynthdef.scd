~testidef = {|
	mod1Target = ""
	|

	var testiname, mod1TargetLine = "";

	testiname = "testi" ++ "_" ++
	mod1Target.asString;

	if (mod1Target.isEmpty,
		{mod1TargetLine = "dummy".asString},
		{mod1TargetLine = "% = % + (% * mod1)".format(mod1Target, mod1Target, mod1Target).asString}
	);

	if(SynthDescLib.match(testiname).isNil){

		SynthDef.new(testiname,
			{
				arg gate = 1,
				freq = 440,
				mod1Amount = 2,
				mod1Rate = 3,
				amp = 1;

				var dummy, mod1, envelope;

				mod1 = SinOsc.ar(mod1Rate, 0, mod1Amount);

				"mod1TargetPlaceholder";

				envelope = EnvGen.kr(Env.perc(0.01,1),	gate: gate,	doneAction:2);

				Out.ar(0, envelope * amp * SinOsc.ar(freq, 0, 0.25));

			}
		)
		.asCompileString.replace("\"mod1TargetPlaceholder\"", replace: mod1TargetLine)
		.interpretPrint
		.add;

	};
	testiname.postln;
};


Pbindef(\test,
	\mod1Amount, 0.4,
	\type, \on,
	\dur, Pseq([3,2,1], inf),
	\mod1Target, "freq",
	\freq, 440,
	\instrument, Pfunc { |ev|
				~testidef.valueWithEnvir(ev)
			},
).play

SynthDef.new(\testi,
	{arg gate,
		freq = 440,

		mod1Amount = 2,
		mod1Rate = 3,
		mod1Target,
		amp;

		var modulator;

		modulator = SinOsc.ar(mod1Rate, 0, mod1Amount);

		freq.poll;

		mod1Target = mod1Target + (mod1Target * modulator); // in this line I want to replace mod1Target with freq, as specified in the Pbindef below, so it looks like freq = freq + (freq * modulator);

		freq.poll; // here the freq should be modulated

		Out.ar(0, SinOsc.ar(freq, 0, 0.25));

}).add




~makeSyn = {|str|

	SynthDef.new(\testi,
		{arg gate,
			freq,
			controlbus,
			out,

			oscillator_mod_1,
			oscillator_mod_2,

			mod1Amount = 1,
			mod1Rate = 1,
			amp;

			"mod1target Input: ".postln;
			mod1target.postln;

			freq = 440;
			freq.postln;
			"replaceMe";

			freq.poll;

			Select.kr([thisFunction.argNames].flat.indexOf(mod1target.asSymbol),[thisFunction.argNames].flat); //entweder in der ausführung, oder irgendwie als variabler textbaustein, um die modulationsmatrix für den synth beim erstellen zu generieren.

			// Out.ar(0, SinOsc.ar(440,0,0.5));

	}).asCompileString.replace("\"replaceMe\"", replace: str).interpret.add
}

~makeSyn.("freq = freq * mod1Amount").add

Pbindef(\test,
	\mod1Amount, 5,
	\mod1Target, \freq,
	\freq, 440,
	\instrument, \testi
).play

SynthDef.new(\testi,
	{arg gate,
		freq = 440,

		mod1Amount = 2,
		mod1Rate = 3,
		mod1Target,
		amp;

		var modulator;

		modulator = SinOsc.ar(mod1Rate, 0, mod1Amount);

		freq.poll;

		mod1Target = mod1Target + (mod1Target * modulator); // in this line I want to replace mod1Target with freq, as specified in the Pbindef below, so it looks like freq = freq + (freq * modulator);

		freq.poll; // here the freq should be modulated

		Out.ar(0, SinOsc.ar(freq, 0, 0.25));

}).add

Pbindef(\test,
	\mod1Amount, 5,
	\mod1Target, \freq,
	\freq, 440,
	\instrument, \testi
).play

~replaceModTarget = { |str|
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

			mod1Amount,
			mod1Rate,
			mod1attack,
			mod1decay,
			mod1sustain,
			mod1release,

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

			var envelope, mod1, pitchOp_freq, pitchOp_freq_2, oscillator, oscillator_2, fx, fx_2, filter, filter_2, drum, drum_2, vca;

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

			mod1 = SynthDef.wrap(
				mod1_function,
				prependArgs: [gate, beatDuration, syncMultiplier, mod1Amount, mod1Rate, mod1attack, mod1decay, mod1sustain, mod1release],
			);

			"replaceModTarget";
			/*mod1Targets = SynthDef.wrap(
			mod1Targets_function,
			prependArgs: [mod1, oscillator_mod_2],
			);
			*/
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

	})
}