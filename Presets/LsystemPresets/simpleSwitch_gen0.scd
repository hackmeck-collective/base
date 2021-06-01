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
	name: 'simpleSwitch_gen0',
	axiom: "F",
	rules:  ($F: "F-G-F2+F"),
	gen: 0,
	opts: opts
)
)