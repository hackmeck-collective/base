Pdef(\simpleSwitchDevelopement_1,
	Pspawner({ |sp|

		/*~lsys[\simpleSwitch].noteOffset = 14;
		~lsys[\simpleSwitch_dev2].noteOffset = 7;
		~lsys[\simpleSwitch_dev3].noteOffset = 3;
		~lsys[\simpleSwitch_gen1].noteOffset = 14;
		~lsys[\simpleSwitch_gen0].noteOffset = 21;
		~lsys[\simpleSwitch_dev4].noteOffset = 0;*/

		~lsys[\simpleSwitch].putAll(~gui.lsysColorsAndTheta.simpleSwitch);
		~lsys[\simpleSwitch_dev2].putAll(~gui.lsysColorsAndTheta.simpleSwitch);
		~lsys[\simpleSwitch_dev3].putAll(~gui.lsysColorsAndTheta.simpleSwitch);
		~lsys[\simpleSwitch_dev4].putAll(~gui.lsysColorsAndTheta.simpleSwitch);
		~lsys[\simpleSwitch_gen0].putAll(~gui.lsysColorsAndTheta.simpleSwitch);
		~lsys[\simpleSwitch_gen1].putAll(~gui.lsysColorsAndTheta.simpleSwitch);

		~lsys[\simpleSwitch].noteOffset = 14;
		~lsys[\simpleSwitch].ctranspose = 0;
		~lsys[\simpleSwitch_dev2].noteOffset = 13;
		~lsys[\simpleSwitch_dev2].branchInterval = -7;
		~lsys[\simpleSwitch_dev2].ctranspose = 0;
		~lsys[\simpleSwitch_dev3].noteOffset = 12;
		~lsys[\simpleSwitch_dev3].branchInterval = -7;
		~lsys[\simpleSwitch_dev3].ctranspose = 0;
		~lsys[\simpleSwitch_gen1].noteOffset = 11;
		~lsys[\simpleSwitch_gen0].noteOffset = 11;
		~lsys[\simpleSwitch_gen0].ctranspose = 0;
		~lsys[\simpleSwitch_gen4].ctranspose = 0;
		~lsys[\simpleSwitch_dev4].noteOffset = 20;
		~lsys[\simpleSwitch_dev4].branchInterval = -7;

		"ss_dev_1".postln;
		~cueSymbols[\new] = 'ss_dev_1';

		"ss1".postln;

		/*soundCue = "SimpleSwitch: 1 -> 0.5"
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlKnobLEDsSetRow.([3],1);
		~launchControlXlUpdateKnobLEDs.value;*/

		sp.par(
			Pbind(\dur, Rest(0.025), \setDetune, Pfunc {|in|
				~lsys[\simpleSwitch].ctranspose = in
			} <> Plazy{Pseg([0,0,~calcIntervalBetweenNoteOffsets.(\simpleSwitch_dev2,\simpleSwitch) - 0.5 ],[4,2.5],3)});
		);
		sp.seq(~simpleSwitchInstrState_4.(
			inputPattern: Pn(Pdef(\simpleSwitch), 4)));

		"ss2".postln;

		~cueSymbols[\new] = 'ss_dev_1b';

		sp.par(
			Pbind(\dur, Rest(0.1), \setDetune, Pfunc {|in|
				~lsys[\simpleSwitch_dev2].ctranspose = in
			} <> Plazy{Pseg([0,0,~calcIntervalBetweenNoteOffsets.(\simpleSwitch_dev3,\simpleSwitch_dev2) - 0.5 ],[8,2],3)});
		);
		sp.seq(~simpleSwitchInstrState_4.(
			inputPattern: Pn(Pdef(\simpleSwitch_dev2), 2)));

		"ss3".postln;

		~cueSymbols[\new] = 'ss_dev_1c';

		sp.par(
			Pbind(\dur, Rest(0.1), \setDetune, Pfunc {|in|
				~lsys[\simpleSwitch_dev3].ctranspose = in
			} <> Plazy{Pseg([0,0,~calcIntervalBetweenNoteOffsets.(\simpleSwitch_gen1,\simpleSwitch_dev3) - 0.5 ],[6,4.25],3)});
		);
		sp.seq(~simpleSwitchInstrState_4.(
			inputPattern: Pn(Pdef(\simpleSwitch_dev3), 2)));

		~lsys[\simpleSwitch_gen1].baseTempo = 1/8;
		~lsys[\simpleSwitch_gen0].baseTempo = 1/8;

		~cueSymbols[\new] = 'ss_dev_1d';

		sp.seq(~simpleSwitchInstrState_4.(
			inputPattern: Pn(Pdef(\simpleSwitch_gen1), 8))
		);

		sp.par(
			Pbind(\dur, Rest(0.1), \setDetune, Pfunc {|in|
				~lsys[\simpleSwitch_gen0].ctranspose = in
			} <> Plazy{Pseg([0,~calcIntervalBetweenNoteOffsets.(\simpleSwitch_dev4,\simpleSwitch_gen0) - 0.5 ],[4],3)});
		);


		~cueSymbols[\new] = 'ss_dev_1_roll';
		sp.seq(~simpleSwitchInstrState_4.(
			inputPattern: Pn(Pdef(\simpleSwitch_gen0), 32))
		);

		"ss5".postln;

		~lsys[\simpleSwitch_dev4].vols = [1, 1, 1, 1, 1, 1];

		sp.seq(~simpleSwitchInstrState_4b.(
			inputPattern: Pdef(\simpleSwitch_dev4))
		);



		// s.sendMsg("/g_freeAll", ~routing[\sourceGroup]);

	})
)