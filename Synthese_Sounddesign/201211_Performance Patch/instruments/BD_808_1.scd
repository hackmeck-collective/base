(
SynthDef.new(\BD_808_1,
	{
		arg gate = 1,
		voice_steal = 1,
		freq;

		var note = \note.kr(60,0),
		noise = 0;

		var macro_controls = Lag.kr(
			In.kr(
				~bd_808_1_controlbus ?? {~bd_808_1_controlbus = Bus.control(Server.default, 4)},
				4),
			0.1);

		var macro_1 = macro_controls[0],
		mod1_amp_range = 75,
		mod1_amp = macro_1.lincurve(0,0.5,0, mod1_amp_range,0),
		overdrive = macro_1.lincurve(0.5,1,1,100,0);

		var macro_2 = macro_controls[1],
		mod1_ratio_range = Rand(-1,1) * macro_2.lincurve(0,1,0,0.3,0),
		mod1_ratio = 2 + mod1_ratio_range;

		var macro_3 = macro_controls[2],
		amp_r = macro_3.lincurve(0,1,0.2,5,-10),
		amp_c = macro_3.lincurve(0,1,-1,-10,-10),
		pitch_env_amount = macro_3.lincurve(0,1,128,8,-20),
		pitch_env_time = macro_3.lincurve(0,1,0.1,0.5,-10),
		pitch_env_curve = macro_3.lincurve(0,1,0.2,-150,-40);

		var fader = macro_controls[3],
		vol = fader.lincurve(0,1,0,0.05 ,-7),
		vol_correct = 2 * macro_1.lincurve(0,0.5,1,0.001,0) + macro_3.lincurve(0,1,1,0.05,-30);

		var carrier_f, pitch_env, mod1_f, modulator1, sine, fm, filter, adsr, mix, sc_trig;

		carrier_f = freq;

		pitch_env =  EnvGen.kr
		(Env.new([carrier_f * pitch_env_amount, 0], pitch_env_time, pitch_env_curve));

		mod1_f = (carrier_f + pitch_env) * mod1_ratio;

		modulator1 = SinOsc.ar(mod1_f, mul:carrier_f*mod1_amp);

		sine = SinOsc.ar(carrier_f + Dust2.ar(500,mul: noise) + pitch_env);

		fm = SinOsc.ar(carrier_f + modulator1 + Dust2.ar(500,mul: noise) + pitch_env);

		filter = BLowPass.ar(fm, freq: carrier_f);

		mix = Clip.ar(
			XFade2.ar
			(filter * macro_1.lincurve(0,0.5,0.5,2,1),
				(Clip.ar(sine * (5 + overdrive), -0.99, 0.99)) * macro_1.lincurve(0.5,1,0.5,0.5,0),
				macro_1.lincurve(0,1,-1,0,0)), -0.99, 0.99);

		adsr = 7 * vol * vol_correct * mix * EnvGen.kr
		(Env.adsr(attackTime: 0.0001,
			decayTime: 0,
			sustainLevel: 1,
			releaseTime: amp_r,
			peakLevel: 1.0, curve: amp_c),
			gate: gate, doneAction:2);

		sc_trig = 0;

/*		sc_trig = 1 - EnvGen.kr
		(Env.adsr(attackTime: 0.0001,
			decayTime: amp_r,
			sustainLevel: 0,
			releaseTime: amp_r,
			peakLevel: 1.0, curve: amp_c),
			gate: gate, doneAction:2);*/

		~sidechain_bus.setAt(0, sc_trig);

		Out.ar(~drums_bus, adsr);

}).add;
)