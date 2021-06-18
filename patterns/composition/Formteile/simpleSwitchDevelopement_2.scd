Pdef(\simpleSwitchDevelopement_2,
	Pspawner({ |sp|
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(15); // 15
				sp2.seq(Pdef(\triangleDevelopement_1));
			})
		);
		~lsys[\presets].simpleSwitch_dev4.vols = [0, 0, 1, 1, 1, 1];
		sp.seq(Pdef(\simpleSwitch_dev4));
		~lsys[\presets].simpleSwitch_dev6.vols = [0, 0, 1, 1, 1, 1];
		//~lsys[\presets].simpleSwitch_dev6.stutterVal = Pseq([1,1,2],inf);
		sp.par(
			Pbind(\dur, Rest(0.1), \x, Pfunc { |in|
				~lsys[\presets].simpleSwitch_dev6.vols[0] = in;
				~lsys[\presets].simpleSwitch_dev6.vols[1] = in;
				0 } <> Pseg([0,0,1,0,0],[15,10,5,5],-3)
			)
		);
		"ss6".postln;
		sp.seq(Pfindur(35, Pdef(\simpleSwitch_dev6)));
	})
);