

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
		rootNoteEqual: "==" // == != oder nil
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



~getListComprehension = { |numNotes, underlyingScale, excludeAll, includeAll, includeOneOf, includeOneOf2, mehrereTritoni, maxUpperNoteWhenBaseIs0, rootNoteEqual|
	var noteStringArray = (numNotes - 1).collect {|i| "n%".format(i + 1) };
	var noteString = ("[0" ++ (numNotes - 1).collect {|i| ", n%".format(i + 1) }.reduce{|a b| a ++ b}  ++ "]");
	var str = "
{: (list: %, rootNote: rootNote), \n
var maxUpperNoteWhenBaseIs0 = %, \n

n1 <- (1..(maxUpperNoteWhenBaseIs0-%)),".format(noteString, maxUpperNoteWhenBaseIs0, numNotes - 2)
	++ (if(excludeAll.notNil){"%.includes(n1.mod(12)).not,".format(excludeAll)} {""})
	++ (if(underlyingScale.notNil){"%.includes(n1.mod(12)),".format(underlyingScale)}{""}) ++ "\n"

	++
	(if(numNotes==3){""}{
		(numNotes - 3).collect { |nn|
			"% <- ((%+1)..(maxUpperNoteWhenBaseIs0-%)),".format("n" ++ (nn + 2), "n" ++ (nn + 1), numNotes - nn - 3)
			++ (if(excludeAll.notNil){"(% & ~intervals.([0, %]).asSet).isEmpty,".format(
				excludeAll, noteStringArray[0..(nn + 1)].reduce{|a b| a ++ ", " ++ b}
			)}{""})
			++ (if(underlyingScale.notNil){"([0, %].asSet - %).isEmpty,".format(
				noteStringArray[0..(nn + 1)].reduce{|a b| a ++ ", " ++ b}, underlyingScale
			)}{""})
			++ "\n"

		}.reduce{|a b| a ++ b}
	})
	++ "% <- ((%+1)..maxUpperNoteWhenBaseIs0), \n

var intervals = ~intervals.(%),".format(noteStringArray.last, noteStringArray.wrapAt(-2), noteString)  ++ "\n"



	++ (if(excludeAll.notNil){"(% & intervals.asSet).isEmpty,".format(excludeAll)}{""}) ++ "\n"

	++ (if(includeOneOf.notNil){"(intervals.asSet & %).notEmpty,".format(includeOneOf)}{""}) ++ "\n"

	++ (if(includeOneOf2.notNil){"(intervals.asSet & %).notEmpty,".format(includeOneOf2)}{""}) ++ "\n"

	++ (if(includeAll.notNil){"% isSubsetOf: intervals.asSet,".format(includeAll)}{""}) ++ "\n"

	++ (if(mehrereTritoni.notNil){"(intervals.count({|item| item.mod(12) == 6}) >= 2),"}{""}) ++ "\n"

	++ "var rootNote = ~rootNote.(%)".format(noteString)

	++ (if(rootNoteEqual.notNil){", (rootNote % 0) && (rootNote.notNil)}".format(rootNoteEqual)}{"}"});

	str.asCompileString.postln;
	str.interpret
};

~getArrayOfEventsWithLists = {
	if(~listAndParameters.dissDegree == 11){
		var numNotes = ~listAndParameters.numNotes; //3-5
		var ambitus = (~listAndParameters.maxUpperNote - ~listAndParameters.minLowerNote);
		var timesThree = Array.series((ambitus / 3).trunc.asInteger + 1, 0, 3);
		var arrayOfLists = timesThree.powerset.select({
			arg item;
			item.size == numNotes && ((item.mod(12).asSet.size >= 3) && item.includes(0))
		});
		var arrayOfEventsWithLists = [];
		arrayOfLists.do({ arg item;
			arrayOfEventsWithLists = arrayOfEventsWithLists.acontraintsdd((list: item, rootNote: 0))
		});
		arrayOfEventsWithLists
	}{
		var inputs = merge(~dissDegreeConstraints[~listAndParameters.dissDegree],(
			numNotes: ~listAndParameters.numNotes,
			maxUpperNoteWhenBaseIs0: (~listAndParameters.maxUpperNote - ~listAndParameters.minLowerNote)
		));
		~getListComprehension.(inputs).all
	};
};

/*
~getArrayOfEventsWithLists = {

case

{~listAndParameters.dissDegree == 0} {
// DissDegree 0
// A Ohne Tritonus I Ohne Sekunden und Septimen 1 Grundton und Basston sind derselbe
~getListComprehension.(
numNotes: ~listAndParameters.numNotes, // >= 3
excludeAll: Set[1, 2, 6, 10, 11],
//includeAll: Set[],
//includeOneOf: Set[0,1,2,3,4,5,6,7,8,9,10,11],
maxUpperNoteWhenBaseIs0: (~listAndParameters.maxUpperNote - ~listAndParameters.minLowerNote),
rootNoteEqual: "==" // == != oder nil
).all //hiernach müsste dann das Schreiben in das Dictionary geschehen.
}





{~listAndParameters.dissDegree == 1} {
// DissDegree 1
// A ohne tritonus I Ohne Sekunden und Septimen 2 Grundton liegt hoeher im Akkord
~getListComprehension.(
numNotes: ~listAndParameters.numNotes, // >= 3
excludeAll: Set[1, 2, 6, 10, 11],
//includeAll: Set[],
//includeOneOf: Set[0,1,2,3,4,5,6,7,8,9,10,11],
maxUpperNoteWhenBaseIs0: (~listAndParameters.maxUpperNote - ~listAndParameters.minLowerNote),
rootNoteEqual: "!=" // == != oder nil
).all
}



{~listAndParameters.dissDegree == 2}
{
// DissDegree 2
// B mit tritonus II ohne kleine Sekunden und große Septimen. Tritonus untergeordnet a) Nur mit kleiner Septime (ohne gr. Sekunde) Grundton Und Basston sind derselbe

~getListComprehension.(
numNotes: ~listAndParameters.numNotes, // >= 3
excludeAll: Set[1, 2, 11],
includeAll: Set[6, 10],
includeOneOf: Set[7, 5, 4, 8],
maxUpperNoteWhenBaseIs0: (~listAndParameters.maxUpperNote - ~listAndParameters.minLowerNote),
rootNoteEqual: "==" // == != oder nil
).all
}


{~listAndParameters.dissDegree == 3} {
// DissDegree 3
// B mit Tritonus II ohne kleine Sekunden und große Septimen. Tritonus untergeordnet b mit großer Sekunde ODER(!)  kleiner Septime 1. Grundton Und Basston sind derselbe

~getListComprehension.(
numNotes: ~listAndParameters.numNotes, // >= 3
excludeAll: Set[1, 11],
includeAll: Set[6],
includeOneOf: Set[7, 5, 4, 8],
includeOneOf2: Set[2, 10],
maxUpperNoteWhenBaseIs0: (~listAndParameters.maxUpperNote - ~listAndParameters.minLowerNote),
rootNoteEqual: "==" // == != oder nil
).all
}


{~listAndParameters.dissDegree == 4} {
// DissDegree 4
// B mit Tritonus II ohne kleine Sekunden und große Septimen. Tritonus untergeordnet b mit großer Sekunde ODER(!) kleiner Septime 2. Grundton liegt höher im Akkord

~getListComprehension.(
numNotes: ~listAndParameters.numNotes, // >= 3
excludeAll: Set[1, 11],
includeAll: Set[6],
includeOneOf: Set[7, 5, 4, 8],
includeOneOf2: Set[2, 10],
maxUpperNoteWhenBaseIs0: (~listAndParameters.maxUpperNote - ~listAndParameters.minLowerNote),
rootNoteEqual: "==" // == != oder nil
).all
}

{~listAndParameters.dissDegree == 5} {
// DissDegree 5
// B mit Tritonus II ohne kleine Sekunden und große Septimen. Tritonus untergeordnet b mit großer Sekunde ODER(!) kleiner Septime 3. Mit mehreren Tritoni
~getListComprehension.(
numNotes: ~listAndParameters.numNotes, // >= 3
excludeAll: Set[1, 11],
includeAll: Set[6],
includeOneOf: Set[7, 5, 4, 8],
includeOneOf2: Set[2, 10],
mehrereTritoni: true,
maxUpperNoteWhenBaseIs0: (~listAndParameters.maxUpperNote - ~listAndParameters.minLowerNote)
).all
}



{~listAndParameters.dissDegree == 6} {
// DissDegree 6
// A ohne Tritonus III Mit Sekunden ODER Septimen 1 Grundton und Basston sind derselbe

~getListComprehension.(
numNotes: ~listAndParameters.numNotes,
excludeAll: Set[6],
//includeAll: Set[6],
includeOneOf: Set[1,2,10,11],
maxUpperNoteWhenBaseIs0: (~listAndParameters.maxUpperNote - ~listAndParameters.minLowerNote),
rootNoteEqual: "=="
).all
}
//{z.next}.bench //dauert 0.006 Sekunden
//{z.all}.bench //dauert 6 Sekunden


{~listAndParameters.dissDegree == 7} {
// DissDegree 7
// A ohne Tritonus III Mit Sekunden ODER Septimen 2 Grundton liegt höher im Akkord
~getListComprehension.(
numNotes: ~listAndParameters.numNotes, // >= 3
excludeAll: Set[6],
//includeAll: Set[6],
includeOneOf: Set[1,2,10,11],
maxUpperNoteWhenBaseIs0: (~listAndParameters.maxUpperNote - ~listAndParameters.minLowerNote),
rootNoteEqual: "!="  // == != oder nil
).all
}
//z.all.size


{~listAndParameters.dissDegree == 8} {
// DissDegree 8
// B mit Tritonus IV Mt kleinen Sekunden ODER großen Septimen. Ein Tritonus oder mehrere untergeordnet 1. Grundton Und Basston sind derselbe
~getListComprehension.(
numNotes: ~listAndParameters.numNotes, // >= 3
//excludeAll: Set[6],
includeAll: Set[6],
includeOneOf: Set[1,11],
includeOneOf2: Set[7, 5, 4, 8],
maxUpperNoteWhenBaseIs0: (~listAndParameters.maxUpperNote - ~listAndParameters.minLowerNote),
rootNoteEqual: "=="  // == != oder nil
).all
}
//z.all.size


{~listAndParameters.dissDegree == 9} {
// DissDegree 9
// B mit Tritonus IV Mt kleinen Sekunden ODER großen Septimen. Ein Tritonus oder mehrere untergeordnet 2. Grundton liegt höher im Akkord
~getListComprehension.(
numNotes: ~listAndParameters.numNotes, // >= 3
underlyingScale: (0..11).asSet,
//excludeAll: Set[6],
includeAll: Set[6],
includeOneOf: Set[1,11],
includeOneOf2: Set[7, 5, 4, 8],
maxUpperNoteWhenBaseIs0: (~listAndParameters.maxUpperNote - ~listAndParameters.minLowerNote),
rootNoteEqual: "!="  // == != oder nil
).all
}

{~listAndParameters.dissDegree == 10}
// DissDegree 10
//A ohne Tritonus V Unbestimmbar
{
var numNotes = ~listAndParameters.numNotes; //3-5
var interval = [4,5].choose;
var list = Array.series(numNotes, 0, interval);
var rootNote;

if (interval == 5) {rootNote = list.last.mod(12)} {rootNote = 0} ;
[(list: list, rootNote: rootNote)]
}

{~listAndParameters.dissDegree == 11}
// DissDegree 11
// B mit Tritonus VI Unbestimmbar Tritonus übergeordnet
{
var numNotes = ~listAndParameters.numNotes; //3-5
var ambitus = (~listAndParameters.maxUpperNote - ~listAndParameters.minLowerNote);
var timesThree = Array.series((ambitus / 3).trunc.asInteger + 1, 0, 3);
var arrayOfLists = timesThree.powerset.select({
arg item;
item.size == numNotes && ((item.mod(12).asSet.size >= 3) && item.includes(0))
});
var arrayOfEventsWithLists = [];
arrayOfLists.do({ arg item;
arrayOfEventsWithLists = arrayOfEventsWithLists.acontraintsdd((list: item, rootNote: 0))
});
arrayOfEventsWithLists
};

};
*/

~actualizeGUI = {
	{~numberboxDissDegree.value =  ~listAndParameters.dissDegree}.defer; //set NumberBox DissDegree
	{~textfieldList.value = ~listAndParameters.list}.defer; //set TextField list
	{~textfieldRoot.value = ~listAndParameters.rootNote}.defer; //set TextField RootNote
	{~numberboxNumberNotes.value = ~listAndParameters.numNotes}.defer;  // set NumberBox NumNotes
};

~listAndParameters = (
	list: [ 0, 4, 7, 12],
	dissDegree: 0,
	numNotes: 4,
	rootNote: 0,
	minLowerNote: 0,
	maxUpperNote: 12
);

