Pdef(\triangle_develope,
	Pspawner({|sp|
		var player1, player2, player3;
		sp.seq(Pn(Psync(Pdef(\fraktal_12), 3, 4), 4));
		"fraktal_13 A".postln;
		sp.seq(Pn(Psync(Pdef(\fraktal_13), 2, 4), 4));
		"fraktal_13 B".postln;
		sp.seq(Pn(Psync(Pdef(\fraktal_13), 1, 4), 4));
		"fraktal_14".postln;
		sp.seq(Pn(Psync(Pdef(\fraktal_14), 4, 4), 2));

		"fraktal_15".postln;
		sp.seq(Psync(Pdef(\fraktal_15), 5, 100));
		"fraktal_16".postln;
		sp.seq(Psync(Pdef(\fraktal_16), 0, 100));
		//"intermezzo".postln;
		//sp.seq(Pdef(\simpleSwitch_dev4));
		"fraktal_17".postln;
		sp.seq(Ppar([
			Pdef(\fraktal_17) <> Pbind(\streamIndex, 2), //\newBranchTest
			Pdef(\simpleSwitch_dev4) <> Pbind(\streamIndex, 1)
		]) );
		"fraktal_1_inverse7".postln;
		sp.seq(Psync(Pdef(\fraktal_1_inverse7), 0, 100));

		player1 = sp.par(Pn(Psync(Pdef(\fraktal_13), 1, 4),inf));
		player2 = sp.par(Pdef(\fraktal_philipp_bd));
		player3 = sp.par(Pdef(\fraktal_philipp_sd));

		sp.wait(16);
		player1.stop; player2.stop; player3.stop;
		player2 = sp.par(Pdef(\fraktal_philipp_bd));
		player3 = sp.par(Pdef(\fraktal_philipp_sd));
		sp.par(Pdef(\fraktal_philipp));
		sp.wait(12);
		sp.par(
			Pdef(\sd2).collect {|ev| ~scM4.play; ev} <> Pbindef(\fifth) <> Pbindef(\pulse_4_ob)
		);
	})
)