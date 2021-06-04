~dissDegreeConstraints = (
	0: (
		excludeAll: Set[1, 2, 6, 10, 11],
		rootNoteEqual: "==" // == != oder nil
	),
	1: (
		excludeAll: Set[1, 2, 6, 10, 11],
		rootNoteEqual: "!="
	),
	2: (
		excludeAll: Set[1, 2, 11],
		includeAll: Set[6, 10],
		includeOneOf: Set[7, 5, 4, 8],
		rootNoteEqual: "=="
	),
	3: (
		excludeAll: Set[1, 11],
		includeAll: Set[6],
		includeOneOf: Set[7, 5, 4, 8],
		includeOneOf2: Set[2, 10],
		rootNoteEqual: "=="
	),
	4: (
		excludeAll: Set[1, 11],
		includeAll: Set[6],
		includeOneOf: Set[7, 5, 4, 8],
		includeOneOf2: Set[2, 10],
		rootNoteEqual: "!=" // == != oder nil
	),
	5: (
		excludeAll: Set[1, 11],
		includeAll: Set[6],
		includeOneOf: Set[7, 5, 4, 8],
		includeOneOf2: Set[2, 10],
		mehrereTritoni: true
	),
	6: (
		excludeAll: Set[6],
		includeOneOf: Set[1,2,10,11],
		rootNoteEqual: "=="
	),
	7: (
		excludeAll: Set[6],
		includeOneOf: Set[1,2,10,11],
		rootNoteEqual: "!="
	),
	8: (
		includeAll: Set[6],
		includeOneOf: Set[1,11],
		includeOneOf2: Set[7, 5, 4, 8],
		rootNoteEqual: "=="
	),
	9: (
		//underlyingScale: (0..11).asSet,
		includeAll: Set[6],
		includeOneOf: Set[1,11],
		includeOneOf2: Set[7, 5, 4, 8],
		rootNoteEqual: "!="
	),


	10: (),
	11: ()
);








~intervals = { |chord|
	all {: (chord[i+gap] - chord[i]).mod(12),
		gap <- (1 .. chord.lastIndex),
		i <- (0 .. chord.lastIndex - gap)
	}
};

~intervalsAndNotes = { |chord| //ohne Oktavierungen!
	all {: (lowNote: chord[i], highNote: chord[i+gap], interval: (chord[i+gap] - chord[i]).mod(12)),
		gap <- (1 .. chord.lastIndex),
		i <- (0 .. chord.lastIndex - gap)
	}
};

~uniqueInterval = { |chord|
	var set = Set.new();
	chord.doAdjacentPairs { |a b|
		set.add(a - b)
	};
	(set.size == 1)
};

~rootNote = { |pitches|
	var dissonanzen = [7, 5, 4, 8, 3, 9, 2, 10, 1, 11];
	var listen = List.new ! 10; //eine Liste mit Listen, die Kandidaten für Grundtöne enthalten. Die Listen sind nach Güte des Intervals geordnet
	var chooseU = [7, 4, 3, 10, 11]; //Diejenigen Intervalle, bei denen man den UNTEREN Ton nehmen sollte.
	var possibleWinner;
	var winner;
	var intervals = ~intervalsAndNotes.(pitches);
	intervals.do { |event| //Iteriert über die Liste der Events
		if(event.interval != 0 && (event.interval != 6), {
			listen[dissonanzen.indexOf(event.interval)].add(event);
		});

	};
	possibleWinner = listen.detect(_.notEmpty);
	if(possibleWinner.isNil){
		nil
	}{
		if(~uniqueInterval.(pitches)){
			nil
		}{
			if(chooseU.includes(possibleWinner[0].interval),{
				winner = possibleWinner.minItem{|event| event.lowNote};
				winner.lowNote % 12;
			},{
				winner = possibleWinner.maxItem{|event| event.highNote};
				winner.highNote % 12;
			});
		}
	}
};

