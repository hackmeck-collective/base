////////////////// triangle

Pdef(\play).clear
(
(Pbind(\controlbus, ~launchcontrol_xl_row_1)
<> Pdef(\triangle)
<> Pbind(
	\external1Target, "oscillator_mod_1",
	\external1Amount, 0.75,
	\external1Target2, "oscillator_mod_2",
	\external1Amount2, 1,
	\external2Target, "envelope_mod",
	\external2Amount, 1,
)).play(~linkClock, quant: 1);

(Pbind(\controlbus, ~launchcontrol_xl_row_1)
<> Pdef(\triangle_bd)
// <> Pbind(\external1Target, "envelope_mod",
// \external1Amount, 1)
).play(~linkClock, quant: 1);

(Pbind(\controlbus, ~launchcontrol_xl_row_1)
<> Pdef(\triangle_sd)
// <> Pbind(\external1Target, "envelope_mod",
// \external1Amount, 1)
).play(~linkClock, quant: 1);

);


(
var testArray = (2..15);
var testName = "triangle";
var testNameAdd = "_2";
var testNameAdd2 = "_3";
var testNameAdd3 = "_bd";
var testNameAdd4 = "_sd";
var baseTempo = 1/8;
var legato = 0.8;
var volume = 2;
var leadInstr1 = \simplePluck;
var branchInstr1 = \simpleLead;
var percInstr1 = \bdBuzz;
var percInstr2 = \crackle;
var testSymbols, testSymbols2, testSymbols3, testSymbols4, testSymbols5;

testArray.do(
	{ |item|

		~newLsys.(
			name: (testName ++ item).asSymbol,
			axiom: "F",
			rules: ( $F: "+F-g--f++gfG", $G: "F" ),
			gen: item,
			opts: (
				useGlobalPitch: false,
				noteOffset: 0,
				quant: 0,
				baseTempo: baseTempo,
				legatoArr: legato,
				wrapLo: [ 12 ],
				wrapHi: [ 96 ],
				instr:  leadInstr1, //([leadInstr1] ++ (branchInstr1!18)).flat,
				vols: volume
			)
		);

		~newLsys.(
			name: (testName ++ testNameAdd3 ++ item).asSymbol,
			axiom: "F",
			rules: ( $F: "FgfgfG", $G: "F" ),
			gen: item,
			opts: (
				useGlobalPitch: false,
				noteOffset: 0,
				quant: 0,
				baseTempo: baseTempo,
				legatoArr: legato,
				wrapLo: [ 24 ],
				wrapHi: [ 36 ],
				instr:  percInstr1, //([leadInstr1] ++ (branchInstr1!18)).flat,
				vols: volume * 0.5
			)
		);

		~newLsys.(
			name: (testName ++ testNameAdd4 ++ item).asSymbol,
			axiom: "F",
			rules: ( $F: "FgfgfG", $G: "F" ),
			gen: item,
			opts: (
				useGlobalPitch: false,
				noteOffset: -12,
				quant: 0,
				baseTempo: baseTempo,
				legatoArr: legato,
				wrapLo: [ 72 ],
				wrapHi: [ 84 ],
				instr: percInstr2, //([leadInstr1] ++ (branchInstr1!18)).flat,
				vols: volume * 1
			)
		);

	}
);

testArray.do(
	{ |item|
		Pdef((testName ++ item ++ "_filter").asSymbol,
			Pbind(\vol, Pfunc {|ev|
				case
				{ev.charNow == $F}{ev.vol * 1.2}
				{ev.charNow == $f}{ev.vol}
				{ev.charNow == $g}{0}
			},
			\filter_1_mod_1, Pfunc {|ev|
				if(ev.charNow == $F){ev.filter_1_mod_1}{ev.filter_1_mod_1 * 1.2}
			},
			\timingOffset, Pfunc {|ev|
				if(ev.charNow == $F){0}{0}
			},
			)
			<> (Pbind(\time, Ptime))
		);



		/*		Pdef((testName ++ testNameAdd2  ++ item ++ "_filter").asSymbol,
		Pbind(\vol, Pfunc {|ev|
		if(ev.charNow == $F){ev.vol}{ev.vol * 1.2}
		},
		\filter_1_mod_1, Pfunc {|ev|
		if(ev.charNow == $F){ev.filter_1_mod_1}{ev.filter_1_mod_1 * 1.2}
		},
		\timingOffset, Pfunc {|ev|
		if(ev.charNow == $F){0}{0}
		},
		)
		<> (Pbind(\time, Ptime))
		);

		Pdef((testName ++ testNameAdd  ++ item ++ "_filter").asSymbol,
		Pbind(\vol, Pfunc {|ev|
		if(ev.charNow == $F){ev.vol}{ev.vol * 1.2}
		},
		\filter_1_mod_1, Pfunc {|ev|
		if(ev.charNow == $F){ev.filter_1_mod_1}{ev.filter_1_mod_1 * 1.2}
		},
		\timingOffset, Pfunc {|ev|
		if(ev.charNow == $F){0}{0}
		},
		)
		<> (Pbind(\time, Ptime))
		);*/

		Pdef((testName ++ testNameAdd3  ++ item ++ "_filter").asSymbol,
			Pbind(\vol, Pfunc {|ev|
				case
				{ev.charNow == $F}{ev.vol}
				{ev.charNow == $f}{0}
				{ev.charNow == $g}{0}
				{true}{0}
			})
			<> (Pbind(\time, Ptime))
		);

		Pdef((testName ++ testNameAdd4  ++ item ++ "_filter").asSymbol,
			Pbind(\vol, Pfunc {|ev|
				case
				{ev.charNow == $F}{0}
				{ev.charNow == $f}{ev.vol * 0.8}
				{ev.charNow == $g}{0}
				{true}{0}
			})
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

testSymbols4 = testArray.collect({ |item|
	(testName ++ testNameAdd3 ++ item).asSymbol
});

testSymbols5 = testArray.collect({ |item|
	(testName ++ testNameAdd4 ++ item).asSymbol
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
			(~lsys.presets[sym].maxPatDur * baseTempo).postln; // beats, muss noch mit baseTempo
			"tolles event".postln;
			sym.postln} <> Pseq(testSymbols)
	)
);

Pdef((testName ++ testNameAdd).asSymbol.postln,
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
) <>Psym(Pseq(testSymbols2)) <> (Pbind(\time, Ptime)));
Pdef((testName ++ testNameAdd2).asSymbol.postln,
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
) <>Psym(Pseq(testSymbols3)) <> (Pbind(\time, Ptime)));

Pdef((testName ++ testNameAdd3).asSymbol.postln,
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
) <>Psym(Pseq(testSymbols4)) <> (Pbind(\time, Ptime)));
Pdef((testName ++ testNameAdd4).asSymbol.postln,
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
) <>Psym(Pseq(testSymbols5)) <> (Pbind(\time, Ptime)));

testArray.collect{|num| ~lsys.presets[(testName ++ num).asSymbol].maxPatDur }.sum * baseTempo;

);
