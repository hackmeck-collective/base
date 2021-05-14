(
// OPTIONS
var opts = (
	useGlobalPitch: false,
	noteOffset: -12,
	quant: 0,
	baseTempo: 1/4,
	legatoArr: 0.175,
	vols: 0.9,
	wrapLo: [ 12 ],
	instr: \simpleLead
);

// FILTERS

// ARGS
~newLsys.(
	name: 'ersteZelle',
	axiom: "F",
	rules: ( $F: "F[F---F]GF"),//"FG+FF-"
	gen: 2,
	opts: opts
)
)

Pdef(\ersteZelle).play(~linkClock, quant: 0)

Pn(Psym(Pseq([\ersteZelle, \zweiteZelle], inf))).play(~linkClock, quant: 0)

Pn(Psym(Pseq([
	Pn(\zweiteZelle2, 4),
	Pn(\zweiteZelle3, 2),
	Pn(\zweiteZelle4, 1)
], inf).trace)).play(~linkClock, quant: 0)

Pseq([
	Psync(Pn(Pdef(\zweiteZelle2), 4), 4, 100),
	Psync(Pn(Pdef(\zweiteZelle3), 2), 4, 100),
	Psync(Pn(Pdef(\zweiteZelle4), 1), 4, 100),
]).play


(
// OPTIONS
var opts = (
	useGlobalPitch: false,
	noteOffset: 0,
	quant: 0,
	baseTempo: 1/4,
	legatoArr: 0.175,
	vols: 0.9,
	wrapLo: [ 12 ],
	instr: \simpleLead
);

// FILTERS

// ARGS
(2..5).do{|g|
	~newLsys.(
		name: 'zweiteZelle' ++ g,
		axiom: "F",
		rules: ( $F: "F[X---F]G-F"),//"FG+FF-"
		gen: g,
		opts: opts
	)
}
)