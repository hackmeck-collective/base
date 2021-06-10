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
	name: \penrose_toPause, //besserer name waere arppeggios
	axiom: "F",//"4-F",
	rules: ($F: "2+F2--G+-F+2-F2+5+F5--F+"), // zweites f durch g ersetzt
	gen: 1, // 1
	opts: opts
)
)