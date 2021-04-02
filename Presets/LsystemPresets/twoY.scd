(
// OPTIONS
var opts = (
	instr: [\simpleBass, \simplePluck],
	vols: 0.4,
	legatoArr: 0.1,
	baseTempo: 1/4,
	quant: 0
);

// FILTERS

// ARGS
~newLsys.(
	name: \twoY,
	axiom: "[F]-F",
	rules: ($F: "-|[|+F-|]++|[|+F-|]-|"),
	gen: 2.0,
	opts: opts
)
)