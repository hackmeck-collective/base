(
(0..4).do({ |i|

	// OPTIONS
	var opts = (
		instr: \digiDist_lead,
		legatoArr: 0.3,
		useGlobalPitch: false,
		noteOffset: 0,
		quant: 0,
		vols: 0.7,
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
		name: ("penrose_simple_gen" ++ i).asSymbol, //besserer name waere arppeggios
		axiom: "F",//"4-F",
		rules: ($F: "F5+F5--F+" ), //"[X]F-G-F2+F" "F-G-F2+F"
		gen: i, // 1
		opts: opts
	);

	~newLsys.(
		name: ("penrose_simple_bd_gen" ++ i).asSymbol, //besserer name waere arppeggios
		axiom: "F",//"4-F",
		rules: ($F: "F5+G5--G+", $G: "G5+F5--G+"),
		gen: i, // 1
		opts: opts_bd
	);

	~newLsys.(
		name: ("penrose_simple_click_gen" ++ i).asSymbol, //besserer name waere arppeggios
		axiom: "F",//"4-F",
		rules: ($F: "G5+G5--F+", $G: "F5+G5--F+"),
		gen: i, // 1
		opts: opts_click
	);
});
)