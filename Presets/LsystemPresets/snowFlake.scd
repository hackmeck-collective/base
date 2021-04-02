(
// OPTIONS
var opts = (
	instr: \simpleBass
);

// FILTERS

// ARGS
~newLsys.(
	name: 'snowFlake',
	axiom: "F",
	rules: ($F: "F-F++F-F"),
	gen: 3.0,
	opts: opts
)
)