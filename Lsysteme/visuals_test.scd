Pdef(\simpleSwitch_midi, Pbind(\controlbus1, ~routing[\launchcontrolXlControlBusses1],
	\external1Amount, 1,
	\external1min, -1,
	\external1max, 1,
	\envelope_mod, 0.5
) <> Pdef(\simpleSwitch) <>
Pbind(\external1Target, "envelope_mod")
);
Pdef(\simpleSwitch_gen4_midi, Pbind(\controlbus1, ~routing[\launchcontrolXlControlBusses1],
	\external1Amount, 1,
	\external1min, -1,
	\external1max, 1,
	\envelope_mod, 0.5
) <> Pdef(\simpleSwitch_gen4) <>
Pbind(\external1Target, "envelope_mod")
);
Pdef(\simpleSwitch_gen5_midi, Pbind(\controlbus1, ~routing[\launchcontrolXlControlBusses1],
	\external1Amount, 1,
	\external1min, -1,
	\external1max, 1,
	\envelope_mod, 0.5
) <> Pdef(\simpleSwitch_gen5) <>
Pbind(\external1Target, "envelope_mod")
);
Pdef(\simpleSwitch_gen6_midi, Pbind(\controlbus1, ~routing[\launchcontrolXlControlBusses1],
	\external1Amount, 1,
	\external1min, -1,
	\external1max, 1,
	\envelope_mod, 0.5
) <> Pdef(\simpleSwitch_gen6) <>
Pbind(\external1Target, "envelope_mod")
);
Pdef(\play, Pn(Pdef(\simpleSwitch_gen4))).play
Pdef(\play).stop

~pitchesRootDissonance[\pitches] = [0, 2, 4, 6, 8, 10]

Pdef(\penrose_midi,
	Pbind(\controlbus1, ~routing[\launchcontrolXlControlBusses0],
		\external1Amount, 1,
		\external1min, -1,
		\external1max, 1,
		\oscillator_1_mod_2, 0.5
	) <>
	Pdef(\penrose) <>
	Pbind(\external1Target, "oscillator_1_mod_2")
);


Pdef(\penrose_gen2_midi,
	Pbind(\controlbus1, ~routing[\launchcontrolXlControlBusses0],
		\external1Amount, 1,
		\external1min, -1,
		\external1max, 1,
		\oscillator_1_mod_2, 0.5
	) <>
	Pdef(\penrose_gen2) <>
	Pbind(\external1Target, "oscillator_1_mod_2")
);

~lsys.presets.pausen.instr = \simplePluck
~lsys.presets.pausen.noteOffset = -20
~lsys.presets.pausen.vols = 0.5
~lsys.presets.pausen.baseTempo = 1/8
~lsys.presets.pausen.useGlobalPitch = false
//axiom: "a+k+f+k+k+a-a-k-f-k-k-a"
//rules: ($a: "b", $b: "c", $c: "d", $d: "e", $e: "f", $f: "h[i]", $i: "j+l", $l: "mn", $n: "o+l")

~lsysPreset.create(\triangle)


~lsys.presets.simpleSwitchMelodie

Pdef(\play).play(~linkClock, quant:1 )

Pdef(\play).stop

Pdef(\playVisuals).play(~linkClock, quant:2 )
Pdef(\playVisuals).stop


~gui.points

~gui.toProcessing.sendMsg('/scale', 1.75)

~gui.toProcessing.sendMsg('/scale', 0.95)

~linkClock.tempo = 1

~gui.toProcessing.sendMsg('/linesMax', 90)


~gui.toProcessing.sendMsg('/lerpFactor', 0.8)

~gui.toProcessing.sendMsg('/reset')


~lsys.presets.chaosFugue.theta = 20

