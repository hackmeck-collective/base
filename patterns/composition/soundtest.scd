(
"pdef_resources.scd".loadRelative;
// "formteile.scd".loadRelative;
(PathName(thisProcess.nowExecutingPath).pathOnly +/+ "Formteile/*").loadPaths;
(PathName(thisProcess.nowExecutingPath).pathOnly +/+ "InstrumentStates/*").loadPaths;

);
(
((Pfindur(35,
			~simpleSwitchInstrState_6.(
				inputPattern: Pdef(\simpleSwitch_dev6))
		))).play
);
(
(~fraktal_1_InstrState_1.(
	inputPattern: Pn(Pdef(\fraktal_12))
)).play
)

(
Pn(~penroseInstrState_7.(
				inputPattern: Pn(Pdef(\digiDist_lead),2)
			)).play
);
(
~simpleSwitchInstrState_4.(
					inputPattern: Pn(Pdef(\simpleSwitch))
				).play
)
(
Pn(~penroseInstrState_8.(
					inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen3))
				)).play
);
(
(
			~patternNotesFade.(
				pat2:
				~penroseInstrState_8.(
					inputPattern: Pn(Pdef(\penrose_canon_mehr_pausen3))
				),

				pat1:
				~simpleSwitchInstrState_4.(
					inputPattern: Pn(Pdef(\simpleSwitch))
				),

				delta: 1/8, //da hakt was, die beiden sind auch nicht das gleiche tempo, sisw ist 1/8 penrose 1/6
				weightPattern: Pbjorklund(
					Pstutter(
						Pseq([4,4,3,3,2,1]),
						Pseq([1,2,3,5,8,13]),
				),16)
			)



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


