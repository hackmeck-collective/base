(
// OPTIONS
var opts = (
	noteOffset: 0,
	instr: \metalPerc,
	useGlobalPitch: false,
	baseTempo: 1/8,
	quant: 0

);

// FILTERS

// ARGS
~newLsys.(
	name: 'simpleSwitch',
	axiom: "|G",
	rules: ( $F: "-Gf+" , $f: "Gf", $G: "-F+G" ),
	gen: 3.0,
	opts: opts
)
)