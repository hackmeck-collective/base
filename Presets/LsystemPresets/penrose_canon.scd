(
// OPTIONS
var opts = (
	instr: \simpleSine,
	legatoArr: 0.2,
	useGlobalPitch: false,
	noteOffset: 7,
	quant: 0,
	vols: 0.8,
	baseTempo: 1/6,
	quant: 0,
	wrapLo: 48,
	wrapHi: 108,
	theta: 60 // 72
);

// FILTERS

// ARGS
~newLsys.(
	name: \penrose_canon, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "F[X--X+X]-G-[F]F2+F"), //5-F++F2-F
	gen: 3, // 1
	opts: opts
)
)