(
SynthDef.new(\modes_synth_1,
	{
	arg gate = 1, amp_a = 0.001, amp_c = 2, freq;

	var note_f,
		ot_num, ot_odd, ot_even,
		base_ot_odd, base_ot_even, harmslope_odd, harmslope_even, harmvol_odd, harmvol_even,
		root_sine, base_sines_odd, base_sines_even,
		d2_ot_odd, d2_ot_even, d2_sines_odd, d2_sines_even,
		d3_ot_odd, d3_ot_even, d3_sines_odd, d3_sines_even,
		mix_base,
		tan_12_odd, tan_12_even, tan_13_odd, tan_13_even, tan_23_odd, tan_23_even,
		tan_12_sines_odd, tan_12_sines_even, tan_13_sines_odd, tan_13_sines_even, tan_23_sines_odd, tan_23_sines_even,
		mix_tan,
		oblique_ot_odd, oblique_ot_even, oblique_sines_odd, oblique_sines_even,
		mix_oblique,
		mix, adsr;


	var macro_controls = Lag.kr(
		In.kr(
				~modes_synth_1_controlbus ?? {~modes_synth_1_controlbus = Bus.control(Server.default, 4)},
			4),
		0.1);

	var macro_1 =  macro_controls[0],
		oddeven = macro_1.lincurve(0,1,0,1,0),
		slope_cntrl = 0.5;


	var macro_2 =  macro_controls[1],
		d3_dimension = macro_2.lincurve(0,1,1,2,0),
		d2_dimension = macro_2.lincurve(0,1,1,3.3,0);

	var macro_3 =  macro_controls[2],
		amp_r = macro_3.lincurve(0,1,0.1,2,-2),
		amp_d = amp_r,
		amp_s = macro_3.lincurve(0,0.8,0.8,0,-3);

	var fader =  macro_controls[3],
		vol = fader.lincurve(0,1,0,0.002,-7),
		vol_correct = 1;

	note_f = freq + SinOsc.ar(Rand(0.25,3),mul: (1-macro_1) * Rand(0.5,2));

	ot_num = 2;

	ot_odd = 2 * (1..ot_num) + 1;

	ot_even = 2 * (1..ot_num);

	base_ot_odd = note_f * ot_odd;

	base_ot_even = note_f * ot_even;

	harmslope_odd = LinLin.kr(slope_cntrl, 0, 1, 1, base_ot_odd);

	harmslope_even = LinLin.kr(slope_cntrl, 0, 1, 1, base_ot_odd);

	harmvol_odd = 1 - oddeven / base_ot_odd * harmslope_odd;

	harmvol_even = oddeven / base_ot_even * harmslope_even;

	root_sine = SinOsc.ar(note_f, 0, 1);

	base_sines_odd = SinOsc.ar(base_ot_even, 0, harmvol_even-0.5);

	base_sines_even = SinOsc.ar(base_ot_odd, 0, harmvol_odd-0.5);

	d2_ot_odd = base_ot_even * d2_dimension;

	d2_ot_even = base_ot_even * d2_dimension;

	d2_sines_odd = SinOsc.ar(d2_ot_odd, 0, harmvol_even-0.5);

	d2_sines_even = SinOsc.ar(d2_ot_even, 0, harmvol_odd-0.5);

	d3_ot_odd = base_ot_even * d3_dimension;

	d3_ot_even = base_ot_even * d3_dimension;

	d3_sines_odd = SinOsc.ar(d3_ot_odd, 0, harmvol_even-0.5);

	d3_sines_even = SinOsc.ar(d3_ot_even, 0, harmvol_odd-0.5);

	mix_base = root_sine + base_sines_odd + base_sines_even + d2_sines_odd + d2_sines_even + d3_sines_odd + d3_sines_even;

	tan_12_odd = base_ot_odd + d2_ot_odd;

	tan_12_even = base_ot_even + d2_ot_even;

	tan_12_sines_odd = SinOsc.ar(tan_12_odd, 0, harmvol_even-0.5);

	tan_12_sines_even = SinOsc.ar(tan_12_even, 0, harmvol_odd-0.5);

	tan_13_odd = base_ot_odd + d3_ot_odd;

	tan_13_even = base_ot_even + d3_ot_even;

	tan_13_sines_odd = SinOsc.ar(tan_13_odd, 0, harmvol_even-0.5);

	tan_13_sines_even = SinOsc.ar(tan_13_even, 0, harmvol_odd-0.5);

	tan_23_odd = d2_ot_odd + d3_ot_odd;

	tan_23_even = d2_ot_even + d3_ot_even;

	tan_23_sines_odd = SinOsc.ar(tan_23_odd, 0, harmvol_even-0.5);

	tan_23_sines_even = SinOsc.ar(tan_23_even, 0, harmvol_odd-0.5);

	mix_tan = tan_12_sines_odd + tan_12_sines_even + tan_13_sines_odd + tan_13_sines_even + tan_23_sines_odd + tan_23_sines_even;

	oblique_ot_odd = base_ot_odd + d2_ot_odd + d3_ot_odd;

	oblique_ot_even	= base_ot_even + d2_ot_even + d3_ot_even;

	oblique_sines_odd = SinOsc.ar(oblique_ot_odd, 0, harmvol_even-0.5);

	oblique_sines_even = SinOsc.ar(oblique_ot_even, 0, harmvol_odd-0.5);

	mix_oblique = oblique_sines_odd + oblique_sines_even;

	mix = mix_base + mix_tan + mix_oblique;

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
