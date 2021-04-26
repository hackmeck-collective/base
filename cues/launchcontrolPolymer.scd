~launchControlEvents = Dictionary.new;

~launchControlEvents.add(\launchControlXlEvent_1_1 -> {
	Pdef(\drums,
		Ppar([
			( Pdef(\bdThump).collect {|ev| ~scM8.play; ev} <> Pbindef(\root) <> Pbindef(\pulse_2) ),
			( Pdef(\bd1).collect {|ev| ~scM4.play; ev} <> Pbindef(\root) <> Pbindef(\pulse_2) ),
			( Pdef(\sd1)/*.collect {|ev| ~scM8.play; ev}*/ <> Pbindef(\root) <> Pbindef(\pulse_4_ob)),
			( Pdef(\hh1) <> Pbindef(\fifth) <> Pbindef(\pulse_8))
		])
	).quant_(4);
	Pdef(\drums).play(~linkClock, quant: 4);
	"lc1_1".postln;}
);

~launchControlEvents.add(\launchControlXlEvent_1_2 -> {
	Pdef(\drums,
		Ppar([
			( Pdef(\bdThump).collect {|ev| ~scM8.play; ev} <> Pbindef(\root) <> Pbindef(\bd_pattern_8th_rng) ),
			( Pdef(\bd1).collect {|ev| ~scM4.play; ev} <> Pbindef(\root) <> Pbindef(\pulse_2) ),
			( Pdef(\sd1).collect {|ev| ~scM8.play; ev} <> Pbindef(\fifth) <> Pbindef(\sd_pattern_1)),
			( Pdef(\hh1) <> Pbindef(\fifth) <> Pbindef(\pulse_8))
		])
	).quant_(4);
	Pdef(\drums).play(~linkClock, quant: 4);
	"lc1_2".postln;}
);

~launchControlEvents.add(\launchControlXlEvent_1_3 -> {
	Pdef(\drums,
		Ppar([
			( Pdef(\bdThump).collect {|ev| ~scM8.play; ev} <> Pbindef(\root) <> Pbindef(\bd_pattern_8th_rng) ),
			( Pdef(\bd1).collect {|ev| ~scM4.play; ev} <> Pbindef(\root) <> Pbindef(\pulse_2) ),
			( Pdef(\sd1).collect {|ev| ~scM8.play; ev} <> Pbindef(\fifth) <> Pbindef(\sd_pattern_1)),
			( Pdef(\hh1) <> Pbindef(\root) <> Pbindef(\euclidean_8th_rng) ),
			( Pdef(\hh2) <> Pbindef(\root) <> Pbindef(\euclidean_16th_rng) ),
		])
	).quant_(4);
	Pdef(\drums).play(~linkClock, quant: 4);
	"lc1_3".postln;}
);

~launchControlEvents.add(\launchControlXlEvent_1_4 -> {
	Pdef(\drums,
		Ppar([
			( Pdef(\bdThump).collect {|ev| ~scM8.play; ev} <> Pbindef(\root) <> Pbindef(\bd_pattern_8th_rng) ),
			( Pdef(\bd1).collect {|ev| ~scM4.play; ev} <> Pbindef(\root) <> Pbindef(\pulse_2) ),
			( Pdef(\sd1).collect {|ev| ~scM8.play; ev} <> Pbindef(\fifth) <> Pbindef(\sd_pattern_1)),
			( Pdef(\hh1) <> Pbindef(\root) <> Pbindef(\euclidean_8th_rng) ),
			( Pdef(\hh2) <> Pbindef(\root) <> Pbindef(\euclidean_16th_rng) ),
			( Pdef(\hh3) <> Pbindef(\root) <> Pbindef(\hh_rng) )
		])
	).quant_(4);
	Pdef(\drums).play(~linkClock, quant: 4);
	"lc1_4".postln;}
);

