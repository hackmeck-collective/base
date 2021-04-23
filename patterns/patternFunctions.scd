//scMCh funktioniert nicht
// wie hole ich dur in sidecain rein?

//////////////////////////////// RHYTHM

~euclid = { |hits, length, offset, pulse|
	Pbjorklund2(hits,length,inf,offset.asStream) * pulse;
};

~acc = { |events, unit|

	Array.fib(events, unit * 4, unit * 4).reverse;

};

~accPulse = { |events, unit, pulse|
	Pbind(
		\time, Ptime(),
		\dur, Pclutch(Pseq(~acc.(events, unit)),
			Pfunc { |ev| ev.time.mod( pulse * 4 ) == 0 }
		);
	)
};

~rit = { |events, unit|

	(Array.fib(events, unit * 4, unit * 4));

};

~ritPulse = { |events, unit, pulse|

	Pbind(
		\time, Ptime(),
		\dur, Pclutch(Pseq(~rit.(events, unit)),
			Pfunc { |ev| ev.time.mod( pulse * 4 ) == 0 }
		);
	)
};

~brownianDurations = { |stepsize = 1, voices = 1|
	Pbind(\durChoice, Pn( Plazy({ |ev| Pbrown(0, ev.durations.size, stepsize).round }) ),
		\dur, Pindex(Pkey(\durations, inf), Pkey(\durChoice, inf), inf)
	);
};

~metreDynamics_4_4 = {
	arg time,
	factor = 0.3,
	random = 0.05,
	static = 0.6;

	var whole, half, quarter, pattern;

	whole = 1 - (time.mod(4)/ 4);
	half = 1 - (time.mod(2) / 2);
	quarter = 1 - (time.mod(1));
	pattern = whole * 0.2 + half * 0.35 + quarter * 0.45;
	pattern = (pattern * factor) + (1.sum3rand * random) + static;
};

~pitchTriggerRepeat = { |noteArray, repeats, notes|
	notes = notes ?? {(0..noteArray.size - 1)};
	Pindex(
		noteArray,
		Pclutch(
			Pseq([Pstutter(
				Pseq(repeats,inf),
				Pseq(notes, inf)
			)]),
			Pfunc{|ev| ev.dur.isNumber}
		),
		inf
	)
};

//////////////////////////////// PITCHES

~pitchesAndOctaves = { |noteArray, lowerLimit = 0, upperLimit = 12, harmonics = 1, transpositions = 10|

	(noteArray + [(0..transpositions)*.x(((1..harmonics) * 2).ratiomidi).round])
	.flat.asSet.asArray.select({arg item; (item <= upperLimit) && (item >= lowerLimit)}).sort
};

~pitchesAndOctavesJI = { |noteArray, lowerLimit = 0, upperLimit = 12, harmonics = 1, transpositions = 10|

	(noteArray + [(0..transpositions)*.x(((1..harmonics) * 2).ratiomidi)])
	.flat.asSet.asArray.select({arg item; (item <= upperLimit) && (item >= lowerLimit)}).sort
};

~intervalFilter = { |input, root, filteredIntervals|

	var pitchFilter, transposedToRoot, transposedBack;

	transposedToRoot = input - root;
	pitchFilter = transposedToRoot.select({arg item; filteredIntervals.includes(item.round.mod(12).asInteger)});
	transposedBack = pitchFilter + root;
	transposedBack;
};

~chord = { |chordtones, lowerLimit = 0, upperLimit = 12, harmonics = 1, transpositions = 10|
	~intervalFilter.(
		~pitchesAndOctaves.(~pitchesRootDissonance[\pitches], lowerLimit, upperLimit, harmonics, transpositions),
		~pitchesRootDissonance[\root],
		chordtones)
};

~pitchPerDuration = { |pitchArray, durations|
	Ptsym(Pseq(pitchArray, inf),dur: Pseq(durations, inf))
};

(
~brownianPitches = { |stepsize = 2|
	Pbind(\noteChoice, Pn( Plazy ( { |ev| Pbrown(0, ev.pitches.size, stepsize).round } ) ),
		\note, Pindex(Pkey(\pitches, inf), Pkey(\noteChoice, inf), inf)
	);
}
);

//////////////////////////////// SIDECHAIN

~scM4 = (
	\type: \set,
	\id: Pfunc { ~audioBusses.melodyBus },
	\args: #[\beatDurNow, \sidechain_trigger_4_melody],
	\beatDurNow: {TempoClock.default.beatDur},
	\sidechain_trigger_4_melody: 1
);

~scM8 = (
	\type: \set,
	\id: Pfunc { ~audioBusses.melodyBus },
	\args: #[\beatDurNow, \sidechain_trigger_8_melody],
	\beatDurNow: {TempoClock.default.beatDur},
	\sidechain_trigger_8_melody: 1
);

~scCh4 = (
	\type: \set,
	\id: Pfunc { ~audioBusses.chordsBus },
	\args: #[\beatDurNow, \sidechain_trigger_4_chords],
	\beatDurNow: {TempoClock.default.beatDur},
	\sidechain_trigger_4_chords: 1
);

~scCh8 = (
	\type: \set,
	\id: Pfunc { ~audioBusses.chordsBus },
	\args: #[\beatDurNow, \sidechain_trigger_8_chords],
	\beatDurNow: {TempoClock.default.beatDur},
	\sidechain_trigger_8_chords: 1
);

~scMCh4 = ((
	\type: \set,
	\id: Pfunc { ~audioBusses.melodyBus },
	\args: #[\beatDurNow, \sidechain_trigger_4_melody],
	\beatDurNow: {TempoClock.default.beatDur},
	\sidechain_trigger_4_melody: 1
);
(
\type: \set,
\id: Pfunc { ~audioBusses.chordsBus },
\args: #[\beatDurNow, \sidechain_trigger_4_chords],
\beatDurNow: {TempoClock.default.beatDur},
\sidechain_trigger_4_chords: 1
);
);

~scMCh8 = ((
	\type: \set,
	\id: Pfunc { ~audioBusses.melodyBus },
	\args: #[\beatDurNow, \sidechain_trigger_8_melody],
	\beatDurNow: {TempoClock.default.beatDur},
	\sidechain_trigger_8_melody: 1
);
(
\type: \set,
\id: Pfunc { ~audioBusses.chordsBus },
\args: #[\beatDurNow, \sidechain_trigger_8_chords],
\beatDurNow: {TempoClock.default.beatDur},
\sidechain_trigger_8_chords: 1
);
);

//~chord.([0,1,2,3,4,5,6,7,8,9,10,11],-36,36,1,0);
