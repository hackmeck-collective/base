(
~filterTypes = (
	lpf_moog: {arg in, gate, freq = 440, filter_mod_1 = 0, filter_mod_2 = 0;

		var filter_freq = freq * filter_mod_1.lincurve(0,1,0.25,4,3),
		filter_resonance = filter_mod_2.lincurve(0,1,0,7,3);

		MoogFF.ar(in, filter_freq, filter_resonance);

	},

	/*lpf_12: {arg in, gate, freq = 440, filter_mod_1 = 0, filter_mod_2 = 0;

		var filter_freq = freq * filter_mod_1.lincurve(0,1,1,8,3),
		filter_resonance = filter_mod_2.lincurve(0,1,1,4,3);

		BLowPass.ar(in, filter_freq, filter_resonance) * filter_resonance;

	},

	lpf_24: {arg in, gate, freq = 440, filter_mod_1 = 0, filter_mod_2 = 0;

		var filter_freq = freq * filter_mod_1.lincurve(0,1,1,8,3),
		filter_resonance = filter_mod_2.lincurve(0,1,1,4,3);

		BLowPass4.ar(in, filter_freq, filter_resonance) * filter_resonance;

	},

	bpf:  {arg in, gate, freq = 440, filter_mod_1 = 0, filter_mod_2 = 0;

		var filter_freq = freq * filter_mod_1.lincurve(0,1,1,8,3),
		filter_resonance = filter_mod_2.lincurve(0,1,4,0.25,3);

		BBandPass.ar(in, filter_freq, filter_resonance);

	},

	notch:  {arg in, gate, freq = 440, filter_mod_1 = 0, filter_mod_2 = 0;

		var filter_freq = freq * filter_mod_1.lincurve(0,1,1,8,3),
		filter_resonance = filter_mod_2.lincurve(0,1,0.25,4,3);

		BBandStop.ar(in, filter_freq, filter_resonance);

	},

	hpf_12:  {arg in, gate, freq = 440, filter_mod_1 = 0, filter_mod_2 = 0;

		var filter_freq = freq * filter_mod_1.lincurve(0,1,1,8,3),
		filter_resonance = filter_mod_2.lincurve(0,1,1,4,3);

		BHiPass.ar(in, filter_freq, filter_resonance) * filter_resonance;

	},

	hpf_24:  {arg in, gate, freq = 440, filter_mod_1 = 0, filter_mod_2 = 0;

		var filter_freq = freq * filter_mod_1.lincurve(0,1,1,8,3),
		filter_resonance = filter_mod_2.lincurve(0,1,1,4,3);

		BHiPass4.ar(in, filter_freq, filter_resonance) * filter_resonance;

	},

	hi_shelf:  {arg in, gate, freq = 440, filter_mod_1 = 0, filter_mod_2 = 0;

		var filter_freq = freq * filter_mod_1.lincurve(0,1,1,8,3),
		filter_resonance = filter_mod_2.lincurve(0,1,1,2,3),
		db = filter_mod_2.lincurve(0,1,0,-12,3);

		BHiShelf.ar(in, filter_freq, filter_resonance, db);

	},

	lo_shelf:  {arg in, gate, freq = 440, filter_mod_1 = 0, filter_mod_2 = 0;

		var filter_freq = freq * filter_mod_1.lincurve(0,1,1,8,3),
		filter_resonance = filter_mod_2.lincurve(0,1,1,2,3),
		db = filter_mod_2.lincurve(0,1,0,-12,3);

		BLowShelf.ar(in, filter_freq, filter_resonance, db);
	},*/

	nofilter:  {arg in;

		in;
	},

);
);



"filter: ".post;
~filterTypes.keys.postln;


