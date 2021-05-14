////////////////// simpleSwitch1
Pdef(\play).clear
(
(Pbind(\controlbus1, ~launchcontrol_xl_row_1,
	\controlbus2, ~launchcontrol_xl_row_1,
	\controlbus3, ~launchcontrol_xl_row_1,
)
<> Pdef(\fraktal_1)
<> Pbind(
	\external1Target, "filter_1_mod_1",
	\external1Amount, 0.5,
	\external1Target2, "fx_mod_1",
	\external1Amount2, 1,
	\external2Target, "envelope_mod",
	\external2Amount, 1,
)).play(~linkClock, quant: 1);
// (Pbind(\controlbus, ~launchcontrol_xl_row_1)
// <> Pdef(\simpleSwitchMelody_bd)
// // <> Pbind(\external1Target, "envelope_mod",
// // \external1Amount, 1)
// ).play(~linkClock, quant: 1);
// (Pbind(\controlbus, ~launchcontrol_xl_row_1)
// <> Pdef(\simpleSwitchMelody_sd)
// // <> Pbind(\external1Target, "envelope_mod",
// // \external1Amount, 1)
// ).play(~linkClock, quant: 1);
// ( Pdef(\sd2) <> Pbindef(\fifth) <> Pbindef(\pulse_4_ob)  ).play(~linkClock, quant: 1);
// ( Pdef(\bd1) <> Pbindef(\root) <> Pbindef(\pulse) ).play(~linkClock, quant: 1);
);


(
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
				noteOffset: 0,
				stepInterval: 1,
				quant: 0,
				baseTempo: baseTempo,
				legatoArr: 1,
				wrapLo: [ 12 ],
				wrapHi: [ 96 ],
				instr: leadInstr1,
				vols: 2,
			)
		);

		~newLsys.(
			name: (testName ++ testNameAdd ++ item).asSymbol,
			axiom: "G",
			rules: ( $F: "Gf" , $f: "Gf", $G: "++F----G++" ),
			gen: item,
			opts: (
				useGlobalPitch: false,
				noteOffset: 0,
				stepInterval: -1,
				quant: 0,
				baseTempo: baseTempo,
				legatoArr: 1,
				wrapLo: [ 12 ],
				wrapHi: [ 96 ],
				instr: leadInstr1,
				vols: 2,
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
			(~lsys.presets[sym].maxPatDur * baseTempo).postln; // beats, muss noch mit baseTempo
			"tolles event".postln;
			sym.postln} <> Pseq([testSymbols, testSymbols2].flop.flat)
	)
);

Pdef((testName ++ testNameAdd).asSymbol.postln, Psym(Pseq(testSymbols2)) <> (Pbind(\time, Ptime)));
Pdef((testName ++ testNameAdd2).asSymbol.postln, Psym(Pseq(testSymbols3)) <> (Pbind(\time, Ptime)));

testArray.collect{|num| ~lsys.presets[(testName ++ num).asSymbol].maxPatDur }.sum * baseTempo;

);
s.record
Pdef(\play).clear

Pdef(\play).quant =4 // wichtig!!!!

Pdef(\play, Pn(Psync(Pdef(\fraktal_12), 4, 4),inf)).play(~linkClock, quant:4)
Pdef(\play, Pn(Psync(Pdef(\fraktal_12), 3, 4),inf))
Pdef(\play, Pn(Psync(Pdef(\fraktal_13), 2, 4),inf))
Pdef(\play, Pn(Psync(Pdef(\fraktal_13), 1, 4),inf))
Pdef(\play, Pn(Psync(Pdef(\fraktal_14), 3, 100),inf))
// Pdef(\play, Psym(Pseq((5..7).collect{|n|("fraktal_1" ++ n).asSymbol} ++ [\fraktal_1_inverse7])) )
// Pdef(\play, Psym(Pseq((2..7).collect{|n|("fraktal_1" ++ n).asSymbol} ++ [\fraktal_1_inverse7])) )
(
Pdef(\play,
	Pspawner({|sp|
		var player1, player2, player3;
		sp.seq(Psync(Pdef(\fraktal_15), 5, 100));
		sp.seq(Psync(Pdef(\fraktal_16), 3, 100));
		sp.seq(Psync(Pdef(\fraktal_17), 0, 100));
		sp.seq(Psync(Pdef(\fraktal_1_inverse7), 0, 100));

		player1 = sp.par(Pn(Psync(Pdef(\fraktal_13), 1, 4),inf));
		player2 = sp.par(Pdef(\fraktal_philipp_bd));
		player3 = sp.par(Pdef(\fraktal_philipp_sd));

		sp.wait(16);
		player1.stop; player2.stop; player3.stop;
		player2 = sp.par(Pdef(\fraktal_philipp_bd));
		player3 = sp.par(Pdef(\fraktal_philipp_sd));
		sp.par(
			(Pbind(\controlbus1, ~launchcontrol_xl_row_1,
				\controlbus2, ~launchcontrol_xl_row_1,
				\controlbus3, ~launchcontrol_xl_row_1,
			)
			<> Pdef(\fraktal_philipp)
			<> Pbind(
				\external1Target, "filter_1_mod_1",
				\external1Amount, 0.5,
				\external1Target2, "fx_mod_1",
				\external1Amount2, 1,
				\external2Target, "envelope_mod",
				\external2Amount, 1,
		)));
		sp.wait(12);
		sp.par(
			Pdef(\sd2).collect {|ev| ~scM4.play; ev} <> Pbindef(\fifth) <> Pbindef(\pulse_4_ob)
		);
}))
)

s.record

~lsys.presets.fraktal_philipp_bd5
(
Pdef(\play, Pn(Psync(Pdef(\fraktal_13), 1, 4),inf));
Pdef(\fraktal_philipp_bd).play(~linkClock, quant: 1);
Pdef(\fraktal_philipp_sd).play(~linkClock, quant: 1);
);
(
Pdef(\play).stop;
(Pbind(\controlbus1, ~launchcontrol_xl_row_1,
	\controlbus2, ~launchcontrol_xl_row_1,
	\controlbus3, ~launchcontrol_xl_row_1,
)
<> Pdef(\fraktal_philipp)
<> Pbind(
	\external1Target, "filter_1_mod_1",
	\external1Amount, 0.5,
	\external1Target2, "fx_mod_1",
	\external1Amount2, 1,
	\external2Target, "envelope_mod",
	\external2Amount, 1,
)).play(~linkClock, quant: 1);

Pdef(\fraktal_philipp_bd).play(~linkClock, quant: 1);
Pdef(\fraktal_philipp_sd).play(~linkClock, quant: 1);

~sd = ( Pdef(\sd2).collect {|ev| ~scM4.play; ev} <> Pbindef(\fifth) <> Pbindef(\pulse_4_ob)  ).play(~linkClock, quant: 1);
);

