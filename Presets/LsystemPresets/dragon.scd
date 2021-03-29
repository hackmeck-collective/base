(
// OPTIONS
var opts = (
	instr: \simplePluck,
	legatoArr: 1,
	quant: 0,
	vols: 0.75,
	baseTempo: 1/6
);

// FILTERS

// ARGS
~newLsys.(
	name: \dragon,
	axiom: "F",
	rules: ($F: "|[+F][+G--G4-F]", $G: "-G++G-"),
	gen: 3.0,
	opts: opts
)
)