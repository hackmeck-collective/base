(
(0..3).do({ |i|
	// OPTIONS
	var opts = (
		noteOffset: 0,
		instr: \metalPerc,
		useGlobalPitch: false,
		baseTempo: 1/8,
		baseColor: 30,
		theta: 36,
		quant: 0
	);

	var opts_click = (
		noteOffset: 0,
		instr: \click,
		useGlobalPitch: false,
		baseTempo: 1/8,
		baseColor: 30,
		theta: 36,
		quant: 0
	);

	// FILTERS



	Pdef(("simpleSwitch_gen" ++ i ++ "_filter").asSymbol,
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


	Pdef(("simpleSwitch_click_gen" ++ i ++ "_filter").asSymbol,
		Pbind(
			\vol, Pfunc {|ev|
				if(ev.charNow == $F){ev.vol * 1}{0}
			},


		)
	);

	// ARGS
	~newLsys.(
		name: ("simpleSwitch_gen" ++ i).asSymbol,
		axiom: "F",
		rules:  ($F: "F-G-f2+f", $f: "f-G-F2+f"),
		gen: i,
		opts: opts
	);

	~newLsys.(
		name: ("simpleSwitch_click_gen" ++ i).asSymbol,
		axiom: "F",
		rules:  ($F: "F-G-f2+F", $f: "f-G-F2+f"),
		gen: i,
		opts: opts_click
	);
})
);