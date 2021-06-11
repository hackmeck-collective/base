Pdef(\triangleDevelopement_2,
	Pspawner({|sp|
		var player1, player2, player3;
		"fraktal_1_inverse7".postln;
		sp.seq(Psync(Pdef(\fraktal_1_inverse7), 0, 100));
		sp.seq(Pdef(\triangleDevelopement_repeat));

		player1 = sp.par(Pn(Psync(Pdef(\fraktal_13), 1, 4),inf));
		player2 = sp.par(Pdef(\fraktal_philipp_bd));
		player3 = sp.par(Pdef(\fraktal_philipp_sd));

		sp.wait(16);

		player1.stop; player2.stop; player3.stop;
		player2 = sp.par(Pdef(\fraktal_philipp_bd));
		player3 = sp.par(Pdef(\fraktal_philipp_sd));
		sp.seq(Pdef(\fraktal_philipp));

	})
)