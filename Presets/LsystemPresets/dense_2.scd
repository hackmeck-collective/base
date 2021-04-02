(
// OPTIONS
var opts = (
	instr: \simpleBass,
	quant: 4,
	legatoArr: 1,
	vols: (1,0.9 .. 0.1) * 0.5,
	baseTempo: 1/8
);

// FILTERS

// ARGS
~newLsys.(
	name: \dense_2,
	axiom: "+++F",
	rules: ($F: "F-F+[+F-F]||[--F-F]|[+F]|"),
	gen: 3,
	opts: opts
)
)