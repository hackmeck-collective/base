~lcXlCtrBus1Bi = { |busNum, amount = 1, min = -1, max = 1|
	Pbind(\controlbus1, ~routing[("launchcontrolXlControlBusses" ++ busNum).asSymbol],
		\external1Amount, amount,
		\external1min, min,
		\external1max, max,
	)
};

~lcXlCtrBus2Bi = { |busNum, amount = 1, min = -1, max = 1|
	Pbind(\controlbus2, ~routing[("launchcontrolXlControlBusses" ++ busNum).asSymbol],
		\external2Amount, amount,
		\external2min, min,
		\external2max, max,
	)
};

~lcXlCtrBus3Bi = { |busNum, amount = 1, min = -1, max = 1|
	Pbind(\controlbus3, ~routing[("launchcontrolXlControlBusses" ++ busNum).asSymbol],
		\external3Amount, amount,
		\external3min, min,
		\external3max, max,
	)
};

~lcXlCtrBus4Bi = { |busNum, amount = 1, min = -1, max = 1|
	Pbind(\controlbus4, ~routing[("launchcontrolXlControlBusses" ++ busNum).asSymbol],
		\external4Amount, amount,
		\external4min, min,
		\external4max, max,
	)
};

~patternVolumeFadePre = (Pbind(
	\vol, (Pfunc {|ev|
		var oldVol = ev.vol ? 1;
		var fade = if(ev.streamIndex == 1){ev.xfade}{1 - ev.xfade};
		oldVol * fade
	})
)
);

~patternVolumeFadePost = ({|length, delta|
	PtimeClutch(Pbind(
		\xfade, Pseg([0,1],[length],0,inf)
	), delta: (delta) - 0.01) // Delta mit dem baseTempo auf dem es laufen soll abstimmen
});

~patternNotesFadePre = (Pbind(
	\vol, (Pfunc {|ev|
		var oldVol = ev.vol ? 1;
		var fade = if(ev.streamIndex == 1){ev.xfade}{1 - ev.xfade};
		oldVol * fade
	})
)
);

~patternNotesFadePost = ({|delta, weightPattern|
	PtimeClutch(Pbind(
		\weights, weightPattern,
		\xfade, Pn(Plazy {|ev| Pwrand([0, 1], [1 - ev.weights, ev.weights])})
	), delta: (delta) - 0.01);
});

~patternVolumeFade = ({|pat1, pat2, length, delta|
	Pbind(
		\vol, (Pfunc {|ev|
			var oldVol = ev.vol ? 1;
			var fade = if(ev.streamIndex == 1){ev.xfade}{1 - ev.xfade};
			oldVol * fade
		})
	) <> Ppar([
		pat1 <> Pbind(\streamIndex, 1), //\newBranchTest
		pat2 <> Pbind(\streamIndex, 2)
	]) <>
	PtimeClutch(Pbind(
		\xfade, Pseg([0,1],[length],0,inf)
	), delta: (delta) - 0.01) // Delta mit dem baseTempo auf dem es laufen soll abstimmen
});

//
// Pdef(\transition_canon_ritardando,
// 	Pbind(
// 		\vol, (Pfunc {|ev|
// 			var oldVol = ev.vol ? 1;
// 			var fade = if(ev.streamIndex == 1){ev.xfade}{1 - ev.xfade};
// 			oldVol * fade
// 		})
// 	) <> Ppar([
// 		Pn(Pdef(\penrose_canon_pausen),2) <> Pbind(\streamIndex, 2), //\newBranchTest
// 		Pn(Pdef(\penrose_canon_mehr_pausen),2) <> Pbind(\streamIndex, 1)
// 	]) <> PtimeClutch(Pbind(
// 		\xfade, Pseg([0,1],[20],0,inf)
// 	), delta: (1/6) - 0.01) // Delta mit dem baseTempo auf dem es laufen soll abstimmen
// );
//
// Pdefn(\weights_transition_penrose_simpleSwitch, Pbjorklund(Pseq([Pstutter(3,Pseq((1..15))),Pn(16)]).trace,16));
//
// Pdef(\transition_penrose_simpleSwitch,
// 	/*Pbind(
// 	\vol, (Pfunc {|ev|
// 	var oldVol = ev.vol ? 1;
// 	var fade = if(ev.streamIndex == 1){ev.xfade}{1 - ev.xfade};
// 	oldVol * fade
// 	})
// 	)*/
// 	~patternNotesFadePre
// 	<> Ppar([
// 		Pn(Pdef(\penrose_canon_mehr_pausen3)) <> Pbind(\streamIndex, 2), //\newBranchTest
// 		Pn(Pdef(\simpleSwitch)) <> Pbind(\streamIndex, 1)
// 	])
// 	<> ~patternNotesFadePost.(1/8, Pbjorklund(Pseq([Pstutter(Pseq([Pn(4,4),Pn(2,2)]),Pseq((1..15))),Pn(16, 1)]).trace,16) )
// 	/*PtimeClutch(Pbind(
// 	\weights, Pbjorklund(Pseq([Pstutter(2,Pseq((1..15))),Pn(16, 1)]).trace,16),
// 	\xfade, Pn(Plazy {|ev| Pwrand([0, 1], [1 - ev.weights, ev.weights])})
// 	), delta: (1/8) - 0.01)*/ // Delta mit dem baseTempo auf dem es laufen soll abstimmen
// );
//