~launchControlEvents.add(\launchControlXlEvent_1_7 -> {
	Pdef(\drums,
		Ppar([

			( Psym1(~pitchTriggerRepeat.([\bdThump, \sd2, \bdThump], [1])).collect {|ev| ~scM8.play; ev} <> Pbindef(\root) <> Pbindef(\euclidean_lsys_2) );
			( Psym1(~pitchTriggerRepeat.([\hh1, \hh2], [1])) <> Pbindef(\root) <> Pbindef(\euclidean_lsys_5) );

		])
	).quant_(4);
	Pdef(\drums).play(~linkClock, quant: 4);
	"lc1_7".postln;}
);


~launchControlEvents.add(\launchControlXlEvent_1_8 -> {

	Pdef(\drums).pause(~linkClock, quant: 4);
	"lc1_8".postln;}
);

~launchControlEvents.add(\launchControlXlEvent_2_1 -> {
	Pdef(\loop,
		Ppar([
			( Pdef(\simplePluckReverse)
				<> Pn(Psync(Pbindef(\pat_332_downUp,
					\upperLimit, 24,
					\lowerLimit, 0,),maxdur:16))
				<> Pbindef(\pulse_8) ),
			( Pdef(\srrPluck)
				<> Pn(Psync(Pbindef(\arp,
					\upperLimit, -12,
					\lowerLimit, -36,
					\transpositionHarmonics, 1,
					\chordTranspositions, 10),maxdur:8))
				<> Pbindef(\pulse_16))
		])
	).quant_(4);
	Pdef(\loop).play(~linkClock, quant: 4);
	"lc2_1".postln;}
);

~launchControlEvents.add(\launchControlXlEvent_2_2 -> {
	Pdef(\loop,
		Ppar([
			( Pbind(\controlbus, ~launchcontrol_xl_row_1) <>
				Pdef(\srrPluck)
				<> Pbind(\external1Target, "fx_mod_1",
					\external1Amount, 1,
					\pattern1Target, "oscillator_mod_1",
					\pattern1Amount, 1,
					\pattern1In, Pseq([0.5,1,0.7,0.2],inf),
				) <>
				Pbindef(\root) <> Pbindef(\pulse_16)),
			( Pdef(\srrPluck)
				<> Pn(Psync(Pbindef(\arp,
					\upperLimit, -12,
					\lowerLimit, -36,
					\transpositionHarmonics, 1,
					\chordTranspositions, 10),maxdur:8))
				<> Pbindef(\pulse_16))
		])
	).quant_(4);
	Pdef(\loop).play(~linkClock, quant: 4);
	"lc2_2".postln;}
);


~launchControlEvents.add(\launchControlXlEvent_2_8 -> {

	Pdef(\loop).pause(~linkClock, quant: 4);
	"lc2_8".postln;}
);

"loading TexturKlang Cues".postln;

// ~instrPreset.edit(\noEnvSrr)
// ~instrPreset.create(\noEnvSine)

