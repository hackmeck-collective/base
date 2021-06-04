Pdef(\play).play

Pdef(\play,
	Pspawner({ |sp|
		"ss1".postln;
		sp.seq(Pn(Pdef(\simpleSwitch), 4));
		"ss2".postln;
		sp.seq(Pn(Pdef(\simpleSwitch_dev2), 2));
		"ss3".postln;
		sp.seq(Pn(Pdef(\simpleSwitch_dev3), 2));
		"ss4".postln;
		sp.seq(Pn(Pdef(\simpleSwitch), 6));
		"ss5".postln;
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
		"ss6".postln;
		sp.seq(Pdef(\simpleSwitch_dev6));
		"ss7".postln;
		sp.seq(Pn(Pdef(\simpleSwitch), 6));
	})
);

thisThread.seconds;