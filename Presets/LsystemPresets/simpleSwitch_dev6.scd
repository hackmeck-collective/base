(
// OPTIONS
var opts = (
	noteOffset: 0,
	instr: \metalPerc,
	useGlobalPitch: false,
	baseTempo: 1/8,
	quant: 0,
	baseColor: 30,
	vols: [0,0,1,1,1,1,1,1,1],
	lineScale: 10

);

// FILTERS

// ARGS
~newLsys.(
	name: 'simpleSwitch_dev6',
	axiom: "F",
	rules:  ($F: "[X]F-G[X[x]]-F2+F[X]"), //"F-G-F2+F", "[X]F-G-F2+F", "[X]F-G-F2+F[X]"
	gen: 5,
	opts: opts
)
)