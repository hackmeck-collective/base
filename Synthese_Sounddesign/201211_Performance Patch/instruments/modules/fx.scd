~overdrive_fuction_1 ?? {
	~overdrive_fuction_1 = Env([-0.999,0,0.999],[1,1],[2,-2]).asSignal(8193);
	~overdrive_fuction_1 = ~overdrive_fuction_1.asWavetableNoWrap;};
~overdrive_fuction_1_buf ?? ~overdrive_fuction_1_buf = Buffer.loadCollection(s, ~overdrive_fuction_1);

(
~fxTypes = (
	overdrive: {arg in, gate, freq = 440, fx_mod_1 = 0, fx_mod_2 = 0;

		var overdrive = fx_mod_1.lincurve(0,1,1,20,3);

		Shaper.ar(~overdrive_fuction_1_buf, in * overdrive);
	},

	fold: {arg in, gate, freq = 440, fx_mod_1 = 0, fx_mod_2 = 0;

		var gain = fx_mod_1.lincurve(0,1,1,10,3);

		Fold.ar(in * gain, -0.999, 0.999);
	},

	wrap: {arg in, gate, freq = 440, fx_mod_1 = 0, fx_mod_2 = 0;

		var gain = fx_mod_1.lincurve(0,1,1,7,3);

		Wrap.ar(in * gain, -0.999, 0.999);
	},
);
)



