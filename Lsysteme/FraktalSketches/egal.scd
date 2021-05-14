////////////////// simpleSwitch1
Pdef(\play).clear
(
(Pbind().trace <> Pdef(\egal2)).play(~linkClock, quant: 1);
);
// BEI G AM ANFANG Gehts nischt
~newLsys.(
	name: \egal2,
	axiom: "|G",
	rules: ( $F: "Gf" , $f: "Gf", $G: "++F----G++" ),
	// rules: ( $F: "G[G]f" , $f: "Gf", $G: "++F----G++" ),
	// rules: ( $F: "G[G]f" , $f: "G[G]f", $G: "++F----G++" ),
	// rules: ( $F: "G[G]f" , $f: "G[G]f", $G: "++F--[G]--G++" ),
	gen: 2,
	opts: (
		useGlobalPitch: false,
		noteOffset: 0,
		quant: 0,
		baseTempo: 1/8,
		legatoArr: 1,// ([0.99] ++ ([0.99, 1.1]!9)).flat,
		wrapLo: [ 12 ],
		wrapHi: [ 96 ],
		instr: \simplePluck, //([leadInstr1] ++ (branchInstr1!18)).flat,
		vols: 2,//[1, 0, 0.75, 0.75, 0, 0, 0, 0, 0, 0, 0]
	)
);


(
var testArray = (2..9);
var testName = "egal";
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
			axiom: "F",
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
	}
);

testArray.do(
	{ |item|
		Pdef((testName ++ item ++ "_filter").asSymbol,
			Pbind(
				/*				\vol, Pfunc {|ev|
				if(ev.charNow == $F){ev.vol * 1.2}{ev.vol ? 1}
				},*/
				/*\filter_1_mod_1, Pfunc {|ev|
				if(ev.charNow == $F){ev.filter_1_mod_1 * 1.2}{ev.filter_1_mod_1}
				},
				\timingOffset, Pfunc {|ev|
				if(ev.charNow == $F){0}{0}
				},*/
			)
			//<> (Pbind(\time, Ptime))
		);
	}
);

testSymbols = testArray.collect({ |item|
	(testName ++ item).asSymbol
});

Pdef((testName).asSymbol.postln,
	/*	Pbind(
	\stretch, 1,/*Pfunc {|ev|
	if(ev.branchLevel.isNil){
	1
	}{
	if(ev.branchLevel > 0){3}{1}
	}
	},*/
	\time, Ptime(),
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ( ev.stretch ? 1));},
	) <>*/
	Psym(Pseq(testSymbols)	)
);

testArray.collect{|num| ~lsys.presets[(testName ++ num).asSymbol].maxPatDur }.sum * baseTempo;

);