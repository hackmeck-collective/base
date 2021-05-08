~pulsar_buffer_1 ?? {~pulsar_buffer_1 = Buffer.readChannel(s, thisProcess.nowExecutingPath.dirname +/+ "/buffer_data/Metall_2_5.wav", channels: [0])};
~grainCloudGuitar_buffer ?? {~grainCloudGuitar_buffer = Buffer.readChannel(s, thisProcess.nowExecutingPath.dirname +/+ "/buffer_data/Guitar_Note_A.wav", channels: [0])};
~grainCloudRecord_buffer ?? {~grainCloudRecord_buffer = Buffer.readChannel(s, thisProcess.nowExecutingPath.dirname +/+ "/buffer_data/Guitar_Note_A.wav", channels: [0])};

(
~oscillatorTypesShortcuts = (
	noOscillator: "no",
	basic: "ba",
	filteredNoise: "fn",
	crackles: "cr",
	fm: "fm",
	fmScaled: "fs",
	formant: "fo",
	pulsar: "pu",
	modal: "mo",
	ping: "pi",
	granulator: "gr",
	beatRepeat: "br",
);

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

	modal: {arg freq = 440,
		gate = 1,
		oscillator_mod_1 = 0,
		oscillator_mod_2 = 0;

		var harmonics_array = (1..3),
		d2_dimension = oscillator_mod_1.lincurve(0,1,1.5,2,0,nil),
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

	granulator: {arg freq = 440,
		gate = 1,
		oscillator_mod_1 = 0,
		oscillator_mod_2 = 0,
		oscillator_mod_3 = 0,
		oscillator_mod_4 = 0,
		buf = ~grainDelayBuffer_1,
		bufPosBus = ~grainDelayBufferPosition_1;

		var grain_density = oscillator_mod_1,
		grain_length = min(oscillator_mod_2.clip(0.01,10), (grain_density.reciprocal * 1.7)),
		grain_pitch = oscillator_mod_3;

		var bufPos, grain_position, grain_trigger, grainPan;

		bufPos = In.ar(bufPosBus);
		grain_position = ((oscillator_mod_4 + (BufFrames.ir(buf) / bufPos)) % 1);
		grain_trigger = Dust.ar(grain_density);
		grainPan = Latch.ar(WhiteNoise.ar(),grain_trigger);

		GrainBuf.ar(
			buf.numChannels,
			grain_trigger,
			grain_length,
			buf,
			grain_pitch,
			grain_position,
			2,
			grainPan,
			-1,
			512,
			2
		);
	},

	beatRepeat: {
		arg freq = 440,
		gate = 1,
		oscillator_mod_1 = 0,
		oscillator_mod_2 = 0,
		oscillator_mod_3 = 0,
		oscillator_mod_4 = 0,
		buf = ~beatRepeatBuffer_1.index,
		bufPosBus = ~beatRepeatBufferPosition_1.index;

		var bufPos, playFreq, pitchTrig, playRangeStart, playRangeEnd,
		env, ptr, sig;

		var start = oscillator_mod_1.clip(1/512,(BufFrames.ir(buf)/SampleRate.ir)),
		rate = oscillator_mod_2.clip(1/512,(BufFrames.ir(buf)/SampleRate.ir)),
		pitch = oscillator_mod_3.clip(1/8,8);

		bufPos = In.ar(bufPosBus);
		playFreq = (BufDur.ir(buf) * rate).reciprocal;
		pitchTrig = Impulse.ar(playFreq);
		ptr = LFSaw.ar(playFreq);

		playRangeStart = Latch.kr((bufPos - (BufFrames.ir(buf) * start)), Impulse.ar(0));
		playRangeEnd = playRangeStart + ((BufFrames.ir(buf) * rate) * Gate.ar(pitch, pitchTrig));

		ptr = ptr.range(playRangeStart, playRangeEnd);

		sig = BufRd.ar(2, buf, ptr);
	}

);
);

"oscillators: ".post;
~oscillatorTypes.keys.postln;