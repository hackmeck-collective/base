Pdef(\penrose_entwicklung2,
	Pspawner({ |sp|

		var penrose_baseTempo = 1/6;
		var penrose_noteOffset = 12;
		var simpleSwitch_baseTempo = 1/8;
		var simpleSwitch_noteOffset = 0;

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

		sp.seq(Ppar([
		Pbind(\amp, 0.23) <> ~penroseInstrState_7.(
		inputPattern: Pn(Pdef(\penrose_pauses_gen4),1))
		])
		);

		"penrose_canon".postln;

		sp.seq(Ppar([
		~penroseInstrState_7.(
		inputPattern: Pseq([
		Pdef(\penrose_canon_1),
		Pdef(\penrose_canon_2)], 2)
		)
		])
		);

		"penrose_canon_pausen x fade".postln;

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

		/*Pn(Pdef(\penrose_canon_pausen_1),5).calcFullDelta
		Pn(Pdef(\penrose_canon_1),3).calcFullDelta*/

		"penrose_canon_pausen1".postln;

		sp.seq(Ppar([
		~penroseInstrState_8.(
		inputPattern: Pdef(\penrose_canon_pausen_1)
		)
		])
		);

		"penrose_canon_pausen2".postln;

		sp.seq(Ppar([
		~penroseInstrState_8.(
		inputPattern: Pdef(\penrose_canon_pausen_2)
		)
		])
		);

		"penrose_canon_mehr_pausen x-fade".postln;

		sp.seq(
		~patternVolumeFade.(
		pat1:
		~penroseInstrState_8.(
		inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen),12)),

		pat2:
		~penroseInstrState_8.(
		inputPattern: Pfindur(61.999999999999/2,Pn(Pdef(\penrose_canon_pausen_2),9))),

		length: 60,
		delta: penrose_baseTempo
		)

		);

		/*Pn(Pdef(\penrose_canon_mehr_pausen),12).calcFullDelta
		Pn(Pdef(\penrose_canon_pausen_2),8).calcFullDelta*/

		"halftime fade in".postln;

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

		sp.seq(
			~penroseInstrState_8.(
				inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen_ht), 1)
			)
		);

		"penrose_canon_mehr_pausen2".postln;

		sp.seq(Ppar([
			~penroseInstrState_8.(
				inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen2), 1)
			)
		])
		);

		"penrose_canon_mehr_pausen3".postln;

		sp.seq(Ppar([
			~penroseInstrState_8.(
				inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen3), 1)
			)
		])
		);


		"transition_penrose_simpleSwitch".postln;

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