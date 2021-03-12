




(
Pdef(\drums_dub_steppers,

	"drums_dub_steppers.scd".loadRelative;

	Ptsym(
		Pseq([[\hh1, \bd1, \bd2, \sd1], [\hh1, \hh2, \bd2, \sd1, \sd2]], inf),
		dur: Pseq([8], inf)
	);
).play(~linkClock, quant: 4);
);

Pdef(\drums_dub_steppers).stop;

(
Pdef(\drums_4ttf,

	"drums_4-4.scd".loadRelative;

	Ptsym(
		Pseq([[\bd1, \bd2, \sd1, \hh1]], inf),
		dur: Pseq([4], inf),
);
).play(~linkClock, quant: 4);
);

Pdef(\drums_4ttf).stop

(
Pdef(\drums_trap,

	"drums_trap.scd".loadRelative;

	Ptsym(
		Pseq([[\bd1, \sd1, \hh1]], inf),
		dur: Pseq([16], inf),
);
).play(~linkClock, quant: 4);
);

Pdef(\drums_trap).stop

(
Pdef(\percussion_loop_1,

	"percussion_loop_1.scd".loadRelative;

	Ptsym(
		Pseq([[\bongo_4, \bongo_8_ob],
			[\bongo_8, \bongo_8_ob],
			[\bongo_8, \bongo_16],
			[\bongo_8, \bongo_8_ob]],inf),
		dur: Pseq([4], inf)
	) <> Pbind(
		\bongo_4_dyn, Pseg([1,1,1],[4, 4]).repeat,
		\bongo_8_ob_dyn, Pseg([1,1,1],[8, 8]).repeat,
		\bongo_8_dyn, Pseg([0,1,1,1,0],[4, 4]).repeat,
		\bongo_16_dyn, Pseg([0,1,0],[2, 2]).repeat,
	);
).play(~linkClock, quant: 4);
);

Pdef(\percussion_loop_1).stop

