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

	create_d: { |self, name|
		var filePath = self.path.fullPath +/+ name ++ ".scd";
		if(File.exists(filePath)){
			"Preset % already exists, use method edit".format(name).warn
		}{
			File.use(filePath, "w", { |f|
				f.write(self.default_d(name))
			});
			Document.open(filePath)
		};
	},

	create_o: { |self, name|
		var filePath = self.path.fullPath +/+ name ++ ".scd";
		if(File.exists(filePath)){
			"Preset % already exists, use method edit".format(name).warn
		}{
			File.use(filePath, "w", { |f|
				f.write(self.default_o(name))
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
\\adsrType, \\pluck, // \\noEnv, \\pluck, \\lead, \\pad, \\sync
\\sendGate, false,
\\envelope_mod, 0.5,
\\envCurve, 3,

\\pitchOpType, \\noPitchOp, // \\noPitchOp, \\vibrato, \\slide, \\unisonoDetune, \\fm, \\vibratoSync, \\slideVibrato, \\rectArpSync, \\rectArp
\\pitchOp_mod_1, 0.55,
\\pitchOp_mod_2, 0.1,

\\pitchOpType, \\noPitchOp,
\\pitchOp_2_mod_1, 0.55,
\\pitchOp_2_mod_2, 0.1,

\\oscillatorType, \\basic, // \\noOscillator, \\basic, \\fm, \\formant, \\filteredNoise, \\modal, \\pulsar, \\ping, \\grainCloudGuitar
\\oscillator_mod_1, 0.45,
\\oscillator_mod_2, 0.001,
\\oscillator_1_level, 1,

\\oscillatorType_2, \\noOscillator,
\\oscillator_2_mod_1, 0.15,
\\oscillator_2_mod_2, 0.01,
\\oscillator_2_level, 1,

\\drumType, \\noDrum, // \\noDrum, \\bodyTimbreTransientTail, \\fmTransientTail, \\noiseFmTransientTail, \\amTransientTail
\\timbre_ratio, 0.45,
\\body_sweep_ratio, 1,
\\timbre_sweep_ratio, 0.25,
\\body_time, 0.5,
\\timbre_time, 0.5,
\\transient_time, 0.15,
\\tail_time, 0.75,
\\body_vol, 1,
\\timbre_vol, 0.25,
\\transient_vol, 1,
\\tail_vol, 0.65,
\\time_factor, 0.01,
\\punch_factor, 2,
\\drum_1_level, 1,

\\drumType_2, \\noDrum,
\\timbre_ratio_2, 0.45,
\\body_sweep_ratio_2, 1,
\\timbre_sweep_ratio_2, 0.25,
\\body_time_2, 0.5,
\\timbre_time_2, 0.5,
\\transient_time_2, 0.15,
\\tail_time_2, 0.75,
\\body_vol_2, 1,
\\timbre_vol_2, 0.25,
\\transient_vol_2, 1,
\\tail_vol_2, 0.65,
\\time_factor_2, 0.01,
\\punch_factor_2, 2,
\\drum_2_level, 1,

// \\noFx,
// \\overdriveSoft, \\overdriveMid, \\overdriveHard,
// \\shelvedOverdriveSoft, \\shelvedOverdriveMid, \\shelvedOverdriveHard,
// \\sampleRateReduction, \\fold, \\wrap, \\rectifier,
// \\tremoloRect, \\tremoloSine, \\tremoloRamp,

\\fxType, \\noFx,
\\fx_1_input_gain, 1,
\\fx_mod_1, 0.25,
\\fx_mod_2, 0.25,

\\fxType_2, \\noFx,
\\fx_2_mod_1, 0.25,
\\fx_2_mod_2, 0.25,


\\filterType, \\noFilter, // \\noFilter, \\lpf_moog, \\lpf_24, \\lpf_12, \\hpf_24, \\hpf_12, \\bpf, \\notch, \\lo_shelf, \\hi_shelf,
\\filter_mod_1, 1,
\\filter_mod_2, 0.25,

\\filterType_2, \\noFilter,
\\filter_2_mod_1, 1,
\\filter_2_mod_2, 0.25,

\\vol, 1,
\\amp, 0.2,

\\out, ~melody_bus,
\\send_1, ~ef_reverb,
\\send_1_level, 0.25,
\\send_2, ~simpleDelay_8d,
\\send_2_level, 0,

\\mod1Type, \\noMod,
\\mod1Target, \"\",
\\mod1Amount, 0.25,
\\mod1Rate, 0.25,
\\mod1attack, 1,
\\mod1decay, 1,
\\mod1sustain, 0.5,
\\mod1release, 1,
\\mod1EnvCurve, 2,
\\mod1syncEnvRatio, 0,
\\mod1ControlbusChannel, 0,

\\mod2Type, \\noMod,
\\mod2Target, \"\",
\\mod2Amount, 0.25,
\\mod2Rate, 0.25,
\\mod2attack, 1,
\\mod2decay, 1,
\\mod2sustain, 0.5,
\\mod2release, 1,
\\mod2EnvCurve, 2,
\\mod2syncEnvRatio, 0,
\\mod2ControlbusChannel, 1,

\\mod3Type, \\noMod,
\\mod3Target, \"\",
\\mod3Amount, 0.25,
\\mod3Rate, 0.25,
\\mod3attack, 1,
\\mod3decay, 1,
\\mod3sustain, 0.5,
\\mod3release, 1,
\\mod3EnvCurve, 2,
\\mod3syncEnvRatio, 0,
\\mod3ControlbusChannel, 2,

\\mod4Type, \\noMod,
\\mod4Target, \"\",
\\mod4Amount, 0.25,
\\mod4Rate, 0.25,
\\mod4attack, 1,
\\mod4decay, 1,
\\mod4sustain, 0.5,
\\mod4release, 1,
\\mod4EnvCurve, 2,
\\mod4syncEnvRatio, 0,
\\mod4ControlbusChannel, 3,
];
~callInstrumentPreset.(%);
)".format(name.asCompileString, name.asCompileString);
	},

	default_o: { |self, name|
		"(
~instrumentPresetsDictionary[%] = [
\\adsrType, \\pluck, // \\noEnv, \\pluck, \\lead, \\pad, \\sync
\\sendGate, false,
\\envelope_mod, 0.5,
\\envCurve, 3,

\\pitchOpType, \\noPitchOp, // \\noPitchOp, \\vibrato, \\slide, \\unisonoDetune, \\fm, \\vibratoSync, \\slideVibrato, \\rectArpSync, \\rectArp
\\pitchOp_mod_1, 0.55,
\\pitchOp_mod_2, 0.1,

\\pitchOpType, \\noPitchOp,
\\pitchOp_2_mod_1, 0.55,
\\pitchOp_2_mod_2, 0.1,

\\oscillatorType, \\basic, // \\noOscillator, \\basic, \\fm, \\formant, \\filteredNoise, \\modal, \\pulsar, \\ping, \\grainCloudGuitar
\\oscillator_mod_1, 0.45,
\\oscillator_mod_2, 0.001,
\\oscillator_1_level, 1,

\\oscillatorType_2, \\noOscillator,
\\oscillator_2_mod_1, 0.15,
\\oscillator_2_mod_2, 0.01,
\\oscillator_2_level, 1,

// \\noFx,
// \\overdriveSoft, \\overdriveMid, \\overdriveHard,
// \\shelvedOverdriveSoft, \\shelvedOverdriveMid, \\shelvedOverdriveHard,
// \\sampleRateReduction, \\fold, \\wrap, \\rectifier,
// \\tremoloRect, \\tremoloSine, \\tremoloRamp,

\\fxType, \\noFx,
\\fx_1_input_gain, 1,
\\fx_mod_1, 0.25,
\\fx_mod_2, 0.25,

\\fxType_2, \\noFx,
\\fx_2_mod_1, 0.25,
\\fx_2_mod_2, 0.25,


\\filterType, \\noFilter, // \\noFilter, \\lpf_moog, \\lpf_24, \\lpf_12, \\hpf_24, \\hpf_12, \\bpf, \\notch, \\lo_shelf, \\hi_shelf,
\\filter_mod_1, 1,
\\filter_mod_2, 0.25,

\\filterType_2, \\noFilter,
\\filter_2_mod_1, 1,
\\filter_2_mod_2, 0.25,

\\vol, 1,
\\amp, 0.2,

\\out, ~melody_bus,
\\send_1, ~ef_reverb,
\\send_1_level, 0.25,
\\send_2, ~simpleDelay_8d,
\\send_2_level, 0,

\\mod1Type, \\noMod,
\\mod1Target, \"\",
\\mod1Amount, 0.25,
\\mod1Rate, 0.25,
\\mod1attack, 1,
\\mod1decay, 1,
\\mod1sustain, 0.5,
\\mod1release, 1,
\\mod1EnvCurve, 2,
\\mod1syncEnvRatio, 0,
\\mod1ControlbusChannel, 0,

\\mod2Type, \\noMod,
\\mod2Target, \"\",
\\mod2Amount, 0.25,
\\mod2Rate, 0.25,
\\mod2attack, 1,
\\mod2decay, 1,
\\mod2sustain, 0.5,
\\mod2release, 1,
\\mod2EnvCurve, 2,
\\mod2syncEnvRatio, 0,
\\mod2ControlbusChannel, 1,

\\mod3Type, \\noMod,
\\mod3Target, \"\",
\\mod3Amount, 0.25,
\\mod3Rate, 0.25,
\\mod3attack, 1,
\\mod3decay, 1,
\\mod3sustain, 0.5,
\\mod3release, 1,
\\mod3EnvCurve, 2,
\\mod3syncEnvRatio, 0,
\\mod3ControlbusChannel, 2,

\\mod4Type, \\noMod,
\\mod4Target, \"\",
\\mod4Amount, 0.25,
\\mod4Rate, 0.25,
\\mod4attack, 1,
\\mod4decay, 1,
\\mod4sustain, 0.5,
\\mod4release, 1,
\\mod4EnvCurve, 2,
\\mod4syncEnvRatio, 0,
\\mod4ControlbusChannel, 3,
];
~callInstrumentPreset.(%);
)".format(name.asCompileString, name.asCompileString);
	},

	default_d: { |self, name|
		"(
~instrumentPresetsDictionary[%] = [
\\adsrType, \\pluck, // \\noEnv, \\pluck, \\lead, \\pad, \\sync
\\sendGate, false,
\\envelope_mod, 0.5,
\\envCurve, 3,

\\pitchOpType, \\noPitchOp, // \\noPitchOp, \\vibrato, \\slide, \\unisonoDetune, \\fm, \\vibratoSync, \\slideVibrato, \\rectArpSync, \\rectArp
\\pitchOp_mod_1, 0.55,
\\pitchOp_mod_2, 0.1,

\\pitchOpType, \\noPitchOp,
\\pitchOp_2_mod_1, 0.55,
\\pitchOp_2_mod_2, 0.1,

\\drumType, \\bodyTimbreTransientTail, // \\noDrum, \\bodyTimbreTransientTail, \\fmTransientTail, \\noiseFmTransientTail, \\amTransientTail
\\timbre_ratio, 0.45,
\\body_sweep_ratio, 1,
\\timbre_sweep_ratio, 0.25,
\\body_time, 0.5,
\\timbre_time, 0.5,
\\transient_time, 0.15,
\\tail_time, 0.75,
\\body_vol, 1,
\\timbre_vol, 0.25,
\\transient_vol, 1,
\\tail_vol, 0.65,
\\time_factor, 0.01,
\\punch_factor, 2,
\\drum_1_level, 1,

\\drumType_2, \\noDrum,
\\timbre_ratio_2, 0.45,
\\body_sweep_ratio_2, 1,
\\timbre_sweep_ratio_2, 0.25,
\\body_time_2, 0.5,
\\timbre_time_2, 0.5,
\\transient_time_2, 0.15,
\\tail_time_2, 0.75,
\\body_vol_2, 1,
\\timbre_vol_2, 0.25,
\\transient_vol_2, 1,
\\tail_vol_2, 0.65,
\\time_factor_2, 0.01,
\\punch_factor_2, 2,
\\drum_2_level, 1,

// \\noFx,
// \\overdriveSoft, \\overdriveMid, \\overdriveHard,
// \\shelvedOverdriveSoft, \\shelvedOverdriveMid, \\shelvedOverdriveHard,
// \\sampleRateReduction, \\fold, \\wrap, \\rectifier,
// \\tremoloRect, \\tremoloSine, \\tremoloRamp,

\\fxType, \\noFx,
\\fx_1_input_gain, 1,
\\fx_mod_1, 0.25,
\\fx_mod_2, 0.25,

\\fxType_2, \\noFx,
\\fx_2_mod_1, 0.25,
\\fx_2_mod_2, 0.25,


\\filterType, \\noFilter, // \\noFilter, \\lpf_moog, \\lpf_24, \\lpf_12, \\hpf_24, \\hpf_12, \\bpf, \\notch, \\lo_shelf, \\hi_shelf,
\\filter_mod_1, 1,
\\filter_mod_2, 0.25,

\\filterType_2, \\noFilter,
\\filter_2_mod_1, 1,
\\filter_2_mod_2, 0.25,

\\vol, 1,
\\amp, 0.2,

\\out, ~melody_bus,
\\send_1, ~ef_reverb,
\\send_1_level, 0.25,
\\send_2, ~simpleDelay_8d,
\\send_2_level, 0,

\\mod1Type, \\noMod,
\\mod1Target, \"\",
\\mod1Amount, 0.25,
\\mod1Rate, 0.25,
\\mod1attack, 1,
\\mod1decay, 1,
\\mod1sustain, 0.5,
\\mod1release, 1,
\\mod1EnvCurve, 2,
\\mod1syncEnvRatio, 0,
\\mod1ControlbusChannel, 0,

\\mod2Type, \\noMod,
\\mod2Target, \"\",
\\mod2Amount, 0.25,
\\mod2Rate, 0.25,
\\mod2attack, 1,
\\mod2decay, 1,
\\mod2sustain, 0.5,
\\mod2release, 1,
\\mod2EnvCurve, 2,
\\mod2syncEnvRatio, 0,
\\mod2ControlbusChannel, 1,

\\mod3Type, \\noMod,
\\mod3Target, \"\",
\\mod3Amount, 0.25,
\\mod3Rate, 0.25,
\\mod3attack, 1,
\\mod3decay, 1,
\\mod3sustain, 0.5,
\\mod3release, 1,
\\mod3EnvCurve, 2,
\\mod3syncEnvRatio, 0,
\\mod3ControlbusChannel, 2,

\\mod4Type, \\noMod,
\\mod4Target, \"\",
\\mod4Amount, 0.25,
\\mod4Rate, 0.25,
\\mod4attack, 1,
\\mod4decay, 1,
\\mod4sustain, 0.5,
\\mod4release, 1,
\\mod4EnvCurve, 2,
\\mod4syncEnvRatio, 0,
\\mod4ControlbusChannel, 3,
];
~callInstrumentPreset.(%);
)".format(name.asCompileString, name.asCompileString);
	},
);

//~instrPreset.create(\blaaaaa)
