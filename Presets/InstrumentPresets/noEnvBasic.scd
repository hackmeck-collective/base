(
~instrumentPresetsDictionary['noEnvBasic'] = [

\pitchOpType, \noPitchOp, // \noPitchOp, \vibrato, \slide, \unisonoDetune, \fm, \vibratoSync, \slideVibrato, \rectArpSync, \rectArp
\pitchOp_1_interval, 0,
\pitchOp_1_amount, 0.1,

\pitchOpType, \noPitchOp,
\pitchOp_2_interval, 12,
\pitchOp_2_amount, 0.1,

\oscillatorType, \basic, // \noOscillator, \basic, \fm, \formant, \filteredNoise, \modal, \pulsar, \ping, \grainCloudGuitar
\oscillator_mod_1, 0.5,
\oscillator_mod_2, 0.5,
\oscillator_1_level, 1,
\oscillator_1_transpose, 0,

\oscillatorType_2, \noOscillator,
\oscillator_2_mod_1, 0.15,
\oscillator_2_mod_2, 0.01,
\oscillator_2_level, 1,
\oscillator_2_transpose, -12,

// \noFx,
// \overdriveSoft, \overdriveMid, \overdriveHard,
// \shelvedOverdriveSoft, \shelvedOverdriveMid, \shelvedOverdriveHard,
// \sampleRateReduction, \fold, \wrap, \rectifier,
// \tremoloRect, \tremoloSine, \tremoloRamp,

\fxType, \noFx,
\fx_1_input_gain, 1,
\fx_mod_1, 0.25,
\fx_mod_2, 0.25,

\fxType_2, \noFx,
\fx_2_mod_1, 0.25,
\fx_2_mod_2, 0.25,


\filterType, \lpf_moog, // \noFilter, \lpf_moog, \lpf_24, \lpf_12, \hpf_24, \hpf_12, \bpf, \notch, \lo_shelf, \hi_shelf,
\filter_1_mod_1, 0.5,
\filter_1_mod_2, 0,

\filterType_2, \noFilter,
\filter_2_mod_1, 1,
\filter_2_mod_2, 0.25,

\vol, 1,
\amp, 0.2,

\out, ~melody_bus,
\send_1, ~ef_reverb,
\send_1_level, 0.25,
\send_2, ~simpleDelay_8d,
\send_2_level, 0,

\mod1Type, \sampleAndHold,
\mod1Target, "oscillator_mod_1",
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
\mod2Target, "oscillator_mod_2",
\mod2Amount, 0.3,
\mod2Rate, 0.25,
\mod2attack, 1,
\mod2decay, 1,
\mod2sustain, 0.5,
\mod2release, 1,
\mod2EnvCurve, 2,
\mod2syncEnvRatio, 0,
\mod2ControlbusChannel, 1,

\mod3Type, \noMod,
\mod3Target, "",
\mod3Amount, 1,
\mod3Rate, 0.25,
\mod3attack, 1,
\mod3decay, 1,
\mod3sustain, 0.5,
\mod3release, 1,
\mod3EnvCurve, 2,
\mod3syncEnvRatio, 0,
\mod3ControlbusChannel, 2,

\mod4Type, \noMod,
\mod4Target, "",
\mod4Amount, 1,
\mod4Rate, 0.25,
\mod4attack, 1,
\mod4decay, 1,
\mod4sustain, 0.5,
\mod4release, 1,
\mod4EnvCurve, 2,
\mod4syncEnvRatio, 0,
\mod4ControlbusChannel, 3,

\external1Target, "oscillator_mod_1",
\external1Amount, 2,
\external2Target, "",
\external2Amount, 1,
\external3Target, "",
\external3Amount, 1,
\external4Target, "",
\external4Amount, 1,
\external1Target2, "oscillator_mod_2",
\external1Amount2, 2,
\external2Target2, "",
\external2Amount2, 1,
\external3Target2, "",
\external3Amount2, 1,
\external4Target2, "",
\external4Amount2, 1,


\pattern1Target, "",
\pattern1Amount, 1,
\pattern2Target, "",
\pattern2Amount, 1,
\pattern3Target, "",
\pattern3Amount, 1,
\pattern4Target, "",
\pattern4Amount, 1,
];
~callInstrumentPreset.('noEnvBasic');
)