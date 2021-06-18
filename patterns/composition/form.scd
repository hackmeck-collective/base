(
"pdef_resources.scd".loadRelative;
// "formteile.scd".loadRelative;
(PathName(thisProcess.nowExecutingPath).pathOnly +/+ "Formteile/*").loadPaths;
(PathName(thisProcess.nowExecutingPath).pathOnly +/+ "InstrumentStates/*").loadPaths;


Pdef(\play,
	Pspawner({ |sp|
		sp.seq(Pdef(\exposition)); //verpeilung am ende raus
		sp.seq(Pdef(\layers)); //verpeilung am ende raus
		sp.seq(Pdef(\penrose_entwicklung1)); // percussion rein
		sp.seq(Pdef(\penrose_entwicklung2));
		// sp.seq(Pdef(\simpleSwitchDevelopement)); //sp.seq(Pdef(\triangle_develope));  ist bei simpleSwitchDev drin

		// Dauer: 5'12"
		sp.seq(Pdef(\simpleSwitchDevelopement_1));
		sp.seq(Pdef(\simpleSwitchDevelopement_1));
		sp.seq(Pdef(\simpleSwitchDevelopement_2));
		sp.seq(Pdef(\triangleDevelopement_2));
		sp.seq(Pdef(\fuge_develope));
	})
);
)

~gui.toProcessing.sendMsg('/linesMax', 50)
Pdef(\playVisuals).stop
Pdef(\playVisuals).play(~linkClock, quant:1 )
Pdef(\play, Pdef(\triangleDevelopement_2))
Pdef(\play, Pdef(\fuge_develope_ende))
Pdef(\play, Pn(Pdef(\fuge_3_gen1)))

(Pbind(\glide,0.2) <> ~fugeInstrState_1.(Pdef(\fuge_2_b)) ).play(~linkClock, quant:1 )

Pdef(\play).play

Pn(Pbind(\glide, 0.2) <> Pdef(\Fuge_1)).play

~linkClock.tempo = 1
1 / ~linkClock.tempo

~gui.toProcessing.sendMsg('/linesMax', 1000)
~gui.toProcessing.sendMsg('/scale', 0.4)

~pitchesRootDissonance[\pitches] = [0,1,3,4,6,7, 9,10]

// anfang von triangle schon bei simpleSwitchDev teilweise dazu

// nach triangle (minute 13) ins flaechige mit philipps fuge

// dann zu noise und am ende fade out, ritardando

Pmono(\default, \dur, 0.5, \degree, Pwhite(0,12)).play