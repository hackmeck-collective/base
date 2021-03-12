(
s.waitForBoot {
	var benniPath = "../Synthese_Sounddesign/";
	~localSetup = true; // hier und bei globals ist das relevant
	if(~localSetup){
		(benniPath ++ "network/address_book.scd").loadRelative;
		(benniPath ++ "signal_flow/groups_setup.scd").loadRelative;
		(benniPath ++ "signal_flow/controlbus_setup.scd").loadRelative;
		(benniPath ++ "signal_flow/audiobus_setup.scd").loadRelative;
		(benniPath ++ "signal_flow/sendFX_setup.scd").loadRelative;
		"signal flow loaded".postln;
		(benniPath ++ "presets/instrument_presets.scd").loadRelative;
		(benniPath ++ "presets/drum_presets.scd").loadRelative;
	};
	"resources/globals.scd".loadRelative;
	"resources/lsysCreator_noDaemon.scd".loadRelative;
	"resources/pdefCreator.scd".loadRelative; // load pdef which will play back lsystems
	"resources/lsys_dict_text_replace.scd".loadRelative;

	s.sync;
	(benniPath ++ "instruments/modules/0_load_modules.scd").loadRelative;
	(benniPath ++ "instruments/makeModularSynthDef.scd").loadRelative;
	(benniPath ++ "instruments/makeModularDrum.scd").loadRelative;

	CmdPeriod.run;
	"ready".postln
}
)

// vorschlag: vol durch amp ersetzen

~ctl.scale  = 4.collect { |i| ~objSpace_philipp[\pitches] + (i * 12) }.flat.sort


(
~callInstrumentPreset = {
	arg instrName;
	Pbindef(instrName).clear;
	Pdef((instrName.asString ++ "_chain").asSymbol,
		Pbindef(instrName,
			\instrument, Pfunc {|ev| ~makeModularSynthDef.(ev.adsrType, ev.pitchOp, ev.osc, ev.fx, ev.filter).asSymbol},
			\group, Pfunc {~source_group},
		) <> ~instrumentPresetsDictionary[instrName]
	)
};
)

(
var presetName = \srrPluck;
~callInstrumentPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([1/2], inf),
	\note, Pwhite(0,12),
	\fx_mod_1, Pseq([0.9,0.8,0.7,0.6], inf),
);
Pdef(\srrPluck_chain).play
)


~instrumentPresetsDictionary[\srrPluck] = PbindProxy();
(
~instrumentPresetsDictionary[\srrPluck].set(
	'vol_macro_channel', 0,
	'testPat2', Pseq([ 'x', 'y' ], inf),
	'fx', 'sampleRateReduction',
	'envelope_mod', 0.5,
	'controlbus', Bus('control', 12, 4, s),
	'oscillator_mod_1_macro_channel', 0,
	'filter', 'noFilter',
	'out', Bus('audio', 16, 2, s),
	'pitchOp_mod_1', 0.75,
	'adsrType', 'pluck',
	'filter_mod_2', 1,
	'pitchOp',  Pseq([ 'slide', 'fm' ], inf),
	'oscillator_mod_2_macro_channel', 0,
	'envelope_mod_macro_channel', 0,
	'filter_mod_1_macro_channel', 0,
	'send_1_level', 0.75,
	'pitchOp_mod_2', 0.23,
	'fx_mod_1_macro_channel', 0,
	'fx_mod_1', 0.7,
	'vol', 0.25,
	'fx_mod_2', 1,
	'pitchOp_mod_1_macro_channel', 0,
	'oscillator_mod_2', 0,
	'fx_mod_2_macro_channel', 0,
	'oscillator_mod_1', 0.45,
	'testPat', Pseq([ 'fm', 'aa', 'aaa' ], inf),
	'sendGate', false,
	'osc',  Pseq([ 'basic', 'fm', 'fm' ], inf),
	'filter_mod_1', 1,
	'send_1', Bus('audio', 30, 2, s),
	'pitchOp_mod_2_macro_channel', 0,
	'filter_mod_2_macro_channel', 0
)
)
