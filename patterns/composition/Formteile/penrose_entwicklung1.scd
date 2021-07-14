Pdef(\penrose_entwicklung1,
	Pspawner({ |sp|

		var penrose_noteOffset = 0;
		var penrose_baseTempo = 1/6;

		~lsys[\penrose_simple_gen1].putAll(~gui.lsysColorsAndTheta.penrose);
		~lsys[\penrose_simple_gen2].putAll(~gui.lsysColorsAndTheta.penrose);
		~lsys[\penrose_simplesimple_gen1].putAll(~gui.lsysColorsAndTheta.penrose);
		~lsys[\penrose_toPause].putAll(~gui.lsysColorsAndTheta.penrose);
		~lsys[\penrose_toPause2].putAll(~gui.lsysColorsAndTheta.penrose);
		~lsys[\penrose_toPause3].putAll(~gui.lsysColorsAndTheta.penrose);
		~lsys[\penrose_pauses_gen1].putAll(~gui.lsysColorsAndTheta.penrose_pauses);
		~lsys[\penrose_pauses_gen2].putAll(~gui.lsysColorsAndTheta.penrose_pauses);
		~lsys[\penrose_pauses_gen3].putAll(~gui.lsysColorsAndTheta.penrose_pauses);
		~lsys[\penrose_toPause_bd].putAll(~gui.lsysColorsAndTheta.click);
		~lsys[\penrose_toPause2_bd].putAll(~gui.lsysColorsAndTheta.click);
		~lsys[\penrose_toPause2_click].putAll(~gui.lsysColorsAndTheta.click);
		~lsys[\penrose_pauses_gen1_bd].putAll(~gui.lsysColorsAndTheta.click);
		~lsys[\penrose_pauses_gen1_click].putAll(~gui.lsysColorsAndTheta.click);
		~lsys[\penrose_pauses_gen2_bd].putAll(~gui.lsysColorsAndTheta.click);
		~lsys[\penrose_pauses_gen2_click].putAll(~gui.lsysColorsAndTheta.click);
		~lsys[\penrose_pauses_gen3_bd].putAll(~gui.lsysColorsAndTheta.click);
		~lsys[\penrose_pauses_gen3_click].putAll(~gui.lsysColorsAndTheta.click);
		~lsys[\penrose_simple_click_gen0].putAll(~gui.lsysColorsAndTheta.click);
		~lsys[\penrose_simple_click_gen1].putAll(~gui.lsysColorsAndTheta.click);
		~lsys[\penrose_simple_click_gen2].putAll(~gui.lsysColorsAndTheta.click);
		~lsys[\fuge_excerpt_gen1].putAll(~gui.lsysColorsAndTheta.fuge);
		~lsys[\fuge_excerpt_gen2].putAll(~gui.lsysColorsAndTheta.fuge);
		~lsys[\fuge_excerpt_gen3].putAll(~gui.lsysColorsAndTheta.fuge);

		~lsys[\penrose_simple_gen2].noteOffset = penrose_noteOffset;
		~lsys[\penrose_simple_gen1].noteOffset = penrose_noteOffset;
		~lsys[\penrose_simplesimple_gen1].noteOffset = penrose_noteOffset;
		~lsys[\penrose_toPause].noteOffset = penrose_noteOffset;
		~lsys[\penrose_toPause2].noteOffset = penrose_noteOffset;
		~lsys[\penrose_toPause3].noteOffset = penrose_noteOffset;
		~lsys[\penrose_pauses_gen1].noteOffset = penrose_noteOffset + 7;
		~lsys[\penrose_pauses_gen2].noteOffset = penrose_noteOffset + 7;
		~lsys[\penrose_pauses_gen3].noteOffset = penrose_noteOffset + 7;

		~lsys[\penrose_simple_gen2].baseTempo = penrose_baseTempo;
		~lsys[\penrose_simple_gen1].baseTempo = penrose_baseTempo;
		~lsys[\penrose_simplesimple_gen1].baseTempo = penrose_baseTempo;
		~lsys[\penrose_toPause].baseTempo = penrose_baseTempo;
		~lsys[\penrose_toPause2].baseTempo = penrose_baseTempo;
		~lsys[\penrose_toPause3].baseTempo = penrose_baseTempo;
		~lsys[\penrose_pauses_gen1].baseTempo = penrose_baseTempo;
		~lsys[\penrose_pauses_gen2].baseTempo = penrose_baseTempo;
		~lsys[\penrose_pauses_gen3].baseTempo = penrose_baseTempo;

		sp.seq(
			Pbind(\amp, 6.dbamp,
				\oscillator_1_mod_1, 2,
				\oscillator_2_mod_1, 0.5,
			)
			<> ~fugeInstrState_0.(
				inputPattern: Pseq([
					Pn(Pdef(\fuge_excerpt_gen1), 8),
					Pn(Pdef(\fuge_excerpt_gen2), 4),
					Pn(Pdef(\fuge_excerpt_gen3), 2),
				])
		));

		sp.seq(Ppar([
			~penroseInstrState_4.(
				inputPattern: Pn(Pdef(\penrose_simple_gen2), 4)),
			~clickInstrState_3.(
				inputPattern: Pn(Pdef(\penrose_simple_click_gen2), 4)
			),
		])
		);

		sp.seq(Ppar([
			~penroseInstrState_4.(
				inputPattern: Pn(Pdef(\penrose_simple_gen1), 4)
			),
			~clickInstrState_3.(
				inputPattern: Pn(Pdef(\penrose_simple_click_gen1), 4)
			),
		])
		);

		sp.seq(Ppar([
			~penroseInstrState_4.(
				inputPattern: Pn(Pdef(\penrose_simplesimple_gen1), 4)
			),
			~clickInstrState_3.(
				inputPattern: Pdef(\penrose_simple_click_gen0)
			),
		])
		);

		"penrose to pause".postln;
		~cueSymbols[\new] = 'penrose to pause';

		sp.seq(Ppar([
			~penroseInstrState_5.(
				inputPattern: Pn(Pdef(\penrose_toPause), 4)
			),
			~bdBuzzInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_toPause_bd), 4)
			),
		])
		);

		"penrose to pause2".postln;
		~cueSymbols[\new] = 'penrose to pause2';

		sp.seq(Ppar([
			~penroseInstrState_5.(
				inputPattern: Pn(Pdef(\penrose_toPause2), 4)
			),
			~bdBuzzInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_toPause2_bd), 4)
			),
			~clickInstrState_4.(
				inputPattern: Pn(Pdef(\penrose_toPause2_click), 4)
			),
		])
		);

		"penrose to pause3".postln;
		~cueSymbols[\new] = 'penrose to pause3';

		sp.seq(Ppar([
			~penroseInstrState_3.(
				inputPattern: Pn(Pdef(\penrose_toPause3), 4)
			)
		])
		);

		"penrose_pauses_gen1".postln;
		~cueSymbols[\new] = 'penrose_pauses_gen1';

		sp.seq(Ppar([
			~penroseInstrState_6.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen1),4)
			),
			~bdBuzzInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen1_bd), 4)
			),
		])
		);

		sp.seq(Ppar([
			~penroseInstrState_6.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen1),4)
			),
			~bdBuzzInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen1_bd), 4)
			),
			~clickInstrState_4.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen1_click), 4)
			),
		])
		);

		"penrose_pauses_gen2".postln;
		~cueSymbols[\new] = 'penrose_pauses_gen2';

		sp.seq(Ppar([
			~penroseInstrState_6.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen2),2)
			),
			~bdBuzzInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen2_bd), 2)
			),
			~clickInstrState_4.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen1_click), 8)
			),
		])
		);

		"penrose_pauses_gen3".postln;
		~cueSymbols[\new] = 'penrose_pauses_gen2_bd_solo';

		sp.seq(Ppar([
			~penroseInstrState_6.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen2),2)
			),
			~bdBuzzInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen3_bd), 1)
			),
			~clickInstrState_3.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen2_click), 2)
			),
		])
		);

		"penrose_pauses_gen3".postln;
		~cueSymbols[\new] = 'penrose_pauses_gen3';

		sp.seq(Ppar([
			Pbind(
				\centerPos, 0.5,) <>
			~penroseInstrState_7.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen3),2)
			),
			~bdBuzzInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen3_bd), 2)
			),
			~clickInstrState_3.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen3_click), 2)
			),
		])
		);

		"penrose to pause3".postln;
		~cueSymbols[\new] = 'penrose to pause3';

		sp.seq(Ppar([
			Pbind(
				\centerPos, 0.5,) <>
			~penroseInstrState_7.(
				inputPattern: Pn(Pdef(\penrose_toPause3), 4)
			),
		])
		);

		//s.sendMsg("/g_freeAll", ~routing[\sourceGroup]);

	})
)

