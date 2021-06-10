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
);

// FILTERS

// ARGS
~newLsys.(
	name: \penrose_pauses_gen1, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "[X]2+F2--G+4+F4--F+"), // "2+F2--G+5+F5--F+" + branch
	gen: 1, // 1
	opts: opts
)
)