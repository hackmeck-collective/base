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
			~simpleSwitchInstrState_2.(
			inputPattern: Pseq([
				Pn(Pdef(\simpleSwitch_gen2), 2),
				Pn(Pdef(\simpleSwitch_gen1), 7)
			], 1)),
			~clickInstrState_2.(
				inputPattern: Pseq([
				Pn(Pdef(\simpleSwitch_click_gen2), 2),
				Pn(Pdef(\simpleSwitch_click_gen1), 7)
			], 1)
			)
		])
		).play
);
~clickInstrState_2.(Pn(Pdef(\simpleSwitch_click_gen2), 2)).play
~linkClock.tempo = 1
(
((~weedInstrState_2_short.(
			inputPattern: Pseq([
				Pdef(\weed_gen3),
				Pdef(\weed_gen1),
				Pn(Pdef(\weed_gen0),3)
		]))
		)
).play
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


