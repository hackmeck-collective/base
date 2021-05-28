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
