(
~adsrTypes.keysValuesDo{
	arg adsrType, envelope_function;

	var synthDefName = "sine_OD_" ++ adsrType.asString;
	(
		SynthDef.new(synthDefName,
			{
				arg gate = 1,
				freq,
				detune_voices = 4,
				amp_a = 0.001, amp_c = 2;

				var note = \note.kr(60,0);

				var macro_controls = Lag.kr(
					In.kr(
						~sine_OD_1_controlbus ?? {~sine_OD_1_controlbus = Bus.control(Server.default, 4)},
						4),
					0.1);

				var macro_1 = macro_controls[0],
				overdrive = macro_1.lincurve(0,1,1,50,3),
				filter_envelope_range = macro_1.lincurve(0,1,1,5,3);

				var macro_2 = macro_controls[1],
				detune = macro_2.lincurve(0,1,0,0.2,3),
				feedback = macro_2.lincurve(0,1,0,1.25,3);

				var macro_3 = macro_controls[2];

				var fader = macro_controls[3],
				vol = fader.lincurve(0,1,0,0.1,3),
				vol_correct = 1 * macro_1.lincurve(0,1,1,0.175,3);

				var note_freq, detune_array, sine, sum, envelope, saturation, filter, clipping, adsr;


				~transfer_fundtion_1 ?? {
					~transfer_fundtion_1 = Env([-0.999,0,0.999],[1,1],[2,-2]).asSignal(8193);
					~transfer_fundtion_1 = ~transfer_fundtion_1.asWavetableNoWrap;};
				~transfer_fundtion_1_buf ?? ~transfer_fundtion_1_buf = Buffer.loadCollection(s, ~transfer_fundtion_1);


				note_freq = freq;

				detune_array =[(-2..2) * detune];

				sine = SinOscFB.ar(freq + detune_array, feedback, 0.125);

				sum = Splay.ar(sine, 1, 0.005);

				envelope = SynthDef.wrap(
					envelope_function,
					prependArgs: [gate, macro_3],
				);

				saturation = Shaper.ar(~transfer_fundtion_1_buf, sine * overdrive);

				filter = MoogFF.ar(saturation, note_freq * ((envelope * filter_envelope_range) + 1), 3);

				adsr = filter * vol * vol_correct * envelope;

				Out.ar(~chords_bus, adsr);

				synthDefName.post;
				" loaded".postln;

	}).add;
	);
};
)
