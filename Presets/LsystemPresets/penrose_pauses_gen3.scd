(
// OPTIONS
var opts = (
	instr: \digiDist_lead,
	legatoArr: 0.3,
	useGlobalPitch: false,
	noteOffset: 12,
	quant: 0,
	vols: 0.5,
	baseTempo: 1/6,
	quant: 0,
	theta: 12, // 72
	wrapLo: 36,
	wrapHi: 120,
	branchInterval: 4,
);


// FILTERS

// ARGS
~newLsys.(
	name: \penrose_pauses_gen3, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "[G3-X3+X]2+F2-G+[X]5-F5+-F+"), //"[X]2+F2--G+5+F5--F+"
	gen: 3, // 1
	opts: opts
)
)