(
s.waitForBoot {
	var benniPath = "../Synthese_Sounddesign/";
	~localSetup = false;
	"resources/globals.scd".loadRelative;
	"resources/lsysCreator_noDaemon.scd".loadRelative;
	"resources/pdefCreator.scd".loadRelative; // load pdef which will play back lsystems
	"resources/lsys_dict_text_replace.scd".loadRelative;

	s.sync;
	(benniPath ++ "instruments/modules/0_load_modules.scd").loadRelative;
	(benniPath ++ "instruments/makeModularSynthDef.scd").loadRelative;
	(benniPath ++ "instruments/makeModularDrum.scd").loadRelative;

	"ready".postln
}
)

~ctl.scale  = 4.collect { |i| ~objSpace_philipp[\pitches] + (i * 12) }.flat.sort

~ctl.scale = Scale(~objSpace_philipp[\pitches])

SynthDescLib.at(\lead_unisonoDetune_fm_noFx_noFilter);
x = Synth(\pluck_fm_fm_shelvedOverdriveSoft_lpf_moog, [\vol, 1],target: ~targetServer)

Pbind(\server, ~targetServer,
	\adsrType, \pluck,
	\sendGate, false,
	\pitchOp, Pseq([\slide, \fm, \unisonoDetune], inf),
	\osc, Pseq([\pulsar, \fm], inf),
	\fx, \shelvedOverdriveSoft,
	\filter, \noFilter,
	\instrument, Pfunc {|ev| ~makeModularSynthDef.(ev.adsrType, ev.pitchOp, ev.osc, ev.fx, ev.filter).asSymbol},
	\group, Pfunc {~routing[\sourceGroup]},
	\out, Pfunc {~routing[\melodyBus]},
	\vol, 0.5,
	\legato, 0.25, \dur, 1
).play(protoEvent: ~presets_benni[\simplePluck])


~presets_benni[\simplePluck]
~presets_benni.keys


Date.localtime