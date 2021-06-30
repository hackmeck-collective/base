(
"pdef_resources.scd".loadRelative;
// "formteile.scd".loadRelative;
(PathName(thisProcess.nowExecutingPath).pathOnly +/+ "Formteile/*").loadPaths;
(PathName(thisProcess.nowExecutingPath).pathOnly +/+ "InstrumentStates/*").loadPaths;

);

(
~clickInstrState_1.(Pseq([
				Pn(Pdef(\simpleSwitch_click_gen2), 2),
				Pn(Pdef(\simpleSwitch_click_gen1), 7)
			], 1)).play
);
(
(Ppar([
			~penroseInstrState_1.(
				inputPattern: Pseq([
					Pn(Pdef(\penrose_gen1), 4),
					Pn(Pdef(\penrose_gen0), 2)
				])
			),
			~clickInstrState_1.(
				inputPattern: Pseq([
				Pn(Pdef(\penrose_click_gen1),2),
				Pdef(\penrose_click_gen0)])
			)
		])
		).play
);
~clickInstrState_2.(Pn(Pdef(\simpleSwitch_click_gen2), 2)).play
~linkClock.tempo = 1
(
(~simpleSwitchInstrState_1.(
			inputPattern: Pseq([
				Pn(Pdef(\simpleSwitch_gen0),12),
				Pn(Pdef(\simpleSwitch_gen1),2),
				Pn(Pdef(\simpleSwitch_gen2),1),
				Pseq([Pdef(\simpleSwitch_gen3)]),
				Pn(Pdef(\simpleSwitch_gen2),1),
				Pn(Pdef(\simpleSwitch_gen1),1),
				Pn(Pdef(\simpleSwitch_gen0),2),
			])
			<> Pbind(\external1Target, "envelope_mod")
		)).play
);

(
(Pbind(\envelope_mod, 0.01)
<> ~penroseInstrState_1.(
	inputPattern: Pn(Pdef(\penrose_simple_gen2)
))
).play
);

(
(Pbind(\envelope_mod, 0.01)
<> ~penroseInstrState_2.(
	inputPattern: Pn(Pdef(\penrose_simple_gen2)
))
).play
);
(
(Pn(~simpleSwitchInstrState_1.(
	inputPattern: Pseq([
		Pn(Pdef(\simpleSwitch_gen0),12),
		Pn(Pdef(\simpleSwitch_gen1),2),
		Pn(Pdef(\simpleSwitch_gen2),1),
		Pseq([Pdef(\simpleSwitch_gen3)]), // percussion
		Pn(Pdef(\simpleSwitch_gen2),1),
		Pn(Pdef(\simpleSwitch_gen1),1),
		Pn(Pdef(\simpleSwitch_gen0),2),
	])
))).play
);


