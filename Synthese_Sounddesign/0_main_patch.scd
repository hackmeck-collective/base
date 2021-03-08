(
var waitForPeers = false;
var loadStuff = {
	"loading signal flow".postln;
	"signal_flow/groups_setup.scd".loadRelative;
	"signal_flow/controlbus_setup.scd".loadRelative;
	"signal_flow/audiobus_setup.scd".loadRelative;
	"signal_flow/sendFx_setup.scd".loadRelative;
	"signal flow loaded".postln;

	"loading instruments".postln;
	"instruments/modules/0_load_modules.scd".loadRelative;
	"instruments/makeModularSynthDef.scd".loadRelative;
	"instruments/makeModularDrum.scd".loadRelative;

	"presets/instrument_presets.scd".loadRelative;
	"presets/drum_presets.scd".loadRelative;

	"loading control interfaces".postln;
	"control_interfaces/midi_defs_launchcontrol-xl.scd".loadRelative;

	if ( ~pitchesRootDissonance[\pitches] == nil ) {~pitchesRootDissonance[\pitches] = [0,3,5,7,10]};
	if (~pitchesRootDissonance[\root] == nil ) {~pitchesRootDissonance[\root] = [0]};

	~linkClock = LinkClock.new(1).latency_(s.latency).enableMeterSync.permanent_(true);
	CmdPeriod.run;
	"ready".postln;
};

"booting server".postln;
"audio_server_options.scd".loadRelative;
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
);

~switchRows.(\bank_1);


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