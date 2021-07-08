Pdef(\triangleDevelopement_2,
	Pspawner({|sp|
		var player1, player2, player3;

		var fraktalNoteOffset = 0;

		~lsys[\fraktal_1_inverse7].noteOffset = fraktalNoteOffset;
		~lsys[\fraktal_13].noteOffset = fraktalNoteOffset;
		~lsys[\fraktal_17].noteOffset = fraktalNoteOffset;
		~lsys[\fraktal_1_inverse7].ctranspose = 12;
		~lsys[\fraktal_13].ctranspose = 12;
		~lsys[\fraktal_17].ctranspose = 12;

		"fraktal_1_inverse7".postln;
		~cueSymbols[\new] = 'fraktal_1_inverse7';


		/*soundCue = "Fraktal_1: 0 -> 1; MasterResonance: X -> 0.75"
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlKnobLEDsSetRow.(4,1);
		~launchControlXlUpdateKnobLEDs.value;*/

		sp.seq(~fraktal_1_InstrState_1.(
			inputPattern: Psync(Pdef(\fraktal_1_inverse7), 0, 100))
		);
		// sp.seq(Pdef(\triangleDevelopement_repeat));



		"fraktal_13 A".postln;
~cueSymbols[\new] = 'fraktal_13 A';

		/*soundCue = "MasterFilter: 1 -> 0.5; MasterResonance: 0.75"
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlKnobLEDsSetRow.(8,1);
		~launchControlXlUpdateKnobLEDs.value;*/

		sp.seq(~fraktal_1_InstrState_1.(
			inputPattern: Pn(Psync(Pdef(\fraktal_13), 2, 4), 4))
		);


		"fraktal_13 B".postln;
~cueSymbols[\new] = 'fraktal_13 B';

		/*soundCue = "MasterFilter: 0.5 -> 1; MasterResonance: 0.75 -> 0"
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlKnobLEDsSetRow.(8,1);
		~launchControlXlUpdateKnobLEDs.value;*/

		sp.seq(~fraktal_1_InstrState_1.(
			inputPattern: Pn(Psync(Pdef(\fraktal_13), 1, 4), 4))
		);

		"fraktal_1_inverse7".postln;
~cueSymbols[\new] = 'fraktal_1_inverse7_2nd';

		/*soundCue = "Fraktal_1: 0 -> 1"
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlKnobLEDsSetRow.(4,1);
		~launchControlXlUpdateKnobLEDs.value;*/

		sp.seq(~fraktal_1_InstrState_1.(
			inputPattern: Psync(Pdef(\fraktal_1_inverse7), 0, 100))
		);


		/*player1 = sp.par(~fraktal_1_InstrState_2.(
			inputPattern: Pn(Psync(Pdef(\fraktal_13), 1, 4),inf))
		);

		player2 = sp.par(~bdBuzzInstrState_1.(
			inputPattern: Pdef(\fraktal_philipp_bd))
		);

		player3 = sp.par(~fraktal_1_sd_InstrState_1.(
			inputPattern: Pdef(\fraktal_philipp_sd))
		);

		sp.wait(16);

		player1.stop; player2.stop; player3.stop;*/

~cueSymbols[\new] = 'fraktal_philipp';


		{
			var rp = ~gui.lastPoints.rootPoint;
			~gui.lastPoints.clear;
			~gui.lastPoints.rootPoint = rp;
		}.value;
		player2 = sp.par(~bdBuzzInstrState_2.(
			inputPattern: Pdef(\fraktal_philipp_bd))
		);
		player3 = sp.par(~fraktal_1_sd_InstrState_1.(
			inputPattern: Pdef(\fraktal_philipp_sd))
		);
		sp.seq(~fraktal_1_InstrState_4.(
			inputPattern: Pdef(\fraktal_philipp))
		);

		})
		)