~launchControlEvents.add(\launchControlXlEvent_6 -> {

	~launchControlXlKnobLEDsSetRow.(1,2);
	~launchControlXlKnobLEDsSetRow.(2,1);
	~launchControlXlKnobLEDsSetRow.([5,6],1);
	~launchControlXlKnobLEDsSetRow.([7,8],3);

	~texturKlangLayers ?? {~texturKlangLayers = 0!7};

	~texturSoundSelector = {
		(
			switch ( ~launchControlXlDMSRButtons[1],
				0, { "" },
				1, { "noisy " },
			)
			++
			switch ( ~launchControlXlDMSRButtons[2],
				0, { "" },
				1, { "inharmonic " } ,
			)
			++
			switch ( ~launchControlXlDMSRButtons[3],
				0, { "" },
				1, { "harmonic " },
			)
		).postln;
		(
			switch ( ~launchControlXlDMSRButtons[1],
				0, { [] },
				1, { [\noEnvNoise, \noEnvPitchedNoise, \noEnvCrackle] },
			)
			++
			switch ( ~launchControlXlDMSRButtons[2],
				0, { []	},
				1, { [\noEnvFM, \noEnvModal, \noEnvFmModal, \noEnvSrr] } ,
			)
			++
			switch ( ~launchControlXlDMSRButtons[3],
				0, { [] },
				1, { [\noEnvSine, \noEnvBasic, \noEnvFormant] },
			)
		)
	};

	~texturEnvelopeSelector = {
		(switch (~launchControlXlSelectButtons[[2,3]],
			[0,0], {
				"farbklänge".postln;
				Pbind(\adsrType, \lead,// \noEnv, \pluck, \lead, \pad, \sync
					\sendGate, true,
					\envelope_mod, 0.5,
					\envCurve, 3) },
			[0,1], {
				"ausschwingKlaenge".postln;
				Pbind(\adsrType, \pluck,// \noEnv, \pluck, \lead, \pad, \sync
					\sendGate, false,
					\envelope_mod, 0.75,
					\envCurve, 4,
				)
			},
			[1,0], {
				"einschwingKlaenge".postln;
				Pbind(\adsrType, \sync,// \noEnv, \pluck, \lead, \pad, \sync
					\sendGate, false,
					\envelope_mod, 1,
					\envCurve, -3,
			) },
			[1,1], {
				"ein- und ausschwingKlaenge".postln;
				Pbind(\adsrType, Pseq([\sync,\pluck],inf),// \noEnv, \pluck, \lead, \pad, \sync
					\sendGate, false,
					\envelope_mod, Pseq([1,0.5],inf),
					\envCurve, Pseq([-1,-3],inf),
				)
			},
		)
		<>
		Pbind(\stretch, 1,
			\time, Ptime(),
			\beatDuration, Pfunc { ~linkClock.tempo },
			\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
		));
	};

	~texturPitches = { Pbind(
		\upperLimit, Pn(Plazy { ~launchcontrol_xl_row_1.getnSynchronous(4).at(0).lincurve(0,1,-36,29,0) + 7}),
		\lowerLimit, (Pkey(\upperLimit) - 12),
		\transpositionHarmonics, 1,
		\chordTranspositions, 10,
		\pitches, Pfunc{ |ev|
			~chord.([0,1,2,3,4,5,6,7,8,9,10,11],
				ev.lowerLimit,
				ev.upperLimit,
				ev.transpositionHarmonics,
				ev.chordTranspositions) },
	)
	};

//	~chord.([0,1,2,3,4,5,6,7,8,9,10,11])

	~texturDurations = {
		Pbind(\durations,
			Pn(Plazy{ 2 ** (~launchcontrol_xl_row_1.getnSynchronous(4).at(1).lincurve(0,1,2,-4,0).round + (-1..1)) }),
		)
	};

	~texturChain = {
		Psym1(Pxrand(~texturSoundSelector.value,inf)/*.trace*/)
		<>
		~texturEnvelopeSelector.value
		<>
		~brownianPitches.()
		<>
		~texturPitches.value
		<>
		~brownianDurations.(2,3)
		<>
		~texturDurations.value
	};

	("bank " ++ "ready").postln;
}
);

~launchControlEvents.add(\launchControlXlEvent_6_1 -> {

	if (~texturKlangLayers.at(0) == 0)

	{"starting TexturKlang Layer 1".postln;
		(Pdef(\texturKlangLayer1,
			Ppar((Pbind(
				\controlbus_vol, ~launchcontrol_xl_row_1,
				\controlbus, ~launchcontrol_xl_row_2,
			)
			<>
			~texturChain.value
			)!~launchcontrol_xl_row_1.getnSynchronous(4).at(2).lincurve(0,1,1,5,0).round
			)
		)).play(~linkClock, quant: 1);

		~launchControlXlBottomLEDs.put( ((~launchControlXlBank * 8) + ~launchControlXlButton), 2);

		~texturKlangLayers.put(0,1);}


	{"stopping TexturKlang Layer 1".postln;

		Pdef(\texturKlangLayer1).stop;

		~launchControlXlBottomLEDs.put( ((~launchControlXlBank * 8) + ~launchControlXlButton), 0);

		~texturKlangLayers.put(0,0);}
}
);

