(
SynthDef.new(\sine_OD_1,
	{
		arg gate = 1,
		freq,
		detune_voices = 4;

		var note = \note.kr(60,0);

		var macro_controls = Lag.kr(
			In.kr(
				~sine_OD_1_controlbus ?? {~sine_OD_1_controlbus = Bus.control(Server.default, 4)},
				4),
			0.1);

		var macro_1 = macro_controls[0],
		overdrive = macro_1.lincurve(0,1,1,50,3);

		var macro_2 = macro_controls[1],
		detune = macro_2.lincurve(0,1,0,0.2,-7),
		feedback = macro_2.lincurve(0,1,0,1.25,-5);

		var macro_3 = macro_controls[2],
		amp_r = macro_3.lincurve(0,1,0.2,5,-10),
		amp_c = macro_3.lincurve(0,1,-1,-10,-10);

		var fader = macro_controls[3],
		vol = fader.lincurve(0,1,0,0.025,3),
		vol_correct = 1 * macro_1.lincurve(0,1,1,0.175,-1);

		var note_freq, detune_array, sine, sum, saturation, clipping, adsr;


		~transfer_fundtion_1 ?? {
			~transfer_fundtion_1 = Env([-0.999,0,0.999],[1,1],[2,-2]).asSignal(8193);
			~transfer_fundtion_1 = ~transfer_fundtion_1.asWavetableNoWrap;};
		~transfer_fundtion_1_buf ?? ~transfer_fundtion_1_buf = Buffer.loadCollection(s, ~transfer_fundtion_1);


		note_freq = freq;

		detune_array =[(-2..2) * detune];

		sine = SinOscFB.ar(freq + detune_array, feedback, 0.125);

		sum = Splay.ar(sine, 1, 0.005);

		saturation = Shaper.ar(~transfer_fundtion_1_buf, sine * overdrive);

		// clipping = Clip.ar(sine * overdrive, -0.999, 0.999);

		adsr = saturation * vol * vol_correct * EnvGen.kr
		(Env.adsr(attackTime: 0.1,
			decayTime: amp_r,
			sustainLevel: 0.5,
			releaseTime: amp_r,
			peakLevel: 1.0, curve: amp_c),
			gate: gate, doneAction:2);

		Out.ar(~chords_bus, adsr);

}).add;
)