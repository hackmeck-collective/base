(
SynthDef.new(\Spreadsynth_1,
	{
	arg gate = 1, amp_a = 0.001, amp_c = 2, freq;

	var note_f, car_ot_num, fm_ot_num, harmnumodd, harmnumeven, harmslope_odd, harmslope_even, harmspread_odd, harmspread_even, harmvolodd, harmvoleven, oscfreq_odd, oscfreq_even, sinoscbase, sinoscodd, sinosceven, fmharmnum, fmharmvol,fmharmsprd, fmod, mix, adsr;

	var macro_controls = Lag.kr(
		In.kr(
				~spreadsynth_1_controlbus ?? {~spreadsynth_1_controlbus = Bus.control(Server.default, 4)},
			4),
		0.1);

	var macro_1 =  macro_controls[0],
		slope_cntrl = macro_1.lincurve(0,1,0,2,2),
		oddeven = macro_1.lincurve(0,1,1,0,2),
		fmamt = macro_1.lincurve(0,1,0,50,2),
		vol_correct = macro_1.lincurve(0,1,0.04,0.02,2);

	var macro_2 =  macro_controls[1],
		spread = macro_2.linlin(0,1,1,3);

	var macro_3 =  macro_controls[2],
		amp_r = macro_3.lincurve(0,1,0.1,2,-2),
		amp_d = amp_r,
		amp_s = macro_3.lincurve(0,0.8,0.8,0,-3);

	var fader =  macro_controls[3],
		vol = fader.lincurve(0,1,0,0.1,-7);

		note_f = freq + SinOsc.ar(Rand(0.25,3),mul: (1-macro_1) * Rand(0.5,2));

	car_ot_num = 10;

	harmnumodd = 2 * (1..car_ot_num) + 1;

	harmnumeven = 2 * (1..car_ot_num);

	fm_ot_num = 5;

	fmharmnum = (1..fm_ot_num) + 1;

	harmspread_odd = harmnumodd * spread;

	harmspread_even = harmnumeven * spread;

	fmharmsprd = fmharmnum * spread;

	harmslope_odd = LinLin.kr(slope_cntrl, 0, 1, 1, harmnumodd);

	harmslope_even = LinLin.kr(slope_cntrl, 0, 1, 1, harmnumeven);

	harmvolodd = 1 - oddeven / harmnumodd * harmslope_odd;

	harmvoleven = oddeven / harmnumeven * harmslope_even;

	fmharmvol = 1 / fmharmnum;

	sinoscbase = SinOsc.ar(note_f, 0, 1);

	fmod = SinOsc.ar(note_f * fmharmsprd, 0, fmharmvol * fmamt, 1);

	oscfreq_odd = note_f * harmspread_odd;

	oscfreq_even = note_f * harmspread_even;

	sinoscodd = SinOsc.ar(oscfreq_odd * fmod, 0, harmvolodd-0.5);

	sinosceven = SinOsc.ar(oscfreq_even * fmod, 0, harmvoleven-0.5);

	mix = sinoscbase + sinoscodd + sinosceven;

	adsr = mix * vol * vol_correct * EnvGen.kr(
			Env.adsr(
				attackTime: amp_a,
				decayTime: amp_d,
				sustainLevel: amp_s,
				releaseTime: amp_r,
				curve: amp_c
			),
			gate: gate,
			doneAction:2);

		Out.ar(~melody_bus,adsr);

}).add;
)
