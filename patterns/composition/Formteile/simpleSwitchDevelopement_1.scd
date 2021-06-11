Pdef(\simpleSwitchDevelopement_1,
	Pspawner({ |sp|
		~lsys[\presets].simpleSwitch_gen0.noteOffset = 0;
		~lsys[\presets].simpleSwitch_gen1.noteOffset = 0;
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
		~lsys[\presets].simpleSwitch_gen1.baseTempo = 1/8;
		~lsys[\presets].simpleSwitch_gen0.baseTempo = 1/8;
		sp.seq(Pn(Pdef(\simpleSwitch_gen1), 8));
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(3.25);
				sp2.seq(Pdef(\fraktal_13));
			})
		);
		sp.seq(Pn(Pdef(\simpleSwitch_gen0), 32));
		"ss5".postln;
		~lsys[\presets].simpleSwitch_dev4.vols = [1, 1, 1, 1, 1, 1];
		sp.seq(Pdef(\simpleSwitch_dev4));
	})
)