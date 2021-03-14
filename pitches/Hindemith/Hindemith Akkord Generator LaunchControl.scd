/*
Überlegung "Welche Parameter für die Listen?"
1. Chromatik
2. Messiaen3 - 0,2,3,4,6,7,8,10,11
3. Alternierende Achtstufigkeit
4. Ganzton
5. Konstrukt - 0,1,4,5,8,9
*/

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
~getListComprehension = { |numNotes, excludeAll, includeAll, includeOneOf, includeOneOf2, maxUpperNote, rootNoteEqual|
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

	++ (if(includeOneOf2.notNil){"(intervals & %).notEmpty,".format(includeOneOf2)}{""}) ++ "\n"

	++ (if(includeAll.notNil){"% isSubsetOf: intervals,".format(includeAll)}{""}) ++ "\n"

	++ "var rootNote = ~rootNote.(%)".format(noteString) ++ (if(rootNoteEqual.notNil){", (rootNote % 0) && (rootNote.notNil)}".format(rootNoteEqual)}{"}"});
	str.asCompileString.postln;
	str.interpret
};

)




// DissDegree 0
// A Ohne Tritonus I Ohne Sekunden und Septimen 1 Grundton und Basston sind derselbe
z = ~getListComprehension.(
	numNotes: 3, // >= 3
	excludeAll: Set[1, 2, 6, 10, 11],
	//includeAll: Set[],
	//includeOneOf: Set[0,1,2,3,4,5,6,7,8,9,10,11],
	maxUpperNote: 24,
	rootNoteEqual: "==" // == != oder nil
)
z.next


// DissDegree 1
// A ohne tritonus I Ohne Sekunden und Septimen 2 Grundton liegt hoeher im Akkord
z = ~getListComprehension.(
	numNotes: 6, // >= 3
	excludeAll: Set[1, 2, 6, 10, 11],
	//includeAll: Set[],
	//includeOneOf: Set[0,1,2,3,4,5,6,7,8,9,10,11],
	maxUpperNote: 24,
	rootNoteEqual: "!=" // == != oder nil
)
z.next


// DissDegree 2
// B mit tritonus II ohne kleine Sekunden und große Septimen. Tritonus untergeordnet a) Nur mit kleiner Septime (ohne gr. Sekunde) Grundton Und Basston sind derselbe

z = ~getListComprehension.(
	numNotes: 6, // >= 3
	excludeAll: Set[1, 2, 11],
	includeAll: Set[6, 10],
	includeOneOf: Set[7, 5, 4, 8],
	maxUpperNote: 24,
	rootNoteEqual: "==" // == != oder nil
)
z.next


// DissDegree 3
// B mit Tritonus II ohne kleine Sekunden und große Septimen. Tritonus untergeordnet b mit großer Sekunde ODER(!)  kleiner Septime 1. Grundton Und Basston sind derselbe

z = ~getListComprehension.(
	numNotes: 6, // >= 3
	excludeAll: Set[1, 11],
	includeAll: Set[6],
	includeOneOf: Set[7, 5, 4, 8],
	includeOneOf2: Set[2, 10],
	maxUpperNote: 24,
	rootNoteEqual: "==" // == != oder nil
);
z.all


// DissDegree 4
// B mit Tritonus II ohne kleine Sekunden und große Septimen. Tritonus untergeordnet b mit großer Sekunde ODER(!) kleiner Septime 2. Grundton liegt höher im Akkord

z = ~getListComprehension.(
	numNotes: 3, // >= 3
	excludeAll: Set[1, 11],
	includeAll: Set[6],
	includeOneOf: Set[7, 5, 4, 8],
	includeOneOf2: Set[2, 10],
	maxUpperNote: 24,
	rootNoteEqual: "==" // == != oder nil
);
z.all

//falsch! mehrere Tritoni
// DissDegree 5
// B mit Tritonus II ohne kleine Sekunden und große Septimen. Tritonus untergeordnet b mit großer Sekunde ODER(!) kleiner Septime 3. Mit mehreren Tritoni
z = ~getListComprehension.(
	numNotes: 6, // >= 3
	excludeAll: Set[1, 11],
	includeAll: Set[6],
	includeOneOf: Set[7, 5, 4, 8],
	includeOneOf2: Set[2, 10],
	maxUpperNote: 24,
	//rootNoteEqual: "!="  // == != oder nil
)
z.all.size
z.all


// DissDegree 6
// A ohne Tritonus III Mit Sekunden ODER Septimen 1 Grundton und Basston sind derselbe
z = ~getListComprehension.(
	numNotes: 6, // >= 3
	excludeAll: Set[6],
	//includeAll: Set[6],
	includeOneOf: Set[1,2,10,11],
	maxUpperNote: 24,
	rootNoteEqual: "=="  // == != oder nil
);
{z.next}.bench //dauert 0.006 Sekunden
{z.all}.bench //dauert 6 Sekunden

// DissDegree 7
// A ohne Tritonus III Mit Sekunden ODER Septimen 2 Grundton liegt höher im Akkord
z = ~getListComprehension.(
	numNotes: 6, // >= 3
	excludeAll: Set[6],
	//includeAll: Set[6],
	includeOneOf: Set[1,2,10,11],
	maxUpperNote: 24,
	rootNoteEqual: "!="  // == != oder nil
);
z.all.size


// DissDegree 8
// B mit Tritonus IV Mt kleinen Sekunden ODER großen Septimen. Ein Tritonus oder mehrere untergeordnet 1. Grundton Und Basston sind derselbe
z = ~getListComprehension.(
	numNotes: 6, // >= 3
	//excludeAll: Set[6],
	includeAll: Set[6],
	includeOneOf: Set[1,11],
	includeOneOf2: Set[7, 5, 4, 8],
	maxUpperNote: 24,
	rootNoteEqual: "=="  // == != oder nil
);
z.all.size


// DissDegree 9
// B mit Tritonus IV Mt kleinen Sekunden ODER großen Septimen. Ein Tritonus oder mehrere untergeordnet 2. Grundton liegt höher im Akkord
z = ~getListComprehension.(
	numNotes: 6, // >= 3
	//excludeAll: Set[6],
	includeAll: Set[6],
	includeOneOf: Set[1,11],
	includeOneOf2: Set[7, 5, 4, 8],
	maxUpperNote: 12,
	rootNoteEqual: "!="  // == != oder nil
);
z.next
z.all.at(18981)
{z.all.size}.bench //dauert 0.5 Sekunden


// DissDegree 10
//A ohne Tritonus V Unbestimmbar
[[0,4,8],[0,5,10],[0,5,10,15],[0,5,10,15,20],[0,5,10,15,20,25]]


// DissDegree 11
// B mit Tritonus VI Unbestimmbar Tritonus übergeordnet
(
var maxUpperNote = 40;
var smallestInterval = 3;
//var dissonanzen = [7, 5, 4, 8, 3, 9, 2, 10, 1, 11];

z = all {: (list: [0, n1, n2, n3], rootNote: rootNote),
	n1 <- (smallestInterval, (smallestInterval * 2) ..(maxUpperNote-2)),

	n2 <- ((n1+smallestInterval), (n1+(smallestInterval* 2))..(maxUpperNote-1)),

	n3 <- ((n2+smallestInterval), (n2+(smallestInterval* 2))..maxUpperNote),

	var intervals = ~intervals.([0, n1, n2, n3]).asSet,

	intervals.includes(6),

	:: [0, n1, n2, n3].postln,

	var rootNote = ~rootNote.([0, n1, n2, n3])
};
)
