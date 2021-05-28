(
// OPTIONS
var opts = (
	instr: \simpleSine,
	legatoArr: 1,
	useGlobalPitch: false,
	noteOffset: 40,
	quant: 0,
	vols: 0.8,
	baseTempo: 1/6,
	quant: 0,
	theta: 12 // 72
);

// FILTERS

// ARGS
~newLsys.(
	name: \penrose_toPause2, //besserer name waere arppeggios
	axiom: "F",//"4-F",
	rules: ($F: "F2-G2-F5-F++F"), //"[X]F-G-F2+F"
	gen: 1, // 1
	opts: opts
)
)