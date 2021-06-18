Pdef(\fuge_develope_ende,
	Pspawner({ |sp|
		sp.par(
			Pbind(\dur, Rest(0.2), \x, Pfunc {|in| ~linkClock.tempo = in } <> Pseg([4,3,2,1.5,1,1],[161.6,0,97.6,0,0]).trace)
		);
		//~lsys[\presets].fuge_3_gen3.baseTempo = 1/20;
		sp.seq(
			Pbind(\glide, 0.05)
			<> Pdef(\fuge_3_gen3)
		);
		"NEXT GEN 2".warn;
		//~lsys[\presets].fuge_3_gen2.baseTempo = 1/10;
		sp.seq(
			Pbind(\glide, Pseg([0.05,0.2],[97.6]))
			<> Pdef(\fuge_3_gen2)
		);
		"NEXT GEN 1".warn;
		//~lsys[\presets].fuge_3_gen1.baseTempo = 1/5;
		sp.seq(
			Pbind(\glide, 0.2)
			<> Pdef(\fuge_3_gen1)
		);
	})
)