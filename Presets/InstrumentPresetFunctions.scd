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
// %

\\adsrType, \\pluck,
\\sendGate, false,
\\envelope_mod, 0.5,
\\envCurve, 3,

// %

\\pitchOpType, \\noPitchOp,
\\pitchOp_1_interval, 0,
\\pitchOp_1_amount, 0.1,

\\pitchOpType_2, \\noPitchOp,
\\pitchOp_2_interval, 12,
\\pitchOp_2_amount, 0.1,

// %

// the buffers have to be EXISTING audio buffers. If they return nil there will be no sound without an ERROR.
// the buffers for the granulator have to be ONE CHANNEL. If they contain more than one channel there will be no sound without an ERROR.

\\oscillatorType, \\basic,
\\oscillator_1_mod_1, 0.45,
\\oscillator_1_mod_2, 0.001,
\\oscillator_1_mod_3, 0,
\\oscillator_1_mod_4, 0,
\\oscillator_1_buffer, ~beatRepeatBuffer_1,
\\oscillator_1_bufferPos, ~beatRepeatBufferPosition_1,
\\oscillator_1_level, 1,
\\oscillator_1_transpose, 0,

\\oscillatorType_2, \\noOscillator,
\\oscillator_2_mod_1, 0.15,
\\oscillator_2_mod_2, 0.01,
\\oscillator_2_mod_3, 0,
\\oscillator_2_mod_4, 0,
\\oscillator_2_buffer, ~beatRepeatBuffer_1,
\\oscillator_2_bufferPos, ~beatRepeatBufferPosition_1,
\\oscillator_2_level, 1,
\\oscillator_1_transpose, -12,

// %

\\drumType, \\noDrum,
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

// %

\\fxType, \\noFx,
\\fx_1_input_gain, 1,
\\fx_1_mod_1, 0.25,
\\fx_1_mod_2, 0.25,

\\fxType_2, \\noFx,
\\fx_2_mod_1, 0.25,
\\fx_2_mod_2, 0.25,

// %

\\filterIn_preFxLevel, 0,
\\filterIn_FxLevel, 1,

\\filterType, \\noFilter,
\\filter_1_mod_1, 1,
\\filter_1_mod_2, 0.25,

\\filterType_2, \\noFilter,
\\filter_2_mod_1, 1,
\\filter_2_mod_2, 0.25,

\\vca_filterLevel, 1,
\\vca_preFilterLevel, 0,
\\vca_preFxLevel, 0,

\\vol, 1,
\\amp, 0.2,

// the sends have to be EXISTING audio busses. If they return nil there will be no sound without an ERROR.

\\out, ~melody_bus,
\\send_1, ~ef_reverb,
\\send_1_level, 0.25,
\\send_2, ~simpleDelay,
\\send_2_level, 0,
\\send_3, ~granulator_1,
\\send_3_level, 0,
\\send_4, ~beatRepeat_1,
\\send_4_level, 0,

// %

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

//external targets you want to declare in a Pattern have to be chained before the preset Pdef(preset) <> Pbind(\external1Target, \"filter_1_mod_1\") for example. If they are declared in the chain, they can't be present in the instrumentPreset, otherwise you will get an ERROR.

\\controlbus1, ~dummybus,
//\\external1Target, \"\",
\\external1Amount, 1,
//\\external1Target2, \"\",
\\external1Amount2, 1,
\\external1min, -1,
\\external1max, 1,

\\controlbus2, ~dummybus,
//\\external2Target, \"\",
\\external2Amount, 1,
//\\external2Target2, \"\",
\\external2Amount2, 1,
\\external2min, -1,
\\external2max, 1,

\\controlbus3, ~dummybus,
//\\external3Target, \"\",
\\external3Amount, 1,
//\\external3Target2, \"\",
\\external3Amount2, 1,
\\external3min, -1,
\\external3max, 1,

\\controlbus4, ~dummybus,
//\\external4Target, \"\",
\\external4Amount, 1,
//\\external4Target2, \"\",
\\external4Amount2, 1,
\\external4min, -1,
\\external4max, 1,

