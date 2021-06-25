Pdef(\penrose_entwicklung2,
	Pspawner({ |sp|

		~lsys[\weed_gen3].noteOffset = 0;
		~lsys[\weed_gen2].noteOffset = 0;
		~lsys[\weed_gen1].noteOffset = 0;
		~lsys[\weed_gen0].noteOffset = 0;
		~lsys[\weed_gen3].baseTempo = 6/16;
		~lsys[\weed_gen2].baseTempo = 6/16;
		~lsys[\weed_gen1].baseTempo = 9/16;
		~lsys[\weed_gen0].baseTempo = 16/16;


		"penrose_pauses_gen4".postln;

		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pn(Pdef(\penrose_pauses_gen4),1)
			<> ~penroseInstrState_maxCrushTo1_External
		])
		);

		"penrose_canon".postln;

		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pseq([Pdef(\penrose_canon_1),Pdef(\penrose_canon_2)], 2)
			<> ~penroseInstrState_maxCrushTo1_External
		])
		);

		"penrose_canon_pausen x fade".postln;

		sp.seq(
			~patternVolumeFade.(
				pat1: ~penroseInstrState_maxCrushTo1
				<> ~penroseInstrState_maxCrushTo1_Controller
				<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
				<> Pn(Pdef(\penrose_canon_1),2)
				<> ~penroseInstrState_maxCrushTo1_External,
				pat2: ~penroseInstrState_maxCrushTo1
				<> ~penroseInstrState_maxCrushTo1_Controller
				<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
				<> Pn(Pdef(\penrose_canon_pausen_1),2)
				<> ~penroseInstrState_maxCrushTo1_External,
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

		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pdef(\penrose_canon_pausen_1)
			<> ~penroseInstrState_maxCrushTo1_External
		])
		);

		"penrose_canon_pausen2".postln;

		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pdef(\penrose_canon_pausen_2)
			<> ~penroseInstrState_maxCrushTo1_External
		])
		);

		"penrose_canon_mehr_pausen x-fade".postln;

		sp.seq(
			~patternVolumeFade.(
				pat2: ~penroseInstrState_maxCrushTo1
				<> ~penroseInstrState_maxCrushTo1_Controller
				<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
				<> Pn(Pdef(\penrose_canon_pausen_2),2)
				<> ~penroseInstrState_maxCrushTo1_External,
				pat1: ~penroseInstrState_maxCrushTo1
				<> ~penroseInstrState_maxCrushTo1_Controller
				<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
				<> Pn(Pdef(\penrose_canon_mehr_pausen),2)
				<> ~penroseInstrState_maxCrushTo1_External,
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

		sp.par(~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pn(Pdef(\penrose_canon_mehr_pausen),4)
			<> ~penroseInstrState_maxCrushTo1_External
		);
		sp.seq(
			~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pn(Pdef(\penrose_canon_mehr_pausen_ht),3)
			<> ~penroseInstrState_maxCrushTo1_External
			<> Pbind(\vol, Pseg([0,1,1],[20,11]))
		);

		"normaltime fade out".postln;

		sp.par(
			~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pn(Pdef(\penrose_canon_mehr_pausen_ht),3)
			<> ~penroseInstrState_maxCrushTo1_External
		);
		sp.seq(
			~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pn(Pdef(\penrose_canon_mehr_pausen),4)
			<> ~penroseInstrState_maxCrushTo1_External
			<> Pbind(\vol, Pseg([1,0,0],[20,11]))
		);

		"penrose_canon_mehr_pausen".postln;

		sp.seq(
			~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pn(Pdef(\penrose_canon_mehr_pausen_ht), 1)
			<> ~penroseInstrState_maxCrushTo1_External
		);

		"penrose_canon_mehr_pausen2".postln;

		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pn(Pdef(\penrose_canon_mehr_pausen2), 1)
			<> ~penroseInstrState_maxCrushTo1_External
		])
		);

		"penrose_canon_mehr_pausen3".postln;

		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pn(Pdef(\penrose_canon_mehr_pausen3), 1)
			<> ~penroseInstrState_maxCrushTo1_External
		])
		);


		"transition_penrose_simpleSwitch".postln;

		sp.seq(
			~patternNotesFade.(
				pat2: ~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
				<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
				<> Pn(Pdef(\penrose_canon_mehr_pausen3))
				<> ~penroseInstrState_maxCrushTo1_External,
				pat1: ~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
				<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
				<> Pn(Pdef(\simpleSwitch))
				<> ~penroseInstrState_maxCrushTo1_External,
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