//~getListComprehension.value(4, Scale.major.degrees, nil, Set[5], nil, nil, nil, 12, "==", 3);
~getListComprehension = { |numNotes, underlyingScale, excludeAll, includeAll, includeOneOf, includeOneOf2, mehrereTritoni, maxUpperNoteWhenBaseIs0, rootNoteEqual, dissDegree|
	var noteStringArray = (numNotes - 1).collect {|i| "n%".format(i + 1) };
	var noteString = ("[0" ++ (numNotes - 1).collect {|i| ", n%".format(i + 1) }.reduce{|a b| a ++ b}  ++ "]");
	var str = "{: (list: %, rootNote: rootNote), \n var maxUpperNoteWhenBaseIs0 = %,
n1 <- (1..(maxUpperNoteWhenBaseIs0-%)),".format(
		noteString, maxUpperNoteWhenBaseIs0, numNotes - 2
	)
	++ (if(excludeAll.notNil){"%.includes(n1.mod(12)).not,".format(excludeAll)} {""})
	//++ (if(underlyingScale.notNil){"%.includes(n1.mod(12)),".format(underlyingScale)}{""})
	++ "\n"
	++
	(if(numNotes==3){""} {
		(numNotes - 3).collect { |nn|
			"% <- ((%+1)..(maxUpperNoteWhenBaseIs0-%)),".format("n" ++ (nn + 2), "n" ++ (nn + 1), numNotes - nn - 3)
			++ (if(excludeAll.notNil){"(% & ~intervals.([0, %]).asSet).isEmpty,".format(
				excludeAll, noteStringArray[0..(nn + 1)].reduce{|a b| a ++ ", " ++ b}
			)}{""})
			++ (if(underlyingScale.notNil){"([0, %].asSet - %.asSet).isEmpty,".format(
				noteStringArray[0..(nn + 1)].reduce{|a b| a ++ ", " ++ b}, underlyingScale
			)}{""})
			++ "\n"
		}.reduce{|a b| a ++ b}
	})
	++
	"% <- ((%+1)..maxUpperNoteWhenBaseIs0), \n var intervals = ~intervals.(%),".format(
		noteStringArray.last, noteStringArray.wrapAt(-2), noteString
	)
	++ "\n"
	++ (if(excludeAll.notNil){"(% & intervals.asSet).isEmpty,".format(excludeAll)}{""}) ++ "\n"
	++ (if(includeOneOf.notNil){"(intervals.asSet & %).notEmpty,".format(includeOneOf)}{""}) ++ "\n"
	++ (if(includeOneOf2.notNil){"(intervals.asSet & %).notEmpty,".format(includeOneOf2)}{""}) ++ "\n"
	++ (if(includeAll.notNil){"% isSubsetOf: intervals.asSet,".format(includeAll)}{""}) ++ "\n"
	++ (if(mehrereTritoni.notNil){"(intervals.count({|item| item.mod(12) == 6}) >= 2),"}{""}) ++ "\n"
	++ "var rootNote = ~rootNote.(%)".format(noteString)
	++ (if(rootNoteEqual.notNil){", (rootNote % 0) &&
		 rootNote.notNil".format(rootNoteEqual, noteStringArray, underlyingScale)}{""})
	++ ", (if(rootNote.notNil) {
		( %.asSet - (% + rootNote).mod(12).asSet).isEmpty
} {false}) }".format(noteStringArray.insert(0,0), underlyingScale);
	//("noteStringArray: " ++ noteStringArray.insert(0,0)).postln;
	//str.asCompileString.postln;
	str.interpret

};

[1,2,3] + 2;
[1,2,3].insert(0,0).asSet;
//( noteString.interpret.asSet - (underlyingScale + rootNote).mod(12).asSet).isEmpty
//true == ( noteStringArray.insert(0,0).asSet - (% + rootNote).mod(12).asSet).isEmpty