~launchControlEvents.add(\launchControlXlEvent_6_2 -> {

	if (~texturKlangLayers.at(1) == 0)

	{"starting TexturKlang Layer 2".postln;

		Pdef(\texturKlangLayer2,
			Ppar(Pbind(
				\controlbus_vol, ~launchcontrol_xl_row_2,
				\controlbus, ~launchcontrol_xl_row_2,
			)
			<>
			(~texturChain.value)
			!~launchcontrol_xl_row_1.getnSynchronous(4).at(2).lincurve(0,1,1,5,0).round
			)
		).play(~linkClock, quant: 1);

		~launchControlXlBottomLEDs.put( ((~launchControlXlBank * 8) + ~launchControlXlButton), 2);

		~texturKlangLayers.put(1,1);}


	{"stopping TexturKlang Layer 2".postln;

		Pdef(\texturKlangLayer2).stop;

		~launchControlXlBottomLEDs.put( ((~launchControlXlBank * 8) + ~launchControlXlButton), 0);

		~texturKlangLayers.put(1,0);}
}
);

~launchControlEvents.add(\launchControlXlEvent_6_3 -> {

	if (~texturKlangLayers.at(2) == 0)

	{"starting TexturKlang Layer 3".postln;

		Pdef(\texturKlangLayer3,
			Ppar(Pbind(
				\controlbus_vol, ~launchcontrol_xl_row_3,
				\controlbus, ~launchcontrol_xl_row_2,
			)
			<>
			(~texturChain.value)
			!~launchcontrol_xl_row_1.getnSynchronous(4).at(2).lincurve(0,1,1,5,0).round
			)
		).play(~linkClock, quant: 1);

		~launchControlXlBottomLEDs.put( ((~launchControlXlBank * 8) + ~launchControlXlButton), 2);

		~texturKlangLayers.put(2,1);}


	{"stopping TexturKlang Layer 3".postln;

		Pdef(\texturKlangLayer3).stop;

		~launchControlXlBottomLEDs.put( ((~launchControlXlBank * 8) + ~launchControlXlButton), 0);

		~texturKlangLayers.put(2,0);}
}
);

~launchControlEvents.add(\launchControlXlEvent_6_4 -> {

	if (~texturKlangLayers.at(3) == 0)

	{"starting TexturKlang Layer 4".postln;

		Pdef(\texturKlangLayer4,
			Ppar((Pbind(\controlbus_vol, ~launchcontrol_xl_row_4,
				\controlbus, ~launchcontrol_xl_row_2,
			)
			<>
			~texturChain.value)
			!~launchcontrol_xl_row_1.getnSynchronous(4).at(2).lincurve(0,1,1,5,0).round
			)
		).play(~linkClock, quant: 1);

		~launchControlXlBottomLEDs.put( ((~launchControlXlBank * 8) + ~launchControlXlButton), 2);

		~texturKlangLayers.put(3,1);}


	{"stopping TexturKlang Layer 4".postln;

		Pdef(\texturKlangLayer4).stop;

		~launchControlXlBottomLEDs.put( ((~launchControlXlBank * 8) + ~launchControlXlButton), 0);

		~texturKlangLayers.put(3,0);}
}
);

