(
SynthDef.new(\fm_1,
	{
		arg gate = 1;

		var note = \note.kr(60,0),
		mod1_ratio = 2,
		amp_d = 0.1,
		amp_s = 1,
		amp_c = 2;

		var macro_1 = \macro_1.kr(0, 0.01),
		vib_f = 0.7 + macro_1.linlin(0,0.5,0,6) + macro_1.lincurve(0.4,1,0,7,3),
		vib_w = 0.005 + macro_1.lincurve(0,0.5,0,0.01,-4) + macro_1.lincurve(0.5,1,0,0.5,1),
		mod1_amp = macro_1.lincurve(0,0.5,0,2,-3) + macro_1.lincurve(0,1,0,3,1),
		filter_ratio = 0.5 + (5 * macro_1),
		filter_f = 2000 + macro_1.lincurve(0,1,0,2000,-2),
		overdrive_amount = macro_1.lincurve(0,1,0,5,-3) + macro_1.lincurve(0.5,1,0,95,10),
		fundamental = 0.5 + macro_1.lincurve(0,1,0,0.5,1),
		vol_correct =  1 + macro_1.lincurve(0,1,0,-0.35,2);

		var macro_2 = \macro_2.kr(0, 0.1) - macro_1.lincurve(0.2,1,0,0.9,3),
		rng_trans = macro_2.lincurve(0,1,0,0.02,-2),
		pitch_env_amount =  macro_2.linlin(0,1,0,-1),
		pitch_env_time = 0.0 + (0.5 * macro_2),
		amp_a = macro_2.lincurve(0,1,1,0.1,-3),
		amp_r = 2 - (1 * macro_2),
		noise_amt = macro_2.lincurve(0,1,0,1900,-2),
		drift_amt = macro_2.lincurve(0,1,0,0.0075,-2);

		var macro_3 = \macro_3.kr(0, 0.1);

		var fader = \fader.kr(0, 0.1),
		vol = fader.lincurve(0,1,0,2!2,3);

		var carrier_f, pitch_env, vibrato, mod1_f, modulator1, drift, noise, carrier, filter, overdrive, adsr;

		//vib_w.poll;
		//macro_1.poll;
		//noise.poll;

		vib_w = vib_w - macro_2.lincurve(0.5,1,0,0.0075);

		carrier_f = note.midicps;

		pitch_env =  EnvGen.kr
		(Env.new([carrier_f * pitch_env_amount, 0], pitch_env_time, -4));

		vibrato = SinOsc.ar(vib_f + pitch_env, mul:carrier_f * vib_w);

		mod1_f = (carrier_f + vibrato + pitch_env) * mod1_ratio;

		modulator1 = SinOsc.ar(mod1_f, mul:carrier_f) * mod1_amp;

		drift = SinOsc.ar(Rand(0.2, 0.5), mul: drift_amt * carrier_f) + (carrier_f * Rand(rng_trans, rng_trans));

		noise = Dust2.ar(Rand(400, 600),mul: noise_amt);

		carrier = SinOsc.ar(carrier_f + vibrato + modulator1 + noise + pitch_env + drift);

		filter = BHiPass4.ar(BLowPass.ar(carrier, freq: filter_f + carrier_f * filter_ratio) * (0.8 + overdrive_amount), carrier_f,
			rq: 1.0);

		overdrive = Clip.ar(SinOsc.ar(carrier_f + vibrato, mul: fundamental * (0.8 + overdrive_amount / 10)) + filter,
			lo: -0.9, hi: 0.9);

		adsr = vol * vol_correct * overdrive * EnvGen.kr(
			Env.adsr(
				attackTime: amp_a,
				decayTime: amp_d,
				sustainLevel: amp_s,
				releaseTime: amp_r,
				curve: amp_c
			),
			gate: gate,
			doneAction:2);

		Out.ar([0,1],Clip.ar(tan(adsr),-0.99, 0.99));

}).add;

SynthDef.new(\BD_808_1,
	{
		arg gate = 1;

		var note = \note.kr(60,0),
		noise = 0;

		var macro_1 = \macro_1.kr(0, 0.1),
		mod1_amp_range = 100,
		mod1_amp = macro_1.lincurve(0,0.5,0,mod1_amp_range,-3),
		overdrive = macro_1.lincurve(0.5,1,1,29,1);

		var macro_2 = \macro_2.kr(0, 0.1),
		mod1_ratio_range = Rand(-1,1) * macro_2.lincurve(0,1,0,0.3,0),
		mod1_ratio = 2 + mod1_ratio_range;

		var macro_3 = \macro_3.kr(0, 0.1),
		amp_r = macro_3.lincurve(0,1,0.2,5,-10),
		amp_c = macro_3.lincurve(0,1,-1,-10,-10),
		pitch_env_amount = macro_3.lincurve(0,1,128,8,-20),
		pitch_env_time = macro_3.lincurve(0,1,0.1,0.5,-10),
		pitch_env_curve = macro_3.lincurve(0,1,0.2,-150,-40);

		var fader = \fader.kr(0, 0.1),
		vol = fader.lincurve(0,1,0,2,3),
		vol_correct = 1;

		var carrier_f, pitch_env, mod1_f, modulator1, sine, fm, filter, adsr, mix;

		carrier_f = note.midicps;

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
				(Clip.ar(sine * (7 + overdrive), -0.99, 0.99)) * macro_1.lincurve(0.5,1,0.5,0.125,0.5),
				macro_1.lincurve(0,1,-1,1,0)), -0.99, 0.99);

		adsr = 7 * vol * mix * EnvGen.kr
		(Env.new([1, 0], amp_r, amp_c,), doneAction:2);

		Out.ar([0,1], adsr);

}).add;

