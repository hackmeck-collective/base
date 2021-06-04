/*(Pseq([
Pseq([Pdef(\penrose_simple_gen0)]),
Pseq([Pdef(\penrose_simple_gen1)]),
Pseq([Pdef(\penrose_simple_gen2)]),
Pseq([Pdef(\penrose_simple_gen1)]),
])).play
Pseq([Pdef(\penrose_gen2)],4).play*/

// Pdef(\exposition).play

(
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

		~lsys.presets.weed_gen1.noteOffset = 0;
		~lsys.presets.weed_gen1.baseTempo = 1;
		~lsys.presets.weed_gen2.noteOffset = 0;
		~lsys.presets.weed_gen2.baseTempo = 1/2;

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

		~lsys.presets.weed_gen1.noteOffset = 0;
		~lsys.presets.weed_gen1.baseTempo = 1/4;
		~lsys.presets.weed_gen2.noteOffset = 0;
		~lsys.presets.weed_gen2.baseTempo = 1/4;
		~lsys.presets.weed_gen3.noteOffset = 0;
		~lsys.presets.weed_gen3.baseTempo = 1/4;
		~lsys.presets.weed_reverse_gen0.noteOffset = 0;
		~lsys.presets.weed_reverse_gen0.baseTempo = 1;
		~lsys.presets.weed_reverse_gen1.noteOffset = 0;
		~lsys.presets.weed_reverse_gen1.baseTempo = 3/4;
		~lsys.presets.weed_reverse_gen2.noteOffset = 0;
		~lsys.presets.weed_reverse_gen2.baseTempo = 4/8;
		~lsys.presets.weed_reverse_gen3.noteOffset = 0;
		~lsys.presets.weed_reverse_gen3.baseTempo = 3/8;

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

		~lsys.presets.penrose_simplesimple_gen1.noteOffset = -5;
		~lsys.presets.penrose_simplesimple_gen1.baseTempo = 3/16;
		~lsys.presets.penrose_simple_gen1.noteOffset = -5;
		~lsys.presets.penrose_simple_gen1.baseTempo = 3/16;
		~lsys.presets.penrose_simple_gen2.noteOffset = -5;
		~lsys.presets.penrose_simple_gen2.baseTempo = 3/16;
		~lsys.presets.penrose_simple_gen0.noteOffset = -5;
		~lsys.presets.penrose_simple_gen0.baseTempo = 3/16;
		~lsys.presets.simpleSwitch_gen0.noteOffset = 0;
		~lsys.presets.simpleSwitch_gen0.baseTempo = 2/16;
		~lsys.presets.simpleSwitch_gen1.noteOffset = 0;
		~lsys.presets.simpleSwitch_gen1.baseTempo = 2/16;
		~lsys.presets.simpleSwitch_gen2.noteOffset = 0;
		~lsys.presets.simpleSwitch_gen2.baseTempo = 2/16;

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

		~lsys.presets.penrose_simple_gen1.noteOffset = 7;
		~lsys.presets.penrose_simple_gen1.baseTempo = 3/16;
		~lsys.presets.penrose_simplesimple_gen1.noteOffset = 7;
		~lsys.presets.penrose_simplesimple_gen1.baseTempo = 3/16;
		~lsys.presets.penrose_simplesimple_gen0.noteOffset = 7;
		~lsys.presets.penrose_simplesimple_gen0.baseTempo = 8/16;

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

		~lsys.presets.weed_gen2.noteOffset = 0;
		~lsys.presets.weed_gen2.baseTempo = 3/8;
		~lsys.presets.weed_gen1.noteOffset = 0;
		~lsys.presets.weed_gen1.baseTempo = 1/4;
		~lsys.presets.weed_gen0.noteOffset = 0;
		~lsys.presets.weed_gen0.baseTempo = 2/4;
		~lsys.presets.penrose_gen1.noteOffset = 12;
		~lsys.presets.penrose_gen1.baseTempo = 1/6;

		sp.seq(Pn(Pdef(\weed_gen0), 1));
		sp.seq(Pn(Pdef(\weed_gen1), 1));
		sp.seq(Pn(Pdef(\weed_gen2), 1));
		sp.wait(2);

		sp.par(Pn(Pdef(\penrose_gen1), 2));
		sp.wait(1.5);


		"weed and simpleswitch".postln;

		~lsys.presets.weed_gen1.baseTempo = 3/4;
		~lsys.presets.weed_gen1.noteOffset = 7;
		~lsys.presets.weed_gen2.baseTempo = 2/4;
		~lsys.presets.weed_gen2.noteOffset = 7;
		~lsys.presets.weed_gen3.baseTempo = 3/8;
		~lsys.presets.weed_gen3.noteOffset = 7;
		~lsys.presets.weed_reverse_gen1.baseTempo = 3/4;
		~lsys.presets.weed_reverse_gen1.noteOffset = 7;
		~lsys.presets.weed_reverse_gen2.baseTempo = 3/8;
		~lsys.presets.weed_reverse_gen2.noteOffset = 7;
		~lsys.presets.weed_reverse_gen0.baseTempo = 3/4;
		~lsys.presets.weed_reverse_gen0.noteOffset = 7;

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
		~lsys.presets.weed_reverse_gen0.baseTempo = 4/4;
		sp.seq(Pn(Pdef(\weed_reverse_gen0), 2));

		sp.wait(8);

	})

);

