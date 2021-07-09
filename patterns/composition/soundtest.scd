(
(Ppar([
			Pbind(
				\centerPos, 0.5,) <>
			~penroseInstrState_7.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen3),2)
			),
			~bdBuzzInstrState_1.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen3_bd), 2)
			),
			~clickInstrState_3.(
				inputPattern: Pn(Pdef(\penrose_pauses_gen3_click), 2)
			),
		])
		).play
);

(~clickInstrState_5.(Pdef(\click)) <> Pdef(\pulse_32)).play

(Pdef(\simpleSwitchDevelopement_1_x_triangle)).play