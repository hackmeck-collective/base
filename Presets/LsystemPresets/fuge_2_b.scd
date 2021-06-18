(0..3).do {|i|
	// OPTIONS
	var opts = (
		instr: \digiDist_lead,
		legatoArr: 1,
		useGlobalPitch: false,
		noteOffset: 0,
		branchInterval: 0,
		quant: 0,
		vols: 0.8,
		baseTempo: 1/3,
		quant: 0,
		theta: 45 // 72
	);

	// FILTERS

	// ARGS
	~newLsys.(
		name: ("fuge_2_b_gen" ++ i).asSymbol,
		axiom: "7+[10+s7-qrs-q+r][q+r-s7-qrs]2-rs8-q+r-sq",
		rules: ($q: "2G2a5+6a-a+a-a-a-a-a", $r: "a-a+a+a+a+a+a+a3-4a-2a+2a", $s: "2a-2a+2a3-2a3+2a-2a-2a3+2a", $a: "bGG2+bG2-", $b: "a-aG+"),
		gen: i, // 1
		opts: opts
	)
};
