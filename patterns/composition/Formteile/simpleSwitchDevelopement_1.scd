Pdef(\simpleSwitchDevelopement_1,
	Pspawner({ |sp|

		~lsys[\simpleSwitch].noteOffset = 14;
		~lsys[\simpleSwitch_dev2].noteOffset = 7;
		~lsys[\simpleSwitch_dev3].noteOffset = 3;
		~lsys[\simpleSwitch_gen1].noteOffset = 14;
		~lsys[\simpleSwitch_gen0].noteOffset = 21;
		~lsys[\simpleSwitch_dev4].noteOffset = 0;

		"ss_dev_1".postln;
		"ss1".postln;

		sp.seq(~simpleSwitchInstrState_4.(
			inputPattern: Pn(Pdef(\simpleSwitch), 4)));

		"ss2".postln;

		sp.seq(~simpleSwitchInstrState_4.(
			inputPattern: Pn(Pdef(\simpleSwitch_dev2), 2)));

		"ss3".postln;

		sp.seq(~simpleSwitchInstrState_4.(
			inputPattern: Pn(Pdef(\simpleSwitch_dev3), 2)));

		~lsys[\simpleSwitch_gen1].baseTempo = 1/8;
		~lsys[\simpleSwitch_gen0].baseTempo = 1/8;

		sp.seq(~simpleSwitchInstrState_4.(
			inputPattern: Pn(Pdef(\simpleSwitch_gen1), 8))
		);

		sp.seq(~simpleSwitchInstrState_4.(
			inputPattern: Pn(Pdef(\simpleSwitch_gen0), 32))
		);

		"ss5".postln;

		~lsys[\simpleSwitch_dev4].vols = [1, 1, 1, 1, 1, 1];

		sp.seq(~simpleSwitchInstrState_4.(
			inputPattern: Pdef(\simpleSwitch_dev4))
		);
	})
)