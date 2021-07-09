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

Pdef(\penrose_canon_pausen_1_filter,
	Pbind(\vol, Pfunc {|ev|
		if((ev.charNow == $F) || (ev.charNow == $X)){ev.vol * 1}{0}
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
		},
		\spread, 1,
	)
);

// ARGS
~newLsys.(
	name: \penrose_canon_pausen_1, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "-F+[F]G[-X+GX]m5-F5+", $m: "-F+[F]G[-X+GX]m5-F5+" /*$G: "GX"*/), // "-F+[-X+GX]G[F]5-F5+-F+" "-F+[-X+3-X3+X]G[F]5-F5+-F+"
	gen: 3, // 1
	opts: opts
)
)
