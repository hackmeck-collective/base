(
"pdef_resources.scd".loadRelative;
// "formteile.scd".loadRelative;
(PathName(thisProcess.nowExecutingPath).pathOnly +/+ "Formteile/*").loadPaths;
(PathName(thisProcess.nowExecutingPath).pathOnly +/+ "InstrumentStates/*").loadPaths;


Pdef(\play,
	Pspawner({ |sp|
		var startTime = thisThread.beats;
		~linkClock.tempo = 1;
		sp.seq(Pdef(\exposition));
		sp.seq(Pdef(\layers));
		sp.seq(Pdef(\penrose_entwicklung1));
		sp.seq(Pdef(\penrose_entwicklung2));  //percussion? tonhöhen? ring?

		// // // Dauer: 5'12"
		sp.seq(Pdef(\simpleSwitchDevelopement_1));
		sp.seq(Pdef(\simpleSwitchDevelopement_1_x_triangle));
		sp.seq(Pdef(\simpleSwitchDevelopement_2)); //fraktal und sisw biscchen ausdünnen, wirkt etwas intransparent
		sp.seq(Pdef(\triangleDevelopement_2));

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

		sp.seq(~fugeInstrState_2.(
			Pseq([
				Pdef(\fuge_develope_ende2)
		]));
		);

		~linkClock.tempo = 1;
		sp.seq(~fugeInstrState_3.( //modem styles legato runter
			Pseq([
				Pn(Pdef(\fuge_excerpt2_gen1), 8),
				Pn(Pdef(\fuge_excerpt2_gen2), 4),
				Pn(Pdef(\fuge_excerpt2_gen3), 2),
		]));
		);

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


s.record
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

~pitchesRootDissonance[\pitches] = [0,2,3,5,7,9, 11] +.x [36,48]


