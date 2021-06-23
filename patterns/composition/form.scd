(
"pdef_resources.scd".loadRelative;
// "formteile.scd".loadRelative;
(PathName(thisProcess.nowExecutingPath).pathOnly +/+ "Formteile/*").loadPaths;
(PathName(thisProcess.nowExecutingPath).pathOnly +/+ "InstrumentStates/*").loadPaths;


Pdef(\play,
	Pspawner({ |sp|
		/*sp.seq(Pdef(\exposition)); //verpeilung am ende raus
		sp.seq(Pdef(\layers)); //verpeilung am ende raus
		sp.seq(Pdef(\penrose_entwicklung1)); // percussion rein
		sp.seq(Pdef(\penrose_entwicklung2));
		// sp.seq(Pdef(\simpleSwitchDevelopement)); //sp.seq(Pdef(\triangle_develope));  ist bei simpleSwitchDev drin

		// Dauer: 5'12"
		sp.seq(Pdef(\simpleSwitchDevelopement_1));
		sp.seq(Pdef(\simpleSwitchDevelopement_1));
		sp.seq(Pdef(\simpleSwitchDevelopement_2));
		sp.seq(Pdef(\triangleDevelopement_2));
		sp.seq(Pdef(\fuge_develope));*/

		sp.seq(Pdef(\fuge_develope_ende));
		sp.seq(Pdef(\fuge_develope_ende2));
	})
);
)

Pdef(\playVisuals).stop
Pdef(\playVisuals).play(~linkClock, quant:1 )

Pdef(\play).play(~linkClock, quant:1 )


~gui.toProcessing.sendMsg('/linesMax', 1000)
~gui.toProcessing.sendMsg('/scale', 0.4)

~pitchesRootDissonance[\pitches] = [0,1,3,4,6,7, 9,10]

