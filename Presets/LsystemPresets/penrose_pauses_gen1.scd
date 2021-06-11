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

	var opts_bd = (
		instr: \bdBuzz,
		legatoArr: 0.3,
		useGlobalPitch: false,
		noteOffset: -60,
		quant: 0,
		vols: 0.5,
		baseTempo: 1/6,
		quant: 0,
		theta: 12, // 72
		wrapLo: 36,
		wrapHi: 48,
	);

	var opts_click = (
		instr: \click,
		legatoArr: 0.3,
		useGlobalPitch: false,
		noteOffset: -60,
		quant: 0,
		vols: 0.5,
		baseTempo: 1/6,
		quant: 0,
		theta: 12, // 72
		wrapLo: 36,
		wrapHi: 48,
	);

// FILTERS

// ARGS
~newLsys.(
	name: \penrose_pauses_gen1, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "[X]2+F2--G+4+F4--F+", $G: "[X]2+F2--G+4+F4--F+"), // "2+F2--G+5+F5--F+" + branch
	gen: 1, // 1
	opts: opts
);

~newLsys.(
	name: \penrose_pauses_gen1_bd, //besserer name waere arppeggios
	axiom: "F",//"4-F",
	rules: ($F: "2+F2--G+4+G4--G+", $G: "2+G2--G+4+F4--G+"),
	gen: 1, // 1
	opts: opts_bd
);

~newLsys.(
	name: \penrose_pauses_gen1_click, //besserer name waere arppeggios
	axiom: "F",//"4-F",
	rules: ($F: "2+G2--G+4+G4--F+", $G: "2+G2--F+4+G4--F+"),
	gen: 1, // 1
	opts: opts_click
);
)