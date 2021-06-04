(
// OPTIONS
var opts = (
	instr: \simpleSine,
	vols: 0.7,
	legatoArr: 1,
	baseTempo: 1/6
);

// FILTERS

// ARGS
~newLsys.(
	name: \chaosFugue,
	axiom: "F",
	rules: ( $F: "F---2f2X[++F4X---3f]++4f", $f: "F---2f2X[++F4X---3f]++4f" ),
	gen: 4.0,
	opts: opts
)
)