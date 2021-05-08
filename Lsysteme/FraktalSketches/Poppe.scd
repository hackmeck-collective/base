////////////////// poppe



Pdef(\play).clear
(

(Pbind(\controlbus, ~launchcontrol_xl_row_1)
<> Pdef(\poppe)
<> Pbind(
	\external1Target, "filter_1_mod_1",
	\external1Amount, 0.5,
	\external1Target2, "fx_mod_1",
	\external1Amount2, 1,
	\external2Target, "envelope_mod",
	\external2Amount, 1,
)).play(~linkClock, quant: 1);

(Pbind(\controlbus, ~launchcontrol_xl_row_1)
<> Pdef(\poppe_2)
<> Pbind(
	\external1Target, "filter_1_mod_1",
	\external1Amount, 0.5,
	\external1Target2, "fx_mod_1",
	\external1Amount2, 1,
	\external2Target, "envelope_mod",
	\external2Amount, 1,
)).play(~linkClock, quant: 1);

(Pbind(\controlbus, ~launchcontrol_xl_row_1)
<> Pdef(\poppe_3)
<> Pbind(
	\external1Target, "filter_1_mod_1",
	\external1Amount, 0.5,
	\external1Target2, "fx_mod_1",
	\external1Amount2, 1,
	\external2Target, "envelope_mod",
	\external2Amount, 1,
)).play(~linkClock, quant: 1);

(Pbind(\controlbus, ~launchcontrol_xl_row_1)
<> Pdef(\poppe_bd)
// <> Pbind(\external1Target, "envelope_mod",
// \external1Amount, 1)
).play(~linkClock, quant: 1);

(Pbind(\controlbus, ~launchcontrol_xl_row_1)
<> Pdef(\poppe_sd)
// <> Pbind(\external1Target, "envelope_mod",
// \external1Amount, 1)
).play(~linkClock, quant: 1);

);


