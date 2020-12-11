(
SynthDef.new(\clicks_1,
	{
		arg gate = 1,freq;

		var macro_controls = Lag.kr(
			In.kr(
				~clicks_1_controlbus ?? {~clicks_1_controlbus = Bus.control(Server.default, 4)},
				4),
			0.1);

		var macro_1 = macro_controls[0];

		var macro_2 = macro_controls[1],
		balance = macro_2.lincurve(0, 1, 0, 1, -3);

		var macro_3 = macro_controls[2],
		amp_r = macro_3.lincurve(0,1,0.01,0.5,-10) - macro_2.lincurve(0, 1, 0, 0.25) + freq.lincurve(1200, 120, -0.1, 2, 2),
		amp_c = macro_3.lincurve(0,1,-1,-10,-10),
		pitch_env_amount = macro_3.lincurve(0,1,2,4,-20),
		pitch_env_time = macro_3.lincurve(0,1,0.01,0.25,-10),
		pitch_env_curve = macro_3.lincurve(0,1,0.2,-150,-40);

		var fader = macro_controls[3],
		vol = fader.lincurve(0, 1, 0, 0.5, -7),
		vol_correct =  macro_3.lincurve(0,1,1.5,0.5,-10) + macro_2.lincurve(0.5, 1, 1, 0.01, -1);

		var note_f, sine, pitch_env, noise, filter, adsr;

		note_f = freq;

		pitch_env =  EnvGen.kr
		(Env.new([note_f * pitch_env_amount, 0], pitch_env_time, pitch_env_curve));

		sine = SinOsc.ar(note_f + pitch_env, mul:balance);

		noise = WhiteNoise.ar(mul: 1 - balance); //Dust2.ar(note_f * 4);

		filter = BLowPass.ar(noise + sine, freq: note_f + pitch_env, rq: 2);

		adsr = 0.25 * vol * vol_correct * filter * EnvGen.kr
		(Env.new([1, 0], amp_r, amp_c,), doneAction:2);

		Out.ar(~drums_bus, Clip.ar(tan(adsr), -0.99, 0.99));

}).add;
)