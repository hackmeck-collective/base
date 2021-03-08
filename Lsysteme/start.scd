(
s.waitForBoot {
	var benniPath = "../Synthese_Sounddesign/";
	~localSetup = false; // hier und bei globals ist das relevant
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

	"ready".postln
}
)

~ctl.scale  = 4.collect { |i| ~objSpace_philipp[\pitches] + (i * 12) }.flat.sort



/////////// BENNI STUFF

// damit wir uns synthDefPool sparen
SynthDescLib.global.match(synthDefName).isNil


///
(
~callInstrumentPreset = {
	arg instrName;
	Pbindef(instrName).clear;
	Pbindef(instrName,
		\putAll, Pfunc {|ev|
			~instrumentPresetsDictionary[instrName].keysValuesDo {|k, v|
				ev[k] = v.next
			};
			ev
		},
		\instrument, Pfunc {|ev| ~makeModularSynthDef.(ev.adsrType, ev.pitchOp, ev.osc, ev.fx, ev.filter).asSymbol},
		\group, Pfunc {~source_group},
	);
};
)

(
~instrumentPresetsDictionary[\variedPlucks] = (
	\adsrType: \pluck,
	\sendGate: false,
	\pitchOp: Pseq([\slide, \fm, \unisonoDetune], inf).asStream,
	\osc: Pseq([\pulsar, \fm], inf).asStream,
	\fx: \shelvedOverdriveSoft,
	\filter: \noFilter,
	\controlbus: ~launchcontrol_xl_row_4,
	\out: ~melody_bus,
	\send_1: ~ef_reverb,
	\send_1_level: 0.1,
	\pitchOp_mod_1: 0.5,
	\pitchOp_mod_2: 0.1,
	\oscillator_mod_1: 0.1,
	\oscillator_mod_2: 0.4,
	\fx_mod_1: 1,
	\fx_mod_2: 1,
	\filter_mod_1: 0,
	\filter_mod_2: 1,
	\envelope_mod: 0.3,
	\vol: 1,
	\pitchOp_mod_1_macro_channel: 0,
	\pitchOp_mod_2_macro_channel: 0,
	\oscillator_mod_1_macro_channel: 0,
	\oscillator_mod_2_macro_channel: 0,
	\fx_mod_1_macro_channel: 0,
	\fx_mod_2_macro_channel: 0,
	\filter_mod_1_macro_channel: 0,
	\filter_mod_2_macro_channel: 0,
	\envelope_mod_macro_channel: 0,
	\vol_macro_channel: 0,
);
)

~instrumentPresetsDictionary[\variedPlucks].push

~oscillator_mod_2 = 0.01
~controlbus
// ... zuende, dann
Environment.pop

//oder
(
var presetName = \variedPlucks;
var env = ~instrumentPresetsDictionary[presetName];
var txt = "";
env.asSortedArray.do { |arr|
	txt = txt ++ "~% = %;\n".format(arr[0], arr[1].asCompileString)
};
Document.new(presetName.asString ++ "_temp", txt, env);
)



// drum sequencing
Pdef(\hhPhrase,
	Ptsym(
		Pseq([\hh1, [\bongo1, \hh2]], inf),
		dur: Pseq([1, 2, 1], inf)
	)
).play

Pdef(\rest, Pbind(\dur, Pn(Rest())))

Pdef(\hhPhrase,
	Ptsym(
		Pseq([\hh1, [\bongo1, \hh2], \rest], inf),
		dur: Pseq([1, 2], inf)
	)
)

