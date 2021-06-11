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
		sp.seq(Pdef(\penrose_entwicklung2));*/
		// sp.seq(Pdef(\simpleSwitchDevelopement)); //sp.seq(Pdef(\triangle_develope));  ist bei simpleSwitchDev drin

		// Dauer: 5'12"
		sp.seq(Pdef(\simpleSwitchDevelopement_1));
		sp.seq(Pdef(\simpleSwitchDevelopement_1));
		sp.seq(Pdef(\simpleSwitchDevelopement_2));
		sp.seq(Pdef(\triangleDevelopement_2));
		//
	})
);
)

Pdef(\play).clear
Pdef(\play).play(~linkClock, quant:1 )

(~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
		<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0,)
<> Pbind(\glide,1.5) <> Pdef(\fuge_2_b)
<> ~penroseInstrState_maxCrushTo1_External).play(~linkClock, quant:1 )


(~penroseInstrState_maxCrushTo1 <> ~penroseInstrState_maxCrushTo1_Controller
		<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.25,)
<> Pbind(\glide,0.2) <> Pdef(\fuge_2_b)
<> ~penroseInstrState_maxCrushTo1_External).play(~linkClock, quant:1 )


(Pbind(\glide,0.2) <> Pdef(\fuge_2)).play(~linkClock, quant:1 )

Pdef(\play).stop

Pn(Pbind(\glide, 0.2) <> Pdef(\Fuge_1)).play

~linkClock.tempo = 1

(
			~patternVolumeFade.(
				pat1: ~penroseInstrState_maxCrushTo1
				<> ~penroseInstrState_maxCrushTo1_Controller
				<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
				<> Pn(Pdef(\penrose_canon_1),2)
				<> ~penroseInstrState_maxCrushTo1_External,
				pat2: ~penroseInstrState_maxCrushTo1
				<> ~penroseInstrState_maxCrushTo1_Controller
				<> Pbind(\envelope_mod, 0, \amp, 0.35, \send_1_level, 0.2,)
				<> Pn(Pdef(\penrose_canon_pausen_1),2)
				<> ~penroseInstrState_maxCrushTo1_External,
				length: 20,
				delta: 1/6
			)
		).play

~pitchesRootDissonance[\pitches] = [0,1,3,4,6,7, 9,10]

// anfang von triangle schon bei simpleSwitchDev teilweise dazu

// nach triangle (minute 13) ins flaechige mit philipps fuge

// dann zu noise und am ende fade out, ritardando

Pmono(\default, \dur, 0.5, \degree, Pwhite(0,12)).play