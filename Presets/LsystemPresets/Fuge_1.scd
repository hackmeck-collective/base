(
// OPTIONS
var opts = (
	instr: \simpleSine,
	legatoArr: 1,
	vols: (1,0.9..0) * 0.35,
	baseTempo: 1/24,
	useGlobalPitch: false,
	noteOffset: 0
);

// FILTERS

// ARGS
~newLsys.(
	name: 'Fuge_1',
	axiom: "2G2a5+6a-a+a-a-a-a-a+2a2-2a+2a+2a+2a+2a2-a+a-2a
[4+2G2a5+6a-a+a-a-a-a-a+2a2-2a+2a+2a+2a+2a2-a+a-2a3-a+a+a+a+a+a+a+a3-4a-2a+2a2a3-2a2a2a3+2a-2a+2a3-2a3+2a-2a-2a3+4a2-2a3-2a+4a-a2+3a-2a
2G2a5+6a-a+a-a-a-a-a+2a2-2a+2a+2a+2a+2a2-a+a-2a2-a+a+a+a+a+a+a+a3-4a-2a+2a2a3-2a2a2a2+2a-2a+2a3-2a3+2a-2a-2a3+4a2-2a3-2a+4a-a2+3a-2a]
2-a+a+a+a+a+a+a+a3-4a-2a+2a2a3-2a2a2a+2a-2a2a2a
[8-2G2a5+6a-a+a-a-a-a-a+2a2-2a+2a+2a+2a+2a2-a+a-2a2-a+a+a+a+a+a+a+a3-4a-2a+2a2a3-2a2a2a2+2a-2a+2a3-2a3+2a-2a-2a3+4a2-2a3-2a+4a-a2+3a-2a
	4+2G2a5+6a-a+a-a-a-a-a+2a2-2a+2a+2a+2a+2a2-a+a-2a3-a+a+a+a+a+a+a+a3-4a-2a+2a2a3-2a2a2a3+2a-2a+2a3-2a3+2a-2a-2a3+4a2-2a3-2a+4a-a2+3a-2a]
2+2a-2a+2a3-2a3+2a-2a-2a3+4a2-2a3-2a+4a-a2+3a-2a
3-2G2a5+6a-a+a-a-a-a-a+2a2-2a+2a+2a+2a+2a2-a+a-2a3-a+a+a+a+a+a+a+a3-4a-2a+2a2a3-2a2a2a3+2a-2a+2a3-2a3+2a-2a-2a3+4a2-2a3-2a+4a-a2+3a-2a",
	rules: ( $a: "b+bG-", $b: "x-x+x-a+"),
	gen: 3.0,
	opts: opts
)
)