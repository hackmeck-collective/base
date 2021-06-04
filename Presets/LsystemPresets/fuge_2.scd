(
// OPTIONS
var opts = (
	instr: \simpleSine,
	legatoArr: 1,
	useGlobalPitch: false,
	noteOffset: 0,
	branchInterval: 0,
	quant: 0,
	vols: 0.8,
	baseTempo: 1/6,
	quant: 0,
	theta: 12 // 72
);

// FILTERS

// ARGS
~newLsys.(
	name: \fuge_2, //besserer name waere arppeggios
	axiom: "[[G]G]rs",//"4-F",
	rules: ($q: "2G2a5+6a-a+a-a-a-a-a-", $r: "a+a+a+a+a+a+a+a3-4a-2a+2a-", $s: "2a-2a+2a3-2a3+2a-2a-2a3+2a"),
	gen: 1, // 1
	opts: opts
)
)

