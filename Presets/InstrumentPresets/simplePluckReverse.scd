(
~instrumentPresetsDictionary[\simplePluckReverse] = [
	\adsrType, \sync,
	\sendGate, false,
	\pitchOpType, \slide,
	\oscillatorType, \fm,
	\oscillatorType_2, \fm,
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
	\controlbus, ~launchcontrol_xl_row_4,
	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.5,

	\pitchOp_1_interval, 0.55,
	\pitchOp_1_amount, 0.5,

	\oscillator_mod_1, 0.45,
	\oscillator_mod_2, 0.001,

	\oscillator_2_mod_1, 0.15,
	\oscillator_2_mod_2, 0.01,

	\fx_mod_1, 1,
	\fx_mod_2, 1,

	\filter_mod_1, 0.75,
	\filter_mod_2, 0.4,

	\envelope_mod, 1,
	\envCurve, 4,

	\vol, 1,
	\amp, 0.2,
];
~callInstrumentPreset.(\simplePluckReverse);
)