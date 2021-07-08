(
"pdef_resources.scd".loadRelative;
// "formteile.scd".loadRelative;
(PathName(thisProcess.nowExecutingPath).pathOnly +/+ "Formteile/*").loadPaths;
(PathName(thisProcess.nowExecutingPath).pathOnly +/+ "InstrumentStates/*").loadPaths;


Pdef(\play,
	Pspawner({ |sp|
		var startTime = thisThread.beats;
		~linkClock.tempo = 1;


		// sp.seq(Pdef(\exposition));
		// sp.seq(Pdef(\layers));
		// sp.seq(Pdef(\penrose_entwicklung1)); //können wir hier auch das panning pro branch machen? eher subtil, dann wird es breiter [0, 0.2, -0.2, 0.4, -0.4]
		// sp.seq(Pdef(\penrose_entwicklung2));  //percussion? tonhöhen? ring?

		// // // Dauer: 5'12"
		// sp.seq(Pdef(\simpleSwitchDevelopement_1));
		// sp.seq(Pdef(\simpleSwitchDevelopement_1_x_triangle));
		sp.seq(Pdef(\simpleSwitchDevelopement_2)); //können wir das wirklich bitte überarbeiten? das wirkt sehr durcheinander. ich finde auch das pattern nicht, was zu laut ist und clipt
		sp.seq(Pdef(\triangleDevelopement_2)); // können wir bei philipp Fraktal die einzelnen branches pannen? so [0, 0.25, -0.25, 0.5, -0.5, 0.75, -0.75, 1, -1], das wäre meeeega, wie geht das?

~cueSymbols[\new] = 'Fuge_1_1st';

		/*soundCue = "Fuge_1: 0 -> 1; MasterResonance: X -> 0.75"
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		8.do({|i|
		~toLaunchControlXl.noteOn(0, (41 + i), 12);
		});
		~toLaunchControlXl.noteOn(0, 41, 60);
		~launchControlXlUpdateKnobLEDs.value;*/

		~linkClock.tempo = 1;
		sp.seq(~fugeInstrState_1.(
			Pseq([
				Pn(Pdef(\fuge_excerpt_gen1), 16),
				Pn(Pdef(\fuge_excerpt_gen2), 8),
				Pn(Pdef(\fuge_excerpt_gen3), 4),
				Pn(Pdef(\fuge_excerpt_gen4), 2),
				Pn(Pdef(\fuge_excerpt_gen5), 1)
		]));
		);


~cueSymbols[\new] = 'Fuge_1_2nd';

		/*soundCue = "Fuge_2: 0 -> 1; MasterResonance: X -> 0.75"
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		8.do({|i|
		~toLaunchControlXl.noteOn(0, (41 + i), 12);
		});
		~toLaunchControlXl.noteOn(0, 42, 60);
		~launchControlXlUpdateKnobLEDs.value;*/


		sp.seq(~fugeInstrState_2.(
			Pseq([
				Pdef(\fuge_develope_ende2)
		]));
		);


~cueSymbols[\new] = 'Fuge_1_3rd';

		/*soundCue = "Fuge_3: 0 -> 1; MasterResonance: X -> 0.75"
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		8.do({|i|
		~toLaunchControlXl.noteOn(0, (41 + i), 12);
		});
		~toLaunchControlXl.noteOn(0, 43, 60);
		~launchControlXlUpdateKnobLEDs.value;*/


		~linkClock.tempo = 1;
		sp.seq(~fugeInstrState_3.( //modem styles legato runter
			Pseq([
				Pn(Pdef(\fuge_excerpt2_gen1), 8),
				Pn(Pdef(\fuge_excerpt2_gen2), 4),
				Pn(Pdef(\fuge_excerpt2_gen3), 2),
		]));
		);


~cueSymbols[\new] = 'Fuge_1_4th';

		/*soundCue = "Fuge_4: 0 -> 1; MasterResonance: X -> 0.75"
		~launchControlXlKnobLEDsSetRow.((1..8),0);
		8.do({|i|
		~toLaunchControlXl.noteOn(0, (41 + i), 12);
		});
		~toLaunchControlXl.noteOn(0, 44, 60);
		~launchControlXlUpdateKnobLEDs.value;*/


		sp.seq(~fugeInstrState_4.(
			Pseq([
				Pdef(\fuge_develope_ende) //ende länger
		]));
		);


		(thisThread.beats - startTime).postln;
	})
);
)

~cueEvents !? {
	"cue1".postln;
	~cueEvents[\cue2].value};


s.record(numChannels: 12)
Pdef(\play).clear
Pdef(\playVisuals).stop
Pdef(\playVisuals).play(~linkClock, quant:1 )

Pdef(\playVisuals).pause

Pdef(\playVisuals).resume

Pdef(\play).stop
Pdef(\play).play(~linkClock, quant:1 )

Pdef(\play).pause
Pdef(\play).resume
~linkClock.tempo = 1


~gui.toProcessing.sendMsg('/linesMax', 1000)
~gui.toProcessing.sendMsg('/scale', 0.4)

~pitchesRootDissonance[\pitches] = [0,1,3,4,6,7, 9,10]

~pitchesRootDissonance[\pitches] = [0,2,3,5,7,9, 11] +.x [36,48, 60,72,84]


