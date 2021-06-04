(
// OPTIONS
var opts = (
	instr: \simpleSine,
	legatoArr: 1.5,
	branchInterval: 2,
	quant: 0,
	noteOffset: 0,
	useGlobalPitch: false,
	vols: 0.45,
	baseTempo: 1/4,
	baseColor: 0
);

// FILTERS

// ARGS
~newLsys.(
	name: \weed,
	axiom: "F",
	rules: ($F: "|[F]GG[-F+F]"),
	gen: 3,
	opts: opts
)
)