~lsys.presets.penrose.legatoArr
~lsys.presets.penrose.theta = 12
~lsys.presets.penrose.maxPatDur * ~lsys.presets.penrose.baseTempo
Pdef(\penrose_filter, Pbind())
Pdef(\exposition,
	Pspawner({ |sp|

		sp.seq(Pn(Pdef(\weed), 4));
		sp.wait(2);
		sp.par(
			Pbind(
				\dur, Rest(0.1),
				\vals, Pseg([1.1,0.1,0.2],[6]),
				\setLegato, Pfunc {|ev|
					~lsys.presets.penrose.legatoArr = ev.vals;
				}
			)
		);
		sp.seq(Pn(Pdef(\penrose_midi), 8));
		sp.seq(Pn(Pdef(\simpleSwitch_midi), 4));

		sp.seq(Pn(Pdef(\weed), 2));
		~lsys.presets.penrose.legatoArr = 1.1;
		sp.par(
			Pbind(
				\dur, Rest(0.1),
				\vals, Pseg([1.1,0.1,0.2],[6]),
				\setLegato, Pfunc {|ev|
					~lsys.presets.penrose.legatoArr = ev.vals;
				}
			)
		);
		sp.par(Pn(Pdef(\weed), 2)); sp.seq(Pn(Pdef(\penrose_midi), 10));

		// sp.seq(Pn(Pdef(\simpleSwitch_midi), 8));

		// sp.seq(Pn(Pdef(\weed), 2));
		// sp.par(Pn(Pdef(\weed), 8)); sp.seq(Pn(Pdef(\penrose_midi), 8));
		// sp.seq(Pn(Pdef(\simpleSwitch_midi), 8));

		/*		sp.seq(Pn(Pdef(\weed), 2));
		sp.seq(Pdef(\weed_gen4));
		sp.seq(Pn(Pdef(\penrose_gen2_midi), 2));
		sp.seq(Pn(Pdef(\penrose_midi), 4));
		sp.seq(Pn(Pdef(\simpleSwitch_midi), 2));*/
	})
);

Pdef(\penrose_entwicklung1,
	Pspawner({ |sp|
		sp.seq(Pn(Pdef(\penrose_midi), 2));
		sp.seq(Pn(Pdef(\penrose_toPause), 4));
		sp.seq(Pn(Pdef(\penrose_toPause2), 4));
		sp.seq(Pn(Pdef(\penrose_toPause3), 4));
		sp.seq(Pn(Pdef(\penrose_pauses),8));
		sp.seq(Pn(Pdef(\penrose_pauses_gen2),2));
		sp.seq(Pn(Pdef(\penrose_pauses_gen3),2));
	})
);

Pdef(\penrose_entwicklung2,
	Pspawner({ |sp|
/*		sp.par(
			Pbind(
				\dur, Rest(0.1),
				\vals, Pseg([0.3,0.1],[9]),
				\setLegato, Pfunc {|ev|
					~lsys.presets.penrose_pauses_gen4.legatoArr = ev.vals;
				}
			)
		);
		sp.seq(Pn(Pdef(\penrose_pauses_gen4),1));
		sp.seq(Pn(Pdef(\penrose_canon), 4));*/
		sp.seq(Pn(Pdef(\penrose_canon_pausen), 2));
		sp.seq(Pdef(\transition_canon_ritardando));
		sp.seq(Pn(Pdef(\penrose_canon_mehr_pausen), 2)); // Langsamer werden stinkt
		sp.seq(Pn(Pdef(\penrose_canon_mehr_pausen2), 2));
		sp.seq(Pdef(\transition_penrose_simpleSwitch));
	})
);
Pdef(\play).clear
Pdefn(\weights_transition_canon_ritardando, Pbjorklund(Pseq([Pseq((1..15)),Pn(16)]).trace,16,inf))


