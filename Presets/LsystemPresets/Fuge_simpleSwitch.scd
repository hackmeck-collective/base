(
// OPTIONS
var opts = (
	instr: \simpleSine,
	legatoArr: 0.2,
	useGlobalPitch: false,
	noteOffset: 0,
	branchInterval: 4,
	baseTempo: 1/6,
	vols: (1,0.8..0),
	quant: 0
);

// FILTERS

// ARGS
~newLsys.(
	name: 'fuge_simpleSwitch',
	axiom: "F-G-F2+F-G-F-G-F2+F2+F-G-F2+F",
	rules: ($F: "|[2G2a5+6a-a+a-a-a-a-a+2a2-2a+2a+2a+2a+2a2-a+a-2a]"), //+2a2-2a+2a+2a+2a+2a2-a+a-2a
	gen: 2.0,
	opts: opts
)
)