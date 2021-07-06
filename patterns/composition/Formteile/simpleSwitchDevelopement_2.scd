Pdef(\simpleSwitchDevelopement_2,
	Pspawner({ |sp|

		"ss_dev_2".postln;
		"ss_4".postln;
		sp.par(
			Pspawner({ |sp2|
				sp2.wait(15); // 15
				sp2.seq(Pdef(\triangleDevelopement_1)); //können wir das bitte überarbeiten? das kommt nicht gut in kombination, das klingt sehr ungroovy
			})
		);

		~lsys[\simpleSwitch_dev4].branchInterval = 7;
		~lsys[\simpleSwitch_dev4].vols = [0, 0, 1, 1, 1, 1];
		~lsys[\simpleSwitch_dev4].ctranspose = 0;

		sp.par(
			Pbind(\dur, Rest(0.1), \setDetune, Pfunc {|in|
				~lsys[\simpleSwitch_dev4].ctranspose = in
			} <> Plazy{Pseg([0,0,~calcIntervalBetweenNoteOffsets.(\simpleSwitch_dev6,\simpleSwitch_dev4)],[10, 5.25],-1).round(2)});
		);

		sp.seq(~simpleSwitchInstrState_6.(
			inputPattern: Pdef(\simpleSwitch_dev4))
		);

		"ss_6".postln;
		~lsys[\simpleSwitch_dev6].vols = [0, 0, 1, 1, 1, 1];
		~lsys[\simpleSwitch_dev6].ctranspose = 0;

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