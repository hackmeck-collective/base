(
// OPTIONS
var opts = (
	instr: \digiDist_lead,
	legatoArr: 0.2,
	useGlobalPitch: false,
	noteOffset: 7,
	quant: 0,
	vols: 0.8,
	baseTempo: 1/6,
	quant: 0,
	wrapLo: 48,
	wrapHi: 108,
	theta: 60 // 72
);

// FILTERS

Pdef(\penrose_canon_filter,
	Pbind(
		\vol, Pfunc {|ev|
			if(ev.charNow == $F){ev.vol * 1.2}{ev.vol * 1}
		},
	)
);

// ARGS
~newLsys.(
	name: \penrose_canon, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "F[X--X+X]-G-[f]f2f",$f: "F[X--X+X]-G-[f]f2f",$G: "F[X--X+X]-G-[f]f2f"), //5-F++F2-F
	gen: 3, // 1
	opts: opts
)
)