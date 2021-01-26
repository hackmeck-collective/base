(
~adsrTypes.keysValuesDo{
	arg adsrType, envelope_function;

	var synthDefName = "fm_vib_" ++ adsrType.asString;

	(SynthDef.new(synthDefName,
		{
			arg gate = 1, freq;

			var mod1_ratio = 2;

			var macro_controls = Lag.kr(
				In.kr(
					~fm_vib_controlbus ?? {~fm_vib_controlbus = Bus.control(Server.default, 4)},
					4),
				0.1);

			var macro_1 = macro_controls[0],
			vib_f = 0.7 + macro_1.linlin(0,0.5,0,6) + macro_1.lincurve(0.4,1,0,7,3),
			vib_w = 0.005 + macro_1.lincurve(0,0.5,0,0.01,-4) + macro_1.lincurve(0.5,1,0,0.5,1),
			mod1_amp = macro_1.lincurve(0,0.5,0,2,-3) + macro_1.lincurve(0,1,0,3,1),
			filter_ratio = 0.5 + (5 * macro_1),
			filter_f = 2000 + macro_1.lincurve(0,1,0,2000,-2),
			overdrive_amount = macro_1.lincurve(0,1,0,5,-3) + macro_1.lincurve(0.5,1,0,95,10),
			fundamental = 0.5 + macro_1.lincurve(0,1,0,0.5,1),
			vol_correct =  1 + macro_1.lincurve(0,1,0,-0.35,2);

			var macro_2 = macro_controls[1] - macro_1.lincurve(0.2,1,0,0.9,3),
			rng_trans = macro_2.lincurve(0,1,0,0.02,-2),
			pitch_env_amount =  macro_2.linlin(0,1,0,-1),
			pitch_env_time = 0.0 + (0.5 * macro_2),
			noise_amt = macro_2.lincurve(0,1,0,1000,-2),
			drift_amt = macro_2.lincurve(0,1,0,0.0075,-2);

			var macro_3 = macro_controls[2];

			var fader = macro_controls[3],
			vol = fader.lincurve(0,1,0,0.01,3);

			var carrier_f, pitch_env, vibrato, mod1_f, modulator1, drift, noise, carrier, filter, overdrive, envelope, amp;

			vib_w = vib_w - macro_2.lincurve(0.5,1,0,0.0075);

			carrier_f = freq;

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

			envelope = SynthDef.wrap(
				envelope_function,
				prependArgs: [gate, macro_3],
			);

			amp = vol * vol_correct * overdrive * envelope;

			Out.ar(~chords_bus,Clip.ar(tan(amp),-0.99, 0.99));

			synthDefName.post;
			" loaded".postln;

	}).add;
	);
};
)
