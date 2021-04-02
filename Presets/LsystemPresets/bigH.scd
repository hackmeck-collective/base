(
// OPTIONS
var opts = (
	instr: \simpleBass,
	vols: 0.4,
	legatoArr: 1,
	baseTempo: 1/8,
	quant: 0
);

// FILTERS

// ARGS
~newLsys.(
	name: \bigH,
	axiom: "[F]--F",
	rules: ($F: "|[+F][-F]"),
	gen: 3.0,
	opts: opts
)
)