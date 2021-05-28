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
	name: 'simpleSwitch_gen4',
	axiom: "|G",
	rules: ( $F: "-Gf+" , $f: "[G]Gf", $G: "-F+G" ),
	gen: 4.0,
	opts: opts
)
)