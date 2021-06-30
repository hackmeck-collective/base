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
		~lsys[\penrose_canon_mehr_pausen_ht].baseTempo = penrose_baseTempo/2;
		~lsys[\penrose_canon_mehr_pausen2].baseTempo = penrose_baseTempo/2;
		~lsys[\penrose_canon_mehr_pausen3].baseTempo = penrose_baseTempo/2;
		~lsys[\simpleSwitch].baseTempo = simpleSwitch_baseTempo;
		~lsys[\penrose_pauses_gen4].noteOffset = penrose_noteOffset;
		~lsys[\penrose_canon_1].noteOffset = penrose_noteOffset;
		~lsys[\penrose_canon_2].noteOffset = penrose_noteOffset;
		~lsys[\penrose_canon_pausen_1].noteOffset = penrose_noteOffset;
		~lsys[\penrose_canon_pausen_2].noteOffset = penrose_noteOffset;
		~lsys[\penrose_canon_mehr_pausen].noteOffset = penrose_noteOffset;
		~lsys[\penrose_canon_mehr_pausen_ht].noteOffset = penrose_noteOffset;
		~lsys[\penrose_canon_mehr_pausen2].noteOffset = penrose_noteOffset;
		~lsys[\penrose_canon_mehr_pausen3].noteOffset = penrose_noteOffset;
		~lsys[\simpleSwitch].noteOffset = simpleSwitch_noteOffset;


		"penrose_pauses_gen4".postln;

		sp.seq(Ppar([
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_2.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen4),1))
		])
		);

		"penrose_canon".postln;

		sp.seq(Ppar([
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_2.(
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
				Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
				<> ~penroseInstrState_2.(
					inputPattern: Pn(Pdef(\penrose_canon_1),2)),

				pat2:
				Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
				<> ~penroseInstrState_2.(
					inputPattern: Pn(Pdef(\penrose_canon_pausen_1),2)),

				length: 20,
				delta: 1/6
			)
		);

		/*sp.seq(~patternVolumeFadePre <> Ppar([
		~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
		<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
		<> Pn(Pdef(\penrose_canon_1),2) <> Pbind(\streamIndex, 2)
		<> ~penroseInstrState_maxCrushTo1_External,

		~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
		<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
		<> Pn(Pdef(\penrose_canon_pausen_1),2) <> Pbind(\streamIndex, 1)
		<> ~penroseInstrState_maxCrushTo1_External

		]) <> ~patternVolumeFadePost.(20, 1/6) // length, Delta mit dem baseTempo auf dem es laufen soll abstimmen
		);*/

		"penrose_canon_pausen1".postln;

		sp.seq(Ppar([
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_2.(
				inputPattern: Pdef(\penrose_canon_pausen_1)
			)
		])
		);

		"penrose_canon_pausen2".postln;

		sp.seq(Ppar([
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_2.(
				inputPattern: Pdef(\penrose_canon_pausen_2)
			)
		])
		);

		"penrose_canon_mehr_pausen x-fade".postln;

		sp.seq(
			~patternVolumeFade.(
				pat1:
				Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
				<> ~penroseInstrState_2.(
					inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen),2)),

				pat2:
				Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
				<> ~penroseInstrState_2.(
					inputPattern: Pn(Pdef(\penrose_canon_pausen_2),2)),

				length: 15,
				delta: 1/6
			)

			/*~patternVolumeFadePre <> Ppar([
			~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pn(Pdef(\penrose_canon_pausen_2),2) <> Pbind(\streamIndex, 2)
			<> ~penroseInstrState_maxCrushTo1_External, //\newBranchTest

			~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pn(Pdef(\penrose_canon_mehr_pausen),2) <> Pbind(\streamIndex, 1)
			<> ~penroseInstrState_maxCrushTo1_External
			]) <> ~patternVolumeFadePost.(15, 1/6)*/
		);

		"halftime fade in".postln;

		sp.par(Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_2.(
				inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen),4)
			)
		);
		sp.seq(
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_2.(
				inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen_ht),3))
			<> Pbind(\vol, Pseg([0,1,1],[20,11]))
		);

		"normaltime fade out".postln;

		sp.par(
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_2.(
				inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen_ht),3)
			)
		);
		sp.seq(
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_2.(
				inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen),4)
			)
			<> Pbind(\vol, Pseg([1,0,0],[20,11]))
		);

		"penrose_canon_mehr_pausen".postln;

		sp.seq(
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_2.(
				inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen_ht), 1)
			)
		);

		"penrose_canon_mehr_pausen2".postln;

		sp.seq(Ppar([
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> ~penroseInstrState_2.(
				inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen2), 1)
			)
		])
		);

		"penrose_canon_mehr_pausen3".postln;

		sp.seq(Ppar([
			Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
				<> ~penroseInstrState_2.(
					inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen3), 1)
			)
		])
		);


		"transition_penrose_simpleSwitch".postln;

		sp.seq(
			~patternNotesFade.(
				pat2:
				Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
				<> ~penroseInstrState_2.(
					inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen3))
				),

				pat1: Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
				<> ~penroseInstrState_2.(
					inputPattern: Pn(Pdef(\simpleSwitch))
				),

				delta: 1/8,
				weightPattern: Pbjorklund(
					Pstutter(
						Pseq([4,4,3,3,2,1]),
						Pseq([1,2,3,5,8,13]),
				),16)
			)

			/*~patternNotesFadePre
			<> Ppar([
			~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pn(Pdef(\penrose_canon_mehr_pausen3)) <> Pbind(\streamIndex, 2)
			<> ~penroseInstrState_maxCrushTo1_External, //\newBranchTest

			~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pn(Pdef(\simpleSwitch)) <> Pbind(\streamIndex, 1)
			<> ~penroseInstrState_maxCrushTo1_External
			])

			<> ~patternNotesFadePost.(1/8, Pbjorklund(
			Pstutter(
			Pseq([4,4,3,3,2,1]),
			Pseq([1,2,3,5,8,13]),
			),16) )*/

		);
	})
)