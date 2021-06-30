Pdef(\penrose_entwicklung1,
	Pspawner({ |sp|

		var penrose_noteOffset = 0;
		var penrose_baseTempo = 1/6;

		~lsys[\penrose_simple_gen2].noteOffset = penrose_noteOffset;
		~lsys[\penrose_simple_gen1].noteOffset = penrose_noteOffset;
		~lsys[\penrose_simplesimple_gen1].noteOffset = penrose_noteOffset;
		~lsys[\penrose_toPause].noteOffset = penrose_noteOffset;
		~lsys[\penrose_toPause2].noteOffset = penrose_noteOffset;
		~lsys[\penrose_toPause3].noteOffset = penrose_noteOffset;
		~lsys[\penrose_pauses_gen1].noteOffset = penrose_noteOffset;
		~lsys[\penrose_pauses_gen2].noteOffset = penrose_noteOffset;
		~lsys[\penrose_pauses_gen3].noteOffset = penrose_noteOffset;

		~lsys[\penrose_simple_gen2].baseTempo = penrose_baseTempo;
		~lsys[\penrose_simple_gen1].baseTempo = penrose_baseTempo;
		~lsys[\penrose_simplesimple_gen1].baseTempo = penrose_baseTempo;
		~lsys[\penrose_toPause].baseTempo = penrose_baseTempo;
		~lsys[\penrose_toPause2].baseTempo = penrose_baseTempo;
		~lsys[\penrose_toPause3].baseTempo = penrose_baseTempo;
		~lsys[\penrose_pauses_gen1].baseTempo = penrose_baseTempo;
		~lsys[\penrose_pauses_gen2].baseTempo = penrose_baseTempo;
		~lsys[\penrose_pauses_gen3].baseTempo = penrose_baseTempo;


		sp.seq(Ppar([
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_simple_gen2), 4)),
			Pn(Pdef(\penrose_simple_click_gen2), 4)
		])
		);

		sp.seq(Ppar([
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_simple_gen1), 4)),
			Pn(Pdef(\penrose_simple_click_gen1), 4)])
		);

		sp.seq(Ppar([
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_simplesimple_gen1), 4)),
			Pdef(\penrose_simple_click_gen0)
		])
		);

		"penrose to pause".postln;
		sp.seq(Ppar([
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_toPause), 4)),
			Pn(Pdef(\penrose_toPause_bd), 4)
		])
		);

		"penrose to pause2".postln;
		sp.seq(Ppar([
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_toPause2), 4)),
			Pn(Pdef(\penrose_toPause2_bd), 4),
			Pn(Pdef(\penrose_toPause2_click), 4)])
		);

		"penrose to pause3".postln;
		sp.seq(Ppar([
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_toPause3), 4))
		])
		);

		"penrose_pauses_gen1[".postln;
		sp.seq(Ppar([
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen1),4)),
			Pn(Pdef(\penrose_pauses_gen1_bd), 4)])
		);

		sp.seq(Ppar([
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen1),4)),
			Pn(Pdef(\penrose_pauses_gen1_bd), 4),
			Pn(Pdef(\penrose_pauses_gen1_click), 4)])
		);

		"penrose_pauses_gen2".postln;
		sp.seq(Ppar([
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen2),2)),
			Pn(Pdef(\penrose_pauses_gen2_bd), 2),
			Pn(Pdef(\penrose_pauses_gen1_click), 8)])
		);

		sp.seq(Ppar([
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen2),2)),
			Pn(Pdef(\penrose_pauses_gen3_bd), 1),
			Pn(Pdef(\penrose_pauses_gen2_click), 2)])
		);

		"penrose_pauses_gen3".postln;
		sp.seq(Ppar([
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen3),2)),
			Pn(Pdef(\penrose_pauses_gen3_bd), 2),
			Pn(Pdef(\penrose_pauses_gen3_click), 2)])
		);

		"penrose to pause3".postln;
		sp.seq(Ppar([
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_toPause3), 4))
		])
		);
	})
)

