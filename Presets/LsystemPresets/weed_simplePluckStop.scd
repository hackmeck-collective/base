(
// OPTIONS
var opts = (
	instr: \simplePluckStop,
	legatoArr: 1,
	branchInterval: 2,
	quant: 0,
	noteOffset: 0,
	useGlobalPitch: false,
	vols: 0.45,
	baseTempo: 1/4
);

// FILTERS

// ARGS
~newLsys.(
	name: \weed_simplePluckStop,
	axiom: "F",
	rules: ($F: "|[F]GG[-F+F]"),
	gen: 3,
	opts: opts
)
)