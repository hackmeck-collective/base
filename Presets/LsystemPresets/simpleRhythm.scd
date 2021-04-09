(
// OPTIONS
var opts = (
	noteOffset: 24,
	quant: 0,
	baseTempo: 1/4,
	vol: 0.03
);

// FILTERS

// ARGS
~newLsys.(
	name: 'simpleRhythm',
	axiom: "F",
	rules: ( $F: "FG[-F-F-F]F", $G: "GGGF+G"),
	gen: 3.0,
	opts: opts
)
)