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
		baseTempo: 1/20,
		quant: 0,
		baseColor: 10,
		theta: 60// 72
	);

	// FILTERS

	// ARGS
	~newLsys.(
		name: ("fuge_excerpt2_gen" ++ i).asSymbol,
		axiom: "16+q", // "7+[9+q3-rs4+q3+r+s3+q3-rs4+q3+r+s][r+s3+q3-rs4+q3+r+s3+q3-rs4+q]3-s4+q4-r+s3+q3-r7+s4+q4-r+s3+q3-r",
		rules: ($q: "a+a-a+aaa+a2-a+a-a2-aaaq", $r: "GGa5+aaaa-a+a-a-a-a-a-r", $s: "a+a-a+aa+aa+aaa2-a-a-a-s", $a: "bG+b-", $b: "a-a+"),
		gen: i, // 1
		opts: opts
	)
}


