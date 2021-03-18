(
s.waitForBoot {
	var benniPath = "../Synthese_Sounddesign/";
	~localSetup = true; // hier und bei globals ist das relevant
	if(~localSetup){
		("../network/address_book.scd").loadRelative;
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
	"resources/lsys_dict_text_replace.scd".loadRelative;
	"../Presets/LsystemPresetFunctions.scd".loadRelative;
	~lsysPreset.loadAll;

	s.sync;
	(benniPath ++ "instruments/modules/0_load_modules.scd").loadRelative;
	(benniPath ++ "instruments/makeModularSynthDef.scd").loadRelative;

	CmdPeriod.run;
	"ready".postln
}
)

Pspawner flexibler als Ptsym?
// vorschlag: vol durch amp ersetzen

~ctl.scale  = 4.collect { |i| ~objSpace_philipp[\pitches] + (i * 12) }.flat.sort
