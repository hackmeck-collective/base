Pdef(\simpleSwitchDevelopement_1_x_triangle,
	Pspawner({ |sp|
		~lsys[\simpleSwitch_gen0].noteOffset = 0;
		~lsys[\simpleSwitch_gen1].noteOffset = 0;

"ss_dev_1".postln;
		"ss1".postln;
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(6.25);
				sp2.seq(~fraktal_1_InstrState_1.(
					inputPattern: Pdef(\fraktal_12))
				);
			})
		);
		sp.seq(~simpleSwitchInstrState_4.(
			inputPattern: Pn(Pdef(\simpleSwitch), 4)));

		"ss2".postln;
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(9.75);
				sp2.seq(~fraktal_1_InstrState_1.(
					inputPattern: Pdef(\fraktal_12))
				);
			})
		);
		sp.seq(~simpleSwitchInstrState_4.(
			inputPattern: Pn(Pdef(\simpleSwitch_dev2), 2)));

		"ss3".postln;
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(9.5);
				sp2.seq(~fraktal_1_InstrState_1.(
					inputPattern: Pdef(\fraktal_13))
				);
			})
		);
		sp.seq(~simpleSwitchInstrState_4.(
			inputPattern: Pn(Pdef(\simpleSwitch_dev3), 2)));

		~lsys[\simpleSwitch_gen1].baseTempo = 1/8;
		~lsys[\simpleSwitch_gen0].baseTempo = 1/8;

		sp.seq(~simpleSwitchInstrState_4.(
			inputPattern: Pn(Pdef(\simpleSwitch_gen1), 8))
		);

		sp.par(
			Pspawner({ |sp2|
				sp2.wait(3.25);
				sp2.seq(~fraktal_1_InstrState_1.(
					inputPattern: Pdef(\fraktal_13))
				);
			})
		);

		sp.seq(~simpleSwitchInstrState_4.(
			inputPattern: Pn(Pdef(\simpleSwitch_gen0), 32))
		);

		"ss5".postln;

		~lsys[\simpleSwitch_dev4].vols = [1, 1, 1, 1, 1, 1];

		sp.seq(~simpleSwitchInstrState_5.(
			inputPattern: Pdef(\simpleSwitch_dev4))
		);
	})
)