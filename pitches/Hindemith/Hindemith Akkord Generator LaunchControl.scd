(
~intervals = { |chord|
	//chord.postln;
	all {: (chord[i+gap] - chord[i]).mod(12),
		gap <- (1 .. chord.lastIndex),
		i <- (0 .. chord.lastIndex - gap)
	}
};


~intervalsAndNotes = { |chord| //ohne Oktavierungen!
	//chord.postln;
	all {: (lowNote: chord[i], highNote: chord[i+gap], interval: (chord[i+gap] - chord[i]).mod(12)),
		gap <- (1 .. chord.lastIndex),
		i <- (0 .. chord.lastIndex - gap),
		:: ["gap:", gap, "i:", i].postln
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
	// var listOfIntervals = [];
	// var uniqueIntevals;
	intervals.do { |event| //Iteriert über die Liste der Events
		if(event.interval != 0 && (event.interval != 6), {
			listen[dissonanzen.indexOf(event.interval)].add(event);
			// listOfIntervals.add(event.interval);
		});

	};

	// uniqueIntevals = ~intervals.(listOfIntervals.as(Set).asArray);

	//winner = listen.detect(_.notEmpty).minItem{|event| event.lowNote};
	possibleWinner = listen.detect(_.notEmpty);
	if(possibleWinner.isNil){
		nil
	}{
		if(~uniqueInterval.(pitches)){
			nil
		}{
			if(chooseU.includes(possibleWinner[0].interval),{
				winner = possibleWinner.minItem{|event| event.lowNote};
				winner.lowNote;
			},{
				winner = possibleWinner.maxItem{|event| event.highNote};
				winner.highNote;
			});
		}
	}
};


//("[0" ++ 3.collect {|i| ", n%".format(i + 1) }.reduce{|a b| a ++ b}  ++ "]").postcs
~getListComprehension = { |numNotes, excludeAll, includeAll, includeOneOf, maxUpperNote, rootNoteEqual|
	var noteStringArray = (numNotes - 1).collect {|i| "n%".format(i + 1) };
	var noteString = ("[0" ++ (numNotes - 1).collect {|i| ", n%".format(i + 1) }.reduce{|a b| a ++ b}  ++ "]");
	var str = "
{: (list: %, rootNote: rootNote), \n
var maxUpperNote = %, \n

n1 <- (1..(maxUpperNote-%)),".format(noteString, maxUpperNote, numNotes - 2) ++ (if(excludeAll.notNil){"%.includes(n1).not,".format(excludeAll)} {""}) ++ "\n"

	++
	(if(numNotes==3){""}{
		(numNotes - 3).collect { |nn|
			"% <- ((%+1)..(maxUpperNote-%)),".format("n" ++ (nn + 2), "n" ++ (nn + 1), numNotes - nn - 3)
			++ (if(excludeAll.notNil){"(% & ~intervals.([0, %]).asSet).isEmpty,".format(
				excludeAll, noteStringArray[0..(nn + 1)].reduce{|a b| a ++ ", " ++ b}
			)}{""}) ++ "\n"

		}.reduce{|a b| a ++ b}
	})
	++ "% <- ((%+1)..maxUpperNote), \n

var intervals = ~intervals.(%).asSet,".format(noteStringArray.last, noteStringArray.wrapAt(-2), noteString)  ++ "\n"

	++ (if(excludeAll.notNil){"(% & intervals).isEmpty,".format(excludeAll)}{""}) ++ "\n"

	++ (if(includeOneOf.notNil){"(intervals & %).notEmpty,".format(includeOneOf)}{""}) ++ "\n"

	++ (if(includeAll.notNil){"% isSubsetOf: intervals,".format(includeAll)}{""}) ++ "\n"

	++ "var rootNote = ~rootNote.(%)".format(noteString) ++ (if(rootNoteEqual.notNil){", (rootNote % 0) && (rootNote.notNil)}".format(rootNoteEqual)}{"}"});
	str.asCompileString.postln;
	str.interpret
};

)

z = {: (list: [0, n1, n2], rootNote: rootNote),
	var maxUpperNote = 24,
	n1 <- (1..(maxUpperNote-1)), Set[ 6, 2, 10, 11, 1 ].includes(n1).not,
	n2 <- ((n1+1)..maxUpperNote), //:: intervals.postln,
	var intervals = ~intervals.([0, n1, n2].postln).asSet,
	(Set[ 6, 2, 10, 11, 1 ] & intervals).isEmpty,
	(intervals & Set[ 8, 0, 3, 9, 2, 11, 6, 10, 4, 1, 5, 7 ]).notEmpty,
	true, //Set[  ] isSubsetOf: intervals,
	//:: [intervals, [0,n1,n2]].postln,
	var rootNote = ~rootNote.([0, n1, n2].postln), ((rootNote == 0) && rootNote.notNil)
};
z.next;

//1
z = ~getListComprehension.(
	numNotes: 3, // > 3 //funktioniert noch nicht für alle Listen mit numNotes: 3
	excludeAll: Set[1, 2, 6, 10, 11],
	//includeAll: Set[],
	includeOneOf: Set[0,1,2,3,4,5,6,7,8,9,10,11],
	maxUpperNote: 24,
	rootNoteEqual: "==" // == != oder nil
)
z.next

Set[] isSubsetOf: Set[1];

// 4
z = ~getListComprehension.(
	numNotes: 3 // >= 3
	excludeAll: Set[1, 11],
	includeAll: Set[2, 6, 10],
	includeOneOf: Set[7, 5, 4, 8],
	maxUpperNote: 24,
	rootNoteEqual: "=="  // == != oder nil
)
z.next


