(
// OPTIONS
var opts = (
	useGlobalPitch: false,
	noteOffset: 0
);

// FILTERS

// ARGS
~newLsys.(
	name: 'expo2',
	axiom: "F",
	rules: ( $F: "2+FG+K-K[2+FG+K-K]"),
	gen: 3.0,
	opts: opts
)
)