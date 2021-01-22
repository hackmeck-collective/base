(a = Pbind(
	\instrument, \BD_808_1,
	\dur, Pseq([ 4], inf),
	\note, Pseq([-24], inf),
	\group, ~source_group,
).play(~linkClock, quant: 1);)

(Pbindef(\glocke,
	\instrument, \simple_modes_synth_1,
	\dur, Pseq([1/4], inf),
	//\note, Pseq([0], inf),
	\group, ~source_group,
).play(~linkClock, quant: 1);)

Pbindef(\glocke, \degree, Pseq([0,2b,4],inf))
Pbindef(\glocke, \degree, Pseq([2b,4,6b],inf))
Pbindef(\glocke).stop

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
).play(~linkClock, quant: 1);


(
b = Pbind(
	\type, \set,
	\id, ~routingSynths.melodyBus,
	\dur, Pseq([1/2], inf),
	\args, #[\beatDurNow, \sidechain_trigger_long],
	\beatDurNow, {TempoClock.default.beatDur},
	\sidechain_trigger_long, 1
).play(~linkClock, quant: 1);)
c = Pbind(
	\type, \set,
	\id, ~routingSynths.ef_reverb,
	\dur, Pseq([1], inf),
	\args, #[\beatDurNow, \sidechain_trigger_verb],
	\beatDurNow, {TempoClock.default.beatDur},
	\sidechain_trigger_verb, 1
).play(~linkClock, quant: 1);
(
b = Pbind(
	\type, \set,
	\id, ~routingSynths.chordsBus,
	\dur, Pseq([1/2], inf),
	\args, #[\beatDurNow, \sidechain_trigger_long],
	\beatDurNow, {TempoClock.default.beatDur},
	\sidechain_trigger_long, 1
).play(~linkClock, quant: 1);)
s.record
c = Pbind(
	\type, \set,
	\id, ~routingSynths.ef_reverb,
	\dur, Pseq([1/2], inf),
	\args, #[\beatDurNow, \sidechain_trigger_verb],
	\beatDurNow, {TempoClock.default.beatDur},
	\sidechain_trigger_verb, 1
).play(~linkClock, quant: 1);