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

		~audioBusses.effectBus.set(
			\eqLoShelf_freq, 200, \eqLoShelf_q, 0.3, \eqLoShelf_db, -5,
			\eqBand1_freq, 350, \eqBand1_q, 0.5, \eqBand1_db, -3,
			\eqBand2_freq, 2000, \eqBand2_q, 0.5,  \eqBand2_db, -3,
			\eqBand3_freq, 4000, \eqBand3_q, 1,  \eqBand3_db, -3,
			\eqHiShelf_freq, 5000, \eqHiShelf_q, 0.8, \eqHiShelf_db, 6,
		);

		~audioBusses.melodyBus.set(
			\eqLoShelf_freq, 200, \eqLoShelf_q, 0.3, \eqLoShelf_db, -5,
			\eqBand1_freq, 350, \eqBand1_q, 1, \eqBand1_db, -3,
			\eqBand2_freq, 2000, \eqBand2_q, 1.3,  \eqBand2_db, 4,
			\eqBand3_freq, 4000, \eqBand3_q, 0.4,  \eqBand3_db, -4,
			\eqHiShelf_freq, 5000, \eqHiShelf_q, 0.8, \eqHiShelf_db, -3,
		);

		~audioBusses.chordsBus.set(
			\eqLoShelf_freq, 200, \eqLoShelf_q, 0.3, \eqLoShelf_db, -5,
			\eqBand1_freq, 500, \eqBand1_q, 1, \eqBand1_db, 6,
			\eqBand2_freq, 2000, \eqBand2_q, 0.5,  \eqBand2_db, -3,
			\eqBand3_freq, 4500, \eqBand3_q, 1,  \eqBand3_db, -6,
			\eqHiShelf_freq, 5000, \eqHiShelf_q, 0.5, \eqHiShelf_db, -10,
		);

		~audioBusses.drumsBus.set(
			\eqLoShelf_freq, 30, \eqLoShelf_q, 2, \eqLoShelf_db, 0,
			\eqBand1_freq, 350, \eqBand1_q, 1, \eqBand1_db, 6,
			\eqBand2_freq, 1500, \eqBand2_q, 0.5,  \eqBand2_db, 6,
			\eqBand3_freq, 5000, \eqBand3_q, 1,  \eqBand3_db, -3,
			\eqHiShelf_freq, 5000, \eqHiShelf_q, 0.8, \eqHiShelf_db, 6,
		);

		~audioBusses.auxBus.set(
			\eqLoShelf_freq, 200, \eqLoShelf_q, 0.3, \eqLoShelf_db, -5,
			\eqBand1_freq, 350, \eqBand1_q, 1, \eqBand1_db, -3,
			\eqBand2_freq, 3500, \eqBand2_q, 0.85,  \eqBand2_db, 6,
			\eqBand3_freq, 750, \eqBand3_q, 1,  \eqBand3_db, 3,
			\eqHiShelf_freq, 7500, \eqHiShelf_q, 0.8, \eqHiShelf_db, -2,
		);

		sp.wait(1);

		"weed buildup 1".postln;
		~cueSymbols[\new] = 'weed buildup 1';


		/*soundCue = "Weed: 1 -> 0; masterFilter: 0.5 -> 1"
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlKnobLEDsSetRow.([1,8],1);
		~launchControlXlUpdateKnobLEDs.value;*/

		~lsys[\weed_gen1].noteOffset = weedOffset_1;
		~lsys[\weed_gen1].baseTempo = 1;
		~lsys[\weed_gen2].noteOffset = weedOffset_1;
		~lsys[\weed_gen2].baseTempo = 3/4;
		~lsys[\fuge_excerpt_gen1].baseTempo = 0.0625;

		sp.seq(Pseq([
		Pbind(\amp, Pseg([-12.dbamp,6.dbamp], 6),
		\oscillator_1_mod_1, Pseg([0,2], 6),
		\oscillator_2_mod_1, Pseg([0,0.4], 6)
		)
		<> ~fugeInstrState_0.(
		inputPattern: Pn(Pdef(\fuge_excerpt_gen1), 16)
		),
		Pbind(\vca_attack, 2,
		\vca_release, 4,)
		<> ~weedInstrState_1.(
		inputPattern: Pseq([
		Pdef(\weed_gen1),
		Pdef(\weed_gen2)
		])),
		])
		);

		~lsys[\fuge_excerpt_gen1].baseTempo = 0.03125;

		sp.seq(Pseq([
		Pbind(\amp, Pseg([-12.dbamp,6.dbamp], 3),
		\oscillator_1_mod_1, Pseg([0,2.5], 3),
		\oscillator_2_mod_1, Pseg([0,0.6], 3)
		)
		<> ~fugeInstrState_0.(
		inputPattern: Pn(Pdef(\fuge_excerpt_gen1), 16)
		),
		Pbind(\vca_attack, 1,
		\vca_release, 2,)
		<> ~weedInstrState_1.(
		inputPattern: Pseq([
		Pdef(\weed_gen1),
		Pdef(\weed_gen2)
		])),
		])
		);

		~lsys[\weed_gen1].noteOffset = weedOffset_1;
		~lsys[\weed_gen1].baseTempo = 1/2;
		~lsys[\weed_gen2].noteOffset = weedOffset_1;
		~lsys[\weed_gen2].baseTempo = 3/8;

		sp.seq(Pbind(\vca_attack, 1,
		\vca_release, 2,)
		<> ~weedInstrState_1.(
		inputPattern: Pseq([
		Pdef(\weed_gen1),
		Pdef(\weed_gen2)
		],1))
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

		sp.seq(Pbind(\vca_attack, 0.5,
		\vca_release, 1,)
		<> ~weedInstrState_1.(
		inputPattern: Pseq([
		Pseq([
		Pdef(\weed_gen1),
		Pdef(\weed_gen2)],2),
		Pdef(\weed_gen3),
		Pdef(\weed_reverse_gen3),

		]))
		);

		sp.seq(Pbind(\vca_attack, 0.5,
			\vca_release, Pseg([1,5],7))
		<> ~weedInstrState_1.(
			inputPattern: Pseq([
				Pdef(\weed_reverse_gen2),
				Pdef(\weed_reverse_gen1),
				Pseq([Pdef(\weed_reverse_gen0)],3),
		]))
		);


		sp.wait(8);

		"penrose buildup 1".postln; // mit percussion und umgedreht

		/*soundCue = "SimpleSwitch: X -> 0;"
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlKnobLEDsSetRow.([3,8],3);
		~launchControlXlUpdateKnobLEDs.value;*/

		~lsys[\penrose_simplesimple_gen1].noteOffset = penroseOffset_1;
		~lsys[\penrose_simplesimple_gen1].baseTempo = 3/16;
		~lsys[\penrose_simple_gen1].noteOffset = penroseOffset_1;
		~lsys[\penrose_simple_gen1].baseTempo = 3/16;
		~lsys[\penrose_simple_gen2].noteOffset = penroseOffset_1;
		~lsys[\penrose_simple_gen2].baseTempo = 3/16;
		~lsys[\penrose_simple_gen0].noteOffset = penroseOffset_1;
		~lsys[\penrose_simple_gen0].baseTempo = 3/16;

		sp.seq(~penroseInstrState_1.(
			inputPattern: Pseq([
				Pn(Pdef(\penrose_simplesimple_gen1),8),
				Pn(Pdef(\penrose_simple_gen1),5),
				Pn(Pdef(\penrose_simple_gen2),2),
				Pn(Pdef(\penrose_simple_gen1),3),
				Pn(Pdef(\penrose_simplesimple_gen1),2)
			])
		)
		);

		~lsys[\penrose_simple_gen0].noteOffset = penroseOffset_1 -12;
		~lsys[\penrose_simple_gen0].baseTempo = 3/16;
		~lsys[\penrose_simple_gen1].noteOffset = penroseOffset_1 -12;
		~lsys[\penrose_simple_gen1].baseTempo = 3/16;
		~lsys[\penrose_simple_gen2].noteOffset = penroseOffset_1 -12;
		~lsys[\penrose_simple_gen2].baseTempo = 3/16;
		~lsys[\penrose_simple_gen3].legatoArr = 0.1;
		~lsys[\penrose_simple_gen3].noteOffset = penroseOffset_1 -12;
		~lsys[\penrose_simple_gen3].baseTempo = 3/16;
		~lsys[\penrose_simplesimple_gen1].noteOffset = penroseOffset_1 -12;
		~lsys[\penrose_simplesimple_gen1].baseTempo = 3/16;

		sp.seq(~penroseInstrState_2.(
			inputPattern: Pdef(\penrose_simple_gen3))
		);



		sp.seq(~penroseInstrState_1.(
			inputPattern: Pseq([
				Pn(Pdef(\penrose_simple_gen2),2),
				Pn(Pdef(\penrose_simple_gen1),1),
			])
		)
		);

		sp.par(~penroseInstrState_1.(
			inputPattern: Pdef(\penrose_simple_gen0)
		)
		);

		~lsys[\fuge_excerpt_gen1].baseTempo =1.5/16;

		sp.seq(
			Pbind(\amp, 6.dbamp,
				\oscillator_1_mod_1, 4,
				\oscillator_2_mod_1, 1,
				\envelope_mod, 0,
			)
			<> ~fugeInstrState_0.(
				inputPattern: Pn(Pdef(\fuge_excerpt_gen1), 2)
			)
		);



~lsys[\fuge_excerpt_gen1].baseTempo = 0.0625;

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

		sp.seq(Pbind(\envelope_mod, Pseg([0,0.2],0.35))
			<> ~penroseInstrState_2.(
				inputPattern: Pn(Pdef(\penrose_simplesimple_gen1),5)
			)
		);

		sp.par(Pbind(\envelope_mod, Pseg([0.2,0.4],1))
			<> ~penroseInstrState_1.(
				inputPattern: Pseq([
					Pseq([Pdef(\penrose_simplesimple_gen1)],3),
					Pseq([Pdef(\penrose_simplesimple_gen0)],4)
				])
			)
		);


		/*soundCue = "SimpleSwitch: 0 -> 1;"
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlKnobLEDsSetRow.(3,1);
		~launchControlXlUpdateKnobLEDs.value;*/

		sp.seq(Pbind(
			\amp, Pseg([-24.dbamp,-12.dbamp,-15.dbamp],[1.25,12]),
			\envelope_mod, Pseg([0.01,0.5,1.1],[12,1.25])
		)
		<>	~simpleSwitchInstrState_1.(
			inputPattern: Pseq([
				Pn(Pdef(\simpleSwitch_gen0),12),
				Pn(Pdef(\simpleSwitch_gen1),2),
				Pn(Pdef(\simpleSwitch_gen2),1),
				Pseq([Pdef(\simpleSwitch_gen3)]),
				Pn(Pdef(\simpleSwitch_gen2),1),
				Pn(Pdef(\simpleSwitch_gen1),1),
				Pn(Pdef(\simpleSwitch_gen0),2),
			])
		));

		sp.wait(2);

		"weed and penrose".postln;

		/*soundCue = "Weed: X -> 0; SimpleSwitch: X -> 1;"
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlKnobLEDsSetRow.([1,3],3);
		~launchControlXlUpdateKnobLEDs.value;*/

		~lsys[\weed_gen2].noteOffset = weedOffset_1-12;
		~lsys[\weed_gen2].baseTempo = 2/8;
		~lsys[\weed_gen1].noteOffset = weedOffset_1-12;
		~lsys[\weed_gen1].baseTempo = 3/8;
		~lsys[\weed_gen0].noteOffset = weedOffset_1-12;
		~lsys[\weed_gen0].baseTempo = 2/4;
		~lsys[\penrose_gen1].noteOffset = penroseOffset_1;
		~lsys[\penrose_gen1].baseTempo = 1/6;
		~lsys[\penrose_gen0].noteOffset = penroseOffset_1;
		~lsys[\penrose_gen0].baseTempo = 1/3;

		sp.seq(~weedInstrState_2.(
			inputPattern: Pseq([
				Pn(Pdef(\weed_gen0), 2),
				Pn(Pdef(\weed_gen1), 2),
				Pn(Pdef(\weed_gen2), 1)
		],1))
		);

		sp.wait(2);

		sp.seq(Ppar([
			~penroseInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_gen1), 2)
			),
			~clickInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_click_gen1),2))

		])
		);

		sp.par(Ppar([
			~penroseInstrState_1.(
				inputPattern: Pseq([
					Pn(Pdef(\penrose_gen1), 4),
					Pn(Pdef(\penrose_gen0), 2)
				])
			),
			~clickInstrState_1.(
				inputPattern: Pseq([
					Pn(Pdef(\penrose_click_gen1),2),
					Pdef(\penrose_click_gen0)])
			)
		])
		);

		sp.wait(1);


