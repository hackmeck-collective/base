(
var waitForPeers = true;
var loadStuff = {
	"loading signal flow".postln;
	"Synthese_Sounddesign/signal_flow/groups_setup.scd".loadRelative;
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

	"loading patternfunctions".postln;
	"patterns/patternFunctions.scd".loadRelative;
	"patterns/rhythmicPatterns.scd".loadRelative;
	"patterns/pitchPatterns.scd".loadRelative;
	"patterns/drumFills.scd".loadRelative;

	"loading control interfaces".postln;
	"control_interfaces/midi_defs_launchcontrol-xl.scd".loadRelative;

	~localSetup = waitForPeers.not; // hier und bei globals ist das relevant

	if(~localSetup){
		"Lsysteme/resources/globals.scd".loadRelative;
		"Lsysteme/resources/lsysCreator_noDaemon.scd".loadRelative;
		"Lsysteme/resources/pdefCreator.scd".loadRelative; // load pdef which will play back lsystems
		"Lsysteme/resources/lsys_dict_text_replace.scd".loadRelative;
	};

	Pdef(\rest, Pbind(\dur, Pn(Rest())));

	if (~pitchesRootDissonance[\pitches] == nil ) {~pitchesRootDissonance[\pitches] = [-36,-9,5,-17,10]};
	if (~pitchesRootDissonance[\root] == nil ) {~pitchesRootDissonance[\root] = [0]};

	~linkClock = LinkClock.new(1).latency_(s.latency).enableMeterSync.permanent_(true);
	CmdPeriod.run;

	Document.open(thisProcess.nowExecutingPath.dirname +/+ "patterns" +/+ "arrangements.scd");

	"ready".postln;
};

Server.killAll;
"reading audio server options".postln;
"audio_server_options.scd".loadRelative;
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
~switchRows.(\bank_1);

~ass = {|nice, ass,| var str = "";  thisFunction.argNames.do {|name| str = str ++ name ++ ", "}; str}

~ass.().postcs


~adsrTypes.keys;
~oscillatorTypes.keys;
~pitchOpTypes.keys;
~fxTypes.keys;
~filterTypes.keys;
~drumTypes.keys;

SynthDef

lpf_freq = macro_3.lincurve(0,1,60,18000,3);

TempoClock.default.tempo = 1

s.record

s.freeAll

s.stopRecording
*/