(
// OPTIONS
var opts = (
	instr: \simpleSine,
	legatoArr: 0.2,
	useGlobalPitch: false,
	noteOffset: 7,
	quant: 0,
	vols: 0.8,
	baseTempo: 1/3,//1/6,
	quant: 0,
	wrapLo: 48,
	wrapHi: 108,
	theta: 60 // 72
);

// FILTERS

// ARGS
~newLsys.(
	name: \penrose_canon_mehr_pausen2, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "-F+[X]G[-X+]G5-F5+", $G: "GX"), //5-F++F2-F
	gen: 3, // 1
	opts: opts
)
)