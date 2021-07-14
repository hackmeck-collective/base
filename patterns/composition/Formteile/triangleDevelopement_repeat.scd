Pdef(\triangleDevelopement_repeat,
	Pspawner({|sp|
		var player1, player2, player3;
		"fraktal_13 A".postln;
		sp.seq(~fraktal_1_InstrState_1.(
			inputPattern: Pn(Psync(Pdef(\fraktal_13), 2, 4), 4))
		);

		"fraktal_13 B".postln;
		sp.seq(~fraktal_1_InstrState_1.(
			inputPattern: Pn(Psync(Pdef(\fraktal_13), 1, 4), 4))
		);

		/*"fraktal_14".postln;
		sp.seq(~fraktal_1_InstrState_1.(
			inputPattern: Pn(Psync(Pdef(\fraktal_14), 4, 4), 2))
		);

		"fraktal_15".postln;
		sp.seq(~fraktal_1_InstrState_1.(
			inputPattern: Psync(Pdef(\fraktal_15), 5, 100))
		);

		"fraktal_16".postln;
		sp.seq(~fraktal_1_InstrState_1.(
			inputPattern: Psync(Pdef(\fraktal_16), 0, 100))
		);*/

		"fraktal_17".postln;
		sp.seq(~fraktal_1_InstrState_1.(
			inputPattern: Pdef(\fraktal_17))
		);

		"fraktal_1_inverse7".postln;
		sp.seq(~fraktal_1_InstrState_1.(
			inputPattern: Psync(Pdef(\fraktal_1_inverse7), 0, 100))
		);

		s.sendMsg("/g_freeAll", ~routing[\sourceGroup]);

	})
)