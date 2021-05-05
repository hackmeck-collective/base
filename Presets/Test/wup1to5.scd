(
var opts = (
	useGlobalPitch: false,
	noteOffset: -10,
	branchInterval: 4,
	quant: 1/2,
	baseTempo: 1/8,
	instr: [\blip, \blip, \blip, \blip, \blip] // erstes \variedPlucks geht auch
);
(1..5).do { |i|
	~newLsys.(
		name: (('wup' ++ i).asSymbol),
		axiom: "FX", //"XF",
		rules: ( $F: "+Y[X-GGX---X]2G-X2G", $X: "--F++Y" ),
		// rules: ( $F: "+F[X-X---X]3G-F2G", $X: "G--F++GY" ),
		gen: i,
		opts: opts
	)
}
)
// ~poppeStretch = Pbind(\stretch, Pseq([4/3, 2/3, Pn(1, 6)], inf));
// ~poppeStretch = Pbind(\stretch, Pseq([1/2, 1/2, 3/2, 3/2, Pn(1, 8)], inf));
// ~poppeStretch = Pbind(\stretch, Pseq([2/3,2/3,2/3, 1, 1, 4/3,4/3,4/3, 1, 1], inf));

// ~poppeStretch = Pbind(\stretch, Pseq([2/3, 4/3, 1/2, 1.5,1,1], inf));
// ~poppeStretch2 = Pbind(\stretch, Pseq([4/3, 2/3, 1.5,1/2,1,1], inf));
/*~poppeStretch = Pbind(\stretch, Pseq([8/5, 2/5], inf));
~poppeStretch2 = Pbind(\stretch, Pseq([2/5, 8/5], inf));*/

// ~poppeStretch = Pbind(\stretch, Pseq([3/2, 1/2,1,1, 4/3, 2/3, 1,1,8/5, 2/5, 1,1,12/7, 2/7,1,1], inf));
// ~poppeStretch = Pbind(\stretch, Prand([Pseq([4/3, 2/3]), Pn(1,2)], inf));
// ~poppeStretch = Pbind(\stretch, Pseq([Pseq([Pn(2/3, 6), Pn(2,2)], 3),Pseq([2/3, 4/3, 1/2, 1.5,1,1,1,1])], inf));
~stretchPat = Pseq([11/8, 7/8, 6/8]);

~stretchPat = Pseq([3,2].normalizeSum * 2);
~stretchPat = Pseq([1,3].normalizeSum * 2);

~stretchPat = Pseq([1,2,3].normalizeSum * 3);
~stretchPat = Pseq([4,1,1].normalizeSum * 3);
~stretchPat = Pseq([7,1,2].normalizeSum * 3);

~stretchPat = Pseq([1,1,2,4].normalizeSum * 4);

~stretchPat = Pseq([3,2,2,2].normalizeSum * 4);
~stretchPat = Pseq([1,3,3,1].normalizeSum * 4);

~stretchPat = Pseq([1,3,6,12].normalizeSum * 4);
~stretchPat = Pseq([1,2,1,4].normalizeSum * 4);


~stretchPat = Pseq([3/2, 1/2]);

~stretchPat = Pseq([8/9,10/9]);
Pdef(\play, Psym(Pseq([Pn(\wup2, 4), Pn(\wup3, 2),\wup4,\wup5, Pn(\wup2, 4)],inf).trace))
(2..5).do {|i|
	Pdef("wup%_filter".format(i).asSymbol, Pbind(\stretch, Pn(Plazy{~stretchPat})))
}
~linkClock.tempo = 0.8
Pdef(\play).clear
(
Pbind(\dur, 1, \note, 24, \legato, 0.2).play(~linkClock, quant:4 );
Pdef(\play).play(~linkClock, quant:4 );
)

(
var opts = (
	useGlobalPitch: false,
	noteOffset: -10,
	branchInterval: 4,
	quant: 1/2,
	baseTempo: 1/8,
	instr: [\blip, \blip, \blip, \blip, \blip] // erstes \variedPlucks geht auch
);
(1..5).do { |i|
	~newLsys.(
		name: (('puw' ++ i).asSymbol),
		axiom: "XF", //"XF",
		rules: ( $F: "+Y[X-GGX---X]2G-X2G", $X: "--F++Y" ),
		// rules: ( $F: "+F[X-X---X]3G-F2G", $X: "G--F++GY" ),
		gen: i,
		opts: opts
	)
}
)

Pdef(\play, Psym(Pseq([
	Pn(\wup1, 4),
	Pn(\puw1, 4),
	Pn(\wup1, 4),
	Pn(\puw1, 4),
	Pn(\wup2, 2),
	Pn(\puw2, 2),
	Pn(\wup3, 2),
	Pn(\puw3, 2),
	\wup4,
	\puw4,
	\wup5,
	\puw5,
],inf).trace))

(
Pbind(\dur, 1, \note, 24, \legato, 0.2).play(~linkClock, quant:4 );
Pdef(\play).play(~linkClock, quant:4 );
)


Pdef(\play,
	Ppar([
		Psym(Pseq([
			Pn(\puw1, 4),
			Pn(\wup1, 4),
			Pn(\wup2, 2),
			Pn(\puw2, 2),
			Pn(\wup3, 2),
			Pn(\puw3, 2),
			\wup4,
			\puw4,
			\wup5,
			\puw5,
		],inf).trace),
		Psym(Pseq([
			Pn(\wup1, 4),
			Pn(\puw1, 4),
			Pn(\puw2, 2),
			Pn(\wup2, 2),
			Pn(\wup3, 2),
			Pn(\puw3, 2),
			\wup4,
			\puw4,
			\wup5,
			\puw5,
		],inf).trace),
	])
)
