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
	name: \penrose_toPause3, //besserer name waere arppeggios
	axiom: "F",//"4-F",
	rules: ($F: "1+F1--G+G3+F3-GF", $G: "1+F1--G+G3+F3-GF"), // f nach dem g entfernt
	gen: 1, // 1
	opts: opts
);

	~newLsys.(
		name: \penrose_toPause3_bd, //besserer name waere arppeggios
		axiom: "F",//"4-F",
		rules: ($F: "1+F1--G+G3+F3-GF", $G: "1+F1--G+G3+F3-GF"),
		gen: 1, // 1
		opts: opts_bd
	);

	~newLsys.(
		name: \penrose_toPause3_click, //besserer name waere arppeggios
		axiom: "F",//"4-F",
		rules: ($F: "1+F1--G+G3+F3-GF", $G: "1+F1--G+G3+F3-GF"),
		gen: 1, // 1
		opts: opts_click
	);
)