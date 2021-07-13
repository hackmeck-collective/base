Pdef(\simpleSwitchDevelopement_1_x_triangle,
	Pspawner({ |sp|
		~lsys[\simpleSwitch_gen0].noteOffset = 0;
		~lsys[\simpleSwitch_gen1].noteOffset = 0;

		~lsys[\simpleSwitch].noteOffset = 10;
		~lsys[\simpleSwitch].ctranspose = 0;
		~lsys[\simpleSwitch_dev2].noteOffset = 12;
		~lsys[\simpleSwitch_dev2].branchInterval = -7;
		~lsys[\simpleSwitch_dev2].ctranspose = 0;
		~lsys[\simpleSwitch_dev3].noteOffset = 14;
		~lsys[\simpleSwitch_dev3].branchInterval = -7;
		~lsys[\simpleSwitch_dev3].ctranspose = 0;
		~lsys[\simpleSwitch_gen1].noteOffset = 16;
		~lsys[\simpleSwitch_gen0].noteOffset = 16;
		~lsys[\simpleSwitch_gen0].ctranspose = 0;
		~lsys[\simpleSwitch_gen4].ctranspose = 0;
		~lsys[\simpleSwitch_dev4].noteOffset = 14;
		~lsys[\simpleSwitch_dev4].branchInterval = 7;

		~lsys[\fraktal_12].putAll(~gui.lsysColorsAndTheta.triangle);
		~lsys[\fraktal_13].putAll(~gui.lsysColorsAndTheta.triangle);
		~lsys[\fraktal_14].putAll(~gui.lsysColorsAndTheta.triangle);
		~lsys[\fraktal_15].putAll(~gui.lsysColorsAndTheta.triangle);
		~lsys[\fraktal_16].putAll(~gui.lsysColorsAndTheta.triangle);
		~lsys[\fraktal_17].putAll(~gui.lsysColorsAndTheta.triangle);
		~lsys[\fraktal_1_inverse7].putAll(~gui.lsysColorsAndTheta.triangle);
		~lsys[\fuge_excerpt_gen0].putAll(~gui.lsysColorsAndTheta.fuge);
		~lsys[\fuge_excerpt2_gen0].putAll(~gui.lsysColorsAndTheta.fuge);
		~lsys[\simpleSwitch_dev4].putAll(~gui.lsysColorsAndTheta.simpleSwitch);

		"ss_dev_1_x_triangle".postln;
		~cueSymbols[\new] = 'ss_dev_1_x_triangle';


		~pitchesRootDissonance[\pitches] = (36, 38 .. 96);

		sp.seq(
			Pbind(\amp, 6.dbamp,
				\oscillator_1_mod_1, 2,
				\oscillator_2_mod_1, 0.5,
			)
			<> ~fugeInstrState_0.(
				inputPattern: Pseq([
					Pn(Pdef(\fuge_excerpt_gen2), 2),
					Pn(Pdef(\fuge_excerpt_gen1), 4),
					Pn(Pdef(\fuge_excerpt_gen0), 8),
				])
		));

		sp.seq(~fugeInstrState_3.( //modem styles legato runter
			Pseq([
				Pn(Pdef(\fuge_excerpt2_gen0), 13),
		]));
		);

		"ss1".postln;

		/*soundCue = "Fraktal_1: 0 -> 0.5; SimpleSwitch: 1 -> 0.5"
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlKnobLEDsSetRow.([3,4],1);
		~launchControlXlUpdateKnobLEDs.value;*/

		sp.par(
			Pspawner({ |sp2|
				sp2.wait(6.25);
				sp2.seq(~fraktal_1_InstrState_1.(
					inputPattern: Pdef(\fraktal_12))
				);
			})
		);

		sp.par(
			Pbind(\dur, Rest(0.025), \setDetune, Pfunc {|in|
				~lsys[\simpleSwitch].ctranspose = in
			} <> Plazy{Pseg([0,0,~calcIntervalBetweenNoteOffsets.(\simpleSwitch_dev2,\simpleSwitch) + 0.5],[4,2.5],1)});
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
		sp.par(
			Pbind(\dur, Rest(0.1), \setDetune, Pfunc {|in|
				~lsys[\simpleSwitch_dev2].ctranspose = in
			} <> Plazy{Pseg([0,0,~calcIntervalBetweenNoteOffsets.(\simpleSwitch_dev3,\simpleSwitch_dev2) + 0.5],[8,2],1)});
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
		sp.par(
			Pbind(\dur, Rest(0.1), \setDetune, Pfunc {|in|
				~lsys[\simpleSwitch_dev3].ctranspose = in
			} <> Plazy{Pseg([0,0,~calcIntervalBetweenNoteOffsets.(\simpleSwitch_gen1, \simpleSwitch_dev3) + 0.5],[8,2.25],1)});
		);
		sp.seq(~simpleSwitchInstrState_4.(
			inputPattern: Pn(Pdef(\simpleSwitch_dev3), 2)));

		~lsys[\simpleSwitch_gen1].baseTempo = 1/8;
		~lsys[\simpleSwitch_gen0].baseTempo = 1/8;


		~cueSymbols[\new] = 'fraktal_1_half';

		/*soundCue = "Fraktal_1: 0.5 -> 1;"
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlKnobLEDsSetRow.(4,1);
		~launchControlXlUpdateKnobLEDs.value;*/

		sp.seq(~simpleSwitchInstrState_4.(
			inputPattern: Pn(Pdef(\simpleSwitch_gen1), 8))
		);

		sp.par(
			Pbind(\dur, Rest(0.1), \setDetune, Pfunc {|in|
				~lsys[\simpleSwitch_gen0].ctranspose = in
			} <> Plazy{Pseg([0,~calcIntervalBetweenNoteOffsets.(\simpleSwitch_gen0, \simpleSwitch_dev4) + 0.5],[4],1)});
		);
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(3.25);
				sp2.seq(~fraktal_1_InstrState_1.(
					inputPattern: Pdef(\fraktal_13))
				);
			})
		);


		~cueSymbols[\new] = 'simpleSwitch_fadeOut';

		/*soundCue = "SimpleSwitch: 0.5 -> 0"
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlKnobLEDsSetRow.(3,1);
		~launchControlXlUpdateKnobLEDs.value;*/

		sp.seq(~simpleSwitchInstrState_4.(
			inputPattern: Pn(Pdef(\simpleSwitch_gen0), 32))
		);

		"ss5".postln;

		~lsys[\simpleSwitch_dev4].vols = [1, 1, 1, 1, 1, 1];

		sp.seq(~simpleSwitchInstrState_6.(
			inputPattern: Pdef(\simpleSwitch_dev4))
		);
	})
)