(
// OPTIONS
var opts = (
	instr: \simpleBass,
	legatoArr: 1,
	quant: 0,
	baseTempo: 1/6
);

// FILTERS

// ARGS
~newLsys.(
	name: \penrose, //besserer name waere arppeggios
	axiom: "4-F",
	rules: ($F: "F4-F4-F10-F++F4-F"),
	gen: 3.0,
	opts: opts
)
)