/*soundCue = "Weed: 0 -> 1; SimpleSwitch: 1 -> 0;"
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		~launchControlXlKnobLEDsSetRow.([1,3],1);
		~launchControlXlUpdateKnobLEDs.value;*/

		"weed and simpleswitch".postln;

		~lsys[\weed_gen1].baseTempo = 3/4;
		~lsys[\weed_gen1].noteOffset = weedOffset_1-7;
		~lsys[\weed_gen2].baseTempo = 2/4;
		~lsys[\weed_gen2].noteOffset = weedOffset_1-7;

		sp.seq(Pbind(
			\amp, Pseg([-12.dbamp,0.dbamp],[6,7]),
		)
		<>	~weedInstrState_2.(
			inputPattern: Pseq([
				Pn(Pdef(\weed_gen1), 2),
				Pn(Pdef(\weed_gen2), 1)
		],1)
		)
		);

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

		//EQ!!!

		sp.par(Pbind(
			\amp, Pseg([-18.dbamp,-6.dbamp,-6.dbamp,-18.dbamp],[5,9.875,6]),
		)
		<>	~simpleSwitchInstrState_2.(
			inputPattern: Pseq([ //19.375/2
				Pn(Pdef(\simpleSwitch_gen3),2),
				Pn(Pdef(\simpleSwitch_gen2),3),
				Pn(Pdef(\simpleSwitch_gen1),5),
				Pn(Pdef(\simpleSwitch_gen0),8),
			])
		));

		sp.seq(~weedInstrState_1.(
				inputPattern: Pseq([
					Pn(Pdef(\weed_gen0), 3),
					Pn(Pdef(\weed_gen1), 2),
					Pn(Pdef(\weed_gen2), 1),
					Pn(Pdef(\weed_reverse_gen2), 1),
					Pn(Pdef(\weed_reverse_gen1), 1),
					Pn(Pdef(\weed_reverse_gen0), 3)
			],1))
		);

		~lsys[\weed_reverse_gen0].baseTempo = 4/4;

		sp.seq(Pbind(\vca_attack, 1,
		\vca_release, 3,)
		<> ~weedInstrState_1.(
				inputPattern: Pn(Pdef(\weed_reverse_gen0), 2))
		);

		sp.wait(2);

	})

	)