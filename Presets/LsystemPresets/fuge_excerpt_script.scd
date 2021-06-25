(0..5).do {|i|
	// OPTIONS
	var opts = (
		instr: \simpleSine,
		legatoArr: 1.5,
		useGlobalPitch: false,
		noteOffset: 0,
		branchInterval: 0,
		quant: 0,
		vols: 0.8,
		baseTempo: 1/32,
		quant: 0,
		theta: 60// 72
	);

	// FILTERS

	// ARGS
	~newLsys.(
		name: ("fuge_excerpt_gen" ++ i).asSymbol,
		axiom: "R", // "7+[9+q3-rs4+q3+r+s3+q3-rs4+q3+r+s][r+s3+q3-rs4+q3+r+s3+q3-rs4+q]3-s4+q4-r+s3+q3-r7+s4+q4-r+s3+q3-r",
		rules: ($R: "a-a-a-a-a-R", $r: "GGa5+aaaa-a+a-a-a-a-a-a", $a: "bG+b-", $b: "a-a+"),
		gen: i, // 1
		opts: opts
	)
}


