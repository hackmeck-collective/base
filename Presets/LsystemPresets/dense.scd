(
// OPTIONS
var opts = (
	instr: [\simpleBass, \simpleBass, \simplePluck],
	legatoArr: [1,1,0.1],
	quant: 0,
	vols: (1,0.9 .. 0.1) * 0.5,
	baseTempo: 1/8
);

// FILTERS

// ARGS
~newLsys.(
	name: \dense,
	axiom: "+F",
	rules: ($F: "-|+F[--F4|]++2F--6|"),
	gen: 5,
	opts: opts
)
)