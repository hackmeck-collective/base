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
		sp.par(
			Pbind(
				\dur, Rest(0.1),
				\vals, Pseg([0.3,0.1],[9]),
				\setLegato, Pfunc {|ev|
					~lsys.presets.penrose_pauses_gen4.legatoArr = ev.vals;
				}
			)
		);
		sp.seq(Pn(Pdef(\penrose_pauses_gen4),1));
		sp.seq(Pn(Pdef(\penrose_canon), 4));
		sp.seq(Pn(Pdef(\penrose_canon_pausen), 2));
		sp.seq(Pdef(\transition_canon_ritardando));
		sp.seq(Pn(Pdef(\penrose_canon_mehr_pausen), 2)); // Langsamer werden stinkt
		sp.seq(Pn(Pdef(\penrose_canon_mehr_pausen2), 2));
		sp.seq(Pdef(\transition_penrose_simpleSwitch));
	})
);


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
);

Pdefn(\weights_transition_penrose_simpleSwitch, Pbjorklund(Pseq([Pstutter(3,Pseq((1..15))),Pn(16)]).trace,16,inf));

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
);

