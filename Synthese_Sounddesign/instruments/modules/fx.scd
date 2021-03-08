~overdrive_fuction_1 ?? {
	~overdrive_fuction_1 = Env([-0.999,0,0.999],[1,1],[2,-2]).asSignal(8193);
	~overdrive_fuction_1 = ~overdrive_fuction_1.asWavetableNoWrap;};
~overdrive_fuction_1_buf ?? ~overdrive_fuction_1_buf = Buffer.loadCollection(s, ~overdrive_fuction_1);

~overdrive_fuction_2 ?? {
	~overdrive_fuction_2 = Env([-0.999,0,0.999],[1,1],[16,-16]).asSignal(8193);
~overdrive_fuction_2 = ~overdrive_fuction_2.asWavetableNoWrap;};
~overdrive_fuction_2_buf ?? ~overdrive_fuction_2_buf = Buffer.loadCollection(s, ~overdrive_fuction_2);

~overdrive_fuction_3 ?? {
	~overdrive_fuction_3 = Env([-0.999,0,0.999],[1,1],[32,-32]).asSignal(8193);
~overdrive_fuction_3 = ~overdrive_fuction_3.asWavetableNoWrap;};
~overdrive_fuction_3_buf ?? ~overdrive_fuction_3_buf = Buffer.loadCollection(s, ~overdrive_fuction_3);

(
~fxTypes = (

	overdriveSoft: {arg in, gate, freq = 440, fx_mod_1, fx_mod_2;

		var overdrive = fx_mod_1.lincurve(0,1,1,20,3);

		Shaper.ar(~overdrive_fuction_1_buf, in * overdrive);
	},

	shelvedOverdriveSoft: {arg in, gate, freq = 440, fx_mod_1, fx_mod_2;

		var overdrive = fx_mod_1.lincurve(0,1,1,20,3),
		shelving = fx_mod_2.lincurve(0,1,-6,6,0);

		in = BLowShelf.ar(in, freq * 3, db: shelving);
		in = BHiShelf.ar(in, freq * 3, db: shelving.neg);
		in = Shaper.ar(~overdrive_fuction_1_buf, in * overdrive);
		in = BLowShelf.ar(in, freq * 3, db: shelving.neg);
		in = BHiShelf.ar(in, freq * 3, db: shelving);
	},

	overdriveMid: {arg in, gate, freq = 440, fx_mod_1 = 0, fx_mod_2 = 0;

		var overdrive = fx_mod_1.lincurve(0,1,1,20,3);

		Shaper.ar(~overdrive_fuction_2_buf, in * overdrive);
	},

	shelvedOverdriveMid: {arg in, gate, freq = 440, fx_mod_1 = 0, fx_mod_2 = 0;

		var overdrive = fx_mod_1.lincurve(0,1,1,20,3),
		shelving = fx_mod_2.lincurve(0,1,-6,6,0);

		in = BLowShelf.ar(in, freq * 3, db: shelving);
		in = BHiShelf.ar(in, freq * 3, db: shelving.neg);
		in = Shaper.ar(~overdrive_fuction_2_buf, in * overdrive);
		in = BLowShelf.ar(in, freq * 3, db: shelving.neg);
		in = BHiShelf.ar(in, freq * 3, db: shelving);
	},

	overdriveHard: {arg in, gate, freq = 440, fx_mod_1 = 0, fx_mod_2 = 0;

		var overdrive = fx_mod_1.lincurve(0,1,1,20,3);

		Shaper.ar(~overdrive_fuction_3_buf, in * overdrive);
	},

	shelvedOverdriveHard: {arg in, gate, freq = 440, fx_mod_1 = 0, fx_mod_2 = 0;

		var overdrive = fx_mod_1.lincurve(0,1,1,20,3),
		shelving = fx_mod_2.lincurve(0,1,-6,6,0);

		in = BLowShelf.ar(in, freq * 3, db: shelving);
		in = BHiShelf.ar(in, freq * 3, db: shelving.neg);
		in = Shaper.ar(~overdrive_fuction_3_buf, in * overdrive);
		in = BLowShelf.ar(in, freq * 3, db: shelving.neg);
		in = BHiShelf.ar(in, freq * 3, db: shelving);
	},

	rectifier: {arg in, gate, freq = 440, fx_mod_1 = 0, fx_mod_2 = 0;

		var offset = fx_mod_1.lincurve(0,1,-1,1,0);

		in = Fold.ar(in + offset, -1, 1);

		LeakDC.ar(in.abs);
	},

	fold: {arg in, gate, freq = 440, fx_mod_1 = 0, fx_mod_2 = 0;

		var gain = fx_mod_1.lincurve(0,1,1,10,3);

		Fold.ar(in * gain, -0.999, 0.999);
	},

	wrap: {arg in, gate, freq = 440, fx_mod_1 = 0, fx_mod_2 = 0;

		var gain = fx_mod_1.lincurve(0,1,1,7,3);

		Wrap.ar(in * gain, -0.999, 0.999);
	},

	sampleRateReduction: {arg in, gate, freq = 440, fx_mod_1 = 0, fx_mod_2 = 0;

		var sample_rate_ratio = fx_mod_1.lincurve(0,1,1,64,3);

		BHiPass.ar(
			Latch.ar(
				in, Impulse.ar(freq * sample_rate_ratio)
		), freq * 0.5);
	},

	noFx: {arg in;

		in;
	},
);
);



"fx: ".post;
~fxTypes.keys.postln;


