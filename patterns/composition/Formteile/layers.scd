Pdef(\layers,
	Pspawner({ |sp|

		var weedOffset_1 = 24;
		var penroseOffset_1 = 12;
		var simpleSwitchOffset_1 = 0;

		/*"weed and penrose 2".postln;

		~lsys[\weed_gen2].baseTempo = 1/4;
		~lsys[\weed_gen2].noteOffset = weedOffset_1-5;
		~lsys[\weed_gen3].baseTempo = 1/4;
		~lsys[\weed_gen3].noteOffset = weedOffset_1-5;
		~lsys[\penrose_gen1].baseTempo = 1/6;
		~lsys[\penrose_gen1].noteOffset = penroseOffset_1+7;


		sp.seq(~weedInstrState_3.(
		inputPattern: Pn(Pdef(\weed_gen3), 1))
		);
		sp.par(~penroseInstrState_3.(
		inputPattern: Pseq([
		Pn(Pdef(\penrose_gen1), 7),
		Pn(Pdef(\penrose_gen0), 1),
		])
		)
		);

		sp.seq(~weedInstrState_3.(
		inputPattern: Pseq([
		Pn(Pdef(\weed_gen3), 2),
		Pn(Pdef(\weed_gen2), 2)
		])
		));

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

		sp.par(~penroseInstrState_1.(
		inputPattern: Pseq([
		Pdef(\penrose_gen2),
		Pdef(\penrose_gen1),
		Pdef(\penrose_simple_gen1)
		])
		));
		sp.seq(~weedInstrState_3.(
		inputPattern: Pn(Pdef(\weed_gen2), 6))
		);
		sp.par(~weedInstrState_3.(
		inputPattern: Pseq([
		Pn(Pdef(\weed_gen1), 2),
		Pn(Pdef(\weed_gen0), 3)
		])
		));

		~lsys[\simpleSwitch_gen3].noteOffset = simpleSwitchOffset_1;
		~lsys[\simpleSwitch_gen2].noteOffset = simpleSwitchOffset_1;
		~lsys[\simpleSwitch_gen1].noteOffset = simpleSwitchOffset_1;
		~lsys[\simpleSwitch_gen0].noteOffset = simpleSwitchOffset_1;
		~lsys[\simpleSwitch_gen3].baseTempo = 3/16;
		~lsys[\simpleSwitch_gen2].baseTempo = 3/16;
		~lsys[\simpleSwitch_gen1].baseTempo = 3/16;
		~lsys[\simpleSwitch_gen0].baseTempo = 3/16;
		~lsys[\simpleSwitch_click_gen3].baseTempo = 3/16;
		~lsys[\simpleSwitch_click_gen2].baseTempo = 3/16;
		~lsys[\simpleSwitch_click_gen1].baseTempo = 3/16;
		~lsys[\simpleSwitch_click_gen0].baseTempo = 3/16;



		"simpleSwitch and weed".postln;

		sp.seq(~simpleSwitchInstrState_2.(
			inputPattern: Pseq([
				Pn(Pdef(\simpleSwitch_gen2), 4),
				Pdef(\simpleSwitch_gen3),
				Pdef(\simpleSwitch_gen2)
			])
		));


		~lsys[\weed_gen2].noteOffset = weedOffset_1+12;
		~lsys[\weed_gen1].noteOffset = weedOffset_1+12;
		~lsys[\weed_gen0].noteOffset = weedOffset_1+12;

		~lsys[\weed_gen2].baseTempo = 6/16;
		~lsys[\weed_gen1].baseTempo = 9/16;
		~lsys[\weed_gen0].baseTempo = 16/16;

		sp.par(~weedInstrState_3.(
			inputPattern: Pseq([
				Pdef(\weed_gen2),
				Pdef(\weed_gen1),
				Pn(Pdef(\weed_gen0),3)
			])
		)
		);


		sp.seq(~simpleSwitchInstrState_2.(
			inputPattern: Pseq([
				Pn(Pdef(\simpleSwitch_gen2), 2),
				Pn(Pdef(\simpleSwitch_gen1), 7)
			], 1)
		));
		sp.seq(Ppar([
			~simpleSwitchInstrState_3.(
			inputPattern: Pseq([
				Pn(Pdef(\simpleSwitch_gen2), 2),
				Pn(Pdef(\simpleSwitch_gen1), 7)
			], 1)),
			~clickInstrState_2.(
				inputPattern: Pseq([
				Pn(Pdef(\simpleSwitch_click_gen2), 2),
				Pn(Pdef(\simpleSwitch_click_gen1), 7)
			], 1)
			)
		])
		);

		~lsys[\weed_gen3].noteOffset = weedOffset_1-7;
		~lsys[\weed_gen1].noteOffset = weedOffset_1-7;
		~lsys[\weed_gen0].noteOffset = weedOffset_1-7;

		~lsys[\weed_gen3].baseTempo = 6/16;
		~lsys[\weed_gen1].baseTempo = 9/16;
		~lsys[\weed_gen0].baseTempo = 16/16;

		sp.par(~weedInstrState_2_short.(
			inputPattern: Pseq([
				Pdef(\weed_gen3),
				Pdef(\weed_gen1),
				Pn(Pdef(\weed_gen0),3)
		]))
		);

		sp.seq(~simpleSwitchInstrState_2.(
			inputPattern: Pseq([
				Pn(Pdef(\simpleSwitch_gen2), 2),
				Pn(Pdef(\simpleSwitch_gen1), 8)
			], 2)
		));

		sp.seq(~simpleSwitchInstrState_3.(
			inputPattern:
				Pn(Pdef(\simpleSwitch_gen1), 1)
		));



		"simpleSwitch to penrose".postln;

		/*soundCue = "SimpleSwitch: 1 -> 0"
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlKnobLEDsSetRow.(3,1);
		~launchControlXlUpdateKnobLEDs.value;*/
*/
		~lsys[\penrose_simple_gen0].baseTempo = 3/16;
		~lsys[\penrose_simple_gen1].baseTempo = 3/16;
		~lsys[\penrose_simple_gen2].baseTempo = 3/16;
		~lsys[\penrose_simple_gen3].baseTempo = 3/16;

		~lsys[\penrose_simple_gen0].noteOffset = 0;
		~lsys[\penrose_simple_gen1].noteOffset = 0;
		~lsys[\penrose_simple_gen2].noteOffset = 0;
		~lsys[\penrose_simple_gen3].noteOffset = 0;

		sp.par(~simpleSwitchInstrState_3.(
		inputPattern: Pseq([
		Pn(Pdef(\simpleSwitch_gen1),4),
		Pn(Pdef(\simpleSwitch_gen0),12)
		])
		));



		sp.seq(Pbind(\amp, 3.dbamp)
			<> ~penroseInstrState_1.(
		inputPattern: Pseq([
		Pn(Pdef(\penrose_simple_gen1),8),
		],1)
		));
		sp.seq(Pbind(\amp, 6.dbamp)
			<> ~penroseInstrState_1.(
		inputPattern: Pseq([
		Pn(Pdef(\penrose_simple_gen2),4),
		],1)
		));
		sp.seq(Pbind(\amp, 6.dbamp)
			<> ~penroseInstrState_2.(
		inputPattern: Pseq([
		Pn(Pdef(\penrose_simple_gen1),2),
		Pn(Pdef(\penrose_simple_gen0),4)
		],1)
		));
		sp.seq(Pbind(\amp, 6.dbamp)
			<> ~penroseInstrState_3.(
		inputPattern: Pseq([
		Pn(Pdef(\penrose_simple_gen1),8),
		Pn(Pdef(\penrose_simple_gen2),4),
		],1)
		));
		sp.seq(Pbind(\amp, 6.dbamp)
			<> ~penroseInstrState_2.(
		inputPattern: Pseq([
		Pn(Pdef(\penrose_simple_gen1),2),
		Pn(Pdef(\penrose_simple_gen0),4)
		],1)
		));


		"weed".postln;

		sp.seq(Pbind(\amp, Pseg([12.dbamp, -3.dbamp],12.1875),
			\vca_attack, 1,
		\vca_release, Pseg([1, 4],12.1875),
		)
			<> ~weedInstrState_3.(
		inputPattern: Pseq([
		Pdef(\weed_gen3),
		Pdef(\weed_gen1),
		Pn(Pdef(\weed_gen0),3)
		])
		)
		);

	})
)