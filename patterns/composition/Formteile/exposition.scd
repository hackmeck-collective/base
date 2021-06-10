Pdef(\exposition,
	Pspawner({ |sp|

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

		~lsys[\presets].weed_gen1.noteOffset = 0;
		~lsys[\presets].weed_gen1.baseTempo = 1;
		~lsys[\presets].weed_gen2.noteOffset = 0;
		~lsys[\presets].weed_gen2.baseTempo = 1/2;

		sp.seq(~lcXlCtrBus1Bi.(24, 0.5) <> Pbind(\envelope_mod, 0.8)
			<> Pseq([
				Pseq([Pdef(\weed_gen1)]),
				Pseq([Pdef(\weed_gen2)]),
				Pseq([Pdef(\weed_gen1)]),
				Pseq([Pdef(\weed_gen2)]),
				Pseq([Pdef(\weed_gen1)]),
				Pseq([Pdef(\weed_gen2)]),
				Pseq([Pdef(\weed_gen1)]),
				Pseq([Pdef(\weed_gen2)]),
			])
			<> Pbind(\external1Target, "envelope_mod"
		));

		~lsys[\presets].weed_gen1.noteOffset = 0;
		~lsys[\presets].weed_gen1.baseTempo = 1/4;
		~lsys[\presets].weed_gen2.noteOffset = 0;
		~lsys[\presets].weed_gen2.baseTempo = 1/4;
		~lsys[\presets].weed_gen3.noteOffset = 0;
		~lsys[\presets].weed_gen3.baseTempo = 1/4;
		~lsys[\presets].weed_reverse_gen0.noteOffset = 0;
		~lsys[\presets].weed_reverse_gen0.baseTempo = 1;
		~lsys[\presets].weed_reverse_gen1.noteOffset = 0;
		~lsys[\presets].weed_reverse_gen1.baseTempo = 3/4;
		~lsys[\presets].weed_reverse_gen2.noteOffset = 0;
		~lsys[\presets].weed_reverse_gen2.baseTempo = 4/8;
		~lsys[\presets].weed_reverse_gen3.noteOffset = 0;
		~lsys[\presets].weed_reverse_gen3.baseTempo = 3/8;

		sp.seq(~lcXlCtrBus1Bi.(24, 0.5) <> Pbind(\envelope_mod, 0.8)
			<> Pseq([
				Pseq([Pdef(\weed_gen1)]),
				Pseq([Pdef(\weed_gen2)]),
				Pseq([Pdef(\weed_gen1)]),
				Pseq([Pdef(\weed_gen2)]),
				Pseq([Pdef(\weed_gen1)]),
				Pseq([Pdef(\weed_gen2)]),
				Pseq([Pdef(\weed_gen1)]),
				Pseq([Pdef(\weed_gen2)]),
				Pseq([Pdef(\weed_gen3)]),
				Pseq([Pdef(\weed_reverse_gen3)]),
				Pseq([Pdef(\weed_reverse_gen2)]),
				Pseq([Pdef(\weed_reverse_gen1)]),
				Pseq([Pdef(\weed_reverse_gen0)],3),
			])
			<> Pbind(\external1Target, "envelope_mod"
		));

		sp.wait(8);

		"penrose buildup 1".postln; // mit percussion und umgedreht

		~lsys[\presets].penrose_simplesimple_gen1.noteOffset = -5;
		~lsys[\presets].penrose_simplesimple_gen1.baseTempo = 3/16;
		~lsys[\presets].penrose_simple_gen1.noteOffset = -5;
		~lsys[\presets].penrose_simple_gen1.baseTempo = 3/16;
		~lsys[\presets].penrose_simple_gen2.noteOffset = -5;
		~lsys[\presets].penrose_simple_gen2.baseTempo = 3/16;
		~lsys[\presets].penrose_simple_gen0.noteOffset = -5;
		~lsys[\presets].penrose_simple_gen0.baseTempo = 3/16;
		~lsys[\presets].simpleSwitch_gen0.noteOffset = 0;
		~lsys[\presets].simpleSwitch_gen0.baseTempo = 2/16;
		~lsys[\presets].simpleSwitch_gen1.noteOffset = 0;
		~lsys[\presets].simpleSwitch_gen1.baseTempo = 2/16;
		~lsys[\presets].simpleSwitch_gen2.noteOffset = 0;
		~lsys[\presets].simpleSwitch_gen2.baseTempo = 2/16;

		sp.seq(~lcXlCtrBus1Bi.(24) <> ~lcXlCtrBus2Bi.(25, -1) <> ~penroseInstrState_1 <> Pbind(\envelope_mod, 0.35)
			<> Pseq([
				Pseq([Pdef(\penrose_simplesimple_gen1)],8),
				Pseq([Pdef(\penrose_simple_gen1)],4),
				Pseq([Pseq([Pdef(\penrose_simple_gen2)],2),
					Pseq([Pdef(\penrose_simple_gen1)],4),
				]
				,2),
			])
			<> Pbind(\external1Target, "envelope_mod", \external2Target, "oscillator_2_level"));

		"simpleSwitch buildup 1".postln;

		~lsys[\presets].penrose_simple_gen1.noteOffset = 7;
		~lsys[\presets].penrose_simple_gen1.baseTempo = 3/16;
		~lsys[\presets].penrose_simplesimple_gen1.noteOffset = 7;
		~lsys[\presets].penrose_simplesimple_gen1.baseTempo = 3/16;
		~lsys[\presets].penrose_simplesimple_gen0.noteOffset = 7;
		~lsys[\presets].penrose_simplesimple_gen0.baseTempo = 8/16;

		sp.seq(~lcXlCtrBus1Bi.(24) <> ~lcXlCtrBus2Bi.(25, -1) <> ~penroseInstrState_1
			<>  Pdef(\penrose_simplesimple_gen1)
			<> Pbind(\external1Target, "envelope_mod", \external2Target, "oscillator_2_level"));

		sp.par(~lcXlCtrBus1Bi.(24) <> Pbind(\envelope_mod, 0.35)
			<> Pseq([
				Pseq([Pdef(\penrose_simplesimple_gen1)],3),
				Pseq([Pdef(\penrose_simplesimple_gen0)],1)
		]) <> Pbind(\external1Target, "envelope_mod"));
		sp.seq(Pn(~lcXlCtrBus1Bi.(25, 0.7)
			<> ~simpleSwitchInstrState_1
			<> Pseq([
				Pseq([Pdef(\simpleSwitch_gen0)],12),
				Pseq([Pdef(\simpleSwitch_gen1)],2),
				Pseq([Pdef(\simpleSwitch_gen2)]), // generation weiter und percussion
				Pseq([Pdef(\simpleSwitch_gen1)],1),
				Pseq([Pdef(\simpleSwitch_gen0)],2),
			])
			<> Pbind(\external1Target, "envelope_mod", \external1Target2, "pitchOp_1_interval"), 4));

		sp.wait(4); // pausenlänge überprüfen

		"weed and penrose".postln; //verballert - muss spannend sein, percussion?

		~lsys[\presets].weed_gen2.noteOffset = 0;
		~lsys[\presets].weed_gen2.baseTempo = 3/8;
		~lsys[\presets].weed_gen1.noteOffset = 0;
		~lsys[\presets].weed_gen1.baseTempo = 1/4;
		~lsys[\presets].weed_gen0.noteOffset = 0;
		~lsys[\presets].weed_gen0.baseTempo = 2/4;
		~lsys[\presets].penrose_gen1.noteOffset = 12;
		~lsys[\presets].penrose_gen1.baseTempo = 1/6;

		sp.seq(Pn(Pdef(\weed_gen0), 1));
		sp.seq(Pn(Pdef(\weed_gen1), 1));
		sp.seq(Pn(Pdef(\weed_gen2), 1));
		sp.wait(2);

		sp.par(Pn(Pdef(\penrose_gen1), 2));
		sp.wait(1.5);


		"weed and simpleswitch".postln;

		~lsys[\presets].weed_gen1.baseTempo = 3/4;
		~lsys[\presets].weed_gen1.noteOffset = 7;
		~lsys[\presets].weed_gen2.baseTempo = 2/4;
		~lsys[\presets].weed_gen2.noteOffset = 7;
		~lsys[\presets].weed_gen3.baseTempo = 3/8;
		~lsys[\presets].weed_gen3.noteOffset = 7;
		~lsys[\presets].weed_reverse_gen1.baseTempo = 3/4;
		~lsys[\presets].weed_reverse_gen1.noteOffset = 7;
		~lsys[\presets].weed_reverse_gen2.baseTempo = 3/8;
		~lsys[\presets].weed_reverse_gen2.noteOffset = 7;
		~lsys[\presets].weed_reverse_gen0.baseTempo = 3/4;
		~lsys[\presets].weed_reverse_gen0.noteOffset = 7;

		sp.seq(Pn(Pdef(\weed_gen1), 1));
		sp.par(Pn(Pdef(\weed_gen2), 1));
		sp.wait(2);
		sp.seq(~lcXlCtrBus1Bi.(25, 0.4)
			<> ~simpleSwitchInstrState_1
			<> Pseq([Pdef(\simpleSwitch_gen1)],3)
			<> Pbind(\external1Target, "envelope_mod", \external1Target2, "pitchOp_1_interval"));
		sp.wait(2);
		sp.seq(Pn(Pdef(\weed_gen3), 1));
		sp.seq(Pn(Pdef(\weed_reverse_gen2), 1));
		sp.seq(Pn(Pdef(\weed_reverse_gen1), 1));
		sp.seq(Pn(Pdef(\weed_reverse_gen0), 3));
		~lsys[\presets].weed_reverse_gen0.baseTempo = 4/4;
		sp.seq(Pn(Pdef(\weed_reverse_gen0), 2));

		sp.wait(8);

	})

)