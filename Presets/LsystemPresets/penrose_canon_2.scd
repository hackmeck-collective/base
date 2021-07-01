(
// OPTIONS
var opts = (
	instr: \digiDist_lead,
	legatoArr: 0.3,
	useGlobalPitch: false,
	noteOffset: 12,
	quant: 0,
	vols: 0.5,
	baseTempo: 1/6,
	quant: 0,
	theta: 12, // 72
	wrapLo: 36,
	wrapHi: 120,
	branchInterval: 3,
);

// FILTERS

Pdef(\penrose_canon_2_filter,
	Pbind(
		\vol, Pfunc {|ev|
			if(ev.charNow == $F){ev.vol * 1.2}{ev.vol * 1}
		},
	)
);

// ARGS
~newLsys.(
	name: \penrose_canon_2, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "-F+[-X+3-X3+X]G[f]5-f5+-f+", $f: "-F+[-X+3-X3+X]G[f]5-f5+-f+", $G: "-F+[-X+3-X3+X]G[f]5-f5+-f+"), // branches gedreht
	gen: 3, // 1
	opts: opts
)
)