{
	var testArray = (2..9);
	var testName = "fraktal_1";
	var testNameAdd = "_inverse";
	var testNameAdd2 = "_sd";
	var baseTempo = 1/8;
	var leadInstr1 = \simplePluck;
	var branchInstr1 = \simplePluck;
	var percInstr1 = \bdBuzz;
	var percInstr2 = \metalPerc;
	var intervals = [1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1];
	var testSymbols, testSymbols2, testSymbols3;

	testArray.do(
		{ |item, index|
			~newLsys.(
				name: (testName ++ item).asSymbol,
				axiom: "G",
				rules: ( $F: "Gf" , $f: "Gf", $G: "++F----G++" ),
				gen: item,
				opts: (
					useGlobalPitch: false,
					noteOffset: 17,
					stepInterval: 1,
					quant: 0,
					baseTempo: baseTempo,
					legatoArr: 1,
					wrapLo: [ 12 ],
					wrapHi: [ 96 ],
					instr: leadInstr1,
					vols: 2,
					baseColor: 0,
					theta: 18,
				)
			);

			~newLsys.(
				name: (testName ++ testNameAdd ++ item).asSymbol,
				axiom: "G",
				rules: ( $F: "Gf" , $f: "Gf", $G: "++F----G++" ),
				gen: item,
				opts: (
					useGlobalPitch: false,
					noteOffset: 17,
					stepInterval: -1,
					quant: 0,
					baseTempo: baseTempo,
					legatoArr: 1,
					wrapLo: [ 12 ],
					wrapHi: [ 96 ],
					instr: leadInstr1,
					vols: 2,
					baseColor: 0,
					theta: 18
				)
			);

			~newLsys.(
				name: (testName ++ testNameAdd2 ++ item).asSymbol,
				axiom: "G",
				rules: ( $F: "G--f++" , $f: "G++F--", $G: "+f--G+" ),
				gen: item,
				opts: (
					useGlobalPitch: false,
					noteOffset: -12,
					quant: 0,
					baseTempo: baseTempo,
					legatoArr: 0.99,
					wrapLo: [ 84 ],
					wrapHi: [ 96 ],
					instr: percInstr2,
					vols: 0.1,
					baseColor: 0,
					theta: 18
				)
			);
		}
	);

	testArray.do(
		{ |item|
			Pdef((testName ++ item ++ "_filter").asSymbol,
				Pbind(\vol, Pfunc {|ev|
					if(ev.charNow == $F){ev.vol * 1.2}{ev.vol}
				},
				\filter_1_mod_1, Pfunc {|ev|
					if(ev.charNow == $F){ev.filter_1_mod_1 * 1.2}{ev.filter_1_mod_1}
				},
				\timingOffset, Pfunc {|ev|
					if(ev.charNow == $F){0}{0}
				},
				)
				<> (Pbind(\time, Ptime))
			);

			Pdef((testName ++ testNameAdd  ++ item ++ "_filter").asSymbol,
				Pbind(\vol, Pfunc {|ev|
					if(ev.charNow == $F){ev.vol * 1.2}{ev.vol}
				},
				\filter_1_mod_1, Pfunc {|ev|
					if(ev.charNow == $F){ev.filter_1_mod_1 * 1.2}{ev.filter_1_mod_1}
				},
				\timingOffset, Pfunc {|ev|
					if(ev.charNow == $F){0}{0}
				},
				)
				<> (Pbind(\time, Ptime))
			);

			Pdef((testName ++ testNameAdd2  ++ item ++ "_filter").asSymbol,
				Pbind(\vol, Pfunc {|ev|
					if(ev.charNow == $F){0}{1}
				},
				/*			\filter_1_mod_1, Pfunc {|ev|
				if(ev.charNow == $F){ev.filter_1_mod_1 * 1.2}{ev.filter_1_mod_1}
				},*/
				\timingOffset, Pfunc {|ev|
					if(ev.charNow == $F){0}{0}
				},
				)
				<> (Pbind(\time, Ptime))
			);
		}
	);

	testSymbols = testArray.collect({ |item|
		(testName ++ item).asSymbol
	});

	testSymbols2 = testArray.collect({ |item|
		(testName ++ testNameAdd ++ item).asSymbol
	});

	testSymbols3 = testArray.collect({ |item|
		(testName ++ testNameAdd2 ++ item).asSymbol
	});

	Pdef((testName).asSymbol.postln,
		Pbind(
			\stretch, Pfunc {|ev|
				if(ev.branchLevel.isNil){
					1
				}{
					if(ev.branchLevel > 0){3}{1}
				}
			},
			\time, Ptime(),
			\beatDuration, Pfunc { ~linkClock.tempo },
			\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
		) <>
		Psym(
			Pfunc{|sym|
				(~lsys[\presets][sym].maxPatDur * baseTempo).postln; // beats, muss noch mit baseTempo
				"tolles event".postln;
				sym.postln} <> Pseq([testSymbols, testSymbols2].flop.flat)
		)
	);

	Pdef((testName ++ testNameAdd).asSymbol.postln, Psym(Pseq(testSymbols2)) <> (Pbind(\time, Ptime)));
	Pdef((testName ++ testNameAdd2).asSymbol.postln, Psym(Pseq(testSymbols3)) <> (Pbind(\time, Ptime)));

	testArray.collect{|num| ~lsys[\presets][(testName ++ num).asSymbol].maxPatDur }.sum * baseTempo;

}.value;


