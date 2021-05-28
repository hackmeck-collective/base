(
// OPTIONS
var opts = (
	noteOffset: 0,
	useGlobalPitch: false,
	instr: \simplePluck,
	baseTempo: 1/8,
	quant: 0,
	vols: 0.5
);

// FILTERS

// ARGS
~newLsys.(
	name: 'triangle',
	axiom: "F",
	rules: ( $F: "+F-G--f++GfG", $f: "+F-G--f++GfG", $G: "F" ),
	gen: 4.0,
	opts: opts
)
)