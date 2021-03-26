~euclid = { |hits, length, offset, pulse|
	Pbjorklund2(hits,length,inf,offset.asStream) * pulse;
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

//~chord.([0,1,2,3,4,5,6,7,8,9,10,11],-36,36,1,0);
