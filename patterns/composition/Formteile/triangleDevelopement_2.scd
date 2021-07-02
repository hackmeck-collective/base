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

		sp.seq(~fraktal_1_InstrState_1.(
			inputPattern: Psync(Pdef(\fraktal_1_inverse7), 0, 100))
		);
		// sp.seq(Pdef(\triangleDevelopement_repeat));


		"fraktal_13 A".postln;
		sp.seq(~fraktal_1_InstrState_1.(
			inputPattern: Pn(Psync(Pdef(\fraktal_13), 2, 4), 4))
		);

		"fraktal_13 B".postln;
		sp.seq(~fraktal_1_InstrState_1.(
			inputPattern: Pn(Psync(Pdef(\fraktal_13), 1, 4), 4))
		);

	/*	"fraktal_17".postln;
		sp.seq(~fraktal_1_InstrState_1.(
			inputPattern: Pdef(\fraktal_17))
		);
*/
		"fraktal_1_inverse7".postln;
		sp.seq(~fraktal_1_InstrState_1.(
			inputPattern: Psync(Pdef(\fraktal_1_inverse7), 0, 100))
		);


		player1 = sp.par(~fraktal_1_InstrState_2.(
			inputPattern: Pn(Psync(Pdef(\fraktal_13), 1, 4),inf))
		);

		player2 = sp.par(~bdBuzzInstrState_1.(
			inputPattern: Pdef(\fraktal_philipp_bd))
		);

		player3 = sp.par(~fraktal_1_sd_InstrState_1.(
			inputPattern: Pdef(\fraktal_philipp_sd))
		);

		sp.wait(16);

		player1.stop; player2.stop; player3.stop;
		{
			var rp = ~gui.lastPoints.rootPoint;
			~gui.lastPoints.clear;
			~gui.lastPoints.rootPoint = rp;
		}.value;
		player2 = sp.par(~bdBuzzInstrState_1.(
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