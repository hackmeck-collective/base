(
var bank = ~fxBank;
var beatRepeatButton = [1,2];
var granulatorButton = [5,6];
var controllerArray = [
	~launchcontrol_xl_row_1,
	~launchcontrol_xl_row_2,
	~launchcontrol_xl_row_3,
	~launchcontrol_xl_row_4,
	~launchcontrol_xl_row_5,
	~launchcontrol_xl_row_6,
	~launchcontrol_xl_row_7,
	~launchcontrol_xl_row_8];
var beatRepeatControl = controllerArray[(beatRepeatButton-1)];
var button;
var buttonArray;

("loading fx Cues on Bank " ++ bank).postln;

~launchControlEvents.add(("launchControlXlEvent_" ++ bank).asSymbol -> {

	~launchControlXlKnobLEDsSetRow.(beatRepeatButton,1);
	~launchControlXlKnobLEDsSetRow.(granulatorButton,2);
	~launchControlXlKnobLEDsSetRow.(8,3);

	~fxState ?? {~fxState = 0!8};

	~audioBusses.melodyBus.set(\sidechain_amount, (-72).dbamp);
	~audioBusses.chordsBus.set(\sidechain_amount, (-72).dbamp);

	(
		~sendFX.ef_reverb.set(\inbus, ~ef_reverb,
			\revtime, 2.5,
			\predelay, 0.025,
			\hpf, 60,
			\lpf, 4500,
			\spread, 1,
			\vol, 1.5,
			\beatDurNow, ~linkClock.tempo,
			\sidechain_amount, (-24).dbamp);
	);

	(
		~sendFX.simpleDelay.set(\inBus, ~simpleDelay,
			\beatDurNow, ~linkClock.tempo,
			\relativeDelayTime, 0.33,
			\filterType, 3,
			\filterFreq, 500,
			\resonance, 2,
			\feedback_amount, 0.45,
			\reverbSend, 0.25,
			\maxDelayTime, 4);
	);

	(
		~sendFX.grainDelay_1.set(\amp, 1, \atk, 0.1, \rel, 1, \gate, 1, \sync, 1,
			\dens, 70, \baseDur, 0.05, \durRand, 0.02, \rate, 2,
			\rateRand, 0.025, \pan, 0, \panRand, 1, \grainEnv, (-1),
			\out, ~effect_bus,
			\buf, ~grainDelayBuffer_1,
			\ptrBus, ~grainDelayBufferPosition_1,
			\feedbackBus, ~grainDelay_1,
			\ptrSampleDelay, s.sampleRate*0.05,
			\ptrRandomSamples, s.sampleRate*0.03,
			\minPtrDelay, 100,
			\feedback, 0.01)
	);

	("LaunchControlXlBank " ++ bank ++ " ready").postln;
}
);

beatRepeatButton.do({ |button, index|

	~launchControlEvents.add(("launchControlXlEvent_" ++ bank ++ "_" ++ button).asSymbol -> {

		if (~fxState.at(button-1) == 0)

		{("starting beatRepeat " ++ button).postln;

			(
				Routine({
					var controlbus =  beatRepeatControl,
					quant = 0.5;
					(~linkClock.timeToNextBeat % quant).wait;
					~sendFX.beatRepeatBufferRecord_1.set(\recording, 0);
					b.pause;

					(Pdef(("beatRepeat" ++ button).asSymbol,
						Pbind(\controlbus2, beatRepeatControl.at(button - 1),
							\controlbus2_index, 1,
							\oscillator_mod_1, quant,
							\oscillator_mod_2, quant,
							\oscillator_mod_3, 0.5,
							\oscillator_buffer, ~beatRepeatBuffer_1,
							\oscillator_bufferPos, ~beatRepeatBufferPosition_1,
						)
						<>
						Pdef(\beatRepeat)
						<>
						Pbind(\dur, Pfunc{ 1/(2**beatRepeatControl.at(button - 1).getnSynchronous[0].linlin(0,1,8,0).round)}, \legato, 1) )
					).play;

				}).play;
			);

			~launchControlXlBottomLEDs.put( (((bank - 1) * 8) + (button - 1)), 2);

			~fxState.put((button - 1),1);}


		{"stopping beatRepeat".postln;

			(
				Routine({
					var quant = 0.5;
					(~linkClock.timeToNextBeat % quant).wait;
					~sendFX.beatRepeatBufferRecord_1.set(\recording, 1);
					b.play;
					Pdef(("beatRepeat" ++ button).asSymbol).stop
				}).play;
			);

			~launchControlXlBottomLEDs.put( (((bank - 1) * 8) + (button - 1)), 0);

			~fxState.put((button - 1),0);}
	}
	);
});



granulatorButton.do({ |button, index|

	~launchControlEvents.add(("launchControlXlEvent_" ++ bank ++ "_" ++ button).asSymbol -> {
		("starting granulator").postln;

		(
			Routine({
				var controlbus =  ~launchcontrol_xl_row_3,
				quant = 1;
				(~linkClock.timeToNextBeat % quant).wait;
				~sendFX.granulatorBufferRecord_1.set(\recording, 0);
				Pdef(("granulator" ++ button).asSymbol,
					Pbind(\controlbus1, controlbus,
						\controlbus1_index, 1,
						\controlbus2, controlbus,
						\controlbus2_index, 1,
						\controlbus3, controlbus,
						\controlbus3_index, 1,
						\oscillator_mod_1, 30,
						\oscillator_mod_2, 0.6,
						\oscillator_mod_3, 1,
						\oscillator_mod_4, 0.9,
						\oscillator_buffer, ~granulatorBuffer_1,
						\oscillator_bufferPos, ~granulatorBufferPosition_1,
						\mod1Type, \noise,
						\mod1Amount, 0,
					) <>
					Pdef(\granulator)
					<> Pbind(\dur, 1, \legato, 1,
						\mod1Target, "oscillator_mod_4",
						\external1Amount, 1,
						\external2Amount, 1,
						\external3Amount, 1,
						\external1Target, "oscillator_mod_1",
						\external2Target, "oscillator_mod_2",
						\external3Target, "oscillator_mod_3",
				) ).play;
				(~linkClock.timeToNextBeat % quant).wait;
				b.stop;
				(~linkClock.timeToNextBeat % quant).postln
			}).play;
		);

		~launchControlXlBottomLEDs.put( (((bank - 1) * 8) + (button - 1)), 1);

		~fxState.put(bank, 1);

	}
	);

	~launchControlEvents.add(("launchControlXlNoteOffEvent_" ++ bank ++ "_" ++ button).asSymbol -> {

		("stopping granulator").postln;

		(
			Routine({
				var quant = 0.5;
				(~linkClock.timeToNextBeat % quant).wait;
				~sendFX.granulatorBufferRecord_1.set(\recording, 1);
				b.play;
				Pdef(("granulator" ++ button).asSymbol).stop
			}).play;
		);

		~launchControlXlBottomLEDs.put( (((bank - 1) * 8) + (button - 1)), 0);

		~fxState.put(bank, 0);
	}
	);

});

)