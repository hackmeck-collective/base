
(
var waitForPeers = false;
var multicoreSetup = false;
var loadStuff = {
	"loading signal flow".postln;
	if(multicoreSetup)
{"Synthese_Sounddesign/signal_flow/groups_setup_multicore.scd".loadRelative;
	"groups for multicore use created".postln;}
{"Synthese_Sounddesign/signal_flow/groups_setup.scd".loadRelative;
	"groups created".postln;
	};

	"Synthese_Sounddesign/signal_flow/controlbus_setup.scd".loadRelative;
	"Synthese_Sounddesign/signal_flow/audiobus_setup.scd".loadRelative;
	"Synthese_Sounddesign/signal_flow/sendFX_setup.scd".loadRelative;
	"Synthese_Sounddesign/signal flow loaded".postln;

	"loading instruments".postln;
	"Synthese_Sounddesign/instruments/modules/0_load_modules.scd".loadRelative;
	"Synthese_Sounddesign/instruments/makeModularSynthDef.scd".loadRelative;

	"loading presets".postln;
	"Presets/InstrumentPresetFunctions.scd".loadRelative;
	~instrPreset.loadAll;
	"Presets/instrumentationPresets.scd".loadRelative;

	"loading patternfunctions".postln;
	"patterns/patternFunctions.scd".loadRelative;
	"patterns/rhythmicPatterns.scd".loadRelative;
	"patterns/pitchPatterns.scd".loadRelative;
	"patterns/drumFills.scd".loadRelative;
	"patterns/launchControlXlTrigger.scd".loadRelative;

	"loading control interfaces".postln;
	"control_interfaces/midi_defs_launchcontrol-xl.scd".loadRelative;

	~localSetup = waitForPeers.not;

	if(~localSetup){
		"loading L-Systems".postln;
		"Lsysteme/resources/globals.scd".loadRelative;
		"Lsysteme/resources/lsysCreator_noDaemon.scd".loadRelative;
		"Lsysteme/resources/pdefCreator.scd".loadRelative; // load pdef which will play back lsystems
		"Lsysteme/resources/lsys_dict_text_replace.scd".loadRelative;
	};

	Pdef(\rest, Pbind(\dur, Pn(Rest())));

	if (~pitchesRootDissonance[\pitches] == nil ) {~pitchesRootDissonance[\pitches] = [-36,-9,5,-17,10]};
	if (~pitchesRootDissonance[\root] == nil ) {~pitchesRootDissonance[\root] = [0]};

	"initializing LinkClock".postln;

	~linkClock = LinkClock.new(1).latency_(s.latency).enableMeterSync.permanent_(true);

	"loading cue functions".postln;
	"cues/cues.scd".loadRelative;
	"cues/launchcontrolPolymer.scd".loadRelative;

	CmdPeriod.run;

	Document.open(thisProcess.nowExecutingPath.dirname +/+ "patterns" +/+ "arrangements.scd");

	"ready".postln;
};

Server.killAll;
"reading audio server options".postln;
if(multicoreSetup)
{"audio_server_options_multicore.scd".loadRelative;
	"multicore server options loaded".postln;}
{"audio_server_options.scd".loadRelative;
	"server options loaded".postln;};

"booting server".postln;
s.waitForBoot {
	if(MIDIClient.initialized.not){
		MIDIClient.init;
		MIDIIn.connectAll;
	};
	ServerTree.removeAll;
	"loading network".postln;
	"network/address_book.scd".loadRelative;
	"network/ip_config.scd".loadRelative;
	"waiting...".postln;
	if(waitForPeers){
		block {|break|
			inf.do{
				~addrBook.names.postln;
				if(~addrBook.names.includes(\vincent)){
					loadStuff.value;
					break.value
				};
				1.wait
			}
		}
	}{
		loadStuff.value
	}
};
)

~instrPreset.keys.do.postln;

(
~instrPreset.loadAll;
~routing[\sourceGroup] = ~source_group.nodeID;
~routing[\melodyBus] = ~melody_bus.index;
~routing[\chordsBus] = ~chords_bus.index;
~routing[\drumsBus] = ~drums_bus.index;
~routing[\auxBus] = ~aux_bus.index;
);

/*

~adsrTypes.keys.asArray.flat;
~oscillatorTypes.keys.asArray.flat;
~pitchOpTypes.keys.asArray.flat;
~fxTypes.keys.asArray.flat;
~filterTypes.keys.asArray.flat;
~drumTypes.keys.asArray.flat;
~modSources.keys.asArray.flat;

s.record

s.freeAll

s.stopRecording
*/
