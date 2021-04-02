(
// OPTIONS
var opts = (
	instr: \simpleBass,
	vols: 0.4,
	legatoArr: 1,
	baseTempo: 1/2
);

// FILTERS

// ARGS
~newLsys.(
	name: \chaosFugue,
	axiom: "F",
	rules: ( $F: "F---2F2G[++F4G---3F]++4F" ),
	gen: 3.0,
	opts: opts
)
)