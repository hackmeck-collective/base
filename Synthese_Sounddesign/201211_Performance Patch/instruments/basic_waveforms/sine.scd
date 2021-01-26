(
~adsrTypes.keysValuesDo{
	arg adsrType, envelope_function;

	var synthDefName = "sine_" ++ adsrType.asString;

	(SynthDef.new(synthDefName,
		{
			arg gate = 1,
			freq = 440;

			var macro_controls = Lag.kr(
				In.kr(
					~sine_controlbus ?? {~sine_controlbus = Bus.control(Server.default, 4)},
					4),
				0.1);

			var macro_1 = macro_controls[0];

			var macro_2 = macro_controls[1];

			var macro_3 = macro_controls[2];

			var note = \note.kr(60,0);

			var fader = macro_controls[3],
			vol = fader.lincurve(0,1,0,0.1,3),
			vol_correct = 1;

			var note_freq, sine, envelope, amp;

			note_freq = freq;

			sine = SinOsc.ar(note_freq);

			envelope = SynthDef.wrap(
				envelope_function,
				prependArgs: [gate, macro_3],
			);

			amp = sine * vol * envelope;

			Out.ar(0, amp);

			synthDefName.post;
			" loaded".postln;

	}).add;
	);
};
)