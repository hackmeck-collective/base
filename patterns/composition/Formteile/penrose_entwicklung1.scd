Pdef(\penrose_entwicklung1,
	Pspawner({ |sp|

		~lsys.presets.penrose_simple_gen2.noteOffset = 0;
		~lsys.presets.penrose_toPause.noteOffset = 0;
		~lsys.presets.penrose_toPause2.noteOffset = 0;
		~lsys.presets.penrose_toPause3.noteOffset = 0;
		~lsys.presets.penrose_pauses_gen1.noteOffset = 0;
		~lsys.presets.penrose_pauses_gen2.noteOffset = 0;
		~lsys.presets.penrose_pauses_gen3.noteOffset = 0;

		sp.seq(Pn(Pdef(\penrose_simple_gen2), 2));
		sp.seq(Pn(Pdef(\penrose_simple_gen1), 4));
		sp.seq(Pn(Pdef(\penrose_simplesimple_gen1), 4));
		"penrose to pause".postln;
		sp.seq(Pn(Pdef(\penrose_toPause), 4));
		"penrose to pause2".postln;
		sp.seq(Pn(Pdef(\penrose_toPause2), 4));
		"penrose to pause3".postln;
		sp.seq(Pn(Pdef(\penrose_toPause3), 4));
		"penrose_pauses_gen1".postln;
		sp.seq(Pn(Pdef(\penrose_pauses_gen1),8));
		"penrose_pauses_gen2".postln;
		sp.seq(Pn(Pdef(\penrose_pauses_gen2),2));
		"penrose_pauses_gen3".postln;
		sp.seq(Pn(Pdef(\penrose_pauses_gen3),2));
		"penrose to pause3".postln;
		sp.seq(Pn(Pdef(\penrose_toPause3), 4));
	})
)

