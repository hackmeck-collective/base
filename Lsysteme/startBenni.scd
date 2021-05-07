(
{
	"../Synthese_Sounddesign/0_main_patch.scd".loadRelative;

	~localSetup = true; // hier und bei globals ist das relevant

	"resources/globals.scd".loadRelative;
	"resources/lsysCreator_noDaemon.scd".loadRelative;
	"resources/pdefCreator.scd".loadRelative; // load pdef which will play back lsystems
	"resources/lsys_dict_text_replace.scd".loadRelative;


}.fork
)
/*[
( $F: "G[G]f" , $f: "Gf", $G: "++F----G++" ),
( $F: "G[G]f" , $f: "G[G]f", $G: "++F--[G]--G++" )
].do{ |rules index|
... rules ...
pdefname ++ "rules" ++ index
};*/

/*
F - play
G - rest
- -down
+ - up
[] - new branch
| - play no rule
*/
~instrPreset.create(\crackle);
~instrPreset.edit(\wub);

////////////////// simpleSwitch1
Pdef(\play).clear
(
(Pbind(\controlbus, ~launchcontrol_xl_row_1)
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
				noteOffset: -12,
				quant: 0,
				baseTempo: baseTempo,
				legatoArr: 0.99,
				wrapLo: [ 24 ],
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
				vols: 0.25
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

( Pdef(\metalPerc) <> Pbindef(\fifth, \octave, 6) <> Pbindef(\pulse_4_ob)  ).play(~linkClock, quant: 1);
( Pdef(\bdBuzz) <> Pbindef(\root, \octave, 4) <> Pbindef(\pulse_2) ).play(~linkClock, quant: 1);
);


(
var testArray = (2..7);
var testName = "poppe";
var testNameAdd = "_2";
var testNameAdd2 = "_3";
var testNameAdd3 = "_bd";
var testNameAdd4 = "_sd";
var baseTempo = 1/4;
var legato = 0.5;
var volume = 2;
var leadInstr1 = \simpleLead;
var branchInstr1 = \simpleLead;
var percInstr1 = \blip;
var percInstr2 = \crackle;
var testSymbols, testSymbols2, testSymbols3, testSymbols4, testSymbols5;

testArray.do(
	{ |item|

		~newLsys.(
			name: (testName ++ item).asSymbol,
			axiom: "aG",
			rules: ( $a: "ab", $b: "bc", $c: "cd", $d: "d-e+", $e: "e+f-", $f: "-[--a++]f+", $G: "a[a]" ),
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
			rules: ( $a: "ab", $b: "bc", $c: "+c-d", $d: "de", $e: "e+f-", $f: "--[a]f++", $G: "a[--a++]" ),
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
			rules: ( $a: "ab", $b: "bc", $c: "c-d+", $d: "d[++a--]e", $e: "e--f++", $f: "-[++a--]f+", $G: "a[--a++]" ),
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
			rules: ( $a: "ab", $b: "bc", $c: "cd", $d: "de", $e: "e+f-", $f: "--f++", $G: "" ),
			gen: item,
			opts: (
				useGlobalPitch: false,
				noteOffset: 0,
				quant: 0,
				baseTempo: baseTempo,
				legatoArr: legato,
				wrapLo: [ 72 ],
				wrapHi: [ 84 ],
				instr:  percInstr1, //([leadInstr1] ++ (branchInstr1!18)).flat,
				vols: volume * 0.5
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
				wrapLo: [ 72 ],
				wrapHi: [ 84 ],
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
~poppeStretch = Pbind(\stretch, Pseq([Pseq([Pn(2/3, 6), Pn(2,2)], 3),Pseq([2/3, 4/3, 1/2, 1.5,1,1,1,1])], inf));


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
			\mod1Amount, Pfunc {|ev|
				switch (ev.charNow,
					$a, {ev.mod1Amount * 0.5},
					$b, {ev.mod1Amount * 0.6},
					$c, {ev.mod1Amount * 0.7},
					$d, {ev.mod1Amount * 0.8},
					$e, {ev.mod1Amount * 0.9},
					$f, {ev.mod1Amount * 1}
				)
			},
			\mod1Rate, Pfunc {|ev|
				switch (ev.charNow,
					$a, {ev.mod1Rate * 0.5},
					$b, {ev.mod1Rate * 0.6},
					$c, {ev.mod1Rate * 0.7},
					$d, {ev.mod1Rate * 0.8},
					$e, {ev.mod1Rate * 0.9},
					$f, {ev.mod1Rate * 1}
				)
			},
			\mod2Amount, Pfunc {|ev|
				switch (ev.charNow,
					$a, {ev.mod2Amount * 0.5},
					$b, {ev.mod2Amount * 0.6},
					$c, {ev.mod2Amount * 0.7},
					$d, {ev.mod2Amount * 0.8},
					$e, {ev.mod2Amount * 0.9},
					$f, {ev.mod2Amount * 1}
				)
			},
			\mod3Amount, Pfunc {|ev|
				switch (ev.charNow,
					$a, {ev.mod3Amount * 0.1},
					$b, {ev.mod3Amount * 0.2},
					$c, {ev.mod3Amount * 0.3},
					$d, {ev.mod3Amount * 0.4},
					$e, {ev.mod3Amount * 0.5},
					$f, {ev.mod3Amount * 0.6}
				)
			},
			)
	<> (Pbind(\time, Ptime));

testArray.do(
	{ |item|
		Pdef((testName ++ item ++ "_filter").asSymbol,
			~poppeStretch <>  ~poppeFilter
		);

		Pdef((testName ++ testNameAdd  ++ item ++ "_filter").asSymbol,
			~poppeStretch <>  ~poppeFilter
		);

		Pdef((testName ++ testNameAdd2  ++ item ++ "_filter").asSymbol,
			~poppeStretch <>  ~poppeFilter
		);

		Pdef((testName ++ testNameAdd3  ++ item ++ "_filter").asSymbol,
			~poppeStretch <> Pbind(\vol, Pfunc {|ev|
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
			~poppeStretch <> Pbind(\vol, Pfunc {|ev|
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

// (Pbind(\controlbus, ~launchcontrol_xl_row_1)
// 	<> Pdef(\poppe_bd)
// 	// <> Pbind(\external1Target, "envelope_mod",
// 	// \external1Amount, 1)
// ).play(~linkClock, quant: 1);
//
// (Pbind(\controlbus, ~launchcontrol_xl_row_1)
// <> Pdef(\poppe_sd)
// // <> Pbind(\external1Target, "envelope_mod",
// // \external1Amount, 1)
// ).play(~linkClock, quant: 1);

// ( Pdef(\metalPerc) <> Pbindef(\fifth, \octave, 6) <> Pbindef(\pulse_4_ob)  ).play(~linkClock, quant: 1);
// ( Pdef(\bdBuzz) <> Pbindef(\root, \octave, 4) <> Pbindef(\pulse_2) ).play(~linkClock, quant: 1);
);


(
var testArray = (2..6);
var testName = "triangle";
var testNameAdd = "_2";
var testNameAdd2 = "_3";
var testNameAdd3 = "_bd";
var testNameAdd4 = "_sd";
var baseTempo = 1/8;
var legato = 0.8;
var volume = 2;
var leadInstr1 = \srrPluck;
var branchInstr1 = \simpleLead;
var percInstr1 = \bdBuzz;
var percInstr2 = \crackle;
var testSymbols, testSymbols2, testSymbols3, testSymbols4, testSymbols5;

testArray.do(
	{ |item|

		~newLsys.(
			name: (testName ++ item).asSymbol,
			axiom: "F",
			rules: ( $F: "+F-G--f++GfG", $f: "+[f]F-G--f++GfG", $G: "F" ),
			// rules: ( $F: "+F-G--f++GfG", $f: "+F-G--f++GfG", $G: "[f]F" ),
			// rules: ( $F: "+[f]F-G--f++GfG", $f: "+F-G--f++GfG", $G: "F" ),
			// rules: ( $F: "+F-G--f++GfG", $f: "+[f]F-G--f++GfG", $G: "F" ),
			// rules: ( $F: "+F-G--f++GfG", $f: "+F-G--f++GfG", $G: "F" ),
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
			rules: ( $F: "FGfGfG", $f: "FGfGfG", $G: "f" ),
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
			rules: ( $F: "FGfGfG", $f: "FGfGfG", $G: "f" ),
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
			{true}{0}
		})
			<> (Pbind(\time, Ptime))
		);

		Pdef((testName ++ testNameAdd4  ++ item ++ "_filter").asSymbol,
			Pbind(\vol, Pfunc {|ev|
			case
			{ev.charNow == $F}{0}
			{ev.charNow == $f}{ev.vol * 0.8}
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

///////////////////////// SIMPLE SWITCH

~instrPreset.edit(\sd1);
(
	~newLsys.(
		name: \simpleSwitch,
		axiom: "F",
		rules: ( $F: "FG", $f: "-F+G", $G: "G+f-" ),
		gen: 6,
		opts: (
			useGlobalPitch: false,
			noteOffset: -24,
			quant: 0,
			baseTempo: 1/4,
			legatoArr: 0.75,
			wrapLo: [ 12 ],
			instr: \syncWub
		)
	);

	Pdef(\simpleSwitch_filter,
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

	(Pdef(\play, Psym(Pseq([\simpleSwitch], inf))
		<> (Pbind(\time, Ptime)))
	).play(~linkClock, quant: 4)
);

(
	~newLsys.(
		name: \simpleSwitch,
		axiom: "F",
		rules: ( $F: "FG", $f: "-F+G", $G: "G+f-" ),
		gen: 6,
		opts: (
			useGlobalPitch: false,
			noteOffset: -24,
			quant: 0,
			baseTempo: 1/2,
			legatoArr: 0.75,
			wrapLo: [ 12 ],
			instr: \syncWub
		)
	);

	Pdef(\simpleSwitch_filter,
		Pbind(\vol, Pfunc {|ev|
			if(ev.charNow == $F){ev.vol}{ev.vol * 1.2}
		},
		\filter_1_mod_1, Pfunc {|ev|
			if(ev.charNow == $F){ev.filter_1_mod_1}{ev.filter_1_mod_1 * 1.2}
		},
		\timingOffset, Pfunc {|ev|
			if(ev.charNow == $F){0}{3/16}
		},
		)
		<> (Pbind(\time, Ptime))
	);

	(Pdef(\play, Psym(Pseq([\simpleSwitch], inf))
		<> (Pbind(\time, Ptime)))
	).play(~linkClock, quant: 4)
);



///////////////////////// Rabbit

(
	var gen_all = 3;
	var tempo_all = 1/8;
	var quant_all = 0;

	~newLsys.(
		name: \rabbitSeq,
		axiom: "F",
		rules: ( $F: "+F-G--f++GfG", $f: "+F-G--f++GfG", $G: "F"),
		gen: gen_all,
		opts: (
			useGlobalPitch: false,
			noteOffset: 0,
			quant: quant_all,
			baseTempo: tempo_all,
			legatoArr: 0.2,
			wrapLo: [ 24 ],
			instr: \simplePluck
		)
	);

	~newLsys.(
		name: \rabbitSeq_bd,
		axiom: "F",
		rules: ( $F: "FGfGfG", $f: "FGfGfG", $G: "f"),
		gen: gen_all,
		opts: (
			useGlobalPitch: false,
			noteOffset: 0,
			quant: quant_all,
			baseTempo: tempo_all,
			legatoArr: 0.2,
			wrapLo: [ 12 ],
			instr: \bd1
		)
	);

	~newLsys.(
		name: \rabbitSeq_sd,
		axiom: "F",
		rules: ( $F: "fGFGSG", $f: "fGFGSG", $S: "fsFGSG", $G: "F", $s: "F"),
		gen: gen_all,
		opts: (
			useGlobalPitch: false,
			noteOffset: 7,
			quant: quant_all,
			baseTempo: tempo_all,
			legatoArr: 0.2,
			wrapLo: [ 12 ],
			vols: [0.9],
			instr: \sd1
		)
	);

	~newLsys.(
		name: \rabbitSeq_hh,
		axiom: "H",
		rules: ( $H: "12+H12-GHhHG", $G: "--H++", $h: "--H++"),
		gen: gen_all,
		opts: (
			useGlobalPitch: false,
			noteOffset: 12,
			quant: quant_all,
			baseTempo: tempo_all,
			legatoArr: 0.2,
			wrapLo: [ 12 ],
			vols: [0.9],
			instr: \hh1
		)
	);
);

(
	Pdef(\rabbitSeq_bd_filter,
		Pbind(\vol, Pfunc {|ev|
			if(ev.charNow == $F){ev.vol}{0}
		})
		<> (Pbind(\time, Ptime))
	);

	Pdef(\rabbitSeq_sd_filter,
		Pbind(\vol, Pfunc {|ev|
			case
			{ev.charNow == $S}{ev.vol}
			{ev.charNow == $s}{ev.vol * 0.8}
			{true}{0}
		})
	);

	Pdef(\rabbitSeq_hh_filter,
		Pbind(\vol, Pfunc {|ev|
			case
			{ev.charNow == $H}{ev.vol}
			{ev.charNow == $h}{ev.vol * 0.5}
			{true}{0}
		})
	);


	Pdef(\rabbitSeq_filter,
		Pbind(\vol, Pfunc {|ev|
			if(ev.charNow == $F){ev.vol * 1.1}{ev.vol * 0.8}
		},
		\oscillator_mod_1, Pfunc {|ev|
			if(ev.charNow == $F){ev.oscillator_mod_1 * 1}{ev.oscillator_mod_1 * 0.7}
		},
		\envelope_mod, Pfunc {|ev|
			if(ev.charNow == $F){ev.envelope_mod * 0.8}{ev.envelope_mod * 1}
		},
		)
	);

	( Pbind(\controlbus, ~launchcontrol_xl_row_1)
		<> Psym(Pseq([\rabbitSeq], inf))
		<> Pbind(\external1Target, "envelope_mod",
			\external1Amount, 1)
	).play(~linkClock, quant: 4);
	Pdef(\rabbit_sd, Psym(Pseq([\rabbitSeq_sd], inf))).play(~linkClock, quant: 4);
	Pdef(\rabbit_bd, Psym(Pseq([\rabbitSeq_bd], inf))).play(~linkClock, quant: 4);
	Pdef(\rabbit_hh, Psym(Pseq([\rabbitSeq_hh], inf))).play(~linkClock, quant: 4);
);

(
	~newLsys.(
		name: \theLick,
		axiom: "-F",//"F-F-F-F-F",
		rules: ( $F: "F+F+F+F--FG--F+FGG" ),
		gen: 2.0
	);
)

Pdef(\basicL).play(l)
~lsys.presets.theLick.instr = \simpleBass
~lsys.presets.theLick.baseTempo = 1/7
~lsys.presets.theLick.quant = 0
Pdef(\play, Psym(Pseq([\rabbitSeq_bd], inf))).play

(
	~newLsys.(
		name: \fuenfte,
		axiom: "F-[F-F]-F-F",
		rules: ( $F: "GFFF--FGGG" ),
		gen: 2.0
	);
)

Pdef(\basicL).play(l)
~ctlPresets.fuenfte.presetName = \simplePluck
~ctlPresets.theLick.baseTempo = 1/4
Pdef(\play, Psym(Pseq([\fuenfte], inf))).play





// baueme umdrehen
~newLsys.(
	name: \snowFlake,
	axiom: "F",
	rules: ($F: "F-[|4+[|4G]10F]F"),
	gen: 2.0
)

Pdef(\snowFlake).play(l)
~ctlPresets.snowFlake.baseTempo = 1/8
~ctlPresets.snowFlake.presetName = \srrLead
Pdef(\play, Psym(Pseq([\snowFlake], inf))).play

(
	~newLsys.(
		name: \pausen,
		axiom: "G",
		rules: ( $F: "-F++F-F", $G: "G--X++G[X-X+F]", $X: "[XG-F]----XG++++F" ),
		gen: 2,
		opts: (
			instr: [\simplePluck, \simplePluck, \srrPluck],
			useGlobalPitch: false,
			noteOffset: 28,
			vols: [0.8, 0.7, 0.7],
			legatoArr: 1,
			quant: 0
		)
	)
)
~lsys.presets.pausen.numBranches
Pdef(\play, Pn(Pdef(\pausen))).play


(
	var gen_all = 10;
	var tempo_all = 1/2;
	var quant_all = 0;
	var leg_all = 0.8;
	var vol_all = 1.5;

	~newLsys.(
		name: \poppe_hi,
		axiom: "aG",
		rules: ( $a: "ab", $b: "bc", $c: "cd", $d: "d-e+", $e: "e+f-", $f: "-f[a]+", $G: "[a]" ),
		gen: gen_all,
		opts: (
			useGlobalPitch: false,
			noteOffset: 12,
			quant: quant_all,
			baseTempo: tempo_all,
			legatoArr: leg_all,
			wrapLo: [ 12 ],
			wrapHi: [ 96 ],
			instr: \simpleLead,
			vols: (vol_all * 0.5)
		)
	);


	~newLsys.(
		name: \poppe_mid,
		axiom: "aG",
		rules: ( $a: "ab", $b: "bc", $c: "cd", $d: "de", $e: "e+f-", $f: "--f[a]++", $G: "[--a++]" ),
		gen: gen_all,
		opts: (
			useGlobalPitch: false,
			noteOffset: 0,
			quant: quant_all,
			baseTempo: tempo_all,
			legatoArr: leg_all,
			wrapLo: [ 12 ],
			wrapHi: [ 96 ],
			instr: \simpleLead,
			vols: (vol_all * 0.75)
		)
	);

	~newLsys.(
		name: \poppe_lo,
		axiom: "aG",
		rules: ( $a: "ab", $b: "bc", $c: "cd", $d: "de", $e: "e--f++", $f: "-f[a]+", $G: "[++a--]" ),
		gen: gen_all,
		opts: (
			useGlobalPitch: false,
			noteOffset: -12,
			quant: quant_all,
			baseTempo: tempo_all,
			legatoArr: leg_all),
		wrapLo: [ 12 ],
		wrapHi: [ 96 ],
		instr: \simpleLead,
		vols: (vol_all * 1.5)
	)
);


(
	Pdef(\poppe_hi_filter,
		Pbind(\vol, Pfunc {|ev|
			switch (ev.charNow,
				$a, {ev.vol * 0.5},
				$b, {ev.vol * 0.6},
				$c, {ev.vol * 0.7},
				$d, {ev.vol * 0.8},
				$e, {ev.vol * 0.9},
				$f, {ev.vol * 1}
			)
		},
		\mod1Amount, Pfunc {|ev|
			switch (ev.charNow,
				$a, {ev.mod1Amount * 0.5},
				$b, {ev.mod1Amount * 0.6},
				$c, {ev.mod1Amount * 0.7},
				$d, {ev.mod1Amount * 0.8},
				$e, {ev.mod1Amount * 0.9},
				$f, {ev.mod1Amount * 1}
			)
		},
		\mod1Rate, Pfunc {|ev|
			switch (ev.charNow,
				$a, {ev.mod1Rate * 0.5},
				$b, {ev.mod1Rate * 0.6},
				$c, {ev.mod1Rate * 0.7},
				$d, {ev.mod1Rate * 0.8},
				$e, {ev.mod1Rate * 0.9},
				$f, {ev.mod1Rate * 1}
			)
		},
		\mod2Amount, Pfunc {|ev|
			switch (ev.charNow,
				$a, {ev.mod2Amount * 0.5},
				$b, {ev.mod2Amount * 0.6},
				$c, {ev.mod2Amount * 0.7},
				$d, {ev.mod2Amount * 0.8},
				$e, {ev.mod2Amount * 0.9},
				$f, {ev.mod2Amount * 1}
			)
		},
		\mod3Amount, Pfunc {|ev|
			switch (ev.charNow,
				$a, {ev.mod3Amount * 0.1},
				$b, {ev.mod3Amount * 0.2},
				$c, {ev.mod3Amount * 0.3},
				$d, {ev.mod3Amount * 0.4},
				$e, {ev.mod3Amount * 0.5},
				$f, {ev.mod3Amount * 0.6}
			)
		},
		)

	);

	Pdef(\poppe_mid_filter,
		Pbind(\vol, Pfunc {|ev|
			switch (ev.charNow,
				$a, {ev.vol * 0.5},
				$b, {ev.vol * 0.6},
				$c, {ev.vol * 0.7},
				$d, {ev.vol * 0.8},
				$e, {ev.vol * 0.9},
				$f, {ev.vol * 1}
			)
		},
		\mod1Amount, Pfunc {|ev|
			switch (ev.charNow,
				$a, {ev.mod1Amount * 0.5},
				$b, {ev.mod1Amount * 0.6},
				$c, {ev.mod1Amount * 0.7},
				$d, {ev.mod1Amount * 0.8},
				$e, {ev.mod1Amount * 0.9},
				$f, {ev.mod1Amount * 1}
			)
		},
		\mod1Rate, Pfunc {|ev|
			switch (ev.charNow,
				$a, {ev.mod1Rate * 0.5},
				$b, {ev.mod1Rate * 0.6},
				$c, {ev.mod1Rate * 0.7},
				$d, {ev.mod1Rate * 0.8},
				$e, {ev.mod1Rate * 0.9},
				$f, {ev.mod1Rate * 1}
			)
		},
		\mod2Amount, Pfunc {|ev|
			switch (ev.charNow,
				$a, {ev.mod2Amount * 0.5},
				$b, {ev.mod2Amount * 0.6},
				$c, {ev.mod2Amount * 0.7},
				$d, {ev.mod2Amount * 0.8},
				$e, {ev.mod2Amount * 0.9},
				$f, {ev.mod2Amount * 1}
			)
		},
		\mod3Amount, Pfunc {|ev|
			switch (ev.charNow,
				$a, {ev.mod3Amount * 0.3},
				$b, {ev.mod3Amount * 0.4},
				$c, {ev.mod3Amount * 0.5},
				$d, {ev.mod3Amount * 0.6},
				$e, {ev.mod3Amount * 0.7},
				$f, {ev.mod3Amount * 0.8}
			)
		},
		)
	);

	Pdef(\poppe_lo_filter,
		Pbind(\vol, Pfunc {|ev|
			switch (ev.charNow,
				$a, {ev.vol * 0.5},
				$b, {ev.vol * 0.6},
				$c, {ev.vol * 0.7},
				$d, {ev.vol * 0.8},
				$e, {ev.vol * 0.9},
				$f, {ev.vol * 1}
			)
		},
		\mod1Amount, Pfunc {|ev|
			switch (ev.charNow,
				$a, {ev.mod1Amount * 0.5},
				$b, {ev.mod1Amount * 0.6},
				$c, {ev.mod1Amount * 0.7},
				$d, {ev.mod1Amount * 0.8},
				$e, {ev.mod1Amount * 0.9},
				$f, {ev.mod1Amount * 1}
			)
		},
		\mod1Rate, Pfunc {|ev|
			switch (ev.charNow,
				$a, {ev.mod1Rate * 0.5},
				$b, {ev.mod1Rate * 0.6},
				$c, {ev.mod1Rate * 0.7},
				$d, {ev.mod1Rate * 0.8},
				$e, {ev.mod1Rate * 0.9},
				$f, {ev.mod1Rate * 1}
			)
		},
		\mod2Amount, Pfunc {|ev|
			switch (ev.charNow,
				$a, {ev.mod2Amount * 0.5},
				$b, {ev.mod2Amount * 0.6},
				$c, {ev.mod2Amount * 0.7},
				$d, {ev.mod2Amount * 0.8},
				$e, {ev.mod2Amount * 0.9},
				$f, {ev.mod2Amount * 1}
			)
		},
		\mod3Amount, Pfunc {|ev|
			switch (ev.charNow,
				$a, {ev.mod3Amount * 0.5},
				$b, {ev.mod3Amount * 0.6},
				$c, {ev.mod3Amount * 0.7},
				$d, {ev.mod3Amount * 0.8},
				$e, {ev.mod3Amount * 0.9},
				$f, {ev.mod3Amount * 1}
			)
		},
		)
	);

	( Pbind(\controlbus, ~launchcontrol_xl_row_1)
		<> Psym(Pseq([\poppe_hi], inf))
		<> Pbind(\external1Target, "envelope_mod",
			\external1Amount, 1)
	).play(~linkClock, quant: 4);

	( Pbind(\controlbus, ~launchcontrol_xl_row_1)
		<> Psym(Pseq([\poppe_mid], inf))
		<> Pbind(\external1Target, "envelope_mod",
			\external1Amount, 1)
	).play(~linkClock, quant: 4);

	( Pbind(\controlbus, ~launchcontrol_xl_row_1)
		<> Psym(Pseq([\poppe_lo], inf))
		<> Pbind(\external1Target, "envelope_mod",
			\external1Amount, 1)
	).play(~linkClock, quant: 4);

);

// es gibt fuer jedes lsystem pdef ein pdef mit dem namen + _filter
// außerdem für jedes "branchLevel" ein pdef mit dem namen + _filter0 (_filter1, _filter2 .. )
// alle werden mit leerem Pbind initialisiert (bewirken also keine änderung)

// fuer das gesamte lsys den wert \oscillator_mod_1 ändern wenn der char F ist
Pdef(\pausen_filter,
	Pbind(\oscillator_mod_1, Pfunc {|ev|
		if(ev.charNow == $F){0}{ev.oscillator_mod_1}
	})
)
Pdef(\pausen_filter, Pbind()) // rückgängig machen

// fuer branchlevel 0 (root) midinote random ändern
Pdef(\pausen_filter0,
	Pbind(\midinote, Pkey(\midinote) + Prand([0,7],inf))
)
Pdef(\pausen_filter0, Pbind()) // rückgängig machen

// bei level 2 alle X rausfiltern
Pdef(\pausen_filter1,
	Pbind(\vol, Pfunc{|ev|
		if(ev.charNow == $X){0}{ev.vol}})
)
Pdef(\pausen_filter1, Pbind())

// bei level 3 alle F rausfiltern
Pdef(\pausen_filter2,
	Pbind(\vol, Pfunc{|ev|
		if(ev.charNow == $F){0}{ev.vol}})
)
Pdef(\pausen_filter2, Pbind())
