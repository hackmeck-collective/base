(
// OPTIONS
var opts = (
	baseTempo: 1/8,
	noteOffset: 12,
	quant: 0,
	useGlobalPitch: false
);

// FILTERS

// ARGS
~newLsys.(
	name: 'lackSystem',
	axiom: "A7+KS-3K4+[B]KS",
	rules: ( $S: "-t-tG+tS", $B: "+B-K-GS" ),
	gen: 7.0,
	opts: opts
)
)