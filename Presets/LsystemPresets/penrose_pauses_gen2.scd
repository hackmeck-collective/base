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
	branchInterval: 5,
);

// FILTERS

// ARGS
~newLsys.(
	name: \penrose_pauses_gen2, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "[X]2-F2++G-3-F3++F-"), //"[X]2+F2--G+5+F5--F+" - branch, vorzeichen gedreht
	gen: 2, // 1
	opts: opts
)
)