(
(0..4).do({ |i|
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

	Pdef(("penrose_gen" ++ i ++ "_filter").asSymbol,
	Pbind(
		\vol, Pfunc {|ev|
			if(ev.charNow == $F){ev.vol * 1.2}{ev.vol * 1}
		},
	)
);

	// ARGS
	~newLsys.(
		name: ("penrose_gen" ++ i).asSymbol, //besserer name waere arppeggios
		axiom: "F",//"4-F",
		rules: ($F: "2+F2--f+-F+2-f2+5+f5--f+", $f: "2+F2--f+-F+2-f2+5+f5--f+"), //"[X]F-G-F2+F"
		gen: i, // 1
		opts: opts
	);

	~newLsys.(
		name: ("penrose_bd_gen" ++ i).asSymbol, //besserer name waere arppeggios
		axiom: "F",//"4-F",
		rules: ($F: "2+F2--G+-G+2-G2+5+G5--G+", $G: "2+G2--G+-G+2-G2+5+F5--G+"),
		gen: i, // 1
		opts: opts_bd
	);

	~newLsys.(
		name: ("penrose_click_gen" ++ i).asSymbol, //besserer name waere arppeggios
		axiom: "F",//"4-F",
		rules: ($F: "2+F2--G+-G+2-G2+5+F5--G+", $G: "2+G2--G+-F+2-G2+5+F5--G+"),
		gen: i, // 1
		opts: opts_click
	);
})
);