(
// OPTIONS
var opts = (
	noteOffset: 0,
	instr: [\metalPerc, \click],
	useGlobalPitch: false,
	baseTempo: 1/8,
	quant: 0

);

// FILTERS


// ARGS
~newLsys.(
	name: 'simpleSwitch_gen3',
	axiom: "F",
	rules:  ($F: "[f]F-G-F2+F"),
	gen: 3,
	opts: opts
)
)