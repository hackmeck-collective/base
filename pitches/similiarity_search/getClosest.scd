(
~intervals = { |chord|
	all {: (chord[i+gap] - chord[i]).mod(12),
		gap <- (1 .. chord.lastIndex),
		i <- (0 .. chord.lastIndex - gap)
	}
};

~getClosest = { |notes, excludeAll, includeAll, includeOneOf|
	var testSteps = [-1,1,-2,2,-3,3,-4,4,-5,5];
	var testSize = (notes.size) * testSteps.size; //Anzahl der Tests
	var seq = Pseq(testSteps, inf).asStream;
	var search = true;
	testSize.do { |i|
		var cp = notes.copy;
		var addNow = seq.next;
		var testi;
		cp[(i / testSteps.size)] = cp[(i / testSteps.size)] + addNow;
		// cp.postln;
		//cp = cp.mod(12).as(Set);
		testi = ~intervals.(cp).mod(12).as(Set);
		if(
			(excludeAll & testi).isEmpty &&
			(testi & includeOneOf).notEmpty &&
			includeAll.isSubsetOf(testi) &&
			(search == true)
		) {~list = cp; search = false;}
	};
	~list.postln;
};
)

~list = [0,4,7,11];
(
~getClosest.(
	notes: ~list ,
	excludeAll: Set[1, 2, 6, 10, 11], //DissDegree 1
	includeAll: Set[],
	includeOneOf: Set[0,1,2,3,4,5,6,7,8,9,10,11],
)

)
(
~getClosest.(
	notes: ~list ,
	excludeAll: Set[1, 11], //DissDegree 4
	includeAll: Set[2, 6, 10],
	includeOneOf: Set[7, 5, 4, 8],
)
)



"""
Was soll getClosest machen?
Es nimmt eine Liste mit Noten entgegen.

Es nimmt einen Array2 mit Listen entgegen.

(Es testet als erstes mal, ob es die Liste auch in Array2 gibt. Wenn ja, brich Suche ab und liefere Liste.)

Es iteriert über eine begrenzte Liste bspw. (1..2)

In dieser Iteration iteriert es über die Liste.

Bsp-Liste [n0, n1, n2]

n0 + 1, n1, n2
Ist das gleich einer Liste aus dem Array2?
Wenn ja, brich die Suche ab, liefere die Liste aus Array2.
Wenn nein, mach weiter
n0 -1, n1, n2
Ist das gleich einer Liste aus dem Array2?
Wenn ja, brich die Suche ab, liefere die Liste aus Array2.
Wenn nein, mach weiter
n0, n1 + 1, n2
Ist das gleich einer Liste aus dem Array2?
Wenn ja, brich die Suche ab, liefere die Liste aus Array2.
Wenn nein, mach weiter
n0, n1 - 1, n2
Ist das gleich einer Liste aus dem Array2?
Wenn ja, brich die Suche ab, liefere die Liste aus Array2.
Wenn nein, mach weiter
n0, n1, n2 +1
Ist das gleich einer Liste aus dem Array2?
Wenn ja, brich die Suche ab, liefere die Liste aus Array2.
Wenn nein, mach weiter
n0, n1 n2 -1
Ist das gleich einer Liste aus dem Array2?
Wenn ja, brich die Suche ab, liefere die Liste aus Array2.
Wenn nein, mach weiter

usw. für die Zahlen 2 und 3

"""

~getClosest = { |list, arrayOfLists|
	var maxDistance = 3;
	var search = true;
	var returnList;
	var distances = all {: [x, y, z],
		x <- (-2..2),
		y <- (-2..2),
		z <- (-2..2)
	}.sort({|a,b| a.sum({|i| i.abs}) < b.sum({|i| i.abs})}).drop(1); // einmal global ausrechnen!!

	distances.do {|distance|
		var testlist = list + distance;
 //anschließend von der Testlist die Intervalle berechnen mit ~intervals und die Rootnote mit ~rootNote, und dann aus dem Dissonanzgrad-dictionary die relevanten Dissonanzgrad-Constraits rauslesen und abtesten mit den Werten.
		if ( arrayOfLists.includesEqual(testList) && search )
		{ search = false; returnList = testList};
	}
};
returnList
};

~getClosest.value([0,1,2], [[5,5,5],[6,6,6],[0,1,5],[0,2,3]]);




(

var list = [0,0,0];
var indices = (0..list.size-1);
var maxDistance = 3;
var distances = Array.fill(maxDistance, {|i| i = i + 1; Array.with(i, i * -1)}).flat;
var search = true;
var returnList;
var allCombinations = indices.powerset;
allCombinations.removeAt(0); //Without empty Array

distances.do { |distance|
	allCombinations.sort({|a,b| a.size < b.size}).do { |combination|
		var testList = list.copy;
		combination.do { |index|
			testList.put(index, list[index] + distance);
		};
		(testList.asString).postln;
	}
}
)


Array.fill(2, {|i| i = i +1; Array.with(i, i * -1)}).flat.insert(0,0)
.stutter(3)
.powerset.select({|array| array.size == 3})
.sort({|a,b| a.sum({|i| i.abs}) < b.sum({|i| i.abs})})
.collect {|arr| var per = []; arr.size.do { |i| per = per.add(arr.permute(i)) }; per}.flatten(1)





(
a = all {: [x, y, z],
	x <- (-2..2),
	y <- (-2..2),
	z <- (-2..2)

}.sort({|a,b| a.sum({|i| i.abs}) < b.sum({|i| i.abs})})
)



~dissDegreeConstraints = (
	0: (
		excludeAll: Set[1, 2, 6, 10, 11],
		rootNoteEqual: "==" // == != oder nil
	),

	1: (
		excludeAll: Set[1, 2, 6, 10, 11],
		rootNoteEqual: "!=" // == != oder nil
	),
	2: (
		excludeAll: Set[1, 2, 11],
		includeAll: Set[6, 10],
		includeOneOf: Set[7, 5, 4, 8],
		rootNoteEqual: "==" // == != oder nil
	)
)

( 'excludeAll': Set[ 6, 2, 10, 11, 1 ], 'rootNoteEqual': '==' ).putAll((numNotes: 3,
	maxUpperNote: (24))) // events kombinieren


~getArrayOfEventsWithLists = {
	var argumentEnvironment = ~dissDegreeConstraints[~listAndParameters.dissDegree].putAll((
		numNotes: ~listAndParameters.numNotes,
		maxUpperNote: (~listAndParameters.maxUpperNote - ~listAndParameters.minLowerNote)
	));
	~getListComprehension.valueWithEnvir(argumentEnvironment).all //hiernach müsste dann das Schreiben in das Dictionary geschehen.

};

//Was Du machst, ist mittels der Constraints testen, ob die Testliste im Dissonanzgrad-Bereich liegt. 