////////////////// simpleSwitch1
Pdef(\play).clear
(
(Pbind(\controlbus1, ~launchcontrol_xl_row_1,
	\controlbus2, ~launchcontrol_xl_row_1,
	\controlbus3, ~launchcontrol_xl_row_1,
)
<> Pdef(\simpleSwitchMelody)
<> Pbind(
	\external1Target, "filter_1_mod_1",
	\external1Amount, 0.5,
	\external1Target2, "fx_mod_1",
	\external1Amount2, 1,
	\external2Target, "envelope_mod",
	\external2Amount, 1,
)).play(~linkClock, quant: 1);
(Pbind(\controlbus, ~launchcontrol_xl_row_1)
<> Pdef(\simpleSwitchMelody_bd)
// <> Pbind(\external1Target, "envelope_mod",
// \external1Amount, 1)
).play(~linkClock, quant: 1);
(Pbind(\controlbus, ~launchcontrol_xl_row_1)
<> Pdef(\simpleSwitchMelody_sd)
// <> Pbind(\external1Target, "envelope_mod",
// \external1Amount, 1)
).play(~linkClock, quant: 1);
 ( Pdef(\sd2) <> Pbindef(\fifth) <> Pbindef(\pulse_4_ob)  ).play(~linkClock, quant: 1);
 ( Pdef(\bd1) <> Pbindef(\root) <> Pbindef(\pulse) ).play(~linkClock, quant: 1);
);


(
var testArray = (2..9);
var testName = "simpleSwitchMelody";
var testNameAdd = "_bd";
var testNameAdd2 = "_sd";
var baseTempo = 1/8;
var leadInstr1 = \simplePluck;
var branchInstr1 = \simplePluck;
var percInstr1 = \bdBuzz;
var percInstr2 = \metalPerc;
var testSymbols, testSymbols2, testSymbols3;

testArray.do(
	{ |item|
		~newLsys.(
			name: (testName ++ item).asSymbol,
			axiom: "G",
			rules: ( $F: "Gf" , $f: "Gf", $G: "++F----G++" ),
			// rules: ( $F: "G[G]f" , $f: "Gf", $G: "++F----G++" ),
			// rules: ( $F: "G[G]f" , $f: "G[G]f", $G: "++F----G++" ),
			// rules: ( $F: "G[G]f" , $f: "G[G]f", $G: "++F--[G]--G++" ),
			gen: item,
			opts: (
				useGlobalPitch: false,
				noteOffset: 0,
				quant: 0,
				baseTempo: baseTempo,
				legatoArr: 1,// ([0.99] ++ ([0.99, 1.1]!9)).flat,
				wrapLo: [ 12 ],
				wrapHi: [ 96 ],
				instr: leadInstr1, //([leadInstr1] ++ (branchInstr1!18)).flat,
				vols: 2,//[1, 0, 0.75, 0.75, 0, 0, 0, 0, 0, 0, 0]
			)
		);

		~newLsys.(
			name: (testName ++ testNameAdd ++ item).asSymbol,
			axiom: "G",
			rules: ( $F: "Gf" , $f: "Gf", $G: "FG" ),
			gen: item,
			opts: (
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
				vols: 0.1
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
				if(ev.charNow == $F){ev.vol * 1.2}{0}
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
			(~lsys.presets[sym].maxPatDur * baseTempo).postln; // beats, muss noch mit baseTempo
			"tolles event".postln;
			sym.postln} <> Pseq(testSymbols)
	)
);

Pdef((testName ++ testNameAdd).asSymbol.postln, Psym(Pseq(testSymbols2)) <> (Pbind(\time, Ptime)));
Pdef((testName ++ testNameAdd2).asSymbol.postln, Psym(Pseq(testSymbols3)) <> (Pbind(\time, Ptime)));

testArray.collect{|num| ~lsys.presets[(testName ++ num).asSymbol].maxPatDur }.sum * baseTempo;

);