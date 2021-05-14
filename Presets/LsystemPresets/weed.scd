(
// OPTIONS
var opts = (
	instr: \simplePluck,
	legatoArr: 1,
	branchInterval: 2,
	quant: 0,
	noteOffset: 14,
	useGlobalPitch: false,
	vols: [0.8, 0.6] ++ (0.4!100),
	baseTempo: 1/2
);

// FILTERS

// ARGS
~newLsys.(
	name: \weed,
	axiom: "F",
	rules: ($F: "[F]GG[-F+F]"),
	gen: 4.0,
	opts: opts
)
)