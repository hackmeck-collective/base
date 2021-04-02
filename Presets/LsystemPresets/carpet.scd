(
// OPTIONS
var opts = (
	instr: \simplePluck,
	legatoArr: 1,
	quant: 0,
	baseTempo: 1/2
);

// FILTERS

// ARGS
~newLsys.(
	name: \carpet,
	axiom: "-F",
	rules: ($F: "F+F[-F-F-F]-F"),
	gen: 3.0,
	opts: opts
)
)