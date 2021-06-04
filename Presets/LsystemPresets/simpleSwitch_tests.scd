(
// OPTIONS
var opts = (
	noteOffset: 0,
	instr: \metalPerc,
	useGlobalPitch: false,
	baseTempo: 1/8,
	quant: 0,
	baseColor: 30,
	lineScale: 10

);

// FILTERS

// ARGS
~newLsys.(
	name: 'simpleSwitch_tests',
	axiom: "F",
	rules:  ($F: "F-G-F2+F"),
	gen: 2,
	opts: opts
)
)