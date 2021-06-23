Pdef(\fuge_develope_ende,
	Pspawner({ |sp|
		sp.par(
			Pbind(\dur, Rest(0.1), \x, Pfunc {|in| ~linkClock.tempo = in } <>
				Pseg([4,2,1,1] * 1,[161.6,97.6,1],[-3,-3,-3,-3,-3])) //,[-9,-9,-9,-9,-9]
		);
		~lsys[\presets].fuge_3_gen3.vols = [ 0.82,0.82,0.82 ];
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
);

Pdef(\fuge_develope_ende2,
	Pspawner({ |sp|
		// langsam alle stimmen ausser root rausfaden
		~lsys[\presets].fuge_3_gen1.vols = [ 0.82,0.82 ];
		sp.seq(
			Pbind(\glide, Pseg([0.2, 2],[67.2  / 2]))
			<> Pn(Pdef(\fuge_3_gen1), 1)
		);
		~lsys[\presets].fuge_3_gen3.vols = [ 0.82,0,0 ];
		sp.par(
			Pbind(\dur, Rest(0.1), \x, Pfunc {|in| ~linkClock.tempo = in } <>
				Pseg([1,0.25],[30]))
		);
		// langsam wieder alle stimmen reinfaden
		sp.seq(
			Pbind(\glide, 2)
			<> Pdef(\fuge_3_gen3)
		);
	})
)

/*a = Pdef(\fuge_3_gen1).calcFullDelta
Env([4,3,2,1.5,1,1],[161.6,0,97.6,0.21,0],[-9,-9,-9,-9,-9]).plot
3 /4
Env([4,2,1,1] * 1,[161.6,97.6,1],[-3,-3,-3,-3,-3]).plot

161.6 / 97.6 / 33.6

97.6 / 161.6

3 * 1.655737704918*/