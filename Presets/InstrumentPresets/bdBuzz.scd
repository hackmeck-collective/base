(
~instrumentPresetsDictionary['bdBuzz'] = [
	// [ rect, pluck, pluckStop, noEnv, pad, lead, sync ]

	\adsrType, \pluck,
	\sendGate, false,
	\envelope_mod, 0.15,
	\envCurve, 10,

	// [ fm, noPitchOp, unisonoDetune, vibrato, rectArp, rectArpSync, slide, vibratoSync ]

	\pitchOpType, \slide,
	\pitchOp_1_interval, 36,
	\pitchOp_1_amount, 0.05,

	\pitchOpType_2, \noPitchOp,
	\pitchOp_2_interval, 12,
	\pitchOp_2_amount, 0.1,

	// [ modal, ping, beatRepeat, filteredNoise, crackles, fm, granulator, formant, noOscillator, fmScaled, basic, pulsar ]

	// the buffers have to be EXISTING audio buffers. If they return nil there will be no sound without an ERROR.
	// the buffers for the granulator have to be ONE CHANNEL. If they contain more than one channel there will be no sound without an ERROR.

	\oscillatorType, \basic,
	\oscillator_1_mod_1, 0.45,
	\oscillator_1_mod_2, 0.3,
	\oscillator_1_mod_3, 0,
	\oscillator_1_mod_4, 0,
	\oscillator_1_buffer, ~beatRepeatBuffer_1,
	\oscillator_1_bufferPos, ~beatRepeatBufferPosition_1,
	\oscillator_1_level, 1,
	\oscillator_1_transpose, -36,

	\oscillatorType_2, \fm,
	\oscillator_2_mod_1, 4,
	\oscillator_2_mod_2, 0.3,
	\oscillator_2_mod_3, 0,
	\oscillator_2_mod_4, 0,
	\oscillator_2_buffer, ~beatRepeatBuffer_1,
	\oscillator_2_bufferPos, ~beatRepeatBufferPosition_1,
	\oscillator_2_level, 0.5,
	\oscillator_1_transpose, -12,

	// [ bodyTimbreTransientTail, noDrum, fmTransientTail, noiseFmTransientTail, amTransientTail ]

	\drumType, \noDrum,
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
	\drum_1_level, 1,

	\drumType_2, \noDrum,
	\timbre_ratio_2, 0.45,
	\body_sweep_ratio_2, 1,
	\timbre_sweep_ratio_2, 0.25,
	\body_time_2, 0.5,
	\timbre_time_2, 0.5,
	\transient_time_2, 0.15,
	\tail_time_2, 0.75,
	\body_vol_2, 1,
	\timbre_vol_2, 0.25,
	\transient_vol_2, 1,
	\tail_vol_2, 0.65,
	\time_factor_2, 0.01,
	\punch_factor_2, 2,
	\drum_2_level, 1,

	// [ combfilter, tremoloRamp, tremoloRect, overdriveHard, overdriveSoft, overdriveMid, shelvedOverdriveMid, bitcrush, noFx, wrap, sampleRateReduction, combfilterScaled, shelvedOverdriveHard, rectifier, tremoloSine, fold, shelvedOverdriveSoft ]


	\fxType, \overdriveSoft,
	\fx_1_input_gain, 1,
	\fx_1_mod_1, 0.25,
	\fx_1_mod_2, 0.25,

	\fxType_2, \noFx,
	\fx_2_mod_1, 0.25,
	\fx_2_mod_2, 0.25,

	// [ lpf_24, bpf, hpf_12, lo_shelf, lpf_12, lpf_moog, notch, hi_shelf, hpf_24, noFilter ]

	\filterIn_preFxLevel, 0,
	\filterIn_FxLevel, 1,

	\filterType, \lpf_12,
	\filter_1_mod_1, 1.2,
	\filter_1_mod_2, 0,

	\filterType_2, \noFilter,
	\filter_2_mod_1, 1,
	\filter_2_mod_2, 0.25,

	\vca_filterLevel, 1,
	\vca_preFilterLevel, 0,
	\vca_preFxLevel, 0,

	\vol, 1,
	\amp, 0.2,

	// the sends have to be EXISTING audio busses. If they return nil there will be no sound without an ERROR.

	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.05,
	\send_2, ~simpleDelay,
	\send_2_level, 0,
	\send_3, ~granulator_1,
	\send_3_level, 0,
	\send_4, ~beatRepeat_1,
	\send_4_level, 0,

	// [ sineLFO, noMod, rampLFO, noise, rampSyncLFO, sampleAndHold, triSyncLFO, triLFO, sawLFO, sawSyncLFO, rectSyncLFO, rectLFO, syncEnv, sineSyncLFO, adsrEnv ]

	\mod1Type, \sampleAndHold,
	\mod1Target, "fx_2_mod_1",
	\mod1Amount, 0.2,
	\mod1Rate, 0.25,
	\mod1attack, 1,
	\mod1decay, 1,
	\mod1sustain, 0.5,
	\mod1release, 1,
	\mod1EnvCurve, 2,
	\mod1syncEnvRatio, 0,
	\mod1ControlbusChannel, 0,

	\mod2Type, \sampleAndHold,
	\mod2Target, "fx_1_mod_1",
	\mod2Amount, 0.1,
	\mod2Rate, 0.25,
	\mod2attack, 1,
	\mod2decay, 1,
	\mod2sustain, 0.5,
	\mod2release, 1,
	\mod2EnvCurve, 2,
	\mod2syncEnvRatio, 0,
	\mod2ControlbusChannel, 1,

	\mod3Type, \sampleAndHold,
	\mod3Target, "filter_1_mod_1",
	\mod3Amount, 0.2,
	\mod3Rate, 0.25,
	\mod3attack, 1,
	\mod3decay, 1,
	\mod3sustain, 0.5,
	\mod3release, 1,
	\mod3EnvCurve, 2,
	\mod3syncEnvRatio, 0,
	\mod3ControlbusChannel, 2,

	\mod4Type, \adsrEnv,
	\mod4Target, "fx_1_mod_1",
	\mod4Amount, 1,
	\mod4Rate, 0.25,
	\mod4attack, 0.01,
	\mod4decay, 0.1,
	\mod4sustain, 0,
	\mod4release, 0.3,
	\mod4EnvCurve, 2,
	\mod4syncEnvRatio, 0,
	\mod4ControlbusChannel, 3,

	//external targets you want to declare in a Pattern have to be chained before the preset Pdef(preset) <> Pbind(external1Target, "filter_1_mod_1") for example. If they are declared in the chain, they can't be present in the instrumentPreset, otherwise you will get an ERROR.

	\controlbus1, ~dummybus,
	//\external1Target, "",
	\external1Amount, 1,
	//\external1Target2, "",
	\external1Amount2, 1,
	\external1min, -1,
	\external1max, 1,

	\controlbus2, ~dummybus,
	//\external2Target, "",
	\external2Amount, 1,
	//\external2Target2, "",
	\external2Amount2, 1,
	\external2min, -1,
	\external2max, 1,

	\controlbus3, ~dummybus,
	//\external3Target, "",
	\external3Amount, 1,
	//\external3Target2, "",
	\external3Amount2, 1,
	\external3min, -1,
	\external3max, 1,

	\controlbus4, ~dummybus,
	//\external4Target, "",
	\external4Amount, 1,
	//\external4Target2, "",
	\external4Amount2, 1,
	\external4min, -1,
	\external4max, 1,

	//\pattern1Target, "",
	\pattern1Amount, 1,
	//\pattern2Target, "",
	\pattern2Amount, 1,
	//\pattern3Target, "",
	\pattern3Amount, 1,
	//\pattern4Target, "",
	\pattern4Amount, 1,

];
~callInstrumentPreset.('bdBuzz');
)