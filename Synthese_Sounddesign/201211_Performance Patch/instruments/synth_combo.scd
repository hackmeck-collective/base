(
~pitchOpTypes.keysValuesDo{
	arg pitchOpType, pitchOp_function;

	(
		~oscillatorTypes.keysValuesDo{
			arg oscillatorType, oscillator_function;

			(
				~adsrTypes.keysValuesDo{
					arg adsrType, envelope_function;

					var synthDefName =
					pitchOpType.asString ++ "_" ++
					oscillatorType.asString ++ "_" ++
					adsrType.asString;

					(SynthDef.new(synthDefName,
						{
							arg gate = 1,
							freq = 440,
							controlbus = ~combo_controlbus,
							macro_1_destination = pitchOp_mod_1,
							macro_2_destination = oscillator_mod_1,
							macro_3_destination = envelope_mod,
							pitchOp_mod_1,
							pitchOp_mod_2,
							oscillator_mod_1,
							oscillator_mod_2,
							envelope_mod;

							var note = \note.kr(60,0),
							lpf_freq = 10000;

							var macro_controls = Lag.kr(
								In.kr(
									controlbus ?? {controlbus = Bus.control(Server.default, 4)},
									4),
								0.1);
							var macro_1 = macro_controls[0],
							macro_2 = macro_controls[1],
							macro_3 = macro_controls[2];

							var fader = macro_controls[3],
							vol = fader.lincurve(0,1,0,0.1,3),
							vol_correct = 1;

							var oscillator, envelope, filter, amp;

							macro_1_destination = macro_1;
							macro_2_destination = macro_2;
							macro_3_destination = macro_3;

							freq = SynthDef.wrap(
								pitchOp_function,
								prependArgs: [freq, gate, pitchOp_mod_1, pitchOp_mod_2],
							);

							oscillator = SynthDef.wrap(
								oscillator_function,
								prependArgs: [freq, oscillator_mod_1, oscillator_mod_2],
							);

							envelope = SynthDef.wrap(
								envelope_function,
								prependArgs: [gate, envelope_mod],
							);

							filter = MoogFF.ar(oscillator, lpf_freq, 2) * 2;

							amp = filter * vol * envelope;

							Out.ar(0, amp);

							synthDefName.post;
							" loaded".postln;

					}).add;
					);
				};
			);
		};
	);
};
);