Pdef(\penrose_entwicklung2,
	Pspawner({ |sp|

		~lsys[\presets].weed_gen3.noteOffset = 0;
		~lsys[\presets].weed_gen2.noteOffset = 0;
		~lsys[\presets].weed_gen1.noteOffset = 0;
		~lsys[\presets].weed_gen0.noteOffset = 0;
		~lsys[\presets].weed_gen3.baseTempo = 6/16;
		~lsys[\presets].weed_gen2.baseTempo = 6/16;
		~lsys[\presets].weed_gen1.baseTempo = 9/16;
		~lsys[\presets].weed_gen0.baseTempo = 16/16;


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

		sp.seq(~patternVolumeFadePre <> Ppar([
			~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pn(Pdef(\penrose_canon_pausen_2),2) <> Pbind(\streamIndex, 2)
			<> ~penroseInstrState_maxCrushTo1_External, //\newBranchTest

			~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pn(Pdef(\penrose_canon_mehr_pausen),2) <> Pbind(\streamIndex, 1)
			<> ~penroseInstrState_maxCrushTo1_External
		]) <> ~patternVolumeFadePost.(15, 1/6)
		);

		"halftime fade in".postln;

		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pn(Pdef(\penrose_canon_mehr_pausen),4)
			<> ~penroseInstrState_maxCrushTo1_External,

			~patternVolumeFadePre <>
			~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pn(Pdef(\penrose_canon_mehr_pausen_ht),2) <> Pbind(\streamIndex, 1)
			<> ~penroseInstrState_maxCrushTo1_External
			<> ~patternVolumeFadePost.(15, 1/6)
		])
		);

		"normaltime fade out".postln;

		sp.seq(Ppar([
			~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pn(Pdef(\penrose_canon_mehr_pausen_ht),2)
			<> ~penroseInstrState_maxCrushTo1_External,

			~patternVolumeFadePre <>
			~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pn(Pdef(\penrose_canon_mehr_pausen),4) <> Pbind(\streamIndex, 2)
			<> ~penroseInstrState_maxCrushTo1_External
			<> ~patternVolumeFadePost.(15, 1/6)
		])
		);

		"penrose_canon_mehr_pausen".postln;

		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
			<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
			<> Pn(Pdef(\penrose_canon_mehr_pausen_ht), 1)
			<> ~penroseInstrState_maxCrushTo1_External
		])
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

		sp.seq(~patternNotesFadePre
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
		),16) ));
	})
)