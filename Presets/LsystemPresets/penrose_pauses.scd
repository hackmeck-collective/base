(
// OPTIONS
var opts = (
	instr: \simpleSine,
	legatoArr: 1,
	useGlobalPitch: false,
	noteOffset: 7,
	quant: 0,
	vols: 0.8,
	baseTempo: 1/6,
	quant: 0,
	wrapLo: 48,
	wrapHi: 108,
	theta: 24 // 72
);

// FILTERS

// ARGS
~newLsys.(
	name: \penrose_pauses, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "[X]F-G-F2+F"), //5-F++F2-F
	gen: 1, // 1
	opts: opts
)
)