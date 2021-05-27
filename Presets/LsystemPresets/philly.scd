(
// OPTIONS
var opts = (
	instr: \simplePluck,
	useGlobalPitch: false,
	noteOffset: 0,
	vols: 0.6,
	branchInterval: 1,
	quant: 0,
	baseTempo: 1/6
);

// FILTERS

// ARGS
~newLsys.(
	name: 'philly',
	axiom: "-FGKK[+FGKK]-FGKK", //"-FGKK[+FGKK]-FGKK",
	rules: ( $F: "FGKK[+FGKK-]" ),
	gen: 3,
	opts: opts
)
)