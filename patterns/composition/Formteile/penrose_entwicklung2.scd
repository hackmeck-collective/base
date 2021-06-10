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

		/*	"penrose_pauses_gen4".postln;
		sp.seq(Pn(Pdef(\penrose_pauses_gen4),1));
		"penrose_canon".postln;
		sp.seq(Pseq([Pdef(\penrose_canon_1),Pdef(\penrose_canon_2)], 2));*/

		/*"penrose_canon_pausen x fade".postln;
		sp.seq(~patternVolumeFadePre <> Ppar([
		Pn(Pdef(\penrose_canon_1),2) <> Pbind(\streamIndex, 2),
		Pn(Pdef(\penrose_canon_pausen_1),2) <> Pbind(\streamIndex, 1)
		]) <> ~patternVolumeFadePost.(20, 1/6) // length, Delta mit dem baseTempo auf dem es laufen soll abstimmen
		);
		"penrose_canon_pausen1".postln;
		sp.seq(Pdef(\penrose_canon_pausen_1));
		"penrose_canon_pausen2".postln;
		sp.seq(Pdef(\penrose_canon_pausen_2));
		"penrose_canon_mehr_pausen x-fade".postln;
		sp.seq(~patternVolumeFadePre <> Ppar([
		Pn(Pdef(\penrose_canon_pausen_2),2) <> Pbind(\streamIndex, 2), //\newBranchTest
		Pn(Pdef(\penrose_canon_mehr_pausen),2) <> Pbind(\streamIndex, 1)
		]) <> ~patternVolumeFadePost.(15, 1/6)
		);
		"halftime fade in".postln;
		sp.seq(Ppar([Pn(Pdef(\penrose_canon_mehr_pausen),4),
		~patternVolumeFadePre <>
		Pn(Pdef(\penrose_canon_mehr_pausen_ht),2) <> Pbind(\streamIndex, 1)
		<> ~patternVolumeFadePost.(15, 1/6)
		])
		);
		"normaltime fade out".postln;
		sp.seq(Ppar([Pn(Pdef(\penrose_canon_mehr_pausen_ht),2),
		~patternVolumeFadePre <>
		Pn(Pdef(\penrose_canon_mehr_pausen),4) <> Pbind(\streamIndex, 2)
		<> ~patternVolumeFadePost.(15, 1/6)
		])
		);

		"penrose_canon_mehr_pausen".postln;
		sp.seq(Pn(Pdef(\penrose_canon_mehr_pausen_ht), 1));
		"penrose_canon_mehr_pausen2".postln;
		sp.seq(Pn(Pdef(\penrose_canon_mehr_pausen2), 1));
		"penrose_canon_mehr_pausen3".postln;
		sp.seq(Pn(Pdef(\penrose_canon_mehr_pausen3), 1));*/
		"transition_penrose_simpleSwitch".postln;
		sp.seq(~patternNotesFadePre
			<> Ppar([
				Pn(Pdef(\penrose_canon_mehr_pausen3)) <> Pbind(\streamIndex, 2), //\newBranchTest
				Pn(Pdef(\simpleSwitch)) <> Pbind(\streamIndex, 1)
			])
			<> ~patternNotesFadePost.(1/8, Pbjorklund(
				Pstutter(
					Pseq([4,4,3,3,2,1]),
					Pseq([1,2,3,5,8,13]),
		),16) ));
	})
)