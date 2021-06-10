(
~instrumentPresetsDictionary['jitter_lead'] = [
// [ rect, pluck, pluckStop, noEnv, pad, lead, sync ]

\adsrType, \lead,
\sendGate, true,
\envelope_mod, 0.5,
\envCurve, 3,

// [ fm, noPitchOp, unisonoDetune, vibrato, rectArp, rectArpSync, slide, vibratoSync ]

\pitchOpType, \vibrato,
\pitchOp_1_interval, 0.15,
\pitchOp_1_amount, 0.01,

\pitchOpType_2, \slide,
\pitchOp_2_interval, -0.2,
\pitchOp_2_amount, 0.1,

// [ modal, ping, beatRepeat, filteredNoise, crackles, fm, granulator, formant, noOscillator, fmScaled, basic, pulsar ]

// the buffers have to be EXISTING audio buffers. If they return nil there will be no sound without an ERROR.
// the buffers for the granulator have to be ONE CHANNEL. If they contain more than one channel there will be no sound without an ERROR.

\oscillatorType, \fm,
\oscillator_1_mod_1, 1,
\oscillator_1_mod_2, 1,
\oscillator_1_mod_3, 0,
\oscillator_1_mod_4, 0,
\oscillator_1_buffer, ~beatRepeatBuffer_1,
\oscillator_1_bufferPos, ~beatRepeatBufferPosition_1,
\oscillator_1_level, 1,
\oscillator_1_transpose, 0,

\oscillatorType_2, \filteredNoise,
\oscillator_2_mod_1, 0.01,
\oscillator_2_mod_2, 0,
\oscillator_2_mod_3, 0,
\oscillator_2_mod_4, 0,
\oscillator_2_buffer, ~beatRepeatBuffer_1,
\oscillator_2_bufferPos, ~beatRepeatBufferPosition_1,
\oscillator_2_level, 2,
\oscillator_2_transpose, 12,

// [ combfilter, tremoloRamp, tremoloRect, overdriveHard, overdriveSoft, overdriveMid, shelvedOverdriveMid, bitcrush, noFx, wrap, sampleRateReduction, combfilterScaled, shelvedOverdriveHard, rectifier, tremoloSine, fold, shelvedOverdriveSoft ]

\fxType, \sampleRateReduction,
\fx_1_input_gain, 1,
\fx_1_mod_1, 0.5,
\fx_1_mod_2, 0.3,

\fxType_2, \combfilterScaled,
\fx_2_mod_1, 1.985,
\fx_2_mod_2, 0.1,

// [ lpf_24, bpf, hpf_12, lo_shelf, lpf_12, lpf_moog, notch, hi_shelf, hpf_24, noFilter ]

\filterIn_preFxLevel, 0.5,
\filterIn_FxLevel, 0.5,

\filterType, \lpf_moog,
\filter_1_mod_1, 1,
\filter_1_mod_2, 0.03,

\filterType_2, \hpf_12,
\filter_2_mod_1, 0,
\filter_2_mod_2, 0.125,

\vca_filterLevel, 1,
\vca_preFilterLevel, 0,
\vca_preFxLevel, 0,

\vol, 1,
\amp, 0.19,

// the sends have to be EXISTING audio busses. If they return nil there will be no sound without an ERROR.

\out, ~melody_bus,
\send_1, ~ef_reverb,
\send_1_level, 0.25,
\send_2, ~simpleDelay,
\send_2_level, 0,
\send_3, ~granulator_1,
\send_3_level, 0,
\send_4, ~beatRepeat_1,
\send_4_level, 0,

// [ sineLFO, noMod, rampLFO, noise, rampSyncLFO, sampleAndHold, triSyncLFO, triLFO, sawLFO, sawSyncLFO, rectSyncLFO, rectLFO, syncEnv, sineSyncLFO, adsrEnv ]

/*	// \mod1Type, \sampleAndHold,
	// \mod1Target, "fx_1_mod_1",
\mod1Amount, 0.05,
\mod1Rate, 0.25,
\mod1attack, 1,
\mod1decay, 1,
\mod1sustain, 0.5,
\mod1release, 1,
\mod1EnvCurve, 2,
\mod1syncEnvRatio, 0,


	// \mod2Type, \noMod,
	// \mod2Target, "",
\mod2Amount, 0.25,
\mod2Rate, 0.25,
\mod2attack, 1,
\mod2decay, 1,
\mod2sustain, 0.5,
\mod2release, 1,
\mod2EnvCurve, 2,
\mod2syncEnvRatio, 0,

	// \mod3Type, \noMod,
	// \mod3Target, "",
\mod3Amount, 0.25,
\mod3Rate, 0.25,
\mod3attack, 1,
\mod3decay, 1,
\mod3sustain, 0.5,
\mod3release, 1,
\mod3EnvCurve, 2,
\mod3syncEnvRatio, 0,

	// \mod4Type, \noMod,
	// \mod4Target, "",
\mod4Amount, 0.25,
\mod4Rate, 0.25,
\mod4attack, 1,
\mod4decay, 1,
\mod4sustain, 0.5,
\mod4release, 1,
\mod4EnvCurve, 2,
\mod4syncEnvRatio, 0,*/

//external targets you want to declare in a Pattern have to be chained before the preset Pdef(preset) <> Pbind(external1Target, "filter_1_mod_1") for example. If they are declared in the chain, they can't be present in the instrumentPreset, otherwise you will get an ERROR.
/*
//\external1Target, "",
\external1Amount, 1,
//\external1Target2, "",
\external1Amount2, 1,
\external1min, -1,
\external1max, 1,

//\external2Target, "",
\external2Amount, 1,
//\external2Target2, "",
\external2Amount2, 1,
\external2min, -1,
\external2max, 1,

//\external3Target, "",
\external3Amount, 1,
//\external3Target2, "",
\external3Amount2, 1,
\external3min, -1,
\external3max, 1,

//\external4Target, "",
\external4Amount, 1,
//\external4Target2, "",
\external4Amount2, 1,
\external4min, -1,
\external4max, 1,

	*/
//\pattern1Target, "",
\pattern1Amount, 1,
//\pattern2Target, "",
\pattern2Amount, 1,
//\pattern3Target, "",
\pattern3Amount, 1,
//\pattern4Target, "",
\pattern4Amount, 1,

];
~callInstrumentPreset.('jitter_lead');
)