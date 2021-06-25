(0..3).do {|i|
	// OPTIONS
	var opts = (
		instr: \simpleSine,
		legatoArr: 1.5,
		useGlobalPitch: false,
		noteOffset: 0,
		branchInterval: 0,
		quant: 0,
		vols: 0.8,
		baseTempo: 1/5,
		quant: 0,
		theta: 60// 72
	);

	// FILTERS

	// ARGS
	~newLsys.(
		name: ("fuge_3_shortBranches_gen" ++ i).asSymbol,
		axiom: "7+[9+q3-rs4+q3+r+s][r+s3+q3-rs4+q]3-s4+q4-r+s3+q3-r",
		rules: ($q: "a+a-a+aaa+a", $r: "5+a-a-a-a-a-a", $s: "+aaa2-a-a-a-a", $a: "bG+b-", $b: "a-a+"),
		gen: i, // 1
		opts: opts
	)
}


