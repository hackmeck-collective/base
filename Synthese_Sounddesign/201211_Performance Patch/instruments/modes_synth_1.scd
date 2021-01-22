(
SynthDef.new(\modes_synth_1,
	{
		arg gate = 1, amp_a = 0.001, amp_c = 2, freq,
		tangential_vol =0.75,
		oblique_vol = 1;

		var note_f,
		ot_num, ot,
		base,
		base_sines,
		tan_12, tan_13, tan_23,
		tan_sines,
		oblique, oblique_sines,
		envelope_base,
		envelope_tangentials,
		transient_envelope,
		mix,
		filter,
		adsr;


		var macro_controls = Lag.kr(
			In.kr(
				~modes_synth_1_controlbus ?? {~modes_synth_1_controlbus = Bus.control(Server.default, 4)},
				4),
			0.1);

		var macro_1 =  macro_controls[0],
		d2_dimension = macro_1.lincurve(0,1,1,2,0),
		d3_dimension = macro_1.lincurve(0,1,1.5,3.3,0);

		var macro_2 =  macro_controls[1],
		base_ot_vol = macro_2.lincurve(0,1,1,0.5,3),
		tan_ot_vol = macro_2.lincurve(0.25,1,0,1.3,3),
		oblique_ot_vol = macro_2.lincurve(0,1,0.25,0.5,3);

		var macro_3 =  macro_controls[2],
		amp_r = macro_3.lincurve(0,1,0.1,2,2),
		amp_d = amp_r,
		transient_decay = macro_3.lincurve(0,1,0.1,0.5,2),
		amp_s = macro_3.lincurve(0,0.8,0.8,0,-3);

		var fader =  macro_controls[3],
		vol = fader.lincurve(0,1,0,0.015,3),
		vol_correct = 0.3;

		note_f = freq + SinOsc.ar(Rand(0.25,3),mul: (1-macro_1) * Rand(0.5,2));

		ot_num = 2;

		ot = (1..ot_num);

		envelope_base = EnvGen.kr(
			Env.adsr(
				attackTime: amp_a,
				decayTime: amp_d,
				sustainLevel: amp_s,
				releaseTime: amp_r,
				curve: amp_c
			),
			gate: gate,
			doneAction:2);

		envelope_tangentials = EnvGen.kr(
			Env.adsr(
				attackTime: amp_a * 0.5,
				decayTime: amp_d * 0.5,
				sustainLevel: amp_s * 0.5,
				releaseTime: amp_r * 0.5,
				curve: amp_c
			),
			gate: gate,
			doneAction:2);

		transient_envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: transient_decay,
				curve: -4
			),
			gate: gate);

		base = note_f * ot;

		base_sines = envelope_base * (SinOsc.ar(base, 0, 2 * base_ot_vol * [1/ot]) + SinOsc.ar([base * d2_dimension, base * d3_dimension], 0, base_ot_vol * [1/ot]));

		tan_12 = base * (1 + d2_dimension);

		tan_13 = base * (1 + d3_dimension);

		tan_23 = base * (d2_dimension + d3_dimension);

		tan_sines = envelope_tangentials * tangential_vol * SinOsc.ar([tan_12, tan_13, tan_23], 0, tan_ot_vol *  [1/ot, 1/ot, 1/ot]);

		oblique = base * (1 + d2_dimension + d3_dimension);

		oblique_sines = transient_envelope * oblique_vol * SinOsc.ar(oblique, 0, oblique_ot_vol * [1/ot]);

		mix = base_sines + tan_sines + oblique_sines;

		adsr = mix.sum * vol * vol_correct;

		Out.ar(~melody_bus.index,adsr.dup(2));

}).add;
)
