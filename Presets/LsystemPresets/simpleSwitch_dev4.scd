(
// OPTIONS
var opts = (
	noteOffset: 0,
	instr: \metalPerc,
	useGlobalPitch: false,
	baseTempo: 1/8,
	quant: 0,
	baseColor: 30,
	theta: 36,
	lineScale: 10

);

// FILTERS

Pdef(\simpleSwitch_dev4_filter,
	Pbind(
		\vol, Pfunc {|ev|
			if(ev.charNow == $F){ev.vol * 1.2}{ev.vol * 1}
		},
		\envelope_mod, Pfunc {|ev|
			if(ev.charNow == $F){0.5}{0.25}
		},
		\pitchOp_1_interval, Pfunc {|ev|
			if(ev.charNow == $F){12}{7}
		},
		\pitchOp_1_amount, Pfunc {|ev|
			if(ev.charNow == $F){0.1}{0.05}
		},
	)
);

// ARGS
~newLsys.(
	name: 'simpleSwitch_dev4',
	axiom: "F",
	rules:  ($F: "[X]F-G[X[x]]-f2+f[X]", $f: "[X]F-G[X[x]]-f2+f[X]"), //"F-G-F2+F", "[X]F-G-F2+F", "[X]F-G-F2+F[X]"
	gen: 4,
	opts: opts
)
)