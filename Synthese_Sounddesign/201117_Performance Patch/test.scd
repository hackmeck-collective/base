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
	\instrument, \modes_synth_1,
	\dur, Pseq([1/4, 1/8, 1/8], inf),
	\note, Pseq([0, 3, 7, 12], inf)
).play

Pbind(
	\instrument, \BD_808_1,
	\dur, Pseq([7/8, 1/8], inf),
	\note, Pseq([-24], inf)
).play

Pbind(

	/*var pattern_1 = [1/4],
	pattern_2 = [1/8, 1/8],
	pattern_3 = [1/16, 1/16, 1/16, 1/16],
	pattern_4 = [1/12, 1/12, 1/12],
	pattern_5 = [1/24, 1/24, 1/24, 1/24, 1/24, 1/24];*/

	\instrument, \Clicks_1,
	\dur, Pseq([1/4, 1/8, 1/8], inf),
	\note, Pseq([0, 3, 7, 12], inf)
).play

