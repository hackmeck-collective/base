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
		(benniPath ++ "instruments/presets/instrument_presets.scd").loadRelative;
		(benniPath ++ "instruments/presets/drum_presets.scd").loadRelative;
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

Pspawner flexibler als Ptsym?
// vorschlag: vol durch amp ersetzen

~ctl.scale  = 4.collect { |i| ~objSpace_philipp[\pitches] + (i * 12) }.flat.sort



~pr = (
	path: PathName("/home/vincent/Desktop/presetTest"),
	create: { |self, name|
		var filePath = self.path.fullPath +/+ name ++ ".scd";
		if(File.exists(filePath)){
			"Preset % already exists, use method edit".format(name).warn
		}{
			File.use(filePath, "w", { |f|
				f.write(self.defaults.asCompileString)
			});
			Document.open(filePath)
		};
	},
	defaults: [\a, 1, \b, 2],
	edit: { |self, name|
		var filePath = self.path.fullPath +/+ name ++ ".scd";
		if(File.exists(filePath).not){
			"Preset % does not exists, use method create first".format(name).warn
		}{
			Document.open(filePath)
		}
	},
	loadAll: { |self|
		self.path.files.do {|f| f.fullPath.load }
	}
)

~pr.create(\drum3)
~pr.edit(\drum5)
