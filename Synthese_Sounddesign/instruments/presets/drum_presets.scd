(
~callDrumPreset = {
	arg instrName;
	Pdef(instrName).clear;
	Pdef(instrName,
		Pbind(
			\instrument, Pfunc {|ev| ~makeModularDrum.(ev.drumType, ev.fx, ev.filter).asSymbol},
			\group, Pfunc {~source_group}
		) <> ~drumPresetsDictionary[instrName]
	)
};
);

"call drum preset function loaded".postln;

~editDrum = {
	arg instrName;
	var env = ~drumPresetsDictionary[instrName];
	var txt = "";
	env.asSortedArray.do { |arr|
		txt = txt ++ "~% = %;\n".format(arr[0], arr[1].asCompileString)
	};
	Document.new(instrName.asString ++ "_temp", txt, env);
};


"edit preset function loaded".postln;

~instrumentPresetsDictionary[\bd1] = PbindProxy.new;
(
~instrumentPresetsDictionary[\bd1].set(
	\octave, 3,
	\drumType, \bodyTimbreTransientTail,
	\fx, \noFx,
	\filter, \noFilter,
	\type, \on,
	\controlbus, ~launchcontrol_xl_row_1,
	\out, ~drums_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0,
	\timbre_ratio, 0.4,
	\body_sweep_ratio, 1,
	\timbre_sweep_ratio, 1,
	\body_time, 0.6,
	\timbre_time, 0.4,
	\transient_time, 0,
	\tail_time, 0.15,
	\body_vol, 1,
	\timbre_vol, 0.6,
	\transient_vol, 0.25,
	\fx_mod_1, 0,
	\tail_vol, 0,
	\time_factor, 0.25,
	\punch_factor, 2,
	\fx_mod_1, 0,
	\fx_mod_2, 0,
	\filter_mod_1, 0,
	\filter_mod_2, 0,
	\vol, 1,
	\time_factor_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\bdThump] = PbindProxy.new;
(
~instrumentPresetsDictionary[\bdThump].set(
	\octave, 2,
	\drumType, \fmTransientTail,
	\fx, \shelvedOverdriveSoft,
	\filter, \lpf_24,
	\type, \on,
	\controlbus, ~launchcontrol_xl_row_1,
	\out, ~drums_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0,
	\timbre_ratio,1,
	\body_sweep_ratio, 1,
	\timbre_sweep_ratio, 1,
	\body_time, 0.1,
	\timbre_time, 0.1,
	\transient_time, 0.7,
	\tail_time, 0.2,
	\body_vol, 1,
	\timbre_vol, 0.57,
	\transient_vol, 0.2,
	\tail_vol, 0,
	\time_factor, 1,
	\punch_factor, 1,
	\fx_mod_1, 0.2,
	\fx_mod_2, 0.1,
	\filter_mod_1, 0.65,
	\filter_mod_2, 0.4,
	\vol, 0.9,
	\time_factor_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\sd1] = PbindProxy.new;
(
~instrumentPresetsDictionary[\sd1].set(
	\octave, 4,
	\drumType, \bodyTimbreTransientTail,
	\fx, \shelvedOverdriveSoft,
	\filter, \noFilter,
	\type, \on,
	\controlbus, ~launchcontrol_xl_row_1,
	\out, ~drums_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0,
	\timbre_ratio, 0.4,
	\body_sweep_ratio, 1,
	\timbre_sweep_ratio, 1,
	\body_time, 0.75,
	\timbre_time, 0.75,
	\transient_time, 0.5,
	\tail_time, 1,
	\body_vol, 1,
	\timbre_vol, 0.45,
	\transient_vol, 1,
	\tail_vol, 0.5,
	\time_factor, 0.01,
	\punch_factor, 6,
	\fx_mod_1, 0.2,
	\fx_mod_2, 0.7,
	\filter_mod_1, 0,
	\filter_mod_2, 0,
	\vol, 0.65,
	\time_factor_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\sd2] = PbindProxy.new;
(
~instrumentPresetsDictionary[\sd2].set(
	\octave, 5,
	\drumType, \fmTransientTail,
	\fx, \sampleRateReduction,
	\filter, \noFilter,
	\type, \on,
	\controlbus, ~launchcontrol_xl_row_1,
	\out, ~drums_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0,
	\timbre_ratio, 0.45,
	\body_sweep_ratio, 1,
	\timbre_sweep_ratio, 0.25,
	\body_time, 0.5,
	\timbre_time, 0.5,
	\transient_time, 0.15,
	\tail_time, 0.75,
	\body_vol, 1,
	\timbre_vol, 0.25,
	\transient_vol, 1,
	\tail_vol, 0.65,
	\time_factor, 0.01,
	\punch_factor, 2,
	\fx_mod_1, 1,
	\fx_mod_2, 0.7,
	\filter_mod_1, 0,
	\filter_mod_2, 0,
	\vol, 1,
	\time_factor_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\hh1] = PbindProxy.new;
(
~instrumentPresetsDictionary[\hh1].set(
	\octave, 8,
	\drumType, \bodyTimbreTransientTail,
	\fx, \noFx,
	\filter, \noFilter,
	\type, \on,
	\controlbus, ~launchcontrol_xl_row_1,
	\out, ~drums_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0,
	\timbre_ratio, 0.05,
	\body_sweep_ratio, 1,
	\timbre_sweep_ratio, 1,
	\body_time, 0.5,
	\timbre_time, 0.4,
	\transient_time, 0.5,
	\tail_time, 0.5,
	\body_vol, 0.21,
	\timbre_vol, 0.6,
	\transient_vol, 0.75,
	\tail_vol, 1,
	\time_factor, 0.25,
	\punch_factor, 2,
	\fx_mod_1, 1,
	\fx_mod_2, 0.7,
	\filter_mod_1, 0,
	\filter_mod_2, 0,
	\vol, 1,
	\time_factor_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\hh2] = PbindProxy.new;
(
~instrumentPresetsDictionary[\hh2].set(
	\octave, 7,
	\drumType, \fmTransientTail,
	\fx, \noFx,
	\filter, \noFilter,
	\type, \on,
	\controlbus, ~launchcontrol_xl_row_1,
	\out, ~drums_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0,
	\timbre_ratio, 0.25,
	\body_sweep_ratio, 1,
	\timbre_sweep_ratio, 1,
	\body_time, 0.5,
	\timbre_time, 0.4,
	\transient_time, 0.5,
	\tail_time, 0.5,
	\body_vol, 0.21,
	\timbre_vol, 0.6,
	\transient_vol, 0.75,
	\tail_vol, 1,
	\time_factor, 0.25,
	\punch_factor, 5,
	\fx_mod_1, 1,
	\fx_mod_2, 0.7,
	\filter_mod_1, 0,
	\filter_mod_2, 0,
	\vol, 1,
	\time_factor_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\bongo_1] = PbindProxy.new;
(
~instrumentPresetsDictionary[\bongo_1].set(
	\octave, 5,
	\drumType, \fmTransientTail,
	\fx, \sampleRateReduction,
	\filter, \noFilter,
	\type, \on,
	\controlbus, ~launchcontrol_xl_row_1,
	\out, ~drums_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0,
	\timbre_ratio, 0.45,
	\body_sweep_ratio, 1,
	\timbre_sweep_ratio, 0.25,
	\body_time, 0.5,
	\timbre_time, 1,
	\transient_time, 0.15,
	\tail_time, 0.75,
	\body_vol, 1,
	\timbre_vol, 1,
	\transient_vol, 1,
	\tail_vol, 0,
	\time_factor, 0.01,
	\punch_factor, 2,
	\fx_mod_1, 1,
	\fx_mod_2, 0.7,
	\filter_mod_1, 0,
	\filter_mod_2, 0,
	\vol, 1,
	\time_factor_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\vol_macro_channel, 0,
);
);


~drumPresetsDictionary.keys.do {|k| ~callDrumPreset.(k.post); " ".post;};

"\ndrum presets loaded".postln;

