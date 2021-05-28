(
// OPTIONS
var opts = (
	instr: \simpleSine,
	legatoArr: 1,
	useGlobalPitch: false,
	noteOffset: 40,
	quant: 0,
	vols: 0.8,
	baseTempo: 1/6,
	quant: 0,
	theta: 36 // 72
);

// FILTERS

// ARGS
~newLsys.(
	name: \penrose_pauses_gen2, //besserer name waere arppeggios
	axiom: "4-F",
	rules: ($F: "F2-G2-F5+F"), //5-F++F2-F
	gen: 2, // 1
	opts: opts
)
)