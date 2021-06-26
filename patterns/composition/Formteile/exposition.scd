Pdef(\exposition,
	Pspawner({ |sp|

		var weedOffset_1 = 24;
		var penroseOffset_1 = 17;
		var simpleSwitchOffset_1 = 24;

		~sendFX.ef_reverb.set(\inBus, ~ef_reverb,
			\revtime, 3,
			\predelay, 0.025,
			\hpf, 60,
			\lpf, 4500,
			\spread, 1,
			\vol, 3,
			\beatDurNow, ~linkClock.tempo,
			\sidechain_amount, (-24).dbamp);

		"weed buildup 1".postln;

		~lsys[\weed_gen1].noteOffset = weedOffset_1;
		~lsys[\weed_gen1].baseTempo = 1;
		~lsys[\weed_gen2].noteOffset = weedOffset_1;
		~lsys[\weed_gen2].baseTempo = 3/4;

		sp.seq(~weedInstrController_0to2
		<> ~weedInstrState_1 <> ~weedInstrModsState_1
		<> Pbind(\envelope_mod, 0.8)
		<> Pseq([
		Pdef(\weed_gen1),
		Pdef(\weed_gen2)
		],2)
		<> ~weedInstrExternal_1 <> ~weedInstrModTargets_1 <> Pbind(\external1Target, "envelope_mod")
		);

		~lsys[\weed_gen1].noteOffset = weedOffset_1;
		~lsys[\weed_gen1].baseTempo = 1/2;
		~lsys[\weed_gen2].noteOffset = weedOffset_1;
		~lsys[\weed_gen2].baseTempo = 3/8;

		sp.seq(~weedInstrController_0to2
		<> ~weedInstrState_1 <> ~weedInstrModsState_1
		<> Pbind(\envelope_mod, 0.8)
		<> Pseq([
		Pdef(\weed_gen1),
		Pdef(\weed_gen2)
		],1)
		<> ~weedInstrExternal_1 <> ~weedInstrModTargets_1 <> Pbind(\external1Target, "envelope_mod")
		);

		~lsys[\weed_gen1].noteOffset = weedOffset_1;
		~lsys[\weed_gen1].baseTempo = 1/4;
		~lsys[\weed_gen2].noteOffset = weedOffset_1;
		~lsys[\weed_gen2].baseTempo = 1/4;
		~lsys[\weed_gen3].noteOffset = weedOffset_1;
		~lsys[\weed_gen3].baseTempo = 1/4;
		~lsys[\weed_reverse_gen0].noteOffset = weedOffset_1;
		~lsys[\weed_reverse_gen0].baseTempo = 1;
		~lsys[\weed_reverse_gen1].noteOffset = weedOffset_1;
		~lsys[\weed_reverse_gen1].baseTempo = 3/4;
		~lsys[\weed_reverse_gen2].noteOffset = weedOffset_1;
		~lsys[\weed_reverse_gen2].baseTempo = 4/8;
		~lsys[\weed_reverse_gen3].noteOffset = weedOffset_1;
		~lsys[\weed_reverse_gen3].baseTempo = 3/8;

		sp.seq(~weedInstrController_0to2
		<> ~weedInstrState_1 <> ~weedInstrModsState_1
		<> Pbind(\envelope_mod, 0.8)
		<> Pseq([
		Pseq([
		Pdef(\weed_gen1),
		Pdef(\weed_gen2)],2),
		Pdef(\weed_gen3),
		Pdef(\weed_reverse_gen3),
		Pdef(\weed_reverse_gen2),
		Pdef(\weed_reverse_gen1),
		Pseq([Pdef(\weed_reverse_gen0)],3),
		])
		<> ~weedInstrExternal_1 <> ~weedInstrModTargets_1 <> Pbind(\external1Target, "envelope_mod")
		);

		sp.wait(8);

		"penrose buildup 1".postln; // mit percussion und umgedreht

		~lsys[\penrose_simplesimple_gen1].noteOffset = penroseOffset_1;
		~lsys[\penrose_simplesimple_gen1].baseTempo = 3/16;
		~lsys[\penrose_simple_gen1].noteOffset = penroseOffset_1;
		~lsys[\penrose_simple_gen1].baseTempo = 3/16;
		~lsys[\penrose_simple_gen2].noteOffset = penroseOffset_1;
		~lsys[\penrose_simple_gen2].baseTempo = 3/16;
		~lsys[\penrose_simple_gen0].noteOffset = penroseOffset_1;
		~lsys[\penrose_simple_gen0].baseTempo = 3/16;

		sp.seq(~lcXlCtrBus1Bi.(24) <> ~lcXlCtrBus2Bi.(25) <> ~lcXlCtrBus3Bi.(25, -0.5) <> ~penroseInstrState_1 <> Pbind(\envelope_mod, 0.35)
		<> Pseq([
		Pn(Pdef(\penrose_simplesimple_gen1),8),
		Pn(Pdef(\penrose_simple_gen1),5),
		Pn(Pdef(\penrose_simple_gen2),2),
		Pn(Pdef(\penrose_simple_gen1),3),
		Pn(Pdef(\penrose_simplesimple_gen1),2)
		/*					Pdef(\penrose_simple_gen2),
		Pn(Pdef(\penrose_simple_gen1),2),*/
		])
		<> Pbind(\external1Target, "envelope_mod",
		\external2Target, "oscillator_2_level",
		\external2Target2, "oscillator_1_mod_1",
		));

		~lsys[\penrose_simple_gen1].noteOffset = penroseOffset_1 -12;
		~lsys[\penrose_simple_gen1].baseTempo = 3/16;
		~lsys[\penrose_simple_gen2].noteOffset = penroseOffset_1 -12;
		~lsys[\penrose_simple_gen2].baseTempo = 3/16;
		~lsys[\penrose_simple_gen3].legatoArr = 0.1;
		~lsys[\penrose_simple_gen3].noteOffset = penroseOffset_1 -12;
		~lsys[\penrose_simple_gen3].baseTempo = 3/16;
		~lsys[\penrose_simplesimple_gen1].noteOffset = penroseOffset_1 -12;
		~lsys[\penrose_simplesimple_gen1].baseTempo = 3/16;

		sp.seq(~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
		<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
		<> Pdef(\penrose_simple_gen3)
		<> ~penroseInstrState_maxCrushTo1_External
		);

		sp.seq(~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
		<> Pbind(\envelope_mod, 0)
		<> Pseq([
		Pn(Pdef(\penrose_simple_gen2),2),
		Pn(Pdef(\penrose_simple_gen1),1),
		Pn(Pdef(\penrose_simplesimple_gen1),4)
		])
		<> ~penroseInstrState_maxCrushTo1_External
		);

		"simpleSwitch buildup 1".postln;

		~lsys[\penrose_simplesimple_gen1].noteOffset = penroseOffset_1 -12;
		~lsys[\penrose_simplesimple_gen1].baseTempo = 3/16;
		~lsys[\penrose_simplesimple_gen0].noteOffset = penroseOffset_1 -12;
		~lsys[\penrose_simplesimple_gen0].baseTempo = 8/16;
		~lsys[\simpleSwitch_gen0].noteOffset = simpleSwitchOffset_1;
		~lsys[\simpleSwitch_gen0].baseTempo = 2/16;
		~lsys[\simpleSwitch_gen1].noteOffset = simpleSwitchOffset_1;
		~lsys[\simpleSwitch_gen1].baseTempo = 2/16;
		~lsys[\simpleSwitch_gen2].noteOffset = simpleSwitchOffset_1;
		~lsys[\simpleSwitch_gen2].baseTempo = 2/16;
		~lsys[\simpleSwitch_gen3].noteOffset = simpleSwitchOffset_1;
		~lsys[\simpleSwitch_gen3].baseTempo = 2/16;

		sp.seq(~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
		<> Pbind(\envelope_mod, 0)
		<>  Pdef(\penrose_simplesimple_gen1)
		<> Pbind(\external1Target, "envelope_mod")
		<> ~penroseInstrState_maxCrushTo1_External);

		sp.par(~lcXlCtrBus1Bi.(24) <> Pbind(\envelope_mod, 0.35)
		<> Pseq([
		Pseq([Pdef(\penrose_simplesimple_gen1)],3),
		Pseq([Pdef(\penrose_simplesimple_gen0)],4)
		]) <> Pbind(\external1Target, "envelope_mod"));
		sp.seq(~simpleSwitchInstrState_1 <> ~simpleSwitchModsState_1 <> ~simpleSwitchInstrController_1
		<> Pseq([
		Pseq([Pdef(\simpleSwitch_gen0)],12),
		Pseq([Pdef(\simpleSwitch_gen1)],2),
		Pseq([Pdef(\simpleSwitch_gen2)]),
		Pseq([Pdef(\simpleSwitch_gen3)]), // percussion
		Pseq([Pdef(\simpleSwitch_gen2)]),
		Pseq([Pdef(\simpleSwitch_gen1)],1),
		Pseq([Pdef(\simpleSwitch_gen0)],2),
		])
		<> Pbind(\external1Target, "envelope_mod")
		<> ~simpleSwitchExternal_1 <> ~simpleSwitchModTargets_1);

		sp.wait(2); // pausenlänge überprüfen

		"weed and penrose".postln;

		~lsys[\weed_gen2].noteOffset = weedOffset_1;
		~lsys[\weed_gen2].baseTempo = 2/8;
		~lsys[\weed_gen1].noteOffset = weedOffset_1;
		~lsys[\weed_gen1].baseTempo = 3/8;
		~lsys[\weed_gen0].noteOffset = weedOffset_1;
		~lsys[\weed_gen0].baseTempo = 2/4;
		~lsys[\penrose_gen1].noteOffset = penroseOffset_1;
		~lsys[\penrose_gen1].baseTempo = 1/6;
		~lsys[\penrose_gen0].noteOffset = penroseOffset_1;
		~lsys[\penrose_gen0].baseTempo = 1/3;

		sp.seq(~weedInstrController_0to2
		<> ~weedInstrState_2 <> ~weedInstrModsState_1
		<> Pbind(\envelope_mod, 0.95)
		<> Pseq([
		Pn(Pdef(\weed_gen0), 2),
		Pn(Pdef(\weed_gen1), 2),
		Pn(Pdef(\weed_gen2), 1)
		],1)
		<> ~weedInstrExternal_2 <> ~weedInstrModTargets_1);

		sp.wait(2);

		sp.seq(Ppar([~lcXlCtrBus1Bi.(24) <> ~lcXlCtrBus2Bi.(25) <> ~lcXlCtrBus3Bi.(25, -0.5) <> ~penroseInstrState_1
		<> Pbind(\envelope_mod, 0.01)
		<> Pn(Pdef(\penrose_gen1), 2)
		<> Pbind(
		\external2Target, "oscillator_2_level",
		\external2Target2, "oscillator_1_mod_1",
		),
		Pn(Pdef(\penrose_click_gen1),2)])
		);
		sp.par(Ppar([~lcXlCtrBus1Bi.(24) <> ~lcXlCtrBus2Bi.(25) <> ~lcXlCtrBus3Bi.(25, -0.5) <> ~penroseInstrState_1
		<> Pbind(\envelope_mod, 0.01)
		<> Pseq([Pn(Pdef(\penrose_gen1), 4), Pn(Pdef(\penrose_gen0), 2)])
		<> Pbind(
		\external2Target, "oscillator_2_level",
		\external2Target2, "oscillator_1_mod_1",
		),
		Pseq([Pn(Pdef(\penrose_click_gen1),2),Pdef(\penrose_click_gen0)])
		])
		);

		sp.wait(1);


		"weed and simpleswitch".postln;

		~lsys[\weed_gen1].baseTempo = 3/4;
		~lsys[\weed_gen1].noteOffset = weedOffset_1-7;
		~lsys[\weed_gen2].baseTempo = 2/4;
		~lsys[\weed_gen2].noteOffset = weedOffset_1-7;

		sp.seq(~weedInstrController_0to2
			<> ~weedInstrState_1 <> ~weedInstrModsState_1
			<> Pbind(\envelope_mod, 0.95)
			<> Pseq([
				Pn(Pdef(\weed_gen1), 2),
				Pn(Pdef(\weed_gen2), 1)
			],1)
			<> ~weedInstrExternal_1 <> ~weedInstrModTargets_1);

		~lsys[\simpleSwitch_gen0].noteOffset = simpleSwitchOffset_1-24;
		~lsys[\simpleSwitch_gen0].baseTempo = 4/16;
		~lsys[\simpleSwitch_gen1].noteOffset = simpleSwitchOffset_1-24;
		~lsys[\simpleSwitch_gen1].baseTempo = 2/16;
		~lsys[\simpleSwitch_gen2].noteOffset = simpleSwitchOffset_1-24;
		~lsys[\simpleSwitch_gen2].baseTempo = 2/16;
		~lsys[\simpleSwitch_gen3].noteOffset = simpleSwitchOffset_1-24;
		~lsys[\simpleSwitch_gen3].baseTempo = 2/16;
		~lsys[\weed_gen2].baseTempo = 1/2;
		~lsys[\weed_gen2].noteOffset = weedOffset_1-7;
		~lsys[\weed_gen1].baseTempo = 3/4;
		~lsys[\weed_gen1].noteOffset = weedOffset_1-7;
		~lsys[\weed_gen0].baseTempo = 1;
		~lsys[\weed_gen0].noteOffset = weedOffset_1-7;
		~lsys[\weed_reverse_gen1].baseTempo = 3/8;
		~lsys[\weed_reverse_gen1].noteOffset = weedOffset_1-7;
		~lsys[\weed_reverse_gen2].baseTempo = 1/2;
		~lsys[\weed_reverse_gen2].noteOffset = weedOffset_1-7;
		~lsys[\weed_reverse_gen0].baseTempo = 1/4;
		~lsys[\weed_reverse_gen0].noteOffset = weedOffset_1-7;

		sp.par(~lcXlCtrBus1Bi.(25, 0.4)
			<> ~simpleSwitchInstrState_2
			<> Pseq([
				Pn(Pdef(\simpleSwitch_gen3),2),
				Pn(Pdef(\simpleSwitch_gen2),3),
				Pn(Pdef(\simpleSwitch_gen1),5),
				Pn(Pdef(\simpleSwitch_gen0),8),
		]));

		sp.seq(~weedInstrController_0to2
			<> ~weedInstrState_1 <> ~weedInstrModsState_1
			<> Pbind(\envelope_mod, 1.1)
			<> Pseq([
				Pn(Pdef(\weed_gen0), 3),
				Pn(Pdef(\weed_gen1), 2),
				Pn(Pdef(\weed_gen2), 1),
				Pn(Pdef(\weed_reverse_gen2), 1),
				Pn(Pdef(\weed_reverse_gen1), 1),
				Pn(Pdef(\weed_reverse_gen0), 3)
			],1)
			<> ~weedInstrExternal_1 <> ~weedInstrModTargets_1);

		~lsys[\weed_reverse_gen0].baseTempo = 4/4;

		sp.seq(~weedInstrController_0to2
			<> ~weedInstrState_1 <> ~weedInstrModsState_1
			<> Pbind(\envelope_mod, 1.5)
			<> Pn(Pdef(\weed_reverse_gen0), 2)
			<> ~weedInstrExternal_1 <> ~weedInstrModTargets_1);

		sp.wait(2);

	})

)