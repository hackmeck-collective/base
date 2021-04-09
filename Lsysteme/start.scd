(
s.waitForBoot {
	var benniPath = "../Synthese_Sounddesign/";
	~localSetup = false; // hier und bei globals ist das relevant
	("../network/address_book.scd").loadRelative;

	if(~localSetup){
		(benniPath ++ "signal_flow/groups_setup.scd").loadRelative;
		(benniPath ++ "signal_flow/controlbus_setup.scd").loadRelative;
		(benniPath ++ "signal_flow/audiobus_setup.scd").loadRelative;
		(benniPath ++ "signal_flow/sendFX_setup.scd").loadRelative;
		"signal flow loaded".postln;
		"loading presets".postln;
		"../Presets/InstrumentPresetFunctions.scd".loadRelative;
		~instrPreset.loadAll;
	};

	"resources/globals.scd".loadRelative;
	"resources/lsysCreator_noDaemon.scd".loadRelative;
	"resources/pdefCreator.scd".loadRelative; // load pdef which will play back lsystems
	"../Presets/LsystemPresetFunctions.scd".loadRelative;
	~lsysPreset.loadAll;

	s.sync;
	(benniPath ++ "instruments/modules/0_load_modules.scd").loadRelative;
	(benniPath ++ "instruments/makeModularSynthDef.scd").loadRelative;

	CmdPeriod.run;
	"ready".postln
}
)

~hail.free

~ctl.scale  = 4.collect { |i| ~objSpace_philipp[\pitches] + (i * 12) }.flat.sort
