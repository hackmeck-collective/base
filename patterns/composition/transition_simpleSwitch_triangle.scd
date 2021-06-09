~pitchesRootDissonance[\pitches] = (36, 38 .. 96)

Pdef(\triangle_develope).play

Pdef(\fraktal_12).play // soll bei \simpleSwitchDevelopement immer mal dazu kommen

Pdef(\play,
	Pspawner({ |sp|
		sp.seq(Pdef(\simpleSwitchDevelopement));
	})
);


Pn(Psync(Pdef(\fraktal_12), 3, 4), 4).calcFullDelta
Pn(Pdef(\simpleSwitch_gen1), 8).play
~lsysPreset.edit(\fraktal_12)
Pdef(\play).play(~linkClock, quant:1 )

Pdef(\play).stop
s.reboot

Pdef(\simpleSwitchDevelopement,
	Pspawner({ |sp|
		"ss1".postln;
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(6.25);
				sp2.seq(Pdef(\fraktal_12));
			})
		);
		sp.seq(Pn(Pdef(\simpleSwitch), 4));
		"ss2".postln;
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(9.75);
				sp2.seq(Pdef(\fraktal_12));
			})
		);
		sp.seq(Pn(Pdef(\simpleSwitch_dev2), 2));
		"ss3".postln;
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(9.5);
				sp2.seq(Pdef(\fraktal_13));
			})
		);
		sp.seq(Pn(Pdef(\simpleSwitch_dev3), 2));
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(3.75);
				sp2.seq(Pdef(\fraktal_12));
			})
		);
		sp.seq(Pn(Pdef(\simpleSwitch_gen1), 8));
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(3.25);
				sp2.seq(Pdef(\fraktal_13));
			})
		);
		sp.seq(Pn(Pdef(\simpleSwitch_gen0), 32));
		"ss5".postln;
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(15);
				sp2.seq(Pdef(\triangle_develope));
			})
		);
		sp.seq(Pdef(\simpleSwitch_dev4));
		~lsys.presets.simpleSwitch_dev6.vols = [0, 0, 1, 1, 1, 1];
		~lsys.presets.simpleSwitch_dev6.stutterVal = Pseq([1,1,2],inf);
		sp.par(
			Pbind(\dur, Rest(0.1), \x, Pfunc { |in|
				~lsys.presets.simpleSwitch_dev6.vols[0] = in;
				~lsys.presets.simpleSwitch_dev6.vols[1] = in;
				0 } <> Pseg([0,0,1,0],[18,12,8],-3)
			)
		);
		"ss6".postln;
		sp.seq(Pdef(\simpleSwitch_dev6));
	})
)
Pdef(\triangle_develope).play
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
Pdef(\fraktal_17).calcFullDelta
Pdef(\simpleSwitch_dev4).calcFullDelta //15.25

Pdef(\par_fraktal_17_simpleSwitch_dev4).play
Pdef(\par_fraktal_17_simpleSwitch_dev4,
	Pbind(
		\vol, (Pfunc {|ev|
			var oldVol = ev.vol ? 1;
			var fade = if(ev.streamIndex == 1){ev.xfade}{1 - ev.xfade};
			oldVol * fade
		})
	) <> Ppar([
		Pdef(\fraktal_17) <> Pbind(\streamIndex, 2), //\newBranchTest
		Pdef(\simpleSwitch_dev4) <> Pbind(\streamIndex, 1)
	]) <> PtimeClutch(Pbind(
		\xfade, Pseq([1,1,1,0],inf),
	), delta: (1/8) - 0.01) // Delta mit dem baseTempo auf dem es laufen soll abstimmen
);