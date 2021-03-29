(
// OPTIONS
var opts = (
	'baseTempo': 0.16666666666667,
	'branchInterval': 7,
	'instr': [ 'simpleBass', 'simpleBass', 'simplePluck', 'simplePluck' ],
	'legatoArr': [ 1, 1, 1, 1, 1 ],
	'maxPatDur': 35,
	'mute': [ 1, 1, 1, 1, 1 ],
	'noteOffset': 48,
	'numBranches': 5,
	'quant': 0,
	'rootPitchDrift': 0,
	'stepInterval': 1,
	'theta': 51.45,
	'useGlobalPitch': true,
	'vols': [ 0.5, 0.5, 0.5, 0.5, 0.5 ],
	'wrapHi': [ 96, 96, 96, 96, 96 ],
	'wrapLo': [ 36, 36, 36, 36, 36 ],
);

// FILTERS
Pdef( 'maze_filter', Pbind.new );
Pdef( 'maze_filter0', Pbind.new );
Pdef( 'maze_filter1', Pbind.new );
Pdef( 'maze_filter2', Pbind.new );
Pdef( 'maze_filter3', Pbind.new );
Pdef( 'maze_filter4', Pbind.new );

// ARGS
~newLsys.(
	name: \maze,
	axiom: "F",
	rules: ($F: "|[GF][+G3-F][G+G+F]", $G: "GG7-"),
	gen: 4.0,
	opts: opts
)
)