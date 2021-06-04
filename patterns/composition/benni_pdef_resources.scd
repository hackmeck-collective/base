~lcXlCtrBus1Bi = { |busNum, amount = 1, min = -1, max = 1|
	Pbind(\controlbus1, ~routing[("launchcontrolXlControlBusses" ++ busNum).asSymbol],
		\external1Amount, amount,
		\external1min, min,
		\external1max, max,
	)
};

~lcXlCtrBus2Bi = { |busNum, amount, min, max|
	Pbind(\controlbus2, ~routing[("launchcontrolXlControlBusses" ++ busNum).asSymbol],
		\external2Amount, 1,
		\external2min, -1,
		\external2max, 1,
	)
};

~simpleSwitchInstrState_1 = (Pbind(\pitchOp_1_interval, 3.5,
	\pitchOp_1_amount, 0.05,
	\pitchOp_2_interval, 0,
	\pitchOp_2_amount, 0,
	\oscillator_1_mod_1, 0, \oscillator_2_mod_1, 0,
	\drum_1_level, 0, \drum_2_level, 0,
	\vca_filterLevel, 0,
	\vca_preFilterLevel, 0,
	\vca_preFxLevel, 1,
	\envelope_mod, 0.6
)
);

~weedInstrState_1 = (Pbind(\send_1_level, 0.25,	\envelope_mod, 0.7));

~penroseInstrState_1 = (
	Pbind(\oscillator_2_level, 0.25,
		\oscillator_1_mod_1, 0.05, \oscillator_2_mod_1, 0,
		\oscillator_1_mod_2, 1.7, \oscillator_2_mod_2, 1.3,
));

~patternVolumeFadePre = (Pbind(
		\vol, (Pfunc {|ev|
			var oldVol = ev.vol ? 1;
			var fade = if(ev.streamIndex == 1){ev.xfade}{1 - ev.xfade};
			oldVol * fade
		})
	)
);

~patternVolumeFadePost = ({|length, delta|
	PtimeClutch(Pbind(
		\xfade, Pseg([0,1],[length],0,inf)
	), delta: (delta) - 0.01) // Delta mit dem baseTempo auf dem es laufen soll abstimmen
});

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

