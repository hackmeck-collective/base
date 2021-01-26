(
Pbind(
	\instrument, \sine_pluck,
	\dur, Pseq([2, 2], inf),
	\note, Pseq([[-1, 3, 7, 12], [0, 3, 7, 14]], inf),
	\group, ~source_group,
).play
)

(
Pbind(
	\instrument, \sine_pad,
	\dur, Pseq([2, 2], inf),
	\note, Pseq([[-1, 3, 7, 12], [0, 3, 7, 14]], inf),
	\group, ~source_group,
).play
)

(
Pbind(
	\instrument, \sine_lead,
	\dur, Pseq([2, 2], inf),
	\note, Pseq([[-1, 3, 7, 12], [0, 3, 7, 14]], inf),
	\group, ~source_group,
).play
)

(
Pbind(
	\instrument, \saw_pluck,
	\dur, Pseq([2, 2], inf),
	\note, Pseq([[-1, 3, 7, 12], [0, 3, 7, 14]], inf),
	\group, ~source_group,
).play
)

(
Pbind(
	\instrument, \saw_pad,
	\dur, Pseq([2, 2], inf),
	\note, Pseq([[-1, 3, 7, 12], [0, 3, 7, 14]], inf),
	\group, ~source_group,
).play
)

(
Pbind(
	\instrument, \saw_lead,
	\dur, Pseq([2, 2], inf),
	\note, Pseq([[-1, 3, 7, 12], [0, 3, 7, 14]], inf),
	\group, ~source_group,
).play
)

(
Pbind(
	\instrument, \rect_pluck,
	\dur, Pseq([2, 2], inf),
	\note, Pseq([[-1, 3, 7, 12], [0, 3, 7, 14]], inf),
	\group, ~source_group,
).play
)

(
Pbind(
	\instrument, \rect_pad,
	\dur, Pseq([2, 2], inf),
	\note, Pseq([[-1, 3, 7, 12], [0, 3, 7, 14]], inf),
	\group, ~source_group,
).play
)

(
Pbind(
	\instrument, \rect_lead,
	\dur, Pseq([2, 2], inf),
	\note, Pseq([[-1, 3, 7, 12], [0, 3, 7, 14]], inf),
	\group, ~source_group,
).play
)

(
Pbind(
	\instrument, \sine_OD_pluck,
	\dur, Pseq([2, 2], inf),
	\note, Pseq([[-1, 3, 7, 12], [0, 3, 7, 14]], inf),
	\group, ~source_group,
).play
)

(
Pbind(
	\instrument, \sine_OD_pad,
	\dur, Pseq([2, 2], inf),
	\note, Pseq([[-1, 3, 7, 12], [0, 3, 7, 14]], inf),
	\group, ~source_group,
).play
)

(
Pbind(
	\instrument, \sine_OD_lead,
	\dur, Pseq([2, 2], inf),
	\note, Pseq([[-1, 3, 7, 12], [0, 3, 7, 14]], inf),
	\group, ~source_group,
).play
)

(
Pbind(
	\instrument, \fm_vib_pluck,
	\dur, Pseq([2, 2], inf),
	\note, Pseq([[-1, 3, 7, 12], [0, 3, 7, 14]], inf),
	\group, ~source_group,
).play
)

(
Pbind(
	\instrument, \fm_vib_pad,
	\dur, Pseq([2, 2], inf),
	\note, Pseq([[-1, 3, 7, 12], [0, 3, 7, 14]], inf),
	\group, ~source_group,
).play
)

(
Pbind(
	\instrument, \fm_vib_lead,
	\dur, Pseq([2, 2], inf),
	\note, Pseq([[-1, 3, 7, 12], [0, 3, 7, 14]], inf),
	\group, ~source_group,
).play
)
/*Pbind(
	\instrument, \Spreadsynth_1,
	\dur, Pseq([1/8, 1/8, 1/4], inf),
	\note, Pseq([7, 12, 5, 0], inf),
	\group, ~source_group,
).play*/

Pbind(
	\instrument, \simple_modes_synth_1,
	\dur, Pseq([1/4, 1/8, 1/8], inf),
	\note, Pseq([0, 3, 7, 12], inf),
	\group, ~source_group,
).play

Pbind(
	\instrument, \modes_synth_1,
	\dur, Pseq([1/4, 1/8, 1/8], inf),
	\note, Pseq([0, 3, 7, 12], inf),
	\group, ~source_group,
).play

a=Pbind(
	\instrument, \sine_OD_1,
	\dur, Pseq([1, 1, 2], inf),
	\note, Pseq([0, 3, 7, 12], inf),
	\group, ~source_group,
).play


a=Pbind(
	\instrument, \wavetable_1,
	\dur, Pseq([1, 1, 2], inf),
	\note, Pseq([0, 3, 7, 12], inf),
	\group, ~source_group,
).play

a = Pbind(
	\instrument, \synchronus_grains_1,
	\dur, Pseq([1, 1, 2], inf),
	\note, Pseq([0, 3, 7, 12], inf),
	\group, ~source_group,
).play

a= Pbind(
	\instrument, \asynchronus_grains_1,
	\dur, Pseq([1, 1, 2], inf),
	\note, Pseq([0, 3, 7, 12], inf),
	\group, ~source_group,
).play

a= Pbind(
	\instrument, \granular_1,
	\dur, Pseq([1, 1, 2], inf),
	\note, Pseq([0, 3, 7, 12], inf),
	\group, ~source_group,
).play


a = Pbind(
	\instrument, \BD_808_1,
	\dur, Pseq([7/8, 1/8], inf),
	\note, Pseq([-24], inf),
	\group, ~source_group,
).play;

b = Pbind(
	\type, \set,
	\id, ~routingSynths.melodyBus,
	\dur, Pseq([7/8, 1/8], inf),
	\args, #[\beatDurNow, \sidechain_trigger_long],
	\beatDurNow, {TempoClock.default.beatDur},
	\sidechain_trigger_long, 1
).play;

b = Pbind(
	\type, \set,
	\id, ~routingSynths.chordsBus,
	\dur, Pseq([7/8, 1/8], inf),
	\args, #[\beatDurNow, \sidechain_trigger_long],
	\beatDurNow, {TempoClock.default.beatDur},
	\sidechain_trigger_long, 1
).play;

c = Pbind(
	\type, \set,
	\id, ~routingSynths.ef_reverb,
	\dur, Pseq([7/8, 1/8], inf),
	\args, #[\beatDurNow, \sidechain_trigger_verb],
	\beatDurNow, {TempoClock.default.beatDur},
	\sidechain_trigger_verb, 1
).play;


a.stop

Pbind(
	\instrument, \clicks_1,
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
	],inf),
	\note, Pseq([0, 3, 7, 12], inf),
	\group, ~source_group,
).play


(
var a, b;
a = Prand([1, Pseq([10, 20, 30]), 2, 3, 4, 5], 6);    // return 6 items
b = a.asStream;
7.do({ b.next.postln; });
)

