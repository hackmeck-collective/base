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
	baseTempo: 1/12,
	quant: 0,
	theta: 12 // 72
);

// FILTERS

// ARGS
~newLsys.(
	name: \fuge_2_b, //besserer name waere arppeggios
	axiom: "[[]10+s7-q2-r+]qrs",//"4-F",
	rules: ($q: "2G2a5+a-a-a-a-a-", $r: "a+a+a+a+a+2a-", $s: "2a-2a+2a3-2-2a-2a3+2a", $a: "bG+bbG-"),
	gen: 2, // 1
	opts: opts
)
)

