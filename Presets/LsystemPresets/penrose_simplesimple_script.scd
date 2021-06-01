(
(0..4).do({ |i|

	// OPTIONS
	var opts = (
		instr: \simpleSine,
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

	// FILTERS

	// ARGS
	~newLsys.(
		name: ("penrose_simplesimple_gen" ++ i).asSymbol, //besserer name waere arppeggios
		axiom: "F",//"4-F",
		rules: ($F: "F5+F5-" ), //"[X]F-G-F2+F" "F-G-F2+F"
		gen: i, // 1
		opts: opts
	)
});
)