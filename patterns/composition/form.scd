(
"pdef_resources.scd".loadRelative;
// "formteile.scd".loadRelative;
(PathName(thisProcess.nowExecutingPath).pathOnly +/+ "Formteile/*").loadPaths;
(PathName(thisProcess.nowExecutingPath).pathOnly +/+ "InstrumentStates/*").loadPaths;


Pdef(\play,
	Pspawner({ |sp|
		var startTime = thisThread.beats;
		~linkClock.tempo = 1;
		sp.seq(Pdef(\exposition)); //verpeilung am ende raus
		sp.seq(Pdef(\layers)); //verpeilung am ende raus
		sp.seq(Pdef(\penrose_entwicklung1)); // percussion rein
		sp.seq(Pdef(\penrose_entwicklung2));
		//
		// // Dauer: 5'12"
		sp.seq(Pdef(\simpleSwitchDevelopement_1));
		sp.seq(Pdef(\simpleSwitchDevelopement_1));
		sp.seq(Pdef(\simpleSwitchDevelopement_2));
		sp.seq(Pdef(\triangleDevelopement_2));

		~linkClock.tempo = 1;
		sp.seq(~fugeInstrState_1.(
			Pseq([
				Pn(Pdef(\fuge_excerpt_gen1), 16),
				Pn(Pdef(\fuge_excerpt_gen2), 8),
				Pn(Pdef(\fuge_excerpt_gen3), 4),
				Pn(Pdef(\fuge_excerpt_gen4), 2),
				Pn(Pdef(\fuge_excerpt_gen5), 1),
				Pdef(\fuge_develope_ende2)
		]));
		);
		~linkClock.tempo = 1;
		sp.seq(~fugeInstrState_1.(
			Pseq([
				Pn(Pdef(\fuge_excerpt2_gen1), 8),
				Pn(Pdef(\fuge_excerpt2_gen2), 4),
				Pn(Pdef(\fuge_excerpt2_gen3), 2),
				Pdef(\fuge_develope_ende)
		]));
		);
		(thisThread.beats - startTime).postln;
	})
);
)



s.record
Pdef(\play).clear
Pdef(\playVisuals).stop
Pdef(\playVisuals).play(~linkClock, quant:1 )
Pdef(\play).stop
Pdef(\play).play(~linkClock, quant:1 )
~linkClock.tempo = 1

Pdef(\play, ~fugeInstrState_1.(Pn(Pdef(\fuge_3_shortBranches_gen3))))

~gui.toProcessing.sendMsg('/linesMax', 1000)
~gui.toProcessing.sendMsg('/scale', 0.4)

~pitchesRootDissonance[\pitches] = [0,1,3,4,6,7, 9,10]


