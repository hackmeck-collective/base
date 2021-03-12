(
~callInstrumentPreset = {
	arg instrName;
	Pbindef(instrName).clear;
	Pdef((instrName.asString ++ "_chain").asSymbol,
		Pbind(
			\instrument, Pfunc {|ev| ~makeModularSynthDef.(ev.adsrType, ev.pitchOp, ev.osc, ev.fx, ev.filter).asSymbol},
			\group, Pfunc {~source_group}
		) <> ~instrumentPresetsDictionary[instrName] <> Pbindef(instrName);
	)
};
);

"call instrument preset function loaded".postln;

~editInst = {
	arg instrName;
	var env = ~instrumentPresetsDictionary[instrName];
	var txt = "";
	env.asSortedArray.do { |arr|
		txt = txt ++ "~% = %;\n".format(arr[0], arr[1].asCompileString)
	};
	Document.new(instrName.asString ++ "_temp", txt, env);
};

"edit preset function loaded".postln;

////////////////// PLUCKS

~instrumentPresetsDictionary[\simplePluck] = PbindProxy();
(
~instrumentPresetsDictionary[\simplePluck].set(
	\adsrType, \pluck,
	\sendGate, false,
	\pitchOp, \slide,
	\osc, \fm,
	\fx, \noFx,
	\filter, \noFilter,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.25,
	\pitchOp_mod_1, 0.55,
	\pitchOp_mod_2, 0.1,
	\oscillator_mod_1, 0.45,
	\oscillator_mod_2, 0,
	\fx_mod_1, 1,
	\fx_mod_2, 1,
	\filter_mod_1, 0.75,
	\filter_mod_2, 0.4,
	\envelope_mod, 0.7,
	\vol, 1,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\simplePluckReverse] = PbindProxy();
(
~instrumentPresetsDictionary[\simplePluckReverse].set(
	\adsrType, \sync,
	\sendGate, false,
	\pitchOp, \slide,
	\osc, \fm,
	\fx, \noFx,
	\filter, \noFilter,
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.5,
	\pitchOp_mod_1, 0.55,
	\pitchOp_mod_2, 0.5,
	\oscillator_mod_1, 0.45,
	\oscillator_mod_2, Pseq([0.2,0],inf),
	\fx_mod_1, 1,
	\fx_mod_2, 1,
	\filter_mod_1, 0.75,
	\filter_mod_2, 0.4,
	\envelope_mod, 1,
	\envCurve, 3,
	\vol, 1,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\srrPluck] = PbindProxy();
(
~instrumentPresetsDictionary[\srrPluck].set(
	\adsrType, \pluck,
	\sendGate, false,
	\pitchOp, \slide,
	\osc, \fm,
	\fx, \sampleRateReduction,
	\filter, \noFilter,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.75,
	\pitchOp_mod_1, 0.75,
	\pitchOp_mod_2, 0.1,
	\oscillator_mod_1, 0.45,
	\oscillator_mod_2, 0,
	\fx_mod_1, 0.7,
	\fx_mod_2, 1,
	\filter_mod_1, 1,
	\filter_mod_2, 0,
	\envelope_mod, 0.5,
	\vol, 0.75,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\blip] = PbindProxy();
(
~instrumentPresetsDictionary[\blip].set(
	\adsrType, \pluck,
	\sendGate, false,
	\pitchOp, \unisonoDetune,
	\osc, \formant,
	\fx, \overdriveMid,
	\filter, \noFilter,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.1,
	\pitchOp_mod_1, 0.55,
	\pitchOp_mod_2, 0.35,
	\oscillator_mod_1, 0.05,
	\oscillator_mod_2, 0.2,
	\fx_mod_1, 0.2,
	\fx_mod_2, 0.2,
	\filter_mod_1, 1,
	\filter_mod_2, 0,
	\envelope_mod, 0.01,
	\vol, 0.75,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\noisyPluck] = PbindProxy();
(
~instrumentPresetsDictionary[\noisyPluck].set(
	\adsrType, \pluck,
	\sendGate, false,
	\pitchOp, \unisonoDetune,
	\osc, \filteredNoise,
	\fx, \shelvedOverdriveSoft,
	\filter, \lpf_moog,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.2,
	\pitchOp_mod_1, 0.5,
	\pitchOp_mod_2, 0.1,
	\oscillator_mod_1, 0.0025,
	\oscillator_mod_2, 0,
	\fx_mod_1, 0.35,
	\fx_mod_2, 0.3,
	\filter_mod_1, 0.15,
	\filter_mod_2, 0.1,
	\envelope_mod, 0.6,
	\vol, 1,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\variedPlucks] = PbindProxy();
(
~instrumentPresetsDictionary[\variedPlucks].set(
	\adsrType, \pluck,
	\sendGate, false,
	\pitchOp, Pseq ([\slide,\vibrato], inf).asStream,
	\osc, Pseq([\fm, \pulsar, \basic], inf).asStream,
	\fx, \shelvedOverdriveSoft,
	\filter, \noFilter,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.5,
	\pitchOp_mod_1, 0.25,
	\pitchOp_mod_2, 0.25,
	\oscillator_mod_1, 0.5,
	\oscillator_mod_2, 0.5,
	\fx_mod_1, 1,
	\fx_mod_2, 1,
	\filter_mod_1, 0,
	\filter_mod_2, 0.5,
	\envelope_mod, 0.3,
	\vol, 0.5,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\detunePluck] = PbindProxy();
(
~instrumentPresetsDictionary[\detunePluck].set(
	\adsrType, \pluck,
	\sendGate, false,
	\pitchOp, \vibrato,
	\osc, \formant,
	\fx, \shelvedOverdriveMid,
	\filter, \lpf_moog,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.9,
	\pitchOp_mod_1, 0.7,
	\pitchOp_mod_2, 0,
	\oscillator_mod_1, 0.35,
	\oscillator_mod_2, 0.25,
	\fx_mod_1, 0.9,
	\fx_mod_2, 0.7,
	\filter_mod_1, 0.7,
	\filter_mod_2, 0.2,
	\envelope_mod, 0.7,
	\vol, 0.75,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\noisyMetalPluck] = PbindProxy();
(
~instrumentPresetsDictionary[\noisyMetalPluck].set(
	\adsrType, \pluck,
	\sendGate, false,
	\pitchOp, \fm,
	\osc, \filteredNoise,
	\fx, \shelvedOverdriveSoft,
	\filter, \hpf_12,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.7,
	\pitchOp_mod_1, 0.35,
	\pitchOp_mod_2, 0.3,
	\oscillator_mod_1, 0.002,
	\oscillator_mod_2, 0,
	\fx_mod_1, 0.5,
	\fx_mod_2, 0.7,
	\filter_mod_1, 0.03,
	\filter_mod_2, 0.6,
	\envelope_mod, 0.6,
	\vol, 1,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

////////////////// LEADS
~instrumentPresetsDictionary[\srrLead] = PbindProxy();
(
~instrumentPresetsDictionary[\srrLead].set(
	\adsrType, \lead,
	\sendGate, false,
	\pitchOp, \unisonoDetune,
	\osc, \fm,
	\fx, \sampleRateReduction,
	\filter, \noFilter,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.2,
	\pitchOp_mod_1, 0.25,
	\pitchOp_mod_2, 0.1,
	\oscillator_mod_1, 0.7,
	\oscillator_mod_2, 0.02,
	\fx_mod_1, 0.5,
	\fx_mod_2, 1,
	\filter_mod_1, 1,
	\filter_mod_2, 0,
	\envelope_mod, 0,
	\vol, 1,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\detuneLead] = PbindProxy();
(
~instrumentPresetsDictionary[\detuneLead].set(
	\adsrType, \lead,
	\sendGate, false,
	\pitchOp, \vibrato,
	\osc, \formant,
	\fx, \shelvedOverdriveMid,
	\filter, \noFilter,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.2,
	\pitchOp_mod_1, 0.6,
	\pitchOp_mod_2, 0,
	\oscillator_mod_1, 0.35,
	\oscillator_mod_2, 0.25,
	\fx_mod_1, 0.9,
	\fx_mod_2, 0.7,
	\filter_mod_1, 1,
	\filter_mod_2, 0,
	\envelope_mod, 0.7,
	\vol, 0.75,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\noisyLead] = PbindProxy();
(
~instrumentPresetsDictionary[\noisyLead].set(
	\adsrType, \lead,
	\sendGate, false,
	\pitchOp, \unisonoDetune,
	\osc, \filteredNoise,
	\fx, \overdriveSoft,
	\filter, \hpf_12,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.3,
	\pitchOp_mod_1, 0.3,
	\pitchOp_mod_2, 0.1,
	\oscillator_mod_1, 0.009,
	\oscillator_mod_2, 0,
	\fx_mod_1, 0.5,
	\fx_mod_2, 0.2,
	\filter_mod_1, 0.03,
	\filter_mod_2, 0.5,
	\envelope_mod, 0.1,
	\vol, 1,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\slideVibratoLead] = PbindProxy();
(
~instrumentPresetsDictionary[\slideVibratoLead].set(
	\adsrType, \lead,
	\sendGate, true,
	\pitchOp, \slideVibrato,
	\osc, \basic,
	\fx, \overdriveSoft,
	\filter, \lpf_moog,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.5,
	\pitchOp_mod_1, 0.25,
	\pitchOp_mod_2, 0.3,
	\oscillator_mod_1, 0.5,
	\oscillator_mod_2, 0.5,
	\fx_mod_1, 1,
	\fx_mod_2, 1,
	\filter_mod_1, 1,
	\filter_mod_2, 0.4,
	\envelope_mod, 0.1,
	\vol, 0.35,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\variedLeads] = PbindProxy();
(
~instrumentPresetsDictionary[\variedLeads].set(
	\adsrType, \lead,
	\pitchOp, \unisonoDetune,
	\osc, \fm,
	\fx, \noFx,
	\filter, \noFilter,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.5,
	\pitchOp_mod_1, 0,
	\pitchOp_mod_2, 0,
	\oscillator_mod_1, 0.5,
	\oscillator_mod_2, 0,
	\fx_mod_1, 1,
	\fx_mod_2, 1,
	\filter_mod_1, 0,
	\filter_mod_2, 0.5,
	\envelope_mod, 0.3,
	\vol, 1,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);


////////////////// BASS

~instrumentPresetsDictionary[\simpleBass] = PbindProxy();
(
~instrumentPresetsDictionary[\simpleBass].set(
	\adsrType, \lead,
	\sendGate, true,
	\pitchOp, \slide,
	\osc, \basic,
	\fx, \shelvedOverdriveSoft,
	\filter, \noFilter,
	\controlbus, ~launchcontrol_xl_row_3,
	\out, ~chords_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.1,
	\pitchOp_mod_1, 1,
	\pitchOp_mod_2, 0.1,
	\oscillator_mod_1, 0.5,
	\oscillator_mod_2, 0.35,
	\fx_mod_1, 0.5,
	\fx_mod_2, 0.2,
	\filter_mod_1, 0,
	\filter_mod_2, 0.5,
	\envelope_mod, 0.1,
	\vol, 0.6,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\arpBass] = PbindProxy();
(
~instrumentPresetsDictionary[\arpBass].set(
	\adsrType, \lead,
	\sendGate, true,
	\pitchOp, \rectArpSync,
	\osc, \basic,
	\fx, \shelvedOverdriveSoft,
	\filter, \noFilter,
	\controlbus, ~launchcontrol_xl_row_3,
	\out, ~chords_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.1,
	\pitchOp_mod_1, 0.5,
	\pitchOp_mod_2, 1/32,
	\oscillator_mod_1, 0.5,
	\oscillator_mod_2, 0.35,
	\fx_mod_1, 0.5,
	\fx_mod_2, 0.2,
	\filter_mod_1, 0,
	\filter_mod_2, 0.5,
	\envelope_mod, 0.1,
	\vol, 0.6,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);



////////////////// PADS

~instrumentPresetsDictionary[\simpleBassPad] = PbindProxy();
(
~instrumentPresetsDictionary[\simpleBassPad].set(
	\adsrType, \pad,
	\sendGate, true,
	\pitchOp, \slide,
	\osc, \basic,
	\fx, \noFx,
	\filter, \noFilter,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~chords_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 1,
	\pitchOp_mod_1, 0.3,
	\pitchOp_mod_2, 0.3,
	\oscillator_mod_1, 0.25,
	\oscillator_mod_2, 0.5,
	\fx_mod_1, 0.1,
	\fx_mod_2, 1,
	\filter_mod_1, 0,
	\filter_mod_2, 0.5,
	\envelope_mod, 0.75,
	\vol, 1,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\srrBassPad] = PbindProxy();
(
~instrumentPresetsDictionary[\srrBassPad].set(
	\adsrType, \pad,
	\sendGate, true,
	\pitchOp, \slide,
	\osc, \basic,
	\fx, \sampleRateReduction,
	\filter, \noFilter,
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~chords_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 1,
	\pitchOp_mod_1, 0.3,
	\pitchOp_mod_2, 0.3,
	\oscillator_mod_1, 0.25,
	\oscillator_mod_2, 0.5,
	\fx_mod_1, 0.1,
	\fx_mod_2, 1,
	\filter_mod_1, 0,
	\filter_mod_2, 0.5,
	\envelope_mod, 0.75,
	\vol, 0.2,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\guitarCloud] = PbindProxy();
(
~instrumentPresetsDictionary[\guitarCloud].set(
	\adsrType, \pad,
	\pitchOp, \unisonoDetune,
	\osc, \grainCloudGuitar,
	\fx, \noFx,
	\filter, \lpf_moog,
	\controlbus, ~launchcontrol_xl_row_6,
	\out, ~chords_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.75,
	\pitchOp_mod_1, 0,
	\pitchOp_mod_2, 0,
	\oscillator_mod_1, 0.5,
	\oscillator_mod_2, 0,
	\fx_mod_1, 0,
	\fx_mod_2, 0,
	\filter_mod_1, 0,
	\filter_mod_2, 0,
	\envelope_mod, 1,
	\vol, 0.4,
	\pitchOp_mod_1_macro_channel, 1,
	\pitchOp_mod_2_macro_channel, 1,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 3,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 4,
);
);

////////////////// FX

~instrumentPresetsDictionary[\noiseSwoosh] = PbindProxy();
(
~instrumentPresetsDictionary[\noiseSwoosh].set(
	\adsrType, \sync,
	\sendGate, false,
	\pitchOp, \slide,
	\osc, \filteredNoise,
	\fx, \noFx,
	\filter, \noFilter,
	\beatDuration, Pfunc { ~linkClock.tempo },
	\envCurve, 10,
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.25,
	\pitchOp_mod_1, 0.55,
	\pitchOp_mod_2, 0.1,
	\oscillator_mod_1, 1,
	\oscillator_mod_2, 0,
	\fx_mod_1, 0,
	\fx_mod_2, 0,
	\filter_mod_1, 0.75,
	\filter_mod_2, 0.4,
	\envelope_mod, 1,
	\envCurve, 3,
	\vol, 1,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\noiseSwoosh25] = PbindProxy();
(
~instrumentPresetsDictionary[\noiseSwoosh25].set(
	\adsrType, \sync,
	\sendGate, false,
	\pitchOp, \slide,
	\osc, \filteredNoise,
	\fx, \noFx,
	\filter, \noFilter,
	\beatDuration, Pfunc { ~linkClock.tempo },
	\envCurve, 10,
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.25,
	\pitchOp_mod_1, 0.55,
	\pitchOp_mod_2, 0.1,
	\oscillator_mod_1, 0.25,
	\oscillator_mod_2, 0,
	\fx_mod_1, 0,
	\fx_mod_2, 0,
	\filter_mod_1, 0.75,
	\filter_mod_2, 0.4,
	\envelope_mod, 1,
	\envCurve, 3,
	\vol, 1,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);

~instrumentPresetsDictionary[\noiseSwoosh100] = PbindProxy();
(
~instrumentPresetsDictionary[\noiseSwoosh100].set(
	\adsrType, \sync,
	\sendGate, false,
	\pitchOp, \slide,
	\osc, \filteredNoise,
	\fx, \noFx,
	\filter, \noFilter,
	\beatDuration, Pfunc { ~linkClock.tempo },
	\envCurve, 10,
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.25,
	\pitchOp_mod_1, 0.55,
	\pitchOp_mod_2, 0.1,
	\oscillator_mod_1, 0,
	\oscillator_mod_2, 0,
	\fx_mod_1, 0,
	\fx_mod_2, 0,
	\filter_mod_1, 0.75,
	\filter_mod_2, 0.4,
	\envelope_mod, 1,
	\envCurve, 3,
	\vol, 1,
	\pitchOp_mod_1_macro_channel, 0,
	\pitchOp_mod_2_macro_channel, 0,
	\oscillator_mod_1_macro_channel, 0,
	\oscillator_mod_2_macro_channel, 0,
	\fx_mod_1_macro_channel, 0,
	\fx_mod_2_macro_channel, 0,
	\filter_mod_1_macro_channel, 0,
	\filter_mod_2_macro_channel, 0,
	\envelope_mod_macro_channel, 0,
	\vol_macro_channel, 0,
);
);


~instrumentPresetsDictionary.keys.do {|k| ~callInstrumentPreset.(k.post); " ".post;};

"\ninstrument presets loaded".postln;

