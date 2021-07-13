Pdef(\penrose_entwicklung2,
	Pspawner({ |sp|

		var penrose_baseTempo = 1/6;
		var penrose_noteOffset = 12;
		var simpleSwitch_baseTempo = 1/8;
		var simpleSwitch_noteOffset = 0;

		~lsys[\penrose_pauses_gen4].putAll(~gui.lsysColorsAndTheta.penrose_pauses);
		~lsys[\penrose_canon_1].putAll(~gui.lsysColorsAndTheta.penrose_pauses);
		~lsys[\penrose_canon_2].putAll(~gui.lsysColorsAndTheta.penrose_pauses);
		~lsys[\penrose_canon_pausen_1].putAll(~gui.lsysColorsAndTheta.penrose_pauses);
		~lsys[\penrose_canon_pausen_2].putAll(~gui.lsysColorsAndTheta.penrose_pauses);
		~lsys[\penrose_canon_mehr_pausen].putAll(~gui.lsysColorsAndTheta.penrose_mehr_pauses);
		~lsys[\penrose_canon_mehr_pausen2].putAll(~gui.lsysColorsAndTheta.penrose_mehr_pauses);
		~lsys[\penrose_canon_mehr_pausen3].putAll(~gui.lsysColorsAndTheta.penrose_mehr_pauses);
		~lsys[\penrose_canon_mehr_pausen_ht].putAll(~gui.lsysColorsAndTheta.penrose_mehr_pauses);
		~lsys[\simpleSwitch].putAll(~gui.lsysColorsAndTheta.simpleSwitch);

		~lsys[\penrose_pauses_gen4].baseTempo = penrose_baseTempo;
		~lsys[\penrose_canon_1].baseTempo = penrose_baseTempo;
		~lsys[\penrose_canon_2].baseTempo = penrose_baseTempo;
		~lsys[\penrose_canon_pausen_1].baseTempo = penrose_baseTempo;
		~lsys[\penrose_canon_pausen_2].baseTempo = penrose_baseTempo;
		~lsys[\penrose_canon_mehr_pausen].baseTempo = penrose_baseTempo;
		~lsys[\penrose_canon_mehr_pausen_ht].baseTempo = penrose_baseTempo*2;
		~lsys[\penrose_canon_mehr_pausen2].baseTempo = penrose_baseTempo;
		~lsys[\penrose_canon_mehr_pausen3].baseTempo = penrose_baseTempo;
		~lsys[\simpleSwitch].baseTempo = simpleSwitch_baseTempo;

		~lsys[\penrose_pauses_gen4].noteOffset = penrose_noteOffset;
		~lsys[\penrose_canon_1].noteOffset = penrose_noteOffset;
		~lsys[\penrose_canon_2].noteOffset = penrose_noteOffset;
		~lsys[\penrose_canon_pausen_1].noteOffset = penrose_noteOffset + 7;
		~lsys[\penrose_canon_pausen_2].noteOffset = penrose_noteOffset + 7;
		~lsys[\penrose_canon_mehr_pausen].noteOffset = penrose_noteOffset;
		~lsys[\penrose_canon_mehr_pausen_ht].noteOffset = penrose_noteOffset - 7;
		~lsys[\penrose_canon_mehr_pausen2].noteOffset = penrose_noteOffset - 7;
		~lsys[\penrose_canon_mehr_pausen3].noteOffset = penrose_noteOffset - 7;
		~lsys[\simpleSwitch].noteOffset = simpleSwitch_noteOffset;


		"penrose_pauses_gen4".postln;
		~cueSymbols[\new] = 'penrose_pauses_gen4';


		sp.seq(
			Pbind(\amp, 6.dbamp,
				\oscillator_1_mod_1, 2,
				\oscillator_2_mod_1, 0.5,
			)
			<> ~fugeInstrState_0.(
				inputPattern: Pseq([
					Pn(Pdef(\fuge_excerpt_gen3), 2),
					Pn(Pdef(\fuge_excerpt_gen2), 4),
					Pn(Pdef(\fuge_excerpt_gen1), 8),
				])
		));

		~linkClock.tempo = 1; // wichtig nach fuge_develope_ende2

		sp.seq(Ppar([
			Pbind(\amp, 0.23) <> ~penroseInstrState_7.(
			inputPattern: Pfindur(16,Pn(Pdef(\penrose_pauses_gen4),1))) //42.833333333333 original
			])
		);

		"penrose_canon".postln;
		~cueSymbols[\new] = 'penrose_canon';


		sp.seq(Ppar([
			~penroseInstrState_7.(
				inputPattern: Pseq([
					Pdef(\penrose_canon_1),
				Pdef(\penrose_canon_2)], 2)
			),
			])
		);

		"penrose_canon_pausen x fade".postln;
		~cueSymbols[\new] = 'penrose_canon_pausen x fade';


		sp.seq(
			~patternVolumeFade.(
				pat1:
				~penroseInstrState_8.(
				inputPattern: Pn(Pdef(\penrose_canon_pausen_1),5)),

				pat2:
				~penroseInstrState_7.(
				inputPattern: Pfindur(34.166666666667, Pn(Pdef(\penrose_canon_1),5))),

				length: 34.166666666667,
				delta: penrose_baseTempo
			)
		);


		"penrose_canon_pausen1".postln;
		~cueSymbols[\new] = 'penrose_canon_pausen1';


		sp.seq(Ppar([ //weg??
			~penroseInstrState_8.(
				inputPattern: Pdef(\penrose_canon_pausen_1)
			)
			])
		);

		"penrose_canon_pausen2".postln;
		~cueSymbols[\new] = 'penrose_canon_pausen2';


		sp.seq(Ppar([
			~penroseInstrState_8.(
				inputPattern: Pdef(\penrose_canon_pausen_2)
			)
			])
		);

		"penrose_canon_mehr_pausen x-fade".postln;
		~cueSymbols[\new] = 'penrose_canon_mehr_pausen x-fade';


		sp.seq(Pfindur(30.999999999999,
		~patternVolumeFade.(
		pat1:
		~penroseInstrState_8.(
		inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen),12)),

		pat2:
		~penroseInstrState_8.(
		inputPattern: Pfindur(30.999999999999,Pn(Pdef(\penrose_canon_pausen_2),9))),

		length: 30.999999999999,
		delta: penrose_baseTempo
		))

		);

		/*Pn(Pdef(\penrose_canon_mehr_pausen),12).calcFullDelta
		Pn(Pdef(\penrose_canon_pausen_2),8).calcFullDelta*/

		"halftime fade in".postln;
		~cueSymbols[\new] = 'halftime fade in';


		sp.par(~penroseInstrState_8.(
			inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen),4)
		)
		);
		sp.seq(
			Pbind(\vol, Pseg([0,1],[20.666666666667]))
		<>
		~penroseInstrState_8.(
			inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen_ht),2)) //dauert 20,666666
		);
		"normaltime fade out".postln;
		~cueSymbols[\new] = 'normaltime fade out';


		sp.par(
			~penroseInstrState_8.(
				inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen_ht),2)
			)
		);
		sp.seq(
			Pbind(\vol, Pseg([1,0,0],[20,11]))
			<>
			~penroseInstrState_8.(
				inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen),4)
			)
		);

		"penrose_canon_mehr_pausen".postln;
		~cueSymbols[\new] = 'penrose_canon_mehr_pausen';


		sp.seq(
			~penroseInstrState_8.(
				inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen_ht), 1)
			)
		);

		"penrose_canon_mehr_pausen2".postln;
		~cueSymbols[\new] = 'penrose_canon_mehr_pausen2';


		sp.seq(Ppar([
			~penroseInstrState_8.(
				inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen2), 1)
			)
		])
		);

		"penrose_canon_mehr_pausen3".postln;
		~cueSymbols[\new] = 'penrose_canon_mehr_pausen3';


		sp.seq(Ppar([
			~penroseInstrState_8.(
				inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen3), 1)
			)
		])
		);


		"transition_penrose_simpleSwitch".postln;
		~cueSymbols[\new] = 'transition_penrose_simpleSwitch';


		sp.seq(
			~patternNotesFade.(
				pat2:
				~penroseInstrState_8.(
					inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen3))
				),

				pat1:
				~simpleSwitchInstrState_4.(
					inputPattern: Pn(Pdef(\simpleSwitch))
				),

				delta: 1/8, //da hakt was, die beiden sind auch nicht das gleiche tempo, sisw ist 1/8 penrose 1/6
				weightPattern: Pbjorklund(
					Pstutter(
						Pseq([4,4,3,3,2,1]),
						Pseq([1,2,3,5,8,13]),
				),16)
			)



		);
	})
)