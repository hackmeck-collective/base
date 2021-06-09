Pdef(\simpleSwitchDevelopement,
	Pspawner({ |sp|
		"ss1".postln;
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(6.25);
				sp2.seq(Pdef(\fraktal_12));
			})
		);
		sp.seq(Pn(Pdef(\simpleSwitch), 4));
		"ss2".postln;
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(9.75);
				sp2.seq(Pdef(\fraktal_12));
			})
		);
		sp.seq(Pn(Pdef(\simpleSwitch_dev2), 2));
		"ss3".postln;
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(9.5);
				sp2.seq(Pdef(\fraktal_13));
			})
		);
		sp.seq(Pn(Pdef(\simpleSwitch_dev3), 2));
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(3.75);
				sp2.seq(Pdef(\fraktal_12));
			})
		);
		sp.seq(Pn(Pdef(\simpleSwitch_gen1), 8));
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(3.25);
				sp2.seq(Pdef(\fraktal_13));
			})
		);
		sp.seq(Pn(Pdef(\simpleSwitch_gen0), 32));
		"ss5".postln;
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(15);
				sp2.seq(Pdef(\triangle_develope));
			})
		);
		sp.seq(Pdef(\simpleSwitch_dev4));
		~lsys.presets.simpleSwitch_dev6.vols = [0, 0, 1, 1, 1, 1];
		~lsys.presets.simpleSwitch_dev6.stutterVal = Pseq([1,1,2],inf);
		sp.par(
			Pbind(\dur, Rest(0.1), \x, Pfunc { |in|
				~lsys.presets.simpleSwitch_dev6.vols[0] = in;
				~lsys.presets.simpleSwitch_dev6.vols[1] = in;
				0 } <> Pseg([0,0,1,0],[18,12,8],-3)
			)
		);
		"ss6".postln;
		sp.seq(Pdef(\simpleSwitch_dev6));
	})
)