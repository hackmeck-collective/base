(
// OPTIONS
var opts = (
	instr: \simpleSine,
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
);

// FILTERS

// ARGS
~newLsys.(
	name: \penrose_toPause3, //besserer name waere arppeggios
	axiom: "F",//"4-F",
	rules: ($F: "1+F1--G+G3+F3-GF"), // f nach dem g entfernt
	gen: 1, // 1
	opts: opts
)
)