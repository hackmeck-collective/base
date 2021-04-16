

"/home/philipp/chronologisch/2021Q2/Hackmeck/pitches/Hindemith/prepare Session.scd".load;


~testDistances = all {: [x, y, z],
	x <- (-2..2),
	y <- (-2..2),
	z <- (-2..2)
}.sort({|a,b| a.sum({|i| i.abs}) < b.sum({|i| i.abs})}).drop(1);

~testDissDegree = {|testList, dissDegree|
	var intervals =  ~intervals.value(testList);
	var rootNote = ~rootNote.value(testList);
	var constraints = merge(~dissDegreeConstraints[dissDegree],(
			numNotes: ~listAndParameters.numNotes,
			maxUpperNote: (~listAndParameters.maxUpperNote - ~listAndParameters.minLowerNote)
		));
	var rootNoteEqualStr;
	constraints.postln;

	if ( rootNote.notNil && constraints.rootNoteEqual.notNil)
	{ rootNoteEqualStr = "(% % %)".format(rootNote, constraints.rootNoteEqual, testList.at(0))}
	{ rootNoteEqualStr = "false"};
	if (
		(intervals.asSet & constraints.excludeAll).isEmpty &&
		(rootNoteEqualStr.interpret) &&
		(testList.size == constraints.numNotes)
	) {true} {false}
};


//Die Funktion kann noch nicht DissDegree = 10 und DissDegree = 11 entgegen nehmen!
~getClosest = { |list, dissDegree|
	var maxDistance = 3;
	var search = true;
	var returnList;
	var distances = ~testDistances;

	distances.do {|distance|
		var testList = list + distance;
		distance.postln;
		if ( ~testDissDegree.value(testList, dissDegree) && search )
		{ search = false; returnList = testList};
	};
	("The closest list to " ++ list ++
		" with DissDegree" ++ dissDegree ++
		" is " ++ returnList).postln;
	returnList
};


)


{~getClosest.value([0,6,7], 0)}.bench;















