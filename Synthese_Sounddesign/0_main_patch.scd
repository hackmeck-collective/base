(
"booting server".postln;
"boot_audio_server.scd".loadRelative;
s.waitForBoot {
	if(MIDIClient.initialized.not){
		MIDIClient.init;
		MIDIIn.connectAll;
	};
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

	"presets/presets.scd".loadRelative;

	"loading control interfaces".postln;
	"control_interfaces/midi_defs_launchcontrol-xl.scd".loadRelative;

	"loading network".postln;
	"network/address_book.scd".loadRelative;
	"network/ip_config.scd".loadRelative;

	~linkClock = LinkClock.new(1).permanent_(true);
	"ready".postln
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