(
// OPTIONS
var opts = (
	instr: [\simpleBass, \simplePluck, \simplePluck],
	legatoArr: 0.1,
	vols: 0.4
);

// FILTERS

// ARGS
~newLsys.(
	name: \weed,
	axiom: "F",
	rules: ($F: "|[-F]|[+F][-F]F"),
	gen: 3.0,
	opts: opts
)
)