~launchControlEvents.add(\launchControlXlEvent_6_5 -> {

	"starting Puls Layer 1".postln;

	Pdef(\texturPulsLayer1,
		Pbind(\controlbus, ~launchcontrol_xl_row_2)
		<>
		Psym1(Pxrand(~texturSoundSelector.value,inf))
		<>
		~texturEnvelopeSelector.value
		<>
		Pbind(\pitchChoice,
			Pfunc { |ev| ~launchcontrol_xl_row_5.getnSynchronous(4).at(0).lincurve(0,1,0,ev.pitches.size,0).round },
			\note,
			Pindex(Pkey(\pitches, inf), Pkey(\pitchChoice, inf), inf)
		)
		<>
		Pbind(
			\upperLimit, 36,
			\lowerLimit, -36,
			\transpositionHarmonics, 1,
			\chordTranspositions, 10,
			\pitches, Pfunc{ |ev|
				~chord.([0,1,2,3,4,5,6,7,8,9,10,11],
					ev.lowerLimit,
					ev.upperLimit,
					ev.transpositionHarmonics,
					ev.chordTranspositions) },
		)
		<>
		Pbind(\controlbus_vol, ~launchcontrol_xl_row_5)
		<>
		Pbind(\dur,
			Pfunc { 2 ** (~launchcontrol_xl_row_5.getnSynchronous(4).at(1).lincurve(0,1,3,-5,0).round) }
		)

		).play(~linkClock, quant: 1);

		~launchControlXlBottomLEDs.put( ((~launchControlXlBank * 8) + ~launchControlXlButton), 1);

		~texturKlangLayers.put(6, 1);

	}
);

~launchControlEvents.add(\launchControlXlNoteOffEvent_6_5 -> {

	"stopping Puls Layer 1".postln;

	Pdef(\texturPulsLayer1).stop;

	~launchControlXlBottomLEDs.put( ((~launchControlXlBank * 8) + ~launchControlXlButton), 0);

	~texturKlangLayers.put(6, 0);
}
);


~launchControlEvents.add(\launchControlXlEvent_6_6 -> {

	"starting Puls Layer 1".postln;

	Pdef(\texturPulsLayer2,
		Pbind(\controlbus, ~launchcontrol_xl_row_2)
		<>
		Psym1(Pxrand(~texturSoundSelector.value,inf))
		<>
		~texturEnvelopeSelector.value
		<>
		Pbind(
			\pitchChoice,
			Pfunc { |ev| ~launchcontrol_xl_row_6.getnSynchronous(4).at(0).lincurve(0,1,0,ev.pitches.size,0).round },
			\note,
			Pindex(Pkey(\pitches, inf), Pkey(\pitchChoice, inf), inf)
		)
		<>
		Pbind(
			\upperLimit, 36,
			\lowerLimit, -36,
			\transpositionHarmonics, 1,
			\chordTranspositions, 10,
			\pitches, Pfunc{ |ev|
				~chord.([0,1,2,3,4,5,6,7,8,9,10,11],
					ev.lowerLimit,
					ev.upperLimit,
					ev.transpositionHarmonics,
					ev.chordTranspositions) },
		)
		<>
		Pbind(\controlbus_vol, ~launchcontrol_xl_row_6)
		<>
		Pbind(\dur,
			Pfunc { 2 ** (~launchcontrol_xl_row_6.getnSynchronous(4).at(1).lincurve(0,1,3,-5,0).round) }
		)

	).play(~linkClock, quant: 1);

	~launchControlXlBottomLEDs.put( ((~launchControlXlBank * 8) + ~launchControlXlButton), 1);

	~texturKlangLayers.put(6, 1);

}
);

~launchControlEvents.add(\launchControlXlNoteOffEvent_6_6 -> {

	"stopping Puls Layer 1".postln;

	Pdef(\texturPulsLayer2).stop;

	~launchControlXlBottomLEDs.put( ((~launchControlXlBank * 8) + ~launchControlXlButton), 0);

	~texturKlangLayers.put(6, 0);
}
);

