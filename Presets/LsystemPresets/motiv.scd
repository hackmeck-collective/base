(
// OPTIONS
var opts = (
		instr: \detuneLead,
		legatoArr: 1,
		quant: 1
);

// FILTERS

// ARGS
~newLsys.(
	name: 'motiv',
	axiom: "F",
	rules: ( $F: "FG-[2F--2F+F]G--4|+2|" ),
	gen: 2.0,
	opts: opts
)
)