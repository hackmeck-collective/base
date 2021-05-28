(
// OPTIONS
var opts = (
	useGlobalPitch: false,
	instr: \simpleSine,
	legatoArr: 0.1,
	noteOffset: 10,
	vols: 0.85,
	branchInterval: -10,
	quant: 0,
	baseTempo: 1/6
);

// FILTERS

// ARGS
~newLsys.(
	name: 'philNeu',
	axiom: "a+k+f+k+k+a-a-k-f-k-k-a",
	rules: ($a: "b", $b: "c", $c: "d", $d: "e", $e: "f", $f: "h[i]", $i: "j+l", $l: "mn", $n: "o+l"),
	gen: 20.0,
	opts: opts
)
)

//axiom: "a+k+f+k+k+a-a-k-f-k-k-a"
//rules: ($a: "b", $b: "c", $c: "d", $d: "e", $e: "f", $f: "h[i]", $i: "j+l", $l: "mn", $n: "o+l")