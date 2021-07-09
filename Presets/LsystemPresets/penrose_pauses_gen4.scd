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
	branchInterval: 3,
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

Pdef(\penrose_pauses_gen4_filter,
	Pbind(
		\vol, Pfunc {|ev|
			if(ev.charNow == $F){ev.vol * 1.2}{ev.vol * 1}
		},
		\centerPos, Pfunc {|ev|
			switch (ev.branchLevel,
				0, 0,
				1, -0.25,
				2, 0.25,
				3, 0.5,
				4, 0.5,
				5, -0.75,
				6, 0.75,
				7, -1,
				8, 1,
				0);
		},
		\spread, 0.1,
	)
);

// ARGS
~newLsys.(
	name: \penrose_pauses_gen4, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "[f]-F+-G+[-X+3-X3+X]5-f5+-f+", $f: "[f]-F+-G+[-X+3-X3+X]5-f5+-f+", $G: "[f]-F+-G+[-X+3-X3+X]5-f5+-f+"), //"[F]2+F2--G+[X]+5+F5--F+"
	gen: 4, // 1
	opts: opts
);

~newLsys.(
	name: \penrose_pauses_gen4_bd, //besserer name waere arppeggios
	axiom: "F",//"4-F",
	rules: ($F: "-F+-G+5-F5+-F+", $G: "-F+-G+5-F5+-F+"),
	gen: 4, // 1
	opts: opts_bd
);

~newLsys.(
	name: \penrose_pauses_gen4_click, //besserer name waere arppeggios
	axiom: "F",//"4-F",
	rules: ($F: "-F+-G+5-F5+-F+", $G: "-F+-G+5-F5+-F+"),
	gen: 4, // 1
	opts: opts_click
);
)