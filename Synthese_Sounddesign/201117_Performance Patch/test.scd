Pbind(
	\instrument, \fm_1,
	\dur, Pseq([2, 2], inf),
	\note, Pseq([[-1, 3, 7, 12], [0, 3, 7, 14]], inf)
).play

Pbind(
	\instrument, \Spreadsynth_1,
	\dur, Pseq([1/8, 1/8, 1/4], inf),
	\note, Pseq([7, 12, 5, 0], inf)
).play

Pbind(
	\instrument, \simple_modes_synth_1,
	\dur, Pseq([1/4, 1/8, 1/8], inf),
	\note, Pseq([0, 3, 7, 12], inf)
).play

a = Pbind(
	\instrument, \BD_808_1,
	\dur, Pseq([7/8, 1/8], inf),
	\note, Pseq([-24], inf),
	\group, ~source_group,
).play

a.stop

Pbind(
	\dur, Pseq([
		Pwrand(
			[Pseq([1/2]), Pseq([1/4], 2)],
			[0.75,0.25]
		),
		1/2,
		Pwrand(
			[Pseq([1/16], 8), Pseq([1/2])]
			,[0.75,0.25]
		),
		1/2
	],inf).trace,
	\note, Pseq([0, 3, 7, 12], inf)
).play


(
var a, b;
a = Prand([1, Pseq([10, 20, 30]), 2, 3, 4, 5], 6);    // return 6 items
b = a.asStream;
7.do({ b.next.postln; });
)

