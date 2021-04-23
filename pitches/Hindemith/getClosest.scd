~createDistances = {|interval|
	(
		3: (
			all {: [x, y, z],
				x <- (interval.neg..interval),
				y <- (interval.neg..interval),
				z <- (interval.neg..interval)
			}.sort({|a,b| a.sum({|i| i.abs}) < b.sum({|i| i.abs})}).drop(1);
		),
		4: (
			all {: [w, x, y, z],
				w <- (interval.neg..interval),
				x <- (interval.neg..interval),
				y <- (interval.neg..interval),
				z <- (interval.neg..interval)
			}.sort({|a,b| a.sum({|i| i.abs}) < b.sum({|i| i.abs})}).drop(1);
		),
		5: (
			all {: [v, w, x, y, z],
				v <- (interval.neg..interval),
				w <- (interval.neg..interval),
				x <- (interval.neg..interval),
				y <- (interval.neg..interval),
				z <- (interval.neg..interval)
			}.sort({|a,b| a.sum({|i| i.abs}) < b.sum({|i| i.abs})}).drop(1);
		),
		6: (
			all {: [u, v, w, x, y, z],
				u <- (interval.neg..interval),
				v <- (interval.neg..interval),
				w <- (interval.neg..interval),
				x <- (interval.neg..interval),
				y <- (interval.neg..interval),
				z <- (interval.neg..interval)
			}.sort({|a,b| a.sum({|i| i.abs}) < b.sum({|i| i.abs})}).drop(1);
		)
	)
};

~testDistances = (
	2: ~createDistances.(2),
	3: ~createDistances.(3)
);


~testDissDegree = {|testList, dissDegree, inputRootNote|
	var intervals =  ~intervals.value(testList);
	var rootNote = ~rootNote.value(testList);
	var constraints = merge(~dissDegreeConstraints[dissDegree],(
		numNotes: testList.size,
		maxUpperNote: (~listAndParameters.maxUpperNote - ~listAndParameters.minLowerNote)
	));
	var rootNoteEqualStr;
	rootNote !? { rootNote = rootNote % 12 };
	if ( rootNote.notNil && constraints.rootNoteEqual.notNil) {
		rootNoteEqualStr = "(% % %)".format(rootNote, constraints.rootNoteEqual, testList.at(0))
	}{
		rootNoteEqualStr = "false"
	};
	if (
		//(inputRootNote == rootNote) &&
		(intervals.asSet & constraints.excludeAll).isEmpty &&
		(intervals.asSet & constraints.includeAll.as(Set)).notEmpty &&
		(intervals.asSet & constraints.includeOneOf.as(Set)).notEmpty &&
		(intervals.asSet & constraints.includeOneOf2.as(Set)).notEmpty &&
		(rootNoteEqualStr.interpret) &&
		(testList.size == constraints.numNotes)

	) {true} {false}
};

//Die Funktion kann noch nicht DissDegree = 10 und DissDegree = 11 entgegen nehmen!
~getClosest = { |list, dissDegree, maxDistance = 2|
	var search = true;
	var returnList;
	var distances = ~testDistances[maxDistance][list.size];
	var inputRootNote = ~listAndParameters.rootNote;//~rootNote.value(list);


	distances.do {|distance|
		var testList = list + distance;
		//distance.postln;
		if ( ~testDissDegree.value(testList, dissDegree, inputRootNote) && search ) {
			search = false; returnList = testList
		};
	};
	/*("The closest list to " ++ list ++
	" with DissDegree" ++ dissDegree ++
	" is " ++ returnList).postln;*/
	returnList
};

// {~getClosest.value([ 12, 14, 19, 24 ] %12, 2).postln}.bench





// ~rootNote.value([ 12, 14, 19, 24 ] )