~launchControlEvents.add(\launchControlXlEvent_6_7 -> {

	var events = 5,
	unit = 2 ** (~launchcontrol_xl_row_1.getnSynchronous(4).at(1).lincurve(0,1,-1,-6,0).round),
	pulse = unit * (~launchcontrol_xl_row_1.getnSynchronous(4).at(2).lincurve(0,1,1,5,0).round),
	fibArray = Array.fib(events, unit * 4, unit * 4),
	patternLength = ~accPulse.( events, unit, pulse).asStream.all(()).collect {|ev| ev.dur}.sum,
	patternEvents = ~accPulse.( events, unit, pulse).asStream.all(()).collect {|ev| ev.dur}.size;

	("Accelerando from " ++
		fibArray.reverse[0].asFraction[0].asString ++ "/" ++ fibArray.reverse[0].asFraction[1].asString ++
		" to " ++
		fibArray[0].asFraction[0].asString ++ "/" ++ fibArray[0].asFraction[1].asString ++
		" over " ++
		patternLength.asString ++
		" seconds " ++
		" in " ++
		patternEvents.asString ++
		" events"
	).postln;

	(
		Pbind(\controlbus, ~launchcontrol_xl_row_2)
		<>
		Psym1(Pxrand(~texturSoundSelector.value,inf))
		<>
		~texturEnvelopeSelector.value
		<>
		~brownianPitches.()
		<>
		~texturPitches.value
		<>
		Pbind(\controlbus_vol, ~launchcontrol_xl_row_7)
		<>
		Pbind(\currentBank, Pn(Plazy ({~launchControlXlBank})),
			\currentButton, Pn(Plazy ({~launchControlXlButton})),
			\sendLedData, Pfunc ( { |ev| if (ev.dur == fibArray[0])
				{~launchControlXlBottomLEDs.put( ((ev.currentBank * 8) + ev.currentButton), 0);
					~launchControlXlUpdateBottomLEDs.value}
				{~launchControlXlBottomLEDs.put( ((ev.currentBank * 8) + ev.currentButton), 1);
					~launchControlXlUpdateBottomLEDs.value}
			})
		)
		<>
		~accPulse.(events, unit, pulse)
	).play(~linkClock, quant: 1);

}
);

~launchControlEvents.add(\launchControlXlEvent_6_8 -> {

	var events = 5,
	unit = 2 ** (~launchcontrol_xl_row_1.getnSynchronous(4).at(1).lincurve(0,1,-1,-6,0).round),
	pulse = unit * (~launchcontrol_xl_row_1.getnSynchronous(4).at(2).lincurve(0,1,1,5,0).round),
	fibArray = Array.fib(events, unit * 4, unit * 4),
	patternLength = ~ritPulse.( events, unit, pulse).asStream.all(()).collect {|ev| ev.dur}.sum,
	patternEvents = ~ritPulse.( events, unit, pulse).asStream.all(()).collect {|ev| ev.dur}.size;

	("Ritardando from " ++
		fibArray[0].asFraction[0].asString ++ "/" ++ fibArray[0].asFraction[1].asString ++
		" to " ++
		fibArray.reverse[0].asFraction[0].asString ++ "/" ++ fibArray.reverse[0].asFraction[1].asString ++
		" over " ++
		patternLength.asString ++
		" seconds " ++
		" in " ++
		patternEvents.asString ++
		" events"
	).postln;

	(
		Pbind(\controlbus, ~launchcontrol_xl_row_2)
		<>
		Psym1(Pxrand(~texturSoundSelector.value,inf))
		<>
		~texturEnvelopeSelector.value
		<>
		~brownianPitches.()
		<>
		~texturPitches.value
		<>
		Pbind(\controlbus_vol, ~launchcontrol_xl_row_8)
		<>
		Pbind(\currentBank, Pn(Plazy ({~launchControlXlBank})),
			\currentButton, Pn(Plazy ({~launchControlXlButton})),
			\sendLedData, Pfunc ( { |ev| if (ev.dur == fibArray.reverse[0])
				{~launchControlXlBottomLEDs.put( ((ev.currentBank * 8) + ev.currentButton), 0);
					~launchControlXlUpdateBottomLEDs.value}
				{~launchControlXlBottomLEDs.put( ((ev.currentBank * 8) + ev.currentButton), 1);
					~launchControlXlUpdateBottomLEDs.value}
			})
		)
		<>
		~ritPulse.( events, unit, pulse)

	).play(~linkClock, quant: 1);
}
);