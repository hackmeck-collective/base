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
	branchInterval: 3,
);

// FILTERS

Pdef(\penrose_canon_1_filter,
	Pbind(
		\vol, Pfunc {|ev|
			if(ev.charNow == $F){ev.vol * 1.2}{ev.vol * 1}
		},
		\centerPos, Pfunc {|ev|
			switch (ev.branchLevel,
				0, 0,
				1, -0.33,
				2, 0.33,
				3, 0.66,
				4, 0.66,
				5, -1,
				6, 1,
				7, -1,
				8, 1,
				0);
		},
		\spread, 1,
	)
);

// ARGS
~newLsys.(
	name: \penrose_canon_1, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "-F+[f]G[-X+3-X3+X]5-f5+-f+", $f: "-F+[f]G[-X+3-X3+X]5-f5+-f+", $G: "-F+[f]G[-X+3-X3+X]5-f5+-f+"), // "[F]-F+-G+[-X+3-X3+X]5-F5+-F+"
	gen: 3, // 1
	opts: opts
)
)