{
	var testArray = (2..9);
	var testName = "fraktal_philipp";
	var testNameAdd = "_bd";
	var testNameAdd2 = "_sd";
	var baseTempo = 1/8;
	var leadInstr1 = [\simplePluck];
	var branchInstr1 = \simplePluck;
	var percInstr1 = \bdBuzz;
	var percInstr2 = \metalPerc;
	var testSymbols, testSymbols2, testSymbols3;

	testArray.do(
		{ |item|
			~newLsys.(
				name: (testName ++ item).asSymbol,
				/*axiom: "af[-b]+f[--b]f-fe",
				rules: ( $a: "ad[-b]+f", $b: "b", $e: "f[--b]f-fe", ),*/
				axiom: "aGGf[-b]+fG[--b]fG-Gfe",
				rules: ( $a: "aGGf[-b]+Gf", $b: "f--Gb++", $e: "[--b]f-fe", ),
				gen: item,
				opts: (
					ignorePoints: false,
					baseColor: 0,
					theta: 15,
					branchInterval: -5,
					useGlobalPitch: false,
					noteOffset: -0,
					quant: 0,
					baseTempo: baseTempo,
					legatoArr: 1,// ([0.99] ++ ([0.99, 1.1]!9)).flat,
					wrapLo: [ 12 ],
					wrapHi: [ 96 ],
					instr: leadInstr1, //([leadInstr1] ++ (branchInstr1!18)).flat,
					vols: [2] ++ (1!18),//[1, 0, 0.75, 0.75, 0, 0, 0, 0, 0, 0, 0]
				)
			);

			~newLsys.(
				name: (testName ++ testNameAdd ++ item).asSymbol,
				axiom: "aGGf[-b]+fG[--b]fG-Gfe",
				rules: ( $a: "aGGf[-b]+Gf", $b: "f--Gb++", $e: "[--b]f-fe", ),
				gen: item,
				opts: (
					ignorePoints: true,
					branchInterval: -7,
					baseColor: 25,
					useGlobalPitch: false,
					noteOffset: -24,
					quant: 0,
					baseTempo: baseTempo,
					legatoArr: 0.99,
					wrapLo: [ 12 ],
					wrapHi: [ 36 ],
					instr: percInstr1,
					vols: 0.75
				)
			);

			~newLsys.(
				name: (testName ++ testNameAdd2 ++ item).asSymbol,
				axiom: "aGGf[-b]+fG[--b]fG-Gfe",
				rules: ( $a: "aGGf[-b]+Gf", $b: "f--Gb++", $e: "[--b]f-fe", ),
				gen: item,
				opts: (
					ignorePoints: true,
					baseColor: 25,
					useGlobalPitch: false,
					noteOffset: -12,
					quant: 0,
					baseTempo: baseTempo,
					legatoArr: 0.99,
					wrapLo: [ 72 ],
					wrapHi: [ 84 ],
					instr: percInstr2,
					vols: 0.8
				)
			);
		}
	);

	testArray.do(
		{ |item|
			Pdef((testName ++ item ++ "_filter").asSymbol,
				Pbind(\vol, Pfunc {|ev|
					if(ev.charNow == $F){ev.vol * 1.2}{ev.vol}
				},
				\filter_1_mod_1, Pfunc {|ev|
					if(ev.charNow == $F){ev.filter_1_mod_1 * 1.2}{ev.filter_1_mod_1}
				},
				\timingOffset, Pfunc {|ev|
					if(ev.charNow == $F){0}{0}
				},
				)
				<> (Pbind(\time, Ptime))
			);

			Pdef((testName ++ testNameAdd  ++ item ++ "_filter").asSymbol,
				Pbind(\vol, Pfunc {|ev|
					if(ev.charNow == $a){ev.vol * 1.2}{0}
				},
				\filter_1_mod_1, Pfunc {|ev|
					if(ev.charNow == $F){ev.filter_1_mod_1 * 1.2}{ev.filter_1_mod_1}
				},
				\timingOffset, Pfunc {|ev|
					if(ev.charNow == $F){0}{0}
				},
				)
				<> (Pbind(\time, Ptime))
			);

			Pdef((testName ++ testNameAdd2  ++ item ++ "_filter").asSymbol,
				Pbind(\vol, Pfunc {|ev|
					if(ev.charNow == $b){ev.vol * 1}{0}
				},
				/*			\filter_1_mod_1, Pfunc {|ev|
				if(ev.charNow == $F){ev.filter_1_mod_1 * 1.2}{ev.filter_1_mod_1}
				},*/
				\timingOffset, Pfunc {|ev|
					if(ev.charNow == $F){0}{0}
				},
				)
				<> (Pbind(\time, Ptime))
			);
		}
	);

	testSymbols = testArray.collect({ |item|
		(testName ++ item).asSymbol
	});

	testSymbols2 = testArray.collect({ |item|
		(testName ++ testNameAdd ++ item).asSymbol
	});

	testSymbols3 = testArray.collect({ |item|
		(testName ++ testNameAdd2 ++ item).asSymbol
	});

	Pdef((testName).asSymbol.postln,
		Pbind(
			\stretch, Pfunc {|ev|
				if(ev.branchLevel.isNil){
					1
				}{
					if(ev.branchLevel > 0){3}{1}
				}
			},
			\time, Ptime(),
			\beatDuration, Pfunc { ~linkClock.tempo },
			\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
		) <>
		Psym(
			Pfunc{|sym|
				(~lsys[\presets][sym].maxPatDur * baseTempo).postln; // beats, muss noch mit baseTempo
				"tolles event".postln;
				sym.postln} <> Pseq(testSymbols)
		)
	);

	Pdef((testName ++ testNameAdd).asSymbol.postln, Psym(Pseq(testSymbols2)) <> (Pbind(\time, Ptime)));
	Pdef((testName ++ testNameAdd2).asSymbol.postln, Psym(Pseq(testSymbols3)) <> (Pbind(\time, Ptime)));

	testArray.collect{|num| ~lsys[\presets][(testName ++ num).asSymbol].maxPatDur }.sum * baseTempo;

}.value;