Pdef(\layers,
	Pspawner({ |sp|


		"weed and penrose 2".postln;

		~lsys.presets.weed_gen2.baseTempo = 1/4;
		~lsys.presets.weed_gen2.noteOffset = 0;
		~lsys.presets.weed_gen3.baseTempo = 1/4;
		~lsys.presets.weed_gen3.noteOffset = 0;
		~lsys.presets.penrose_gen1.noteOffset = 12;
		~lsys.presets.penrose_gen1.baseTempo = 1/6;

		sp.seq(Pn(Pdef(\weed_gen3), 1));
		sp.par(Pn(Pdef(\penrose_gen1), 7));
		sp.seq(Pn(Pdef(\weed_gen3), 2));
		sp.seq(Pn(Pdef(\weed_gen2), 2));

		~lsys.presets.penrose_gen1.noteOffset = 12;
		~lsys.presets.penrose_gen1.baseTempo = 1/6;
		~lsys.presets.penrose_gen2.noteOffset = 12;
		~lsys.presets.penrose_gen2.baseTempo = 3/16;
		~lsys.presets.penrose_simple_gen1.noteOffset = 12;
		~lsys.presets.penrose_simple_gen1.baseTempo = 1/4;
		~lsys.presets.weed_gen2.noteOffset = 0;
		~lsys.presets.weed_gen2.baseTempo = 1/4;
		~lsys.presets.weed_gen1.noteOffset = 0;
		~lsys.presets.weed_gen1.baseTempo = 1/4;

		sp.par(Pseq([Pdef(\penrose_gen2), Pdef(\penrose_gen1), Pdef(\penrose_simple_gen1)]));
		sp.seq(Pn(Pdef(\weed_gen2), 6));
		sp.par(Pseq([Pn(Pdef(\weed_gen1), 2),Pn(Pdef(\weed_gen0), 3)]));

		~lsys.presets.simpleSwitch_gen3.noteOffset = -0;
		~lsys.presets.simpleSwitch_gen2.noteOffset = -0;
		~lsys.presets.simpleSwitch_gen1.noteOffset = -0;
		~lsys.presets.simpleSwitch_gen0.noteOffset = -0;
		~lsys.presets.simpleSwitch_gen3.baseTempo = 3/16;
		~lsys.presets.simpleSwitch_gen2.baseTempo = 3/16;
		~lsys.presets.simpleSwitch_gen1.baseTempo = 3/16;
		~lsys.presets.simpleSwitch_gen0.baseTempo = 3/16;
		~lsys.presets.penrose_simple_gen1.baseTempo = 3/16;
		~lsys.presets.penrose_simple_gen2.baseTempo = 3/16;
		~lsys.presets.penrose_simple_gen3.baseTempo = 3/16;


		"simpleSwitch and weed".postln;

		sp.seq(~lcXlCtrBus1Bi.(25, 0.8)
			<> ~simpleSwitchInstrState_1
			<> Pseq([Pn(Pdef(\simpleSwitch_gen2), 4), Pdef(\simpleSwitch_gen3), Pdef(\simpleSwitch_gen2)])
			<> Pbind(\external1Target, "envelope_mod", \external1Target, "pitchOp_1_interval"));

		~lsys.presets.weed_gen3.noteOffset = 0;
		~lsys.presets.weed_gen2.noteOffset = 0;
		~lsys.presets.weed_gen1.noteOffset = 0;
		~lsys.presets.weed_gen0.noteOffset = 0;
		~lsys.presets.weed_gen3.baseTempo = 6/16;
		~lsys.presets.weed_gen2.baseTempo = 6/16;
		~lsys.presets.weed_gen1.baseTempo = 9/16;
		~lsys.presets.weed_gen0.baseTempo = 16/16;

		sp.par(Pseq([Pdef(\weed_gen2),Pdef(\weed_gen1),Pn(Pdef(\weed_gen0),3)]));

		sp.seq(Pn(~lcXlCtrBus1Bi.(25, 0.8)
			<> ~simpleSwitchInstrState_1
			<> Pseq([Pn(Pdef(\simpleSwitch_gen2), 2), Pn(Pdef(\simpleSwitch_gen1), 7), ])
			<> Pdef(\simpleSwitch_gen2)
			<> Pbind(\external1Target, "envelope_mod", \external1Target, "pitchOp_1_interval"), 2));

		sp.par(Pseq([Pdef(\weed_gen3),Pdef(\weed_gen1),Pn(Pdef(\weed_gen0),3)]));

		sp.seq(Pn(~lcXlCtrBus1Bi.(25, 0.8)
			<> ~simpleSwitchInstrState_1
			<> Pseq([Pn(Pdef(\simpleSwitch_gen2), 2), Pn(Pdef(\simpleSwitch_gen1), 9), ])
			<> Pdef(\simpleSwitch_gen2)
			<> Pbind(\external1Target, "envelope_mod", \external1Target, "pitchOp_1_interval"), 2));

		"simpleSwitch to penrose".postln;

		sp.par(~lcXlCtrBus1Bi.(25, 0.8)
			<> ~simpleSwitchInstrState_1
			<> Pseq([Pseq([Pdef(\simpleSwitch_gen1)],4),Pseq([Pdef(\simpleSwitch_gen0)],12)])
			<> Pbind(\external1Target, "envelope_mod", \external1Target, "pitchOp_1_interval"));


		sp.seq(~lcXlCtrBus1Bi.(24)
			<> Pseq([Pn(Pdef(\penrose_simple_gen1),8),
				Pn(Pdef(\penrose_simple_gen2),4),
				Pn(Pdef(\penrose_simple_gen1),2),
				Pn(Pdef(\penrose_simple_gen0),4)
			],2)
			<> Pbind(\external1Target, "oscillator_1_mod_2"));

		"weed".postln;

		sp.seq(Pseq([Pdef(\weed_gen3),Pdef(\weed_gen1),Pn(Pdef(\weed_gen0),3)]));

	})
);
);

