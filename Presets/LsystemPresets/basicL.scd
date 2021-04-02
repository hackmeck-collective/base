(
// OPTIONS
var opts = (
	'baseTempo': 0.25,
	'branchInterval': 7,
	'instr': [ 'simplePluck', 'simplePluck', 'simplePluck' ],
	'legatoArr': [ 0.95, 0.95, 0.95 ],
	'maxPatDur': 13,
	'mute': [ 1, 1, 1 ],
	'noteOffset': 24,
	'numBranches': 3,
	'quant': 4,
	'rootPitchDrift': 0,
	'stepInterval': 1,
	'theta': 51.45,
	'useGlobalPitch': true,
	'vols': [ 1, 1, 1 ],
	'wrapHi': [ 96, 96, 96 ],
	'wrapLo': [ 36, 36, 36 ],
);

// FILTERS
Pdef( 'basicL_filter', Pbind.new );
Pdef( 'basicL_filter0', Pbind('oscillator_mod_2', Pseq([ 0, 0.3, 1 ], inf)) );
Pdef( 'basicL_filter1', Pbind.new );
Pdef( 'basicL_filter2', Pbind.new );

// ARGS
~newLsys.(
	name: 'basicL',
	axiom: "F",
	rules: ( $F: "F-[F]+4F" ),
	gen: 2.0,
	opts: opts
)
)