//\\pattern1Target, \"\",
\\pattern1Amount, 1,
//\\pattern2Target, \"\",
\\pattern2Amount, 1,
//\\pattern3Target, \"\",
\\pattern3Amount, 1,
//\\pattern4Target, \"\",
\\pattern4Amount, 1,

];
~callInstrumentPreset.(%);
)".format(name.asCompileString, ~adsrTypes.keys.asArray.flat, ~pitchOpTypes.keys.asArray.flat, ~oscillatorTypes.keys.asArray.flat, ~drumTypes.keys.asArray.flat, ~fxTypes.keys.asArray.flat, ~filterTypes.keys.asArray.flat, ~modSources.keys.asArray.flat, name.asCompileString);
	},

	default_o: { |self, name|
		"(
~instrumentPresetsDictionary[%] = [
// %

\\adsrType, \\pluck,
\\sendGate, false,
\\envelope_mod, 0.5,
\\envCurve, 3,

// %

\\pitchOpType, \\noPitchOp,
\\pitchOp_1_interval, 0,
\\pitchOp_1_amount, 0.1,

\\pitchOpType_2, \\noPitchOp,
\\pitchOp_2_interval, 12,
\\pitchOp_2_amount, 0.1,

// %

// the buffers have to be EXISTING audio buffers. If they return nil there will be no sound without an ERROR.
// the buffers for the granulator have to be ONE CHANNEL. If they contain more than one channel there will be no sound without an ERROR.

\\oscillatorType, \\basic,
\\oscillator_1_mod_1, 0.45,
\\oscillator_1_mod_2, 0.001,
\\oscillator_1_mod_3, 0,
\\oscillator_1_mod_4, 0,
\\oscillator_1_buffer, ~beatRepeatBuffer_1,
\\oscillator_1_bufferPos, ~beatRepeatBufferPosition_1,
\\oscillator_1_level, 1,
\\oscillator_1_transpose, 0,

\\oscillatorType_2, \\noOscillator,
\\oscillator_2_mod_1, 0.15,
\\oscillator_2_mod_2, 0.01,
\\oscillator_2_mod_3, 0,
\\oscillator_2_mod_4, 0,
\\oscillator_2_buffer, ~beatRepeatBuffer_1,
\\oscillator_2_bufferPos, ~beatRepeatBufferPosition_1,
\\oscillator_2_level, 1,
\\oscillator_1_transpose, -12,

// %

\\fxType, \\noFx,
\\fx_1_input_gain, 1,
\\fx_1_mod_1, 0.25,
\\fx_1_mod_2, 0.25,

\\fxType_2, \\noFx,
\\fx_2_mod_1, 0.25,
\\fx_2_mod_2, 0.25,

// %

\\filterIn_preFxLevel, 0,
\\filterIn_FxLevel, 1,

\\filterType, \\noFilter,
\\filter_1_mod_1, 1,
\\filter_1_mod_2, 0.25,

\\filterType_2, \\noFilter,
\\filter_2_mod_1, 1,
\\filter_2_mod_2, 0.25,

\\vca_filterLevel, 1,
\\vca_preFilterLevel, 0,
\\vca_preFxLevel, 0,

\\vol, 1,
\\amp, 0.2,

// the sends have to be EXISTING audio busses. If they return nil there will be no sound without an ERROR.

\\out, ~melody_bus,
\\send_1, ~ef_reverb,
\\send_1_level, 0.25,
\\send_2, ~simpleDelay,
\\send_2_level, 0,
\\send_3, ~granulator_1,
\\send_3_level, 0,
\\send_4, ~beatRepeat_1,
\\send_4_level, 0,

// %

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

//external targets you want to declare in a Pattern have to be chained before the preset Pdef(preset) <> Pbind(\external1Target, \"filter_1_mod_1\") for example. If they are declared in the chain, they can't be present in the instrumentPreset, otherwise you will get an ERROR.

//\\external1Target, \"\",
\\external1Amount, 1,
//\\external1Target2, \"\",
\\external1Amount2, 1,
\\external1min, -1,
\\external1max, 1,

//\\external2Target, \"\",
\\external2Amount, 1,
//\\external2Target2, \"\",
\\external2Amount2, 1,
\\external2min, -1,
\\external2max, 1,

//\\external3Target, \"\",
\\external3Amount, 1,
//\\external3Target2, \"\",
\\external3Amount2, 1,
\\external3min, -1,
\\external3max, 1,

//\\external4Target, \"\",
\\external4Amount, 1,
//\\external4Target2, \"\",
\\external4Amount2, 1,
\\external4min, -1,
\\external4max, 1,

//\\pattern1Target, \"\",
\\pattern1Amount, 1,
//\\pattern2Target, \"\",
\\pattern2Amount, 1,
//\\pattern3Target, \"\",
\\pattern3Amount, 1,
//\\pattern4Target, \"\",
\\pattern4Amount, 1,

];
~callInstrumentPreset.(%);
)".format(name.asCompileString, ~adsrTypes.keys.asArray.flat, ~pitchOpTypes.keys.asArray.flat, ~oscillatorTypes.keys.asArray.flat, ~fxTypes.keys.asArray.flat, ~filterTypes.keys.asArray.flat, ~modSources.keys.asArray.flat, name.asCompileString);
	},



	default_d: { |self, name|
		"(
~instrumentPresetsDictionary[%] = [
// %

\\adsrType, \\pluck,
\\sendGate, false,
\\envelope_mod, 0.5,
\\envCurve, 3,

// %

\\pitchOpType, \\noPitchOp,
\\pitchOp_1_interval, 0,
\\pitchOp_1_amount, 0.1,

\\pitchOpType_2, \\noPitchOp,
\\pitchOp_2_interval, 12,
\\pitchOp_2_amount, 0.1,

// %

\\drumType, \\bodyTimbreTransientTail,
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

// %

\\fxType, \\noFx,
\\fx_1_input_gain, 1,
\\fx_1_mod_1, 0.25,
\\fx_1_mod_2, 0.25,

\\fxType_2, \\noFx,
\\fx_2_mod_1, 0.25,
\\fx_2_mod_2, 0.25,

// %

\\filterIn_preFxLevel, 0,
\\filterIn_FxLevel, 1,

\\filterType, \\noFilter,
\\filter_1_mod_1, 1,
\\filter_1_mod_2, 0.25,

\\filterType_2, \\noFilter,
\\filter_2_mod_1, 1,
\\filter_2_mod_2, 0.25,

\\vca_filterLevel, 1,
\\vca_preFilterLevel, 0,
\\vca_preFxLevel, 0,

\\vol, 1,
\\amp, 0.2,

// the sends have to be EXISTING audio busses. If they return nil there will be no sound without an ERROR.

\\out, ~melody_bus,
\\send_1, ~ef_reverb,
\\send_1_level, 0.25,
\\send_2, ~simpleDelay,
\\send_2_level, 0,
\\send_3, ~granulator_1,
\\send_3_level, 0,
\\send_4, ~beatRepeat_1,
\\send_4_level, 0,

// %

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

//external targets you want to declare in a Pattern have to be chained before the preset Pdef(preset) <> Pbind(\external1Target, \"filter_1_mod_1\") for example. If they are declared in the chain, they can't be present in the instrumentPreset, otherwise you will get an ERROR.

//\\external1Target, \"\",
\\external1Amount, 1,
//\\external1Target2, \"\",
\\external1Amount2, 1,
\\external1min, -1,
\\external1max, 1,

//\\external2Target, \"\",
\\external2Amount, 1,
//\\external2Target2, \"\",
\\external2Amount2, 1,
\\external2min, -1,
\\external2max, 1,

//\\external3Target, \"\",
\\external3Amount, 1,
//\\external3Target2, \"\",
\\external3Amount2, 1,
\\external3min, -1,
\\external3max, 1,

//\\external4Target, \"\",
\\external4Amount, 1,
//\\external4Target2, \"\",
\\external4Amount2, 1,
\\external4min, -1,
\\external4max, 1,

//\\pattern1Target, \"\",
\\pattern1Amount, 1,
//\\pattern2Target, \"\",
\\pattern2Amount, 1,
//\\pattern3Target, \"\",
\\pattern3Amount, 1,
//\\pattern4Target, \"\",
\\pattern4Amount, 1,

];
~callInstrumentPreset.(%);
)".format(name.asCompileString, ~adsrTypes.keys.asArray.flat, ~pitchOpTypes.keys.asArray.flat, ~drumTypes.keys.asArray.flat, ~fxTypes.keys.asArray.flat, ~filterTypes.keys.asArray.flat, ~modSources.keys.asArray.flat, name.asCompileString);
	},
);

//~instrPreset.create(\blaaaaa)