(
Pdef(\penrose_entwicklung1,
	Pspawner({ |sp|

		~lsys.presets.penrose_simple_gen2.noteOffset = 0;
		~lsys.presets.penrose_toPause.noteOffset = 0;
		~lsys.presets.penrose_toPause2.noteOffset = 0;
		~lsys.presets.penrose_toPause3.noteOffset = 0;
		~lsys.presets.penrose_pauses_gen1.noteOffset = 0;
		~lsys.presets.penrose_pauses_gen2.noteOffset = 0;
		~lsys.presets.penrose_pauses_gen3.noteOffset = 0;

		sp.seq(Pn(Pdef(\penrose_simple_gen2), 2));
		sp.seq(Pn(Pdef(\penrose_simple_gen1), 4));
		sp.seq(Pn(Pdef(\penrose_simplesimple_gen1), 4));
		"penrose to pause".postln;
		sp.seq(Pn(Pdef(\penrose_toPause), 4));
		"penrose to pause2".postln;
		sp.seq(Pn(Pdef(\penrose_toPause2), 4));
		"penrose to pause3".postln;
		sp.seq(Pn(Pdef(\penrose_toPause3), 4));
		"penrose_pauses_gen1".postln;
		sp.seq(Pn(Pdef(\penrose_pauses_gen1),8));
		"penrose_pauses_gen2".postln;
		sp.seq(Pn(Pdef(\penrose_pauses_gen2),2));
		"penrose_pauses_gen3".postln;
		sp.seq(Pn(Pdef(\penrose_pauses_gen3),2));
		"penrose to pause3".postln;
		sp.seq(Pn(Pdef(\penrose_toPause3), 4));
	})
);
);