/*
Pdef(\simpleSwitch_midi, Pbind(\controlbus1, ~routing[\launchcontrolXlControlBusses1],
\external1Amount, 1,
\external1min, -1,
\external1max, 1,
\envelope_mod, 0.5
) <> Pdef(\simpleSwitch) <>
Pbind(\external1Target, "envelope_mod")
);
Pdef(\simpleSwitch_gen4_midi, Pbind(\controlbus1, ~routing[\launchcontrolXlControlBusses1],
\external1Amount, 1,
\external1min, -1,
\external1max, 1,
\envelope_mod, 0.5
) <> Pdef(\simpleSwitch_gen4) <>
Pbind(\external1Target, "envelope_mod")
);
Pdef(\simpleSwitch_gen5_midi, Pbind(\controlbus1, ~routing[\launchcontrolXlControlBusses1],
\external1Amount, 1,
\external1min, -1,
\external1max, 1,
\envelope_mod, 0.5
) <> Pdef(\simpleSwitch_gen5) <>
Pbind(\external1Target, "envelope_mod")
);
Pdef(\simpleSwitch_gen6_midi, Pbind(\controlbus1, ~routing[\launchcontrolXlControlBusses1],
\external1Amount, 1,
\external1min, -1,
\external1max, 1,
\envelope_mod, 0.5
) <> Pdef(\simpleSwitch_gen6) <>
Pbind(\external1Target, "envelope_mod")
);

Pdef(\penrose_midi,
Pbind(\controlbus1, ~routing[\launchcontrolXlControlBusses0],
\external1Amount, 1,
\external1min, -1,
\external1max, 1,
\oscillator_1_mod_2, 0.5
) <>
Pdef(\penrose) <>
Pbind(\external1Target, "oscillator_1_mod_2")
);


Pdef(\penrose_gen2_midi,
Pbind(\controlbus1, ~routing[\launchcontrolXlControlBusses0],
\external1Amount, 1,
\external1min, -1,
\external1max, 1,
\oscillator_1_mod_2, 0.5
) <>
Pdef(\penrose_gen2) <>
Pbind(\external1Target, "oscillator_1_mod_2")
);*/