SynthDef.new(\Clicks_1,
	{
		arg gate = 1;

		var note = \note.kr(60,0);

		var macro_1 = \macro_1.kr(0, 0.1);

		var macro_2 = \macro_2.kr(0, 0.1);

		var macro_3 = \macro_3.kr(0, 0.1),
		amp_r = macro_3.lincurve(0,1,0.01,0.25,-10),
		amp_c = macro_3.lincurve(0,1,-1,-10,-10),
		pitch_env_amount = macro_3.lincurve(0,1,2,4,-20),
		pitch_env_time = macro_3.lincurve(0,1,0.01,0.125,-10),
		pitch_env_curve = macro_3.lincurve(0,1,0.2,-150,-40);

		var fader = \fader.kr(0, 0.1),
		vol = fader.lincurve(0,1,0,1,2),
		vol_correct =  macro_3.lincurve(0,1,0.7,1,2);

		var note_f, pitch_env, noise, filter, adsr;

		note_f = note.midicps;

		pitch_env =  EnvGen.kr
		(Env.new([note_f * pitch_env_amount, 0], pitch_env_time, pitch_env_curve));

		noise = WhiteNoise.ar; //Dust2.ar(note_f * 4);

		filter = BLowPass.ar(noise, freq: note_f + pitch_env, rq: 2);

		adsr = 100 * vol * vol_correct * filter * EnvGen.kr
		(Env.new([1, 0], amp_r, amp_c,), doneAction:2);

		Out.ar([0,1], Clip.ar(tan(adsr), -0.99, 0.99));

}).add;

