(
// OPTIONS
var opts = (
	instr: \digiDist_lead,
	legatoArr: 0.3,
	useGlobalPitch: false,
	noteOffset: 12,
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

Pdef(\penrose_toPause2_filter,
	Pbind(
		\vol, Pfunc {|ev|
			if(ev.charNow == $F){ev.vol * 1.2}{ev.vol * 1}
		},
	)
);

// ARGS
~newLsys.(
	name: \penrose_toPause2, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "+F--G+-F+G4+f4-f", $f: "+F--G+-F+G4+f4-f", $G: "+F--G+-F+G4+f4-f", ), // f nach dem g entfernt
	gen: 1, // 1
	opts: opts
);

	~newLsys.(
		name: \penrose_toPause2_bd, //besserer name waere arppeggios
		axiom: "F",//"4-F",
		rules: ($F: "+F--G+-G+G4+G4-G", $G: "+F--G+-G+G4+G4-G"),
		gen: 1, // 1
		opts: opts_bd
	);

	~newLsys.(
		name: \penrose_toPause2_click, //besserer name waere arppeggios
		axiom: "F",//"4-F",
		rules: ($F: "+G--G+-G+F4+G4-G", $G: "+G--G+-G+F4+G4-G"),
		gen: 1, // 1
		opts: opts_click
	);
)