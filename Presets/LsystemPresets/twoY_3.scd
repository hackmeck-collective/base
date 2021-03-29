(
// OPTIONS
var opts = (
	instr: [\simpleBass, \simplePluck],
	vols: 0.4,
	legatoArr: 1,
	baseTempo: 1/4,
	quant: 0
);

// FILTERS

// ARGS
~newLsys.(
	name: \twoY_3,
	axiom: "[F]4-F",
	rules: ($F: "|[+F][-F]"),
	gen: 3.0,
	opts: opts
)
)