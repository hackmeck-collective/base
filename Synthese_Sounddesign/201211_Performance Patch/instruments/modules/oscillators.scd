~pulsar_buffer_1 ?? {~pulsar_buffer_1 = Buffer.readChannel(s, thisProcess.nowExecutingPath.dirname +/+ "/buffer_data/Metall_2_5.wav", channels: [0])};

(
~oscillatorTypes = (
	sine: {arg freq = 440, oscillator_mod_1 = 0;

		SinOsc.ar(freq);
	},

	saw: {arg freq = 440, oscillator_mod_1 = 0;

		Saw.ar(freq);
	},

	rect: {arg freq = 440, oscillator_mod_1 = 0.5;
		var pulsewidth = oscillator_mod_1.lincurve(0,1,0.5,0.01,3);

		Pulse.ar(freq, pulsewidth);
	},

	pulsar: {arg freq = 440, oscillator_mod_1 = 0, oscillator_mod_2 = 1,
		grain_position = 0.5;
		var grain_rate = oscillator_mod_1.lincurve(0,1,0.25,4,0),
		grain_length_ratio = oscillator_mod_2.lincurve(0,1,1,0,0);

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
			8
		);
	},
);
)
