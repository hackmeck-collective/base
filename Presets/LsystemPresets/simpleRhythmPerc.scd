(
// OPTIONS
var opts = (
	'baseTempo': 0.25,
	'branchInterval': 7,
	'instr': [ 'bdThump', 'sd3', 'hh1', 'bongo_1', 'bongo_1' ],
	'legatoArr': [ 0.95, 0.95, 0.95, 0.95 ],
	'maxPatDur': 75,
	'mute': [ 1, 1, 1, 1 ],
	'noteOffset': 24,
	'numBranches': 4,
	'quant': 0,
	'rootPitchDrift': 7,
	'stepInterval': 1,
	'theta': 51.45,
	'useGlobalPitch': true,
	'vols': [ 1, 1, 1, 1 ],
	'wrapHi': [ 72, 72, 72, 72 ],
	'wrapLo': [ 48, 48, 48, 48 ],
);

// FILTERS
Pdef( 'simpleRhythmPerc_filter', Pbind.new );
Pdef( 'simpleRhythmPerc_filter0', Pbind('note', Pseries(0, -1)) );
Pdef( 'simpleRhythmPerc_filter1', Pbind('note', Pseries(0, -1)) );
Pdef( 'simpleRhythmPerc_filter2', Pbind('note', Pseries(0, -1)) );
Pdef( 'simpleRhythmPerc_filter3', Pbind('note', Pseries(0, -1)) );

// ARGS
~newLsys.(
	name: 'simpleRhythmPerc',
	axiom: "F",
	rules: ( $F: "FG[-F-F-F]F", $G: "GGGF+G"),
	gen: 3.0,
	opts: opts
)
)