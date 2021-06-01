(
// OPTIONS
var opts = (
	noteOffset: 0,
	instr: \metalPerc,
	useGlobalPitch: false,
	baseTempo: 1/6,
	quant: 0

);

// FILTERS

// ARGS
~newLsys.(
	name: 'simpleSwitch_gen2',
	axiom: "F",
	rules:  ($F: "F-G-F2+F"),
	gen: 2,
	opts: opts
)
)