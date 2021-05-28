(
// OPTIONS
var opts = (
	instr: \simpleSine,
	legatoArr: 1.5,
	branchInterval: 4,
	quant: 0,
	noteOffset: 0,
	useGlobalPitch: false,
	vols: 0.35,
	baseTempo: 1/4
);

// FILTERS

// ARGS
~newLsys.(
	name: \weed_gen4,
	axiom: "F",
	rules: ($F: "|[F]GG[-F+F]"),
	gen: 4,
	opts: opts
)
)