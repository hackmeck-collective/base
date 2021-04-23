~pulsar_buffer_1 ?? {~pulsar_buffer_1 = Buffer.readChannel(s, thisProcess.nowExecutingPath.dirname +/+ "/buffer_data/Metall_2_5.wav", channels: [0])};
~grainCloudGuitar_buffer ?? {~grainCloudGuitar_buffer = Buffer.readChannel(s, thisProcess.nowExecutingPath.dirname +/+ "/buffer_data/Guitar_Note_A.wav", channels: [0])};
~grainCloudRecord_buffer ?? {~grainCloudRecord_buffer = Buffer.readChannel(s, thisProcess.nowExecutingPath.dirname +/+ "/buffer_data/Guitar_Note_A.wav", channels: [0])};

(
~oscillatorTypes = (
	noOscillator: {arg freq = 440,
		gate = 1,
		oscillator_mod_1 = 0,
		oscillator_mod_2 = 0;

		var sig;

		sig = 0;

	},

	basic: {arg freq = 440,
		gate = 1,
		oscillator_mod_1 = 0,
		oscillator_mod_2 = 0;

		var feedback = oscillator_mod_1,
		gain = oscillator_mod_2.lincurve(0,1,1,20,3,nil);

		Clip.ar(SinOscFB.ar(freq,feedback) * gain, -1, 1);

	},

	filteredNoise: {arg freq = 440,
		gate = 1,
		oscillator_mod_1 = 0,
		oscillator_mod_2 = 0;

		var rq = oscillator_mod_1.lincurve(0,1,0.0005,5,3,nil),
		gain = oscillator_mod_1.lincurve(0,1,135,0.75,3,nil);

		BPF.ar(PinkNoise.ar(), freq, rq, gain);

	},

	crackles: {arg freq = 440,
		gate = 1,
		oscillator_mod_1 = 0,
		oscillator_mod_2 = 0;

		var envelope = EnvGen.kr(
			Env.new(
				levels: [ 0, 1, 0 ],
				times: [ 0, oscillator_mod_2 ],
				curve: 'sin'
			),
			gate: Dust.ar(freq * oscillator_mod_1)
		);

		ClipNoise.ar(envelope);

	},

	fm: {arg freq = 440,
		gate = 1,
		oscillator_mod_1 = 0,
		oscillator_mod_2 = 0;

		var amount = freq * oscillator_mod_1,
		ratio = freq * oscillator_mod_2;

		SinOsc.ar(freq + SinOsc.ar(ratio,Rand(),amount));
	},

	fmScaled: {arg freq = 440,
		gate = 1,
		oscillator_mod_1 = 0,
		oscillator_mod_2 = 0;

		var amount = freq * oscillator_mod_1.lincurve(0,1,0,20,3,nil),
		ratio = freq * oscillator_mod_2.lincurve(0,1,1,5,3,nil);

		SinOsc.ar(freq + SinOsc.ar(ratio,Rand(),amount));
	},

	formant: {arg freq = 440,
		gate = 1,
		oscillator_mod_1 = 0,
		oscillator_mod_2 = 0;

		var formantFrequency = freq * oscillator_mod_1.lincurve(0,1,1,64,3,nil),
		bandwidth = (formantFrequency - freq) * oscillator_mod_2.lincurve(0,1,1,64,3,nil);

		Formant.ar(freq, formantFrequency, bandwidth);

	},

	pulsar: {arg freq = 440,
		gate = 1,
		oscillator_mod_1 = 0,
		oscillator_mod_2 = 0,
		grain_position = 0.5;
		var grain_rate = oscillator_mod_1.lincurve(0,1,0.25,4,0,nil),
		grain_length_ratio = oscillator_mod_2.lincurve(0,1,1,0.1,0,nil);

		GrainBuf.ar(
			1,
			Impulse.ar(freq),
			(1/freq) * grain_length_ratio,
			~pulsar_buffer_1,
			grain_rate,
			grain_position,
			4,
			0,
			-1,
			8,
			16
		);
	},

	grainCloudGuitar: {arg freq = 440,
		gate = 1,
		oscillator_mod_1 = 0,
		oscillator_mod_2 = 0;

		var grain_density = oscillator_mod_1.lincurve(0,1,1,10,3,nil),
		grain_rate = (freq.cpsmidi-69).midiratio * 15.midiratio,
		grain_length_ratio = (2/grain_density) * oscillator_mod_2.lincurve(0,1,2,0.1,3,nil);

		var grain_trigger, grain_position;

		grain_trigger = Dust.ar(grain_density);
		grain_position = 0.1 + Latch.ar(WhiteNoise.ar().abs/2,grain_trigger);

		GrainBuf.ar(
			1,
			grain_trigger,
			grain_length_ratio,
			~grainCloudGuitar_buffer,
			grain_rate,
			grain_position,
			4,
			Latch.ar(WhiteNoise.ar(),grain_trigger),
			-1,
			16,
			0.5
		);
	},

	/*grainCloudGuitar: {arg freq = 440,
	gate = 1,
	oscillator_mod_1 = 0,
	oscillator_mod_2 = 0;

	var grain_density = oscillator_mod_1.lincurve(0,1,1,10,3),
	grain_rate = (freq.cpsmidi-69).midiratio * 15.midiratio,
	grain_length_ratio = (2/grain_density) * oscillator_mod_2.lincurve(0,1,2,0.1,3);

	var grain_trigger, grain_position;

	grain_trigger = Dust.ar(grain_density);
	grain_position = 0.1 + Latch.ar(WhiteNoise.ar().abs/2,grain_trigger);

	GrainBuf.ar(
	1,
	grain_trigger,
	grain_length_ratio,
	~grainCloudRecord_buffer,
	grain_rate,
	grain_position,
	4,
	Latch.ar(WhiteNoise.ar(),grain_trigger),
	-1,
	16,
	0.5
	);
	},*/

	modal: {arg freq = 440,
		gate = 1,
		oscillator_mod_1 = 0,
		oscillator_mod_2 = 0,
		harmonics_array = (1..3);

		var d2_dimension = oscillator_mod_1.lincurve(0,1,1.5,2,0,nil),
		d3_dimension = oscillator_mod_1.lincurve(0,1,1,3.3,0,nil),
		tan_ot_vol = oscillator_mod_2.lincurve(0,1,0.01,0.5,3,nil),
		oblique_ot_vol = oscillator_mod_2.lincurve(0,1,0.25,0.5,3,nil),
		amp_r = oscillator_mod_2.lincurve(0,1,0.05,1,3,nil);

		var tan_env, obl_env, overtones_array, d1, d2, d3, tan12, tan13, tan23, oblique,
		axial_modes, tangential_modes, oblique_modes;

		tan_env = EnvGen.kr(
			Env.perc(
				attackTime: 0.1,
				releaseTime: (amp_r * 2),
				curve: -4,
			),
			gate: gate);

		obl_env = EnvGen.kr(
			Env.perc(
				attackTime: 0.01,
				releaseTime: amp_r,
				curve: -4,
			),
			gate: gate);

		d1 = freq * harmonics_array;
		d2 = d1 * d2_dimension;
		d3 = d1 * d3_dimension;

		tan12 = d1 + d2;
		tan13 = d1 + d3;
		tan23 = d2 + d3;

		oblique = d1 + d2 + d3;

		axial_modes = SinOsc.ar([d1, d2, d3], Rand(), 1/harmonics_array);
		tangential_modes = SinOsc.ar([tan12, tan13, tan23], Rand(), tan_ot_vol * 1/harmonics_array);
		oblique_modes = SinOsc.ar(oblique, Rand(), oblique_ot_vol * 1/harmonics_array);

		Splay.ar([axial_modes,
			tangential_modes,
			oblique_modes]);

	},

	ping: {arg freq = 440,
		gate = 1,
		oscillator_mod_1 = 0,
		oscillator_mod_2 = 0;

		var sig;

		sig = LeakDC.ar(
			EnvGen.ar(
				Env.perc(0, 0.02, 2, 0),
				gate) - 1,
		);
	},

);
);

"oscillators: ".post;
~oscillatorTypes.keys.postln;