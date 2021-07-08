Pdef(\triangleDevelopement_1,
	Pspawner({|sp|
		var player1, player2, player3;

		var fraktalNoteOffset = -7;

		~lsys[\fraktal_12].noteOffset = fraktalNoteOffset;
		~lsys[\fraktal_13].noteOffset = fraktalNoteOffset;
		~lsys[\fraktal_14].noteOffset = fraktalNoteOffset;
		~lsys[\fraktal_15].noteOffset = fraktalNoteOffset;
		~lsys[\fraktal_16].noteOffset = fraktalNoteOffset;
		~lsys[\fraktal_17].noteOffset = fraktalNoteOffset;

		/*soundCue = "Fraktal_1: 0 -> 1;"
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlKnobLEDsSetRow.([4],1);
		~launchControlXlUpdateKnobLEDs.value;*/
		~cueSymbols[\new] = 'fraktal_12';

		~pitchesRootDissonance[\pitches] = (36, 38 .. 96);

		"fraktal_12".postln;
		[ 1, 2.125, 3.25, 4.375, 5.5, 6.625, 7.625, 8.875, 10.0].differentiate.do { |waitTime|
			sp.par(~fraktal_1_InstrState_1.(
				inputPattern: Pdef(\fraktal_12))
			);
			sp.wait(waitTime)
		};
		"fraktal_13".postln;
		([11.125, 12.25, 13.375, 14.5, 15.625, 16.75, 17.75, 19.0] - 10).differentiate.do { |waitTime|
			sp.par(~fraktal_1_InstrState_1.(
				inputPattern: Pdef(\fraktal_13))
			);
			sp.wait(waitTime)
		};
		sp.wait(1);

		"fraktal_14".postln;
		sp.par(~fraktal_1_InstrState_1.(
			inputPattern: Pdef(\fraktal_14))
		);
		sp.wait(2);

		"fraktal_15".postln;
		sp.seq(~fraktal_1_InstrState_1.(
			inputPattern: Psync(Pdef(\fraktal_15), 5, 100))
		);
		"fraktal_16".postln;
		sp.seq(~fraktal_1_InstrState_1.(
			inputPattern: Psync(Pdef(\fraktal_16), 0, 100))
		);
		"fraktal_17".postln;
		~lsys[\simpleSwitch_dev4].vols = [1, 1, 1, 1, 1, 1];
		sp.par(
			Pbind(\dur, Rest(0.1), \x, Pfunc { |in|
				// ~lsys[\simpleSwitch_dev4].vols[0] = in;
				~lsys[\simpleSwitch_dev4].vols[1] = in;
				0 } <> Pseg([1,0],[16],3)
			)
		);

		sp.seq(Ppar([
			~fraktal_1_InstrState_1.(
				inputPattern: Pdef(\fraktal_17)),
			Psync(~simpleSwitchInstrState_1.(
				inputPattern: Pdef(\simpleSwitch_dev4)),4,16)
		]));
	})
)