Pdef(\transition_canon_ritardando,
	Pbind(
		\vol, (Pfunc {|ev|
			var oldVol = ev.vol ? 1;
			var fade = if(ev.streamIndex == 1){ev.xfade}{1 - ev.xfade};
			oldVol * fade
		})
	) <> Ppar([
		Pn(Pdef(\penrose_canon_pausen),2) <> Pbind(\streamIndex, 2), //\newBranchTest
		Pn(Pdef(\penrose_canon_mehr_pausen),2) <> Pbind(\streamIndex, 1)
	]) <> PtimeClutch(Pbind(
		\xfade, Pseg([0,1],[20],0,inf)
	), delta: (1/6) - 0.01) // Delta mit dem baseTempo auf dem es laufen soll abstimmen
)
~lsys.presets.penrose_canon_mehr_pausen.maxPatDur
Pdefn(\weights_transition_penrose_simpleSwitch, Pbjorklund(Pseq([Pstutter(3,Pseq((1..15))),Pn(16)]).trace,16,inf))

Pdef(\transition_penrose_simpleSwitch,
	Pbind(
		\vol, (Pfunc {|ev|
			var oldVol = ev.vol ? 1;
			var fade = if(ev.streamIndex == 1){ev.xfade}{1 - ev.xfade};
			oldVol * fade
		})
	) <> Ppar([
		Pn(Pdef(\penrose_canon_mehr_pausen)) <> Pbind(\streamIndex, 2), //\newBranchTest
		Pn(Pdef(\simpleSwitch)) <> Pbind(\streamIndex, 1)
	]) <> PtimeClutch(Pbind(
		\weights, Pdefn(\weights_transition_penrose_simpleSwitch),//Pseg([0,1,0],[20,20],0,inf),//Pfunc{ ~weightsTest },
		\xfade, Pn(Plazy {|ev| Pwrand([0, 1], [1 - ev.weights, ev.weights])})
	), delta: (1/8) - 0.01) // Delta mit dem baseTempo auf dem es laufen soll abstimmen
)

Pdef(\simpleSwitch_entwicklung,
	Pspawner({ |sp|
		sp.seq(Pn(Pdef(\simpleSwitch_gen4_midi),4));
		sp.seq(Pn(Pdef(\simpleSwitch_gen5_midi),2));
		sp.seq(Pdef(\simpleSwitch_gen6_midi));
	})
);

Pdef(\play,
	Pspawner({ |sp|
		sp.seq(Pdef(\exposition));
		sp.seq(Pdef(\penrose_entwicklung1));
		sp.seq(Pdef(\penrose_entwicklung2));
	})
)

Pdef(\play,
	Pseq([Pn(Pdef(\simpleSwitch_midi),4),Pn(Pdef(\penrose_midi),4)],inf)
)
Pdef(\play).play(~linkClock, quant:1 )

Pdef(\play).stop
~lsys.presets.simpleSwitch.stutterVal= 1
~lsys.presets.simpleSwitch.stutterVal= Pseq([3, Pn(1,4)])


Pdef(\play,Pdef(\penrose_entwicklung2))

Pdef(\playVisuals).play(~linkClock, quant:2 )
Pdef(\playVisuals).stop

// Weiteres Vorgehen:

// bei den loops einmal kurz hoerere generation einbauen.

// zweite wdh (vom perc wieder auf weed) mit hoeherer gen als basis

// fuer jedes ein parameter auf bennis dings (bei weed verzerrung, bei simpleSwitch envelope)

// pdef wrapping?

// bei 2ter wdh die reihenfolge aendern (von weed nach simpleSwitch)
File.copy("/home/vincent/Repos/hackmeck-base/Presets/LsystemPresets/penrose_pauses.scd"
	, "/home/vincent/Repos/hackmeck-base/Presets/LsystemPresets/penrose_pauses_gen2.scd")

File.use("/home/vincent/Repos/hackmeck-base/Presets/LsystemPresets/penrose_pauses_gen2.scd", "r+", { |f|
	var str = f.readAllString;
	str.replace("penrose_pauses", "penrose_pauses_gen3");
	str.replace("gen: 2", "gen: 3");
	f.pos = 0;
	f.write(str)
});