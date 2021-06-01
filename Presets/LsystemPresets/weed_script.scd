(
(0..4).do({ |i|

	// OPTIONS
	var opts = (
		instr: \simpleSine,
		legatoArr: 1.5,
		branchInterval: 2,
		quant: 0,
		noteOffset: 0,
		useGlobalPitch: false,
		vols: 0.45,
		baseTempo: 1/4
	);

	// FILTERS

	// ARGS
	~newLsys.(
		name: ("weed_gen" ++ i).asSymbol,
		axiom: "F",
		rules: ($F: "|[F]GG[-F+F]"),
		gen: i,
		opts: opts
	)
})
);