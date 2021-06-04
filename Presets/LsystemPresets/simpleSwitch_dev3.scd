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
	name: 'simpleSwitch_dev3',
	axiom: "F",
	rules:  ($F: "[X]F-G-F2+F[X]"), //"F-G-F2+F", "[X]F-G-F2+F", "[X]F-G-F2+F[X]"
	gen: 3,
	opts: opts
)
)