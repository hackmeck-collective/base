Pdef(\play).play

Pdef(\play,
	Pspawner({ |sp|
		sp.seq(Pn(Pdef(\simpleSwitch), 4));
		sp.seq(Pn(Pdef(\simpleSwitch_dev2), 2));
		sp.seq(Pn(Pdef(\simpleSwitch_dev3), 2));
		sp.seq(Pn(Pdef(\simpleSwitch), 6));
		sp.seq(Pdef(\simpleSwitch_dev4));
		// sp.seq(Pdef(\simpleSwitch_dev5));
		~lsys.presets.simpleSwitch_dev6.vols = [0, 0, 1, 1, 1, 1];
		~lsys.presets.simpleSwitch_dev6.stutterVal = Pseq([1,1,2],inf);
		sp.par(
			Pbind(\dur, Rest(0.1), \x, Pfunc { |in|
				~lsys.presets.simpleSwitch_dev6.vols[0] = in;
				~lsys.presets.simpleSwitch_dev6.vols[1] = in;
				0 } <> Pseg([0,0,1],[18,12],-3)
			)
		);
		sp.seq(Pdef(\simpleSwitch_dev6));
		sp.seq(Pn(Pdef(\simpleSwitch), 6));
	})
);

thisThread.seconds;