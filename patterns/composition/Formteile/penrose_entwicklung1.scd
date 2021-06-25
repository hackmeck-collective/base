Pdef(\penrose_entwicklung1,
	Pspawner({ |sp|

		~lsys[\penrose_simple_gen2].noteOffset = 0;
		~lsys[\penrose_toPause].noteOffset = 0;
		~lsys[\penrose_toPause2].noteOffset = 0;
		~lsys[\penrose_toPause3].noteOffset = 0;
		~lsys[\penrose_pauses_gen1].noteOffset = 0;
		~lsys[\penrose_pauses_gen2].noteOffset = 0;
		~lsys[\penrose_pauses_gen3].noteOffset = 0;


		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
		<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
		<> Pn(Pdef(\penrose_simple_gen2), 4)
		<> ~penroseInstrState_maxCrushTo1_External,
			Pn(Pdef(\penrose_simple_click_gen2), 4)
		])
		);

		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
		<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
		<> Pn(Pdef(\penrose_simple_gen1), 4)
		<> ~penroseInstrState_maxCrushTo1_External,
			Pn(Pdef(\penrose_simple_click_gen1), 4)])
		);

		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
		<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
		<> Pn(Pdef(\penrose_simplesimple_gen1), 4)
		<> ~penroseInstrState_maxCrushTo1_External],
			Pdef(\penrose_simple_click_gen0))
		);

		"penrose to pause".postln;
		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
		<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
		<> Pn(Pdef(\penrose_toPause), 4)
		<> ~penroseInstrState_maxCrushTo1_External,
			Pn(Pdef(\penrose_toPause_bd), 4)
		])
		);

		"penrose to pause2".postln;
		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
		<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
		<> Pn(Pdef(\penrose_toPause2), 4)
		<> ~penroseInstrState_maxCrushTo1_External,
			Pn(Pdef(\penrose_toPause2_bd), 4),
			Pn(Pdef(\penrose_toPause2_click), 4)])
		);

		"penrose to pause3".postln;
		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
		<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
		<> Pn(Pdef(\penrose_toPause3), 4)
		<> ~penroseInstrState_maxCrushTo1_External])
		);

		"penrose_pauses_gen1".postln;
		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
		<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
		<> Pn(Pdef(\penrose_pauses_gen1),4)
			<> ~penroseInstrState_maxCrushTo1_External,
			Pn(Pdef(\penrose_pauses_gen1_bd), 4)])
		);
		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
		<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
		<> Pn(Pdef(\penrose_pauses_gen1),4)
			<> ~penroseInstrState_maxCrushTo1_External,
			Pn(Pdef(\penrose_pauses_gen1_bd), 4),
			Pn(Pdef(\penrose_pauses_gen1_click), 4)])
		);

		"penrose_pauses_gen2".postln;
		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
		<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
		<> Pn(Pdef(\penrose_pauses_gen2),2)
		<> ~penroseInstrState_maxCrushTo1_External,
			Pn(Pdef(\penrose_pauses_gen2_bd), 2),
			Pn(Pdef(\penrose_pauses_gen1_click), 8)])
		);

		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
		<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
		<> Pn(Pdef(\penrose_pauses_gen2),2)
		<> ~penroseInstrState_maxCrushTo1_External,
			Pn(Pdef(\penrose_pauses_gen3_bd), 1),
			Pn(Pdef(\penrose_pauses_gen2_click), 2)])
		);

		"penrose_pauses_gen3".postln;
		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
		<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
		<> Pn(Pdef(\penrose_pauses_gen3),2)
		<> ~penroseInstrState_maxCrushTo1_External,
			Pn(Pdef(\penrose_pauses_gen3_bd), 2),
			Pn(Pdef(\penrose_pauses_gen3_click), 2)])
		);

		"penrose to pause3".postln;
		sp.seq(Ppar([~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
		<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
		<> Pn(Pdef(\penrose_toPause3), 4)
		<> ~penroseInstrState_maxCrushTo1_External])
		);
	})
)

