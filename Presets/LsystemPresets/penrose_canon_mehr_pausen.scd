(
// OPTIONS
var opts = (
	instr: \digiDist_lead,
	legatoArr: 0.2,
	useGlobalPitch: false,
	noteOffset: 7,
	quant: 0,
	vols: 0.8,
	baseTempo: 1/4,//1/6,
	quant: 0,
	wrapLo: 48,
	wrapHi: 108,
	theta: 60 // 72
);

// FILTERS

// ARGS
~newLsys.(
	name: \penrose_canon_mehr_pausen, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "F[G--G+X]-G-[X--X+X]G2+F", $G: "GX"), //5-F++F2-F
	gen: 3, // 1
	opts: opts
)
)