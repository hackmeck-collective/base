Pdef(\simpleSwitchDevelopement_2,
	Pspawner({ |sp|

		"ss_dev_2".postln;
		"ss_4".postln;
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(15); // 15
				sp2.seq(Pdef(\triangleDevelopement_1));
			})
		);

		~lsys[\simpleSwitch_dev4].vols = [0, 0, 1, 1, 1, 1];

		sp.seq(~simpleSwitchInstrState_6.(
			inputPattern: Pdef(\simpleSwitch_dev4))
		);

		"ss_6".postln;
		~lsys[\simpleSwitch_dev6].vols = [0, 0, 1, 1, 1, 1];

		//~lsys[\presets].simpleSwitch_dev6.stutterVal = Pseq([1,1,2],inf);

		sp.par(
			Pbind(\dur, Rest(0.1), \x, Pfunc { |in|
				~lsys[\simpleSwitch_dev6].vols[0] = in;
				~lsys[\simpleSwitch_dev6].vols[1] = in;
				0 } <> Pseg([0,0,1,0,0],[15,10,5,5],-3)
			)
		);

		"ss6".postln;

		sp.seq(Pfindur(35,
			~simpleSwitchInstrState_5.(
				inputPattern: Pdef(\simpleSwitch_dev6))
		));
	})
);