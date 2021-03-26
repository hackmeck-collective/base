(
~callInstrumentPreset = {
	arg instrName;
	Pdef(instrName).clear;
	Pdef(instrName,
		Pbind(
			\instrument, Pfunc {|ev|
				~makeModularSynthDef.valueWithEnvir(ev)
			},
			\group, Pfunc {~source_group}
		) <> Pbind(*~instrumentPresetsDictionary[instrName])
	);
}
);

"call instrument preset function loaded".postln;

~localEditInst = {
	arg instrName;
	var env = ~instrumentPresetsDictionary[instrName];
	var txt = "";
	env.asSortedArray.do { |arr|
		txt = txt ++ "~% = %;\n".format(arr[0], arr[1].asCompileString)
	};
	Document.new(instrName.asString ++ "_temp", txt, env);
};

"local edit preset function loaded".postln;

~instrPreset = (
	path: PathName(thisProcess.nowExecutingPath.dirname +/+ "InstrumentPresets"),
	create: { |self, name|
		var filePath = self.path.fullPath +/+ name ++ ".scd";
		if(File.exists(filePath)){
			"Preset % already exists, use method edit".format(name).warn
		}{
			File.use(filePath, "w", { |f|
				f.write(self.defaults(name))
			});
			Document.open(filePath)
		};
	},
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
	},
	defaults: { |self, name|
		"(
~instrumentPresetsDictionary[%] = [
\\adsrType, \\pluck,
\\sendGate, false,
\\pitchOpType, \\slide,
\\oscillatorType, \\fm,
\\oscillatorType_2, \\fm,
\\controlbus, ~launchcontrol_xl_row_4,
\\out, ~melody_bus,
\\send_1, ~ef_reverb,
\\send_1_level, 0.25,
\\pitchOp_mod_1, 0.55,
\\pitchOp_mod_2, 0.1,
\\oscillator_mod_1, 0.45,
\\oscillator_mod_2, 0.001,
\\oscillator_2_mod_1, 0.15,
\\oscillator_2_mod_2, 0.01,
\\fx_mod_1, 1,
\\fx_mod_2, 1,
\\filter_mod_1, 0.75,
\\filter_mod_2, 0.4,
\\envelope_mod, 0.7,
\\vol, 1,
\\amp, 0.2,
\\pitchOp_mod_1_macro_channel, 0,
\\pitchOp_mod_2_macro_channel, 0,
\\oscillator_mod_1_macro_channel, 0,
\\oscillator_mod_2_macro_channel, 0,
\\fx_mod_1_macro_channel, 0,
\\fx_mod_2_macro_channel, 0,
\\filter_mod_1_macro_channel, 0,
\\filter_mod_2_macro_channel, 0,
\\envelope_mod_macro_channel, 0,
\\vol_macro_channel, 0,
];
~callInstrumentPreset.(%);
)".format(name.asCompileString, name.asCompileString);
	}
);
//
// ~instrPreset.create(\blaaaaa)
