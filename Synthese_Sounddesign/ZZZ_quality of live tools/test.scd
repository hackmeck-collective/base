
(
Pbindef(\testi,
	\adsrType, \pluck,
	\pitchOp, Pseq([\slide, \fm, \unisonoDetune], inf),
	\osc, Pseq([\pulsar, \fm], inf),
	\fx, \shelvedOverdriveSoft,
	\filter, \lpf_moog,
	\instrument, Pfunc {|ev| "%_%_%_%_%".format(ev.adsrType, ev.pitchOp, ev.osc, ev.fx, ev.filter).asSymbol },
	\dur, Pseq([1/4], inf),
	\note, Pseq([-12,-5,0,7,12], inf),
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.5,
	\pitchOp_mod_1, 0,
	\pitchOp_mod_2, 0,
	\oscillator_mod_1, 0.5,
	\oscillator_mod_2, 0,
	\fx_mod_1, 1,
	\fx_mod_2, 1,
	\filter_mod_1, 0,
	\filter_mod_2, 1,
	\pitchOp_mod_1_macro_channel, 2,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 2,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 2,
	\fx_mod_2_macro_channel, 2,
	\filter_mod_1_macro_channel, 1,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 3,
	\group, ~source_group,
).play(quant: 2)
)

(
Pbindef(\BD1,
	\drumType, \bodyTimbreTransientTail,
	\fx, \shelvedOverdriveSoft,
	\filter, \nofilter,
	\instrument, Pfunc {|ev| "%_%_%".format(ev.drumType, ev.fx, ev.filter).asSymbol },
	\dur, Pseq([1], inf),
	\note, Pseq([-24], inf),
	\controlbus, ~launchcontrol_xl_row_1,
	\out, ~drums_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.5,
	\timbre_ratio, 0.25,
	\body_sweep_ratio, 0.75,
	\timbre_sweep_ratio, 1,
	\body_time, 1,
	\timbre_time, 1,
	\transient_time, 0.85,
	\tail_time, 1,
	\body_vol, 1,
	\timbre_vol, 0.45,
	\transient_vol, 0.5,
	\tail_vol, 0.3,
	\time_factor, 0.5,
	\fx_mod_1, 0,
	\fx_mod_2, 0,
	\filter_mod_1, 1,
	\filter_mod_2, 1,
	\time_factor_macro_channel, 3,
	\fx_mod_1_macro_channel, 1,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 2,
	\filter_mod_2_macro_channel, 0,
	\group, ~source_group,
).play(quant: 2)
)



(
Pbind(
	\instrument, \pad_unisonoDetune_pulsar_overdrive,
	\dur, Pseq([2], inf),
	\note, Pseq([[-1,3,7,10,12]], inf),
	\out, ~chords_bus,
	\controlbus, ~launchcontrol_xl_row_3,
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
	\instrument, \bodyTimbreTransientTail_shelvedOverdriveSoft_nofilter,
	\dur, Pseq([1.25,0.75], inf),
	\note, Pseq([-24], inf),
	\out, ~drums_bus,
	\controlbus, ~launchcontrol_xl_row_1,
	\fx_mod_1_macro_channel, 2,
	\fx_mod_2, 0.35,
	\timbre_ratio, 0.25,
	\body_sweep_ratio, 0.75,
	\timbre_sweep_ratio, 1,
	\body_time, 1,
	\timbre_time, 1,
	\transient_time, 0.85,
	\tail_time, 1,
	\body_vol, 1,
	\timbre_vol, 0.45,
	\transient_vol, 0.5,
	\tail_vol, 0.3,
	\filter_mod_1_macro_channel, 1,
	\filter_mod_2, 0,
	\group, ~source_group,
).play(quant: 2)
)
(
Pbind(
	\instrument, \amTransientTail_overdriveSoft,
	\dur, Pseq([1.25,0.75], inf),
	\note, Pseq([-24], inf),
	\out, ~drums_bus,
	\controlbus, ~launchcontrol_xl_row_1,
	\fx_mod_1_macro_channel, 2,
	\timbre_ratio, 0.25,
	\body_sweep_ratio, 0.75,
	\timbre_sweep_ratio, 1,
	\body_time, 1,
	\timbre_time, 1,
	\transient_time, 0.85,
	\tail_time, 1,
	\body_vol, 1,
	\timbre_vol, 0.45,
	\transient_vol, 0.5,
	\tail_vol, 0.3,
	\group, ~source_group,
).play(quant: 2)
)

