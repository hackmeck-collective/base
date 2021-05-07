(
var bank = ~texturKlangBank;
var texturKlangButtons = [1,2,3,4];
var pulsButtons = [5,6];
var accellerandoButtons = [7];
var ritardandoButtons = [8];
var controllerArray = [
	~launchcontrol_xl_row_1,
	~launchcontrol_xl_row_2,
	~launchcontrol_xl_row_3,
	~launchcontrol_xl_row_4,
	~launchcontrol_xl_row_5,
	~launchcontrol_xl_row_6,
	~launchcontrol_xl_row_7,
	~launchcontrol_xl_row_8];
var patternValuesControl = controllerArray[[1,2]];
var soundControl1 = controllerArray[0];
var liveControl = controllerArray;
var button;
var buttonArray;

("loading TexturKlang Cues on Bank " ++ bank).postln;

~launchControlEvents.add(("launchControlXlEvent_" ++ bank).asSymbol -> {

	~launchControlXlKnobLEDsSetRow.([2,3],4);
	~launchControlXlKnobLEDsSetRow.(1,1);
	~launchControlXlKnobLEDsSetRow.([5,6],2);
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
		\upperLimit, 36,
		\lowerLimit, -36,
		\transpositionHarmonics, 1,
		\chordTranspositions, 10,
		\pitchesRaw, Pfunc{ |ev|
			~chord.([0,1,2,3,4,5,6,7,8,9,10,11],
				ev.lowerLimit,
				ev.upperLimit,
				ev.transpositionHarmonics,
				ev.chordTranspositions) },
		\pitches, Pfunc{ |ev|
			var selector = patternValuesControl[0].getnSynchronous(4).at(0).lincurve(0,1,0,(ev.pitchesRaw.size - 1),0);
			var testArray = ev.pitchesRaw[selector + (-5..7)];
			testArray.select({ |item, i|
				item.isNumber;
			}).select({ |item, i|
				((item <= (ev.pitchesRaw[selector] + 7)) && (item >= (ev.pitchesRaw[selector] - 5)));
			});

		}
	)
	};

	~texturDurations = {
		Pbind(\durations,
			Pn(Plazy{ 2 ** (patternValuesControl[0].getnSynchronous(4).at(1).lincurve(0,1,2,-4,0).round + (-1..1)) }),
		)
	};

	~texturChain = {
		Pn(
			Plazy { |ev|
				var events = List.new;
				Pseq([
					(Psync(ev.loopPattern,1,ev.loopDur)).collect{|ev| events.add(ev);ev},
					Pn(Plazy{Pseq(events)}, ev.loopRepeats - 1)
				])
			}
			<> (
				loopPattern:
				(Psym1(Pxrand(~texturSoundSelector.value,inf)/*.trace*/)
					<>
					~texturEnvelopeSelector.value
					<>
					~brownianPitches.()
					<>
					~texturPitches.value
					<>
					~brownianDurations.(2,3)
					<>
					~texturDurations.value),
				loopRepeats: inf,
				loopDur:  (2 ** (patternValuesControl[1].getnSynchronous(4).at(1).lincurve(0,1,3,-1,2).round)).postln
			)
		)

	};

	("LaunchControlXlBank " ++ bank ++ " ready").postln;
}
);

texturKlangButtons.do({ |button, index|

	~launchControlEvents.add(("launchControlXlEvent_" ++ bank ++ "_" ++ button).asSymbol -> {

		if (~texturKlangLayers.at(button-1) == 0)

		{("starting TexturKlang Layer " ++ button).postln;
			(Pdef(("texturKlangLayer" ++ button).asSymbol,
				Ppar((Pbind(
					\controlbus_vol, liveControl.at(button - 1),
					\controlbus, soundControl1,
				)
				<>
				~texturChain.value
				)!patternValuesControl[1].getnSynchronous(4).at(0).lincurve(0,1,1,5,0).round
				)
			)).play(~linkClock, quant: 1);

			~launchControlXlBottomLEDs.put( (((bank - 1) * 8) + (button - 1)), 2);

			~texturKlangLayers.put((button - 1),1);}


		{"stopping TexturKlang Layer 1".postln;

			Pdef(("texturKlangLayer" ++ button).asSymbol).stop;

			~launchControlXlBottomLEDs.put( (((bank - 1) * 8) + (button - 1)), 0);

			~texturKlangLayers.put((button - 1),0);}
	}
	);
});

