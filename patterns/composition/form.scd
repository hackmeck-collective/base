(
"pdef_resources.scd".loadRelative;
// "formteile.scd".loadRelative;
(PathName(thisProcess.nowExecutingPath).pathOnly +/+ "Formteile/*").loadPaths;

Pdef(\play,
	Pspawner({ |sp|
		sp.seq(Pdef(\exposition)); //verpeilung am ende raus
		sp.seq(Pdef(\penrose_entwicklung1)); // percussion rein
		sp.seq(Pdef(\penrose_entwicklung2));
		sp.seq(Pdef(\simpleSwitchDevelopement)); //sp.seq(Pdef(\triangle_develope));  ist bei simpleSwitchDev drin

	})
);
)
Pdef(\play).clear
Pdef(\play).play(~linkClock, quant:1 )

Pdef(\play).stop

Pn(Pbind(\glide, 0.2) <> Pdef(\Fuge_1)).play

~linkClock.tempo = 1

~pitchesRootDissonance[\pitches] = [0,1,3,4,6,7, 9,10]

// anfang von triangle schon bei simpleSwitchDev teilweise dazu

// nach triangle (minute 13) ins flaechige mit philipps fuge

// dann zu noise und am ende fade out, ritardando

Pmono(\default, \dur, 0.5, \degree, Pwhite(0,12)).play