(
Pbind(
	\instrument, \bodyTimbreTransientTail_overdriveSoft,
	\dur, Pseq([Rest(0.5),0.5,Rest(0.75),0.25], inf),
	\note, Pseq([-5], inf),
	\out, ~drums_bus,
	\controlbus, ~launchcontrol_xl_row_2,
	\fx_mod_1_macro_channel, 2,
	\timbre_ratio, 0.4,
	\body_sweep_ratio, 0.5,
	\timbre_sweep_ratio, 0.5,
	\body_time, 0.75,
	\timbre_time, 1,
	\transient_time, 0.35,
	\tail_time, 1,
	\body_vol, 1,
	\timbre_vol, 0.45,
	\transient_vol, 1,
	\tail_vol, 0.65,
	\group, ~source_group,
).play(quant: 2)
)
(
Pbind(
	\instrument, \fmTransientTail_sampleRateReduction,
	\dur, Pseq([Rest(0.5),0.5,Rest(0.25),0.75], inf),
	\note, Pseq([7], inf),
	\out, ~drums_bus,
	\controlbus, ~launchcontrol_xl_row_3,
	\fx_mod_1_macro_channel, 2,
	\timbre_ratio, 0.45,
	\body_sweep_ratio, 1,
	\timbre_sweep_ratio, 0.25,
	\body_time, 0.5,
	\timbre_time, 0.5,
	\transient_time, 0.15,
	\tail_time, 0.75,
	\body_vol, 1,
	\timbre_vol, 0.25,
	\transient_vol, 1,
	\tail_vol, 0.65,
	\group, ~source_group,
).play(quant: 2)
)

(
Pbind(
	\instrument, \noiseFmTransientTail_overdrive,
	\dur, Pseq([Rest(0.5),0.5,Rest(0.25),0.75], inf),
	\note, Pseq([7], inf),
	\out, ~drums_bus,
	\controlbus, ~launchcontrol_xl_row_2,
	\fx_mod_1_macro_channel, 2,
	\timbre_ratio, 0.45,
	\body_sweep_ratio, 1,
	\timbre_sweep_ratio, 0.25,
	\body_time, 0.5,
	\timbre_time, 1,
	\transient_time, 0.15,
	\tail_time, 0.75,
	\body_vol, 1,
	\timbre_vol, 1,
	\transient_vol, 1,
	\tail_vol, 0,
	\group, ~source_group,
).play(quant: 2)
)


(
Pbind(
	\instrument, \bodyTimbreTransientTail_overdrive,
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
		1/2], inf),
	\note, Pseq([48], inf),
	\out, ~drums_bus,
	\controlbus, ~launchcontrol_xl_row_3,
	\fx_mod_1_macro_channel, 2,
	\timbre_ratio, 0.05,
	\body_sweep_ratio, 1,
	\timbre_sweep_ratio, 1,
	\body_time, 0.5,
	\timbre_time, 0.4,
	\transient_time, 0.5,
	\tail_time, 0.5,
	\body_vol, 0.21,
	\timbre_vol, 0.6,
	\transient_vol, 0.75,
	\tail_vol, 1,
	\group, ~source_group,
).play(quant: 2)
)

(
Pbind(
	\instrument, \fmTransientTail_overdrive,
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
		1/2], inf),
	\note, Pseq([48], inf),
	\out, ~drums_bus,
	\controlbus, ~launchcontrol_xl_row_3,
	\fx_mod_1_macro_channel, 2,
	\timbre_ratio, 0.05,
	\body_sweep_ratio, 1,
	\timbre_sweep_ratio, 1,
	\body_time, 0.5,
	\timbre_time, 0.4,
	\transient_time, 0.5,
	\tail_time, 0.5,
	\body_vol, 0.21,
	\timbre_vol, 0.6,
	\transient_vol, 0.75,
	\tail_vol, 1,
	\group, ~source_group,
).play(quant: 2)
)

(
Pbind(
	\instrument, \amTransientTail_overdrive,
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
		1/2], inf),
	\note, Pseq([48], inf),
	\out, ~drums_bus,
	\controlbus, ~launchcontrol_xl_row_3,
	\fx_mod_1_macro_channel, 2,
	\timbre_ratio, 0.05,
	\body_sweep_ratio, 1,
	\timbre_sweep_ratio, 1,
	\body_time, 0.5,
	\timbre_time, 0.4,
	\transient_time, 0.5,
	\tail_time, 0.5,
	\body_vol, 0.21,
	\timbre_vol, 0.6,
	\transient_vol, 0.75,
	\tail_vol, 1,
	\group, ~source_group,
).play(quant: 2)
)

(
Pbind(
	\instrument, \snare2_overdrive,
	\dur, Pseq([1], inf),
	\note, Pseq([-24], inf),
	\out, ~drums_bus,
	\controlbus, ~launchcontrol_xl_row_1,
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
	\controlbus, ~launchcontrol_xl_row_3,
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

