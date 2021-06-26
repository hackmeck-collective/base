Pdef(\layers,
	Pspawner({ |sp|

		var weedOffset_1 = 24;
		var penroseOffset_1 = 12;
		var simpleSwitchOffset_1 = 0;

		"weed and penrose 2".postln;

		~lsys[\weed_gen2].baseTempo = 1/4;
		~lsys[\weed_gen2].noteOffset = weedOffset_1-5;
		~lsys[\weed_gen3].baseTempo = 1/4;
		~lsys[\weed_gen3].noteOffset = weedOffset_1-5;
		~lsys[\penrose_gen1].baseTempo = 1/6;
		~lsys[\penrose_gen1].noteOffset = penroseOffset_1+7;


		sp.seq(~weedInstrState_0 <> Pn(Pdef(\weed_gen3), 1));
		sp.par(~penroseInstrState_2
			<> Pseq([
				Pn(Pdef(\penrose_gen1), 7),
				Pn(Pdef(\penrose_gen0), 1),
			])
		);
		sp.seq(~weedInstrState_0 <> Pn(Pdef(\weed_gen3), 2));
		sp.seq(~weedInstrState_0 <> Pn(Pdef(\weed_gen2), 2));

		~lsys[\penrose_gen1].noteOffset = penroseOffset_1;
		~lsys[\penrose_gen1].baseTempo = 1/6;
		~lsys[\penrose_gen2].noteOffset = penroseOffset_1;
		~lsys[\penrose_gen2].baseTempo = 3/16;
		~lsys[\penrose_simple_gen1].noteOffset = penroseOffset_1;
		~lsys[\penrose_simple_gen1].baseTempo = 1/4;
		~lsys[\weed_gen2].noteOffset = weedOffset_1+7;
		~lsys[\weed_gen2].baseTempo = 1/4;
		~lsys[\weed_gen1].noteOffset = weedOffset_1+7;
		~lsys[\weed_gen1].baseTempo = 1/4;

		sp.par(~penroseInstrState_2 <> Pseq([Pdef(\penrose_gen2), Pdef(\penrose_gen1), Pdef(\penrose_simple_gen1)]));
		sp.seq(~weedInstrState_0 <> Pn(Pdef(\weed_gen2), 6));
		sp.par(~weedInstrState_0 <> Pseq([Pn(Pdef(\weed_gen1), 2),Pn(Pdef(\weed_gen0), 3)]));

		~lsys[\simpleSwitch_gen3].noteOffset = simpleSwitchOffset_1;
		~lsys[\simpleSwitch_gen2].noteOffset = simpleSwitchOffset_1;
		~lsys[\simpleSwitch_gen1].noteOffset = simpleSwitchOffset_1;
		~lsys[\simpleSwitch_gen0].noteOffset = simpleSwitchOffset_1;
		~lsys[\simpleSwitch_gen3].baseTempo = 3/16;
		~lsys[\simpleSwitch_gen2].baseTempo = 3/16;
		~lsys[\simpleSwitch_gen1].baseTempo = 3/16;
		~lsys[\simpleSwitch_gen0].baseTempo = 3/16;
		~lsys[\penrose_simple_gen1].baseTempo = 3/16;
		~lsys[\penrose_simple_gen2].baseTempo = 3/16;
		~lsys[\penrose_simple_gen3].baseTempo = 3/16;


		"simpleSwitch and weed".postln;

		sp.seq(~lcXlCtrBus1Bi.(25, 0.8)
			<> ~simpleSwitchInstrState_2
			<> Pseq([Pn(Pdef(\simpleSwitch_gen2), 4), Pdef(\simpleSwitch_gen3), Pdef(\simpleSwitch_gen2)])
			<> Pbind(\external1Target, "envelope_mod", \external1Target, "pitchOp_1_interval"));

		~lsys[\weed_gen3].noteOffset = weedOffset_1+12;
		~lsys[\weed_gen2].noteOffset = weedOffset_1+12;
		~lsys[\weed_gen1].noteOffset = weedOffset_1+12;
		~lsys[\weed_gen0].noteOffset = weedOffset_1+12;
		~lsys[\weed_gen3].baseTempo = 6/16;
		~lsys[\weed_gen2].baseTempo = 6/16;
		~lsys[\weed_gen1].baseTempo = 9/16;
		~lsys[\weed_gen0].baseTempo = 16/16;

		sp.par(~weedInstrState_0 <> Pseq([Pdef(\weed_gen2),Pdef(\weed_gen1),Pn(Pdef(\weed_gen0),3)]));

		sp.seq(Pn(~lcXlCtrBus1Bi.(25, 0.8)
			<> ~simpleSwitchInstrState_2
			<> Pseq([Pn(Pdef(\simpleSwitch_gen2), 2), Pn(Pdef(\simpleSwitch_gen1), 7), ])
			<> Pdef(\simpleSwitch_gen2)
			<> Pbind(\external1Target, "envelope_mod", \external1Target, "pitchOp_1_interval"), 2));

		sp.par(Pseq([Pdef(\weed_gen3),Pdef(\weed_gen1),Pn(Pdef(\weed_gen0),3)]));

		sp.seq(Pn(~lcXlCtrBus1Bi.(25, 0.8)
			<> ~simpleSwitchInstrState_2
			<> Pseq([Pn(Pdef(\simpleSwitch_gen2), 2), Pn(Pdef(\simpleSwitch_gen1), 9), ])
			<> Pdef(\simpleSwitch_gen2)
			<> Pbind(\external1Target, "envelope_mod", \external1Target, "pitchOp_1_interval"), 2));

		"simpleSwitch to penrose".postln;

		sp.par(~lcXlCtrBus1Bi.(25, 0.8)
			<> ~simpleSwitchInstrState_2
			<> Pseq([Pseq([Pdef(\simpleSwitch_gen1)],4),Pseq([Pdef(\simpleSwitch_gen0)],12)])
			<> Pbind(\external1Target, "envelope_mod", \external1Target, "pitchOp_1_interval"));


		sp.seq(~penroseInstrState_1
			<> Pseq([Pn(Pdef(\penrose_simple_gen1),8),
				Pn(Pdef(\penrose_simple_gen2),4),
				Pn(Pdef(\penrose_simple_gen1),2),
				Pn(Pdef(\penrose_simple_gen0),4)
			],2)
			<> Pbind(\external1Target, "oscillator_1_mod_2"));

		"weed".postln;

		sp.seq(Pseq([Pdef(\weed_gen3),Pdef(\weed_gen1),Pn(Pdef(\weed_gen0),3)]));

	})
)