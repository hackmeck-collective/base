/*Pdef(\fuge_develope_ende,
Pspawner({ |sp|
sp.par(
Pbind(\dur, Rest(0.1), \x, Pfunc {|in| ~linkClock.tempo = in } <>
Pseg([4,2,1,1] * 1,[161.6,97.6,1],[-3,-3,-3,-3,-3])) //,[-9,-9,-9,-9,-9]
);
~lsys[\fuge_3_gen3].vols = [ 0.82,0.82,0.82 ];
sp.seq(
Pbind(\glide, 0.05)
<> ~fugeInstrState_1.(Pdef(\fuge_3_gen3))
);
"NEXT GEN 2".warn;
//~lsys[\presets].fuge_3_gen2.baseTempo = 1/10;
sp.seq(
Pbind(\glide, Pseg([0.05,0.2],[97.6]))
<> ~fugeInstrState_1.(Pdef(\fuge_3_gen2))
);
"NEXT GEN 1".warn;
//~lsys[\presets].fuge_3_gen1.baseTempo = 1/5;
sp.seq(
Pbind(\glide, 0.2)
<> ~fugeInstrState_1.(Pdef(\fuge_3_gen1))
);
})
);*/

Pdef(\fuge_develope_ende,
	Pspawner({ |sp|
		~lsys[\fuge_3_gen3].baseColor = ~gui.lsysColorsAndTheta.fuge.baseColor;
		sp.par(
			Pbind(\dur, Rest(0.1), \x, Pfunc {|in| ~linkClock.tempo = in } <>
				// Pseg([4,3,2,1.5,1,1] * 1,[80.8,0, 48.8,0,0.1,1],[-3,-3,-3,-3,-3])) //,[-9,-9,-9,-9,-9]
				Pseg([10,2,0.035] * 1,[65,9],[-2,-2])) //,[-9,-9,-9,-9,-9]
		);
		~lsys[\fuge_3_gen3].vols = [ 0.82,0.82,0.82 ];
		sp.seq(
			Pbind(\glide, Pseg([0.05, 0.05,4] * 1,[65.8,15],[-3,-2]))
			<> ~fugeInstrState_1.(Pdef(\fuge_3_gen3))
		);
	})
);

Pdef(\fuge_develope_ende2,
	Pspawner({ |sp|
		sp.par(
			Pbind(\dur, Rest(0.1), \x, Pfunc {|in| ~linkClock.tempo = in } <>
				// Pseg([4,3,2,1.5,1,1] * 1,[80.8,0, 48.8,0,0.1,1],[-3,-3,-3,-3,-3])) //,[-9,-9,-9,-9,-9]
				Pseg([10,2] * 1,[40],[-5])) //,[-9,-9,-9,-9,-9]
		);
		~lsys[\fuge_3_shortBranches_gen3].baseColor = ~gui.lsysColorsAndTheta.fuge.baseColor;
		sp.seq(
			Pbind(\glide, 0.05)
			<> ~fugeInstrState_1.(Pdef(\fuge_3_shortBranches_gen3))
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