(
Pdef(\penrose_entwicklung2,
	Pspawner({ |sp|

		~lsys.presets.weed_gen3.noteOffset = 0;
		~lsys.presets.weed_gen2.noteOffset = 0;
		~lsys.presets.weed_gen1.noteOffset = 0;
		~lsys.presets.weed_gen0.noteOffset = 0;
		~lsys.presets.weed_gen3.baseTempo = 6/16;
		~lsys.presets.weed_gen2.baseTempo = 6/16;
		~lsys.presets.weed_gen1.baseTempo = 9/16;
		~lsys.presets.weed_gen0.baseTempo = 16/16;

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
);
);

Pdef(\simpleSwitchDevelopement,
	Pspawner({ |sp|
		"ss1".postln;
		sp.seq(Pn(Pdef(\simpleSwitch), 4));
		"ss2".postln;
		sp.seq(Pn(Pdef(\simpleSwitch_dev2), 2));
		"ss3".postln;
		sp.seq(Pn(Pdef(\simpleSwitch_dev3), 2));
		sp.seq(Pn(Pdef(\simpleSwitch_gen1), 8));
		sp.seq(Pn(Pdef(\simpleSwitch_gen0), 16));
		"ss4".postln;
		//sp.seq(Pn(Pdef(\simpleSwitch), 6));
		"ss5".postln;
		sp.seq(Pdef(\simpleSwitch_dev4));
		// sp.seq(Pdef(\simpleSwitch_dev5));
		~lsys.presets.simpleSwitch_dev6.vols = [0, 0, 1, 1, 1, 1];
		~lsys.presets.simpleSwitch_dev6.stutterVal = Pseq([1,1,2],inf);
		sp.par(
			Pbind(\dur, Rest(0.1), \x, Pfunc { |in|
				~lsys.presets.simpleSwitch_dev6.vols[0] = in;
				~lsys.presets.simpleSwitch_dev6.vols[1] = in;
				0 } <> Pseg([0,0,1],[18,12],-3)
			)
		);
		"ss6".postln;
		sp.seq(Pdef(\simpleSwitch_dev6));
		//"ss7".postln;
		//sp.seq(Pn(Pdef(\simpleSwitch), 6));
	})
);


Pdef(\triangle_develope,
	Pspawner({|sp|
		var player1, player2, player3;
		sp.seq(Pn(Psync(Pdef(\fraktal_12), 4, 4), 8));
		"fraktal_12".postln;
		sp.seq(Pn(Psync(Pdef(\fraktal_12), 3, 4), 4));
		"fraktal_13 A".postln;
		sp.seq(Pn(Psync(Pdef(\fraktal_13), 2, 4), 4));
		"fraktal_13 B".postln;
		sp.seq(Pn(Psync(Pdef(\fraktal_13), 1, 4), 4));
		"fraktal_14".postln;
		sp.seq(Pn(Psync(Pdef(\fraktal_14), 4, 4), 2));

		"fraktal_15".postln;
		sp.seq(Psync(Pdef(\fraktal_15), 5, 100));
		"fraktal_16".postln;
		sp.seq(Psync(Pdef(\fraktal_16), 3, 100));
		"fraktal_17".postln;
		sp.seq(Psync(Pdef(\fraktal_17), 0, 100));
		"fraktal_1_inverse7".postln;
		sp.seq(Psync(Pdef(\fraktal_1_inverse7), 0, 100));

		player1 = sp.par(Pn(Psync(Pdef(\fraktal_13), 1, 4),inf));
		player2 = sp.par(Pdef(\fraktal_philipp_bd));
		player3 = sp.par(Pdef(\fraktal_philipp_sd));

		sp.wait(16);
		player1.stop; player2.stop; player3.stop;
		player2 = sp.par(Pdef(\fraktal_philipp_bd));
		player3 = sp.par(Pdef(\fraktal_philipp_sd));
		sp.par(Pdef(\fraktal_philipp));
		sp.wait(12);
		sp.par(
			Pdef(\sd2).collect {|ev| ~scM4.play; ev} <> Pbindef(\fifth) <> Pbindef(\pulse_4_ob)
		);
	})
);