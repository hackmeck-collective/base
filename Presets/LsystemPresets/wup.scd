(
// OPTIONS
var opts = (
	useGlobalPitch: false,
	noteOffset: 0,
	quant: 0,
	baseTempo: 1/6,
	instr: [\variedPlucks, \blip, \blip]
);

// FILTERS

// ARGS
~newLsys.(
	name: 'wup',
	axiom: "FX",
	rules: ( $F: "+F-[X-X---X]3GF2G", $X: "GFGY" ),
	gen: 1.0,
	opts: opts
)
)

/*	axiom: "FX",
	rules: ( $F: "F-[X-X---X]+3GF2G", $X: "GFGY" ),*/

/*	axiom: "XFX",
	rules: ( $F: "---F[X-GX---X]3G+++F3G", $X: "GFGGGY++Y" ),*/