SynthDef.new(\Pulse_1,
	{
		arg gate = 1;

		var note = \note.kr(60,0),
		mod1_ratio = 1,
		amp_d = 0.1,
		amp_s = 1,
		amp_c = 2;

		var macro_1 = \macro_1.kr(0, 0.1),
		vib_f = 0.2 + macro_1.linlin(0,0.3,0,7) + macro_1.linexp(0.4,1,0.001,7),
		vib_w = 0.005 + macro_1.lincurve(0,0.3,0.0,0.06,-4) + macro_1.lincurve(0.7,1,0,1,3),
		mod1_amp = macro_1.linlin(0,0.5,0,100),
		filter_ratio = 0.5 + (5 * macro_1),
		filter_f = 200 + (2000 * macro_1),
		overdrive = macro_1.linexp(0.3,0.8,0.000001,3) + macro_1.linexp(0.6,1,0.000001,50) + macro_1.linexp(0.8,1,0.000001,100),
		fundamental = 0.5 + (0.5 * macro_1),
		vol_correct =  2.5 + (0.5 * macro_1);

		var macro_2 = \macro_2.kr(0, 0.1),
		pitch_env_amount =  macro_2.linlin(0,1,0,-0.5),
		pitch_env_time = 0.0 + (0.5 * macro_2),
		amp_a = macro_2.lincurve(0,1,1,0.1,-3),
		amp_r = 2 - (1 * macro_2),
		noise = macro_2.lincurve(0,1,0,2000,-2);



		var macro_3 = \macro_3.kr(0, 0.1);

		var fader = \fader.kr(0, 0.1),
		vol = fader;

		var carrier_f, pitch_env, vibrato, mod1_f, modulator1, carrier, filter, adsr;

		//vib_w.poll;
		//macro_1.poll;
		//noise.poll;

		carrier_f = note.midicps;

		pitch_env =  EnvGen.kr
		(Env.new([carrier_f * pitch_env_amount, 0], pitch_env_time, -2));

		vibrato = SinOsc.ar(vib_f + pitch_env, mul:carrier_f*vib_w);

		mod1_f = (carrier_f + vibrato + pitch_env) * mod1_ratio;

		modulator1 = SinOsc.ar(mod1_f, mul:carrier_f*mod1_amp);

		carrier = SinOsc.ar(carrier_f + vibrato + modulator1 + Dust2.ar(500,mul: noise) + pitch_env
		);

		filter = Clip.ar
		(SinOsc.ar(carrier_f + vibrato, mul: fundamental * (0.8 + overdrive / 10))
			+ BHiPass4.ar
			(BLowPass.ar
				(carrier, freq: filter_f + carrier_f * filter_ratio) * (0.8 + overdrive), carrier_f,
				rq: 1.0),
			lo: -0.9, hi: 0.9);

		adsr = vol * vol_correct * filter * EnvGen.kr(
			Env.adsr(
				attackTime: amp_a,
				decayTime: amp_d,
				sustainLevel: amp_s,
				releaseTime: amp_r,
				curve: amp_c
			),
			gate: gate,
			doneAction:2);

		Out.ar([0,1],adsr);

}).add;

(SynthDef.new(\Spreadsynth_1,
	{
	arg sprd=1, oddeven=0.5, slopecntrl=0.5, gate=0, amp=0, fmfreq=1, fmamt=0;

	var note = \note.kr(60,0);

	var harmnumodd, harmnumeven, harmslopeodd, harmslopeeven, harmsprdodd, harmsprdeven, harmvolodd, harmvoleven, oscfreqodd, oscfreqeven, sinoscbase, sinoscodd, sinosceven, fmharmnum, fmharmvol,fmharmsprd, fmod, mix, pan;

	ot_num = 20;

	fm_ot_num = 5; //fm OT

	note_f = note.midicps;

	sprd = 1.2;

	oddeven = 0.5;

	slopecntrl = 0.5;

	harmnumodd = 2 * (1..ot_num) + 1;

	harmnumeven = 2 * (1..ot_num);

	harmslopeodd = LinLin.kr(slopecntrl,0,1,1,harmnumodd);

	harmslopeeven = LinLin.kr(slopecntrl,0,1,1,harmnumeven);

	harmsprdodd = harmnumodd * sprd;

	harmsprdeven = harmnumeven * sprd;

	harmvolodd = 1 - oddeven / harmnumodd * harmslopeodd;

	harmvoleven = oddeven / harmnumeven * harmslopeeven;


	fmfreq = 1; // verhältnis zur Frequenz

	fmamt = 0; // fmamt

	fmharmnum = 2 * (0..fm_ot_num) + 1;

	fmharmsprd = fmharmnum*sprd;

	fmharmvol = 1 / fmharmnum;

	fmod=SinOsc.ar(note_f * fmharmsprd * fmfreq , 0 , fmharmvol * fmamt , 1);

	oscfreqodd = note_f * harmsprdodd; //*fmod

	oscfreqeven = note_f * harmsprdeven; //*fmod

	sinoscbase = SinOsc.ar(note_f * fmod , 0, 1);

	sinoscodd=SinOsc.ar(oscfreqodd*fmod,0,harmvolodd);

	sinosceven=SinOsc.ar(oscfreqeven*fmod,0,harmvoleven);

		mix=Mix.ar([sinoscbase, sinoscodd, sinosceven])*EnvGen.ar(Env.asr, gate, doneAction:2);

	pan=Pan2.ar(mix,0,0.08);

		Out.ar([0,1],pan)

}).add)


"synthDefs loaded".postln;
)