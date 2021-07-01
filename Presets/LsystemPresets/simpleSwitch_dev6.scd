(
// OPTIONS
var opts = (
	noteOffset: 0,
	instr: \metalPerc,
	useGlobalPitch: false,
	baseTempo: 1/8,
	quant: 0,
	baseColor: 30,
	vols: [0,0,1,1,1,1,1,1,1],
	theta: 36,
	lineScale: 10

);

// FILTERS

Pdef(\simpleSwitch_dev6_filter,
	Pbind(
		\vol, Pfunc {|ev|
			if(ev.charNow == $X){ev.vol * 1.2}{ev.vol * 1}
		},
		\envelope_mod, Pfunc {|ev|
			if(ev.charNow == $X){0.25}{0.5}
		},
		\pitchOp_1_interval, Pfunc {|ev|
			if(ev.charNow == $X){12}{7}
		},
		\pitchOp_1_amount, Pfunc {|ev|
			if(ev.charNow == $X){0.1}{0.05}
		},
	)
);

// ARGS
~newLsys.(
	name: 'simpleSwitch_dev6',
	axiom: "F",
	rules:  ($F: "[X]F-G[X[x]]-f2+f[X]", $f: "[X]F-G[X[x]]-f2+f[X]"), //"F-G-F2+F", "[X]F-G-F2+F", "[X]F-G-F2+F[X]"
	gen: 5,
	opts: opts
)
)
