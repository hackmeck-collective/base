(
// OPTIONS
var opts = (
	instr: \simpleSine,
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
	branchInterval: 3,
);

// FILTERS

// ARGS
~newLsys.(
	name: \penrose_pauses_gen4, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "[F]-F+-G+[-X+3-X3+X]5-F5+-F+"), //"[F]2+F2--G+[X]+5+F5--F+"
	gen: 4, // 1
	opts: opts
)
)