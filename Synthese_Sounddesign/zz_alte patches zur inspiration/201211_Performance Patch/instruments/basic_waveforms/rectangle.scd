(
~adsrTypes.keysValuesDo{
	arg adsrType, envelope_function;

	var synthDefName = "rect_" ++ adsrType.asString;

	(SynthDef.new(synthDefName,
		{
			arg gate = 1,
			freq = 440;

			var macro_controls = Lag.kr(
				In.kr(
					~rect_controlbus ?? {~rect_controlbus = Bus.control(Server.default, 4)},
					4),
				0.1);

			var macro_1 = macro_controls[0],
			lpf_resonance = macro_1.lincurve(0,1,0,3.5,3),
			filter_vol_correct = macro_1.lincurve(0,1,1,3,3);

			var macro_2 = macro_controls[1],
			lpf_freq = macro_2.lincurve(0,1,1,10000,3);

			var macro_3 = macro_controls[2];

			var note = \note.kr(60,0);

			var fader = macro_controls[3],
			vol = fader.lincurve(0,1,0,0.1,3),
			vol_correct = 1;

			var note_freq, rectangle, envelope, filter, amp;

			note_freq = freq;

			rectangle = Pulse.ar(note_freq);

			envelope = SynthDef.wrap(
				envelope_function,
				prependArgs: [gate, macro_3],
			);

			filter = MoogFF.ar(rectangle, lpf_freq, lpf_resonance) * filter_vol_correct;

			amp = filter * vol * envelope;

			Out.ar(0, amp);

			synthDefName.post;
			" loaded".postln;

	}).add;
	);
};
)
