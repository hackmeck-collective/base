
(
Pbindef(\testi,
	\adsrType, \pluck,
	\pitchOp, Pseq([\slide, \fm, \unisonoDetune], inf),
	\osc, Pseq([\pulsar, \fm], inf),
	\fx, \overdrive,
	\instrument, Pfunc {|ev| "%_%_%_%".format(ev.adsrType, ev.pitchOp, ev.osc, ev.fx).asSymbol },
	\dur, Pseq([1/8], inf),
	\note, Pseq([0], inf),
	\out, ~melody_bus,
	\controlbus, ~row3_controlbus,
	\pitchOp_mod_1_macro_channel, 1,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 2,
	\oscillator_mod_2_macro_channel, 2,
	\fx_mod_1_macro_channel, 2,
	\pitchOp_mod_1, 0,
	\pitchOp_mod_2, 0.2,
	\envelope_mod_macro_channel, 3,
	\group, ~source_group,
).play(quant: 2)
)


(
Pbind(
	\instrument, \pad_unisonoDetune_pulsar_overdrive,
	\dur, Pseq([2], inf),
	\note, Pseq([[-1,3,7,10,12]], inf),
	\out, ~chords_bus,
	\controlbus, ~row4_controlbus,
	\pitchOp_mod_1_macro_channel, 1,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 2,
	\oscillator_mod_2_macro_channel, 2,
	\fx_mod_1_macro_channel, 2,
	\pitchOp_mod_1, 0,
	\pitchOp_mod_2, 0.2,
	\envelope_mod_macro_channel, 3,
	\group, ~source_group,
).play(quant: 2)
)

(
Pbind(
	\instrument, \sineSweep_overdrive,
	\dur, Pseq([1], inf),
	\note, Pseq([-24], inf),
	\out, ~drums_bus,
	\controlbus, ~row1_controlbus,
	\fx_mod_1_macro_channel, 2,
	\osc1_time_macro_channel, 3,
	\group, ~source_group,
).play(quant: 2)
)

(
Pbind(
	\instrument, \whiteNoise_overdrive,
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
	\note, Pseq([-5,], inf),
	\out, ~drums_bus,
	\controlbus, ~row2_controlbus,
	\fx_mod_1_macro_channel, 2,
	\osc1_time_macro_channel, 3,
	\group, ~source_group,
).play(quant: 2)
)


b = Pbind(
	\type, \set,
	\id, ~routingSynths.melodyBus,
	\dur, Pseq([7/8, 1/8], inf),
	\args, #[\beatDurNow, \sidechain_trigger_long],
	\beatDurNow, {TempoClock.default.beatDur},
	\sidechain_trigger_long, 1
).play;

(
b = Pbind(
	\type, \set,
	\id, ~routingSynths.chordsBus,
	\dur, Pseq([7/8, 1/8], inf),
	\args, #[\beatDurNow, \sidechain_trigger_long],
	\beatDurNow, {TempoClock.default.beatDur},
	\sidechain_trigger_long, 1
).play;
)

c = Pbind(
	\type, \set,
	\id, ~routingSynths.ef_reverb,
	\dur, Pseq([7/8, 1/8], inf),
	\args, #[\beatDurNow, \sidechain_trigger_verb],
	\beatDurNow, {TempoClock.default.beatDur},
	\sidechain_trigger_verb, 1
).play;


a.stop



(
var a, b;
a = Prand([1, Pseq([10, 20, 30]), 2, 3, 4, 5], 6);    // return 6 items
b = a.asStream;
7.do({ b.next.postln; });
)

