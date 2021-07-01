(
// OPTIONS
var opts = (
	instr: \digiDist_lead,
	legatoArr: 0.3,
	useGlobalPitch: false,
	noteOffset: 12,
	quant: 0,
	vols: 0.7,
	baseTempo: 1/6,
	quant: 0,
	theta: 12, // 72
	wrapLo: 36,
	wrapHi: 120,
	branchInterval: 5,
);

	var opts_bd = (
		instr: \bdBuzz,
		legatoArr: 0.3,
		useGlobalPitch: false,
		noteOffset: -60,
		quant: 0,
		vols: 0.5,
		baseTempo: 1/6,
		quant: 0,
		theta: 12, // 72
		wrapLo: 36,
		wrapHi: 48,
	);

	var opts_click = (
		instr: \click,
		legatoArr: 0.3,
		useGlobalPitch: false,
		noteOffset: -60,
		quant: 0,
		vols: 0.5,
		baseTempo: 1/6,
		quant: 0,
		theta: 12, // 72
		wrapLo: 36,
		wrapHi: 48,
	);
// FILTERS

Pdef(\penrose_pauses_gen2_filter,
	Pbind(
		\vol, Pfunc {|ev|
			if(ev.charNow == $F){ev.vol * 1.2}{ev.vol * 1}
		},
	)
);

// ARGS
~newLsys.(
	name: \penrose_pauses_gen2, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "[X]2-F2++G-3-f3++f-", $f: "[X]2-F2++G-3-f3++f-", $G: "[X]2-F2++G-3-f3++f-"), //"[X]2+F2--G+5+F5--F+" - branch, vorzeichen gedreht
	gen: 2, // 1
	opts: opts
);

~newLsys.(
	name: \penrose_pauses_gen2_bd, //besserer name waere arppeggios
	axiom: "F",//"4-F",
	rules: ($F: "2-F2++G-3-G3++F-", $G: "2-G2++G-3-F3++G-"),
	gen: 2, // 1
	opts: opts_bd
);

~newLsys.(
	name: \penrose_pauses_gen2_click, //besserer name waere arppeggios
	axiom: "F",//"4-F",
	rules: ($F: "2-G2++G-3-F3++G-", $G: "2-F2++F-3-G3++F-"),
	gen: 2, // 1
	opts: opts_click
);
)