(
var testArray = (2..7);
var testName = "poppe";
var testNameAdd = "_2";
var testNameAdd2 = "_3";
var testNameAdd3 = "_bd";
var testNameAdd4 = "_sd";
var baseTempo = 1/4;
var legato = 0.9;
var volume = 2;
var leadInstr1 = \simpleLead;
var branchInstr1 = \simpleLead;
var percInstr1 = \bdBuzz;
var percInstr2 = \crackle;
var testSymbols, testSymbols2, testSymbols3, testSymbols4, testSymbols5;

testArray.do(
	{ |item|

		~newLsys.(
			name: (testName ++ item).asSymbol,
			axiom: "aG",
			// rules: ( $a: "+a-b", $b: "bc", $c: "cd", $d: "d-e+", $e: "e+f-", $f: "-[--a++]f+", $G: "a[a]" ),
			rules: ( $a: "ab", $b: "bc", $c: "cd", $d: "d-e+", $e: "e+f-", $f: "-[--a++]f+", $G: "a" ),
			gen: item,
			opts: (
				useGlobalPitch: false,
				noteOffset: 12,
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
			name: (testName ++ testNameAdd ++ item).asSymbol,
			axiom: "aG",
			// rules: ( $a: "ab", $b: "bc", $c: "cd", $d: "de", $e: "e+f-", $f: "--[a]f++", $G: "a[--a++]" ),
			// rules: ( $a: "ab", $b: "bc", $c: "+c-d", $d: "de", $e: "e+f-", $f: "--[a]f++", $G: "a[--a++]" ),
			rules: ( $a: "ab", $b: "bc", $c: "+c-d", $d: "de", $e: "e+f-", $f: "--f++", $G: "a" ),
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
				vols: volume * 1.5
			)
		);

		~newLsys.(
			name: (testName ++ testNameAdd2 ++ item).asSymbol,
			axiom: "aG",
			// rules: ( $a: "ab", $b: "bc", $c: "c-d+", $d: "d[++a--]e", $e: "e--f++", $f: "-[++a--]f+", $G: "a[--a++]" ),
			rules: ( $a: "ab", $b: "bc", $c: "c-d+", $d: "de", $e: "e--f++", $f: "-f+", $G: "a" ),
			gen: item,
			opts: (
				useGlobalPitch: false,
				noteOffset: -12,
				quant: 0,
				baseTempo: baseTempo,
				legatoArr: legato,
				wrapLo: [ 12 ],
				wrapHi: [ 96 ],
				instr: leadInstr1, //([leadInstr1] ++ (branchInstr1!18)).flat,
				vols: volume * 2
			)
		);

		~newLsys.(
			name: (testName ++ testNameAdd3 ++ item).asSymbol,
			axiom: "aG",
			rules: ( $a: "ab", $b: "bc", $c: "cd", $d: "de", $e: "e+f-", $f: "--f++", $G: "a" ),
			gen: item,
			opts: (
				useGlobalPitch: false,
				noteOffset: -24,
				quant: 0,
				baseTempo: baseTempo,
				legatoArr: legato,
				wrapLo: [ 12 ],
				wrapHi: [ 96 ],
				instr:  percInstr1, //([leadInstr1] ++ (branchInstr1!18)).flat,
				vols: volume * 0.4
			)
		);

		~newLsys.(
			name: (testName ++ testNameAdd4 ++ item).asSymbol,
			axiom: "aG",
			rules: ( $a: "+a-+b-", $b: "-b++c-", $c: "cd", $d: "de", $e: "e--f++", $f: "-f+", $G: "" ),
			gen: item,
			opts: (
				useGlobalPitch: false,
				noteOffset: -12,
				quant: 0,
				baseTempo: baseTempo,
				legatoArr: legato,
				wrapLo: [ 12 ],
				wrapHi: [ 96 ],
				instr: percInstr2, //([leadInstr1] ++ (branchInstr1!18)).flat,
				vols: volume * 1
			)
		);
		//
		// ~newLsys.(
		// 	name: (testName ++ testNameAdd ++ item).asSymbol,
		// 	axiom: "G",
		// 	rules: ( $F: "Gf" , $f: "Gf", $G: "FG" ),
		// 	gen: item,
		// 	opts: (
		// 		useGlobalPitch: false,
		// 		noteOffset: -12,
		// 		quant: 0,
		// 		baseTempo: baseTempo,
		// 		legatoArr: 0.99,
		// 		wrapLo: [ 24 ],
		// 		wrapHi: [ 36 ],
		// 		instr: percInstr1,
		// 		vols: 0.75
		// 	)
		// );
		//
		// ~newLsys.(
		// 	name: (testName ++ testNameAdd2 ++ item).asSymbol,
		// 	axiom: "G",
		// 	rules: ( $F: "G--f++" , $f: "G++F--", $G: "+f--G+" ),
		// 	gen: item,
		// 	opts: (
		// 		useGlobalPitch: false,
		// 		noteOffset: -12,
		// 		quant: 0,
		// 		baseTempo: baseTempo,
		// 		legatoArr: 0.99,
		// 		wrapLo: [ 84 ],
		// 		wrapHi: [ 96 ],
		// 		instr: percInstr2,
		// 		vols: 0.25
		// 	)
		// );
	}
);
// 6/3  + (6 / 2)
// ~poppeStretch = Pbind(\stretch, Pseq([4/3, 2/3, Pn(1, 6)], inf));
// ~poppeStretch = Pbind(\stretch, Pseq([1/2, 1/2, 3/2, 3/2, Pn(1, 8)], inf));
// ~poppeStretch = Pbind(\stretch, Pseq([2/3,2/3,2/3, 1, 1, 4/3,4/3,4/3, 1, 1], inf));

// ~poppeStretch = Pbind(\stretch, Pseq([2/3, 4/3, 1/2, 1.5,1,1], inf));
// ~poppeStretch2 = Pbind(\stretch, Pseq([4/3, 2/3, 1.5,1/2,1,1], inf));
/*~poppeStretch = Pbind(\stretch, Pseq([8/5, 2/5], inf));
~poppeStretch2 = Pbind(\stretch, Pseq([2/5, 8/5], inf));*/

// ~poppeStretch = Pbind(\stretch, Pseq([3/2, 1/2,1,1, 4/3, 2/3, 1,1,8/5, 2/5, 1,1,12/7, 2/7,1,1], inf));
// ~poppeStretch = Pbind(\stretch, Prand([Pseq([4/3, 2/3]), Pn(1,2)], inf));
// ~poppeStretch = Pbind(\stretch, Pseq([Pseq([Pn(2/3, 6), Pn(2,2)], 3),Pseq([2/3, 4/3, 1/2, 1.5,1,1,1,1])], inf));


~poppeFilter = Pbind(\vol, Pfunc {|ev|
	switch (ev.charNow,
		$a, {ev.vol * 0.5},
		$b, {ev.vol * 0.6},
		$c, {ev.vol * 0.7},
		$d, {ev.vol * 0.8},
		$e, {ev.vol * 0.9},
		$f, {ev.vol * 1}
	)
},
\pitchOp_2_interval, Pfunc {|ev|
	switch (ev.charNow,
		$a, {ev.pitchOp_2_interval * 0.2},
		$b, {ev.pitchOp_2_interval * 0.4},
		$c, {ev.pitchOp_2_interval * 0.6},
		$d, {ev.pitchOp_2_interval * 0.8},
		$e, {ev.pitchOp_2_interval * 1},
		$f, {ev.pitchOp_2_interval * 1.2}
	)
},
\filter_1_mod_2, Pfunc {|ev|
	switch (ev.charNow,
		$a, {ev.filter_1_mod_2 * 0.5},
		$b, {ev.filter_1_mod_2 * 0.6},
		$c, {ev.filter_1_mod_2 * 0.7},
		$d, {ev.filter_1_mod_2 * 0.8},
		$e, {ev.filter_1_mod_2 * 0.9},
		$f, {ev.filter_1_mod_2 * 1}
	)
},
/*\stretch, Pfunc {|ev|
	switch (ev.charNow,
		$a, {16},
		$b, {8},
		$c, {4},
		$d, {2},
		$e, {1},
		$f, {0.5}
	)
},*/
\stretch, Pfunc {|ev|
	switch (ev.charNow,
		$a, {2},
		$b, {1},
		$c, {1},
		$d, {2},
		$e, {1},
		$f, {1}
	)
},
)
<> (Pbind(\time, Ptime));

testArray.do(
	{ |item|
		Pdef((testName ++ item ++ "_filter").asSymbol,
			/*~poppeStretch <> */ ~poppeFilter
		);

		Pdef((testName ++ testNameAdd  ++ item ++ "_filter").asSymbol,
			/*~poppeStretch <>  */~poppeFilter
		);

		Pdef((testName ++ testNameAdd2  ++ item ++ "_filter").asSymbol,
			/*~poppeStretch <> */ ~poppeFilter
		);

		Pdef((testName ++ testNameAdd3  ++ item ++ "_filter").asSymbol,
			/*~poppeStretch <> */Pbind(\vol, Pfunc {|ev|
				switch (ev.charNow,
					$a, {ev.vol * 1},
					$b, {ev.vol * 0},
					$c, {ev.vol * 0.75},
					$d, {ev.vol * 0},
					$e, {ev.vol * 0.5},
					$f, {ev.vol * 0}
				)
			},
			)
			<> (Pbind(\time, Ptime))
		);

		Pdef((testName ++ testNameAdd4  ++ item ++ "_filter").asSymbol,
			/*~poppeStretch <> */Pbind(\vol, Pfunc {|ev|
				switch (ev.charNow,
					$a, {ev.vol * 0},
					$b, {ev.vol * 0.6},
					$c, {ev.vol * 0},
					$d, {ev.vol * 0.8},
					$e, {ev.vol * 0},
					$f, {ev.vol * 1}
				)
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