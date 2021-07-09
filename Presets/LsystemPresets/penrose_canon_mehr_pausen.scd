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

Pdef(\penrose_canon_mehr_pausen_filter,
	Pbind(
		\vol, Pfunc {|ev|
			if(ev.charNow == $F){ev.vol * 1.2}{ev.vol * 1}
		},
		\centerPos, Pfunc {|ev|
			switch (ev.branchLevel,
				0, 0,
				1, -0.4,
				2, 0.4,
				3, 0.8,
				4, 0.8,
				5, -1,
				6, 1,
				7, -1,
				8, 1,
				0);
		}.trace,
		\spread, 1,

	)
);

// ARGS
~newLsys.(
	name: \penrose_canon_mehr_pausen, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "F[G--G+X]-G-[X--X+X]G2+f", $f: "F[G--G+X]-G-[X--X+X]G2+f", $G: "GX"), //5-F++F2-F
	gen: 3, // 1
	opts: opts
)
)