(
// OPTIONS
var opts = (
	instr: \simplePluck,
	useGlobalPitch: false,
	noteOffset: 0,
	vols: 0.6,
	branchInterval: [2],
	quant: 0,
	baseTempo: 1/6
);

// FILTERS

// ARGS
~newLsys.(
	name: 'philly2',
	axiom: "KGKK[+FGKK]-FGKK",
	rules: ( $F: "KGKK[+FGKK]-FGKK" ),
	gen: 3,
	opts: opts
)
)