pulsButtons.do({ |button, index|

	~launchControlEvents.add(("launchControlXlEvent_" ++ bank ++ "_" ++ button).asSymbol -> {
		("starting Layer " ++ button ++ ": puls").postln;

		Pdef(("texturPulsLayer" ++ button).asSymbol,
			Pbind(\controlbus, soundControl1)
			<>
			Psym1(Pxrand(~texturSoundSelector.value,inf))
			<>
			~texturEnvelopeSelector.value
			<>
			Pbind(\pitchChoice,
				Pfunc { |ev| liveControl.at(button - 1).getnSynchronous(4).at(0).lincurve(0,1,0,(ev.pitches.size - 1),0).round },
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
			Pbind(\controlbus_vol, liveControl.at(button - 1))
			<>
			Pbind(\dur,
				Pfunc { 2 ** (liveControl.at(button - 1).getnSynchronous(4).at(1).lincurve(0,1,3,-5,0).round) }
			)

		).play(~linkClock, quant: 1);

		~launchControlXlBottomLEDs.put( (((bank - 1) * 8) + (button - 1)), 1);

		~texturKlangLayers.put(bank, 1);

	}
	);

	~launchControlEvents.add(("launchControlXlNoteOffEvent_" ++ bank ++ "_" ++ button).asSymbol -> {

		("stopping Layer " ++ button ++ ": puls").postln;

		Pdef(("texturPulsLayer" ++ button).asSymbol).stop;

		~launchControlXlBottomLEDs.put( (((bank - 1) * 8) + (button - 1)), 0);

		~texturKlangLayers.put(bank, 0);
	}
	);

});

accellerandoButtons.do({ |button|

	~launchControlEvents.add(("launchControlXlEvent_" ++ bank ++ "_" ++ button).asSymbol -> {

		var events = 5,
		unit = 2 ** (patternValuesControl[0].getnSynchronous(4).at(1).lincurve(0,1,-1,-6,0).round),
		pulse = unit * (patternValuesControl[0].getnSynchronous(4).at(2).lincurve(0,1,1,5,0).round),
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
			Pbind(\controlbus, soundControl1)
			<>
			Psym1(Pxrand(~texturSoundSelector.value,inf))
			<>
			~texturEnvelopeSelector.value
			<>
			~brownianPitches.()
			<>
			~texturPitches.value
			<>
			Pbind(\controlbus_vol, liveControl.at(button - 1))
			<>
			Pbind(\sendLedData, Pfunc ( { |ev| if (ev.dur == fibArray[0])
				{~launchControlXlBottomLEDs.put( (((bank - 1) * 8) + (button - 1)), 0);
					~launchControlXlUpdateBottomLEDs.value}
				{~launchControlXlBottomLEDs.put( (((bank - 1) * 8) + (button - 1)), 1);
					~launchControlXlUpdateBottomLEDs.value}
			})
			)
			<>
			~accPulse.(events, unit, pulse)
		).play(~linkClock, quant: 1);

	}
	);
});

ritardandoButtons.do({ |button|

	~launchControlEvents.add(("launchControlXlEvent_" ++ bank ++ "_" ++ button).asSymbol -> {

		var events = 5,
		unit = 2 ** (patternValuesControl[0].getnSynchronous(4).at(1).lincurve(0,1,-1,-6,0).round),
		pulse = unit * (patternValuesControl[0].getnSynchronous(4).at(2).lincurve(0,1,1,5,0).round),
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
			Pbind(\controlbus, soundControl1)
			<>
			Psym1(Pxrand(~texturSoundSelector.value,inf))
			<>
			~texturEnvelopeSelector.value
			<>
			~brownianPitches.()
			<>
			~texturPitches.value
			<>
			Pbind(\controlbus_vol, liveControl.at(button - 1))
			<>
			Pbind(\sendLedData, Pfunc ( { |ev| if (ev.dur == fibArray.reverse[0])
				{~launchControlXlBottomLEDs.put( (((bank - 1) * 8) + (button - 1)), 0);
					~launchControlXlUpdateBottomLEDs.value}
				{~launchControlXlBottomLEDs.put( (((bank - 1) * 8) + (button - 1)), 1);
					~launchControlXlUpdateBottomLEDs.value}
			})
			)
			<>
			~ritPulse.( events, unit, pulse)

		).play(~linkClock, quant: 1);
	}
	);

})
)