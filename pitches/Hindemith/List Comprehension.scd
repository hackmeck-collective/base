


~rootNote.([0, 8, 15, 21]); //Mozart Dissonanzenquartett ersten Takte
~intervals.([0, 8, 15, 21]);
Set[1, 2, 6, 10, 11] & Set[5, 6]; //Intersection
(
~excludeAll = Set[1, 2, 6, 10, 11];
(~intervals.([0, 8, 15, 21]).asSet & ~excludeAll).isEmpty
)
~intervalsAndLowNote.([0, 8, 15, 21])
~rootNote.([ 0, 5, 9, 12 ]);
~intervalsAndLowNote.([ 0, 5, 9, 12 ])


(
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


~rootNote = { |pitches|
	var dissonanzen = [7, 5, 4, 8, 3, 9, 2, 10, 1, 11];
	var listen = List.new ! 10; //eine Liste mit Listen, die Kandidaten für Grundtöne enthalten. Die Listen sind nach Güte des Intervals geordnet
	var chooseU = [7, 4, 3, 10, 11]; //Diejenigen Intervalle, bei denen man den UNTEREN Ton nehmen sollte.
	var possibleWinner;
	var winner;
	var intervals = ~intervalsAndNotes.(pitches);

	intervals.do { |event| //Iteriert über die Liste der Events
		if(event.interval != 0 && (event.interval != 6), {
			listen[dissonanzen.indexOf(event.interval)].add(event)
		})
	};
	//winner = listen.detect(_.notEmpty).minItem{|event| event.lowNote};
	possibleWinner = listen.detect(_.notEmpty);
	if(possibleWinner.isNil){
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
};

)

~rootNote.([0,3,6,12])









// DissDegree 0
// A Ohne Tritonus I Ohne Sekunden und Septimen 1 Grundton und Basston sind derselbe
//Vierklänge
(
var excludeAll = Set[1, 2, 6, 10, 11];
var without2or7 = { |set| (excludeAll & set).isEmpty }; //without-2-or-7-constraint
var maxUpperNote = 24;

z = all {: (list: [0, n1, n2, n3], rootNote: rootNote),
	n1 <- (1..(maxUpperNote-2)), excludeAll.includes(n1).not,

	n2 <- ((n1+1)..(maxUpperNote-1)), without2or7.(~intervals.([0, n1, n2]).asSet),

	n3 <- ((n2+1)..maxUpperNote), without2or7.(~intervals.([0, n1, n2, n3]).asSet),

	var rootNote = ~rootNote.([0, n1, n2, n3]), rootNote == 0
};
)
z.size



// DissDegree 1
// A ohne tritonus I Ohne Sekunden und Septimen 2 Grundton liegt hoeher im Akkord
//Vierklänge
(
var excludeAll = Set[1, 2, 6, 10, 11];
var without2or7 = { |set| (excludeAll & set).isEmpty }; //without-2-or-7-constraint
var maxUpperNote = 24;

z = all {: (list: [0, n1, n2, n3], rootNote: rootNote),
	n1 <- (1..(maxUpperNote-2)), excludeAll.includes(n1).not,

	n2 <- ((n1+1)..(maxUpperNote-1)), without2or7.(~intervals.([0, n1, n2]).asSet),

	n3 <- ((n2+1)..maxUpperNote), without2or7.(~intervals.([0, n1, n2, n3]).asSet),

	var rootNote = ~rootNote.([0, n1, n2, n3]), rootNote != 0
};
)
z.size



// DissDegree 2
// B mit tritonus II ohne kleine Sekunden und große Septimen. Tritonus untergeordnet a) Nur mit kleiner Septime (ohne gr. Sekunde) Grundton Und Basston sind derselbe
//Vierklänge
//vgl. Unterweisung im Tonsatz S. 124.
//"Als Erfahrungstatsache steht fest, dass der Tritonus, wenn er mit anderen Intervallen zum Akkord verbunden wird, sich der Herrschaft der starksten Intervall aus der Reihe 2 beugt. Die ersten beiden Paare (Quinte - Quarte, große Terz - kleine Sexte) unterdrücken seine Unbestimmtheit, überlassen sich aber willig der ihm eigenen Zielstrebigkeit. [...] Das nächste Paar (kleine Terz - große Sexte) hat nicht mehr so viel harmonische Kraft, um die Unbestimmtheit des Tritonus in sich zu einem harmonisch sicheren Klang umzuformen. Ein Akkord, der außer dem Tritonus kein besseres Intervall als eines dieser beiden enthält, bleibt deshalb so unbestimmt wie der Tritonus selbst."

(

var excludeAll = Set[1, 2, 11];
var includeAll = Set[6, 10];
var includeAtleastOneOf = Set[7, 5, 4, 8]; // stärkere intervalle als kleine Terz
var maxUpperNote = 24;

//var dissonanzen = [7, 5, 4, 8, 3, 9, 2, 10, 1, 11];

z = all {: (list: [0, n1, n2, n3], rootNote: rootNote),
	n1 <- (1..(maxUpperNote-2)), excludeAll.includes(n1).not,

	n2 <- ((n1+1)..(maxUpperNote-1)), (excludeAll & ~intervals.([0, n1, n2]).asSet).isEmpty,

	n3 <- ((n2+1)..maxUpperNote),

	var intervals = ~intervals.([0, n1, n2, n3]).asSet,

	(excludeAll & intervals).isEmpty,

	// includeAll.isSubsetOf(intervals),
	includeAll isSubsetOf: intervals,

	(intervals & includeAtleastOneOf).notEmpty,

	var rootNote = ~rootNote.([0, n1, n2, n3]), rootNote == 0
};
)
z.size

// DissDegree 3
// B mit Tritonus II ohne kleine Sekunden und große Septimen. Tritonus untergeordnet b mit großer Sekunde und kleiner Septime 1. Grundton Und Basston sind derselbe
(

var excludeAll = Set[1, 11];
var includeAll = Set[2, 6, 10];
var includeOneOf = Set[7, 5, 4, 8];
var maxUpperNote = 24;
//var dissonanzen = [7, 5, 4, 8, 3, 9, 2, 10, 1, 11];

z = all {: (list: [0, n1, n2, n3], rootNote: rootNote),
	n1 <- (1..(maxUpperNote-2)),

	n2 <- ((n1+1)..(maxUpperNote-1)),

	n3 <- ((n2+1)..maxUpperNote),

	var intervals = ~intervals.([0, n1, n2, n3]).asSet,

	(excludeAll & intervals).isEmpty,

	(intervals & includeOneOf).notEmpty,

	includeAll isSubsetOf: intervals,

	var rootNote = ~rootNote.([0, n1, n2, n3]), rootNote == 0
};
)

// DissDegree 4
// B mit Tritonus II ohne kleine Sekunden ODER (!) große Septimen. Tritonus untergeordnet b mit großer Sekunde und kleiner Septime 2. Grundton liegt höher im Akkord
(

var excludeAll = Set[1, 11];
var includeAll = Set[2, 6, 10];
var includeOneOf = Set[7, 5, 4, 8];
var maxUpperNote = 24;
//var dissonanzen = [7, 5, 4, 8, 3, 9, 2, 10, 1, 11];

z = all {: (list: [0, n1, n2, n3], rootNote: rootNote),
	n1 <- (1..(maxUpperNote-2)),

	n2 <- ((n1+1)..(maxUpperNote-1)),

	n3 <- ((n2+1)..maxUpperNote),

	var intervals = ~intervals.([0, n1, n2, n3]).asSet,

	(excludeAll & intervals).isEmpty,

	(intervals & includeOneOf).notEmpty,

	includeAll isSubsetOf: intervals,

	var rootNote = ~rootNote.([0, n1, n2, n3]), rootNote != 0
};
)


// DissDegree 5
// B mit Tritonus II ohne kleine Sekunden ODER (!) große Septimen. Tritonus untergeordnet b mit großer Sekunde und kleiner Septime 3. Mit mehreren Tritoni
(

var excludeAll = Set[1, 11];
var includeOneOf = Set[7, 5, 4, 8];
var includeOneOf2 = Set[2, 10];
var maxUpperNote = 12;
//var dissonanzen = [7, 5, 4, 8, 3, 9, 2, 10, 1, 11];

z = all {: (list: [0, n1, n2, n3], rootNote: rootNote),
	n1 <- (1..(maxUpperNote-2)),

	n2 <- ((n1+1)..(maxUpperNote-1)),

	n3 <- ((n2+1)..maxUpperNote),

	var intervals = ~intervals.([0, n1, n2, n3]),

	(excludeAll & intervals.asSet).isEmpty,

	(intervals.asSet & includeOneOf).notEmpty,

	(intervals.asSet & includeOneOf2).notEmpty,

	(intervals.select({|item| item == 6}).size > 1),

	var rootNote = ~rootNote.([0, n1, n2, n3])

};
)


// DissDegree 6
// A ohne Tritonus III Mit Sekunden ODER Septimen 1 Grundton und Basston sind derselbe
//Vierklänge
(
var excludeAll = Set[6];
var includeAtleastOneOf = Set[1,2,10,11];
var maxUpperNote = 24;

z = all {: (list: [0, n1, n2, n3], rootNote: rootNote),
	n1 <- (1..(maxUpperNote-2)),

	n2 <- ((n1+1)..(maxUpperNote-1)),

	n3 <- ((n2+1)..maxUpperNote),

	var intervals = ~intervals.([0, n1, n2, n3]).asSet,

	(intervals & excludeAll).isEmpty,

	(intervals & includeAtleastOneOf).notEmpty,

	var rootNote = ~rootNote.([0, n1, n2, n3]), rootNote == 0
};
)

// DissDegree 7
// A ohne Tritonus III Mit Sekunden ODER Septimen 2 Grundton liegt höher im Akkord
//Vierklänge
(
var excludeAll = Set[6];
var maxUpperNote = 24;

z = all {: (list: [0, n1, n2, n3], rootNote: rootNote),
	n1 <- (1..(maxUpperNote-2)),

	n2 <- ((n1+1)..(maxUpperNote-1)),


	n3 <- ((n2+1)..maxUpperNote),

	(~intervals.([0, n1, n2, n3]).asSet & excludeAll).isEmpty,

	var rootNote = ~rootNote.([0, n1, n2, n3]), rootNote != 0
};
)
{z.next}.bench

// DissDegree 8
// B mit Tritonus IV Mt kleinen Sekunden ODER großen Septimen. Ein Tritonus oder mehrere untergeordnet 1. Grundton Und Basston sind derselbe
(

var includeOneOf = Set[1, 11];
var includeOneOf2 = Set[7, 5, 4, 8];
var maxUpperNote = 24;
//var dissonanzen = [7, 5, 4, 8, 3, 9, 2, 10, 1, 11];

z = all {: (list: [0, n1, n2, n3], rootNote: rootNote),
	n1 <- (1..(maxUpperNote-2)),

	n2 <- ((n1+1)..(maxUpperNote-1)),

	n3 <- ((n2+1)..maxUpperNote),

	var intervals = ~intervals.([0, n1, n2, n3]).asSet,

	intervals.includes(6);

	(intervals & includeOneOf).notEmpty,

	(intervals & includeOneOf2).notEmpty,

	var rootNote = ~rootNote.([0, n1, n2, n3]), rootNote == 0
};
)


// DissDegree 9
// B mit Tritonus IV Mt kleinen Sekunden ODER großen Septimen. Ein Tritonus oder mehrere untergeordnet 2. Grundton liegt höher im Akkord
(
var includeOneOf = Set[1, 11];
var includeOneOf2 = Set[7, 5, 4, 8];
var maxUpperNote = 24;
//var dissonanzen = [7, 5, 4, 8, 3, 9, 2, 10, 1, 11];

z = all {: (list: [0, n1, n2, n3], rootNote: rootNote),
	n1 <- (1..(maxUpperNote-2)),

	n2 <- ((n1+1)..(maxUpperNote-1)),

	n3 <- ((n2+1)..maxUpperNote),

	var intervals = ~intervals.([0, n1, n2, n3]).asSet,

	intervals.includes(6);

	(intervals & includeOneOf).notEmpty,

	(intervals & includeOneOf2).notEmpty,

	var rootNote = ~rootNote.([0, n1, n2, n3]), rootNote != 0
};
)


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

/*

( // I(alle ohne Tritonus , Sekunden und Septimen
var excludeAll = Set[1, 2, 6, 10, 11];
var removeAll = { |i| (excludeAll & i.mod(12).asArray).isEmpty };
var maxInterval = 15;

z = all {: [0, i1, i2],
i1 <- (1..maxInterval), removeAll.(i1), //Wenn es keins der oben stehenden Intervalle ist, lässt er den Fall durch
//:: i1.postln,
i2 <- (i1 + 1 .. maxInterval), removeAll.(i2),

var invs = ~intervals.([i1, i2]), removeAll.(invs)
}
)

z.next



(  //Auch I, aber mit einem Intervallton mehr
var excludeAll = Set[1, 2, 6, 10, 11];
var removeAll = { |i| (excludeAll & i.mod(12).asArray).isEmpty };
var maxInterval = 23;

z = {: [i1, i2, i3],
i1 <- (1..maxInterval), removeAll.(i1),

i2 <- (i1 + 1.. maxInterval), removeAll.(i2),

var invs = ~intervals.([i1, i2]), removeAll.(invs),

i3 <- (i2 + 1.. maxInterval), removeAll.(i3),

var invs = ~intervals.([i1, i2, i3]), removeAll.(invs) && (~grundTon.([i1, i2, i3]))
}
)





// A Ohne Tritonus I Ohne Sekunden und Septimen 1 Grundton und Basston sind derselbe
( //Ich lgaub, das ist Quatsch hier
var excludeAll = Set[1, 2, 6, 10, 11];
var excludeUnique = Set[5, 8, 9]; //Quarte, kl. Sexte, gr. Sexte.
var removeAll = { |i| (excludeAll & i.mod(12).asArray).isEmpty };
var removeUnique = { |arr i|
if(arr.mod(12).includes(i.mod(12))){
true // pass if the note already exists in a lower octave
}{
(excludeUnique & i.mod(12).asArray).isEmpty
}
};
var maxInterval = 23;

z = {: [0, i1, i2, i3],
i1 <- (1..maxInterval), (
(excludeAll | excludeUnique) & [i1.mod(12)]
).isEmpty,

i2 <- (i1 + 1..maxInterval), removeAll.(i2) && removeUnique.([i1], i2),
var invs = ~intervals.([i1, i2]), removeAll.(invs),

i3 <- (i2 + 1..maxInterval), removeAll.(i3) && removeUnique.([i1, i2], i3),
var invs = ~intervals.([i1, i2, i3]), removeAll.(invs) && (i3 > i2)
};
)
z.all.size


VON VINCENT

// mit tritonus
// Stufe II a //vierklang

(
var excludeAll = Set[1, 2, 11];
var mustInclude = Set[6, 10];
var removeAll = { |i| (excludeAll & i.mod(12).asArray).isEmpty };
var symmetryTest = { |arr1, arr2| (Set.newFrom(arr1) & Set.newFrom(arr2 * 2 % 12)).isEmpty };
var maxInterval = 23;

z = {: [0,i1, i2, i3],
i1 <- (1..maxInterval), removeAll.(i1),

i2 <- (i1 + 1..maxInterval), removeAll.(i2),// && symmetryTest.([i2], [i1]),
//:: ("interval 1: " ++ [i1, intervals]).postln,

var invs = ~intervals.([i1, i2]), removeAll.(invs),// && symmetryTest.(invs, [i1, i2]),

i3 <- (i2 + 1.. maxInterval), removeAll.(i3)  && (mustInclude & [i1, i2, i3].mod(12).asArray).notEmpty,
//:: ("  interval 2: " ++ [i2, intervals]).postln,&& symmetryTest.([i3], [i1, i2])

var invs = ~intervals.([i1, i2, i3]), removeAll.(invs) && (i3 > i2)//symmetryTest.(invs, [i1, i2, i3]) &&
}
)
//Wie kann ein KLang wie [ 0, 3, 4, 10 ] sein?!?
z.next


(
var excludeAll = Set[1, 2, 6, 10, 11];
var excludeUnique = Set[5, 8, 9];
var removeAll = { |i| (excludeAll & i.mod(12).asArray).isEmpty };
var removeUnique = { |arr i|
if(arr.mod(12).includes(i.mod(12))){
true // pass if the note already exist in a lower octave
}{
(excludeUnique & i.mod(12).asArray).isEmpty
}
};
var maxInterval = 60;

z = {: [0, i1, i2, i3, i4, i5, i6, i7],
i1 <- (1..maxInterval), (
(excludeAll | excludeUnique) & [i1.mod(12)]
).isEmpty,

i2 <- (i1 + 1..maxInterval), removeAll.(i2) && removeUnique.([i1], i2),
var invs = ~intervals.([i1, i2]), removeAll.(invs),

i3 <- (i2 + 1..maxInterval), removeAll.(i3) && removeUnique.([i1, i2], i3),
var invs = ~intervals.([i1, i2, i3]), removeAll.(invs),// && (i3 > i2)

i4 <- (i3 + 1..maxInterval), removeAll.(i4) && removeUnique.([i1, i2, i3], i4),
var invs = ~intervals.([i1, i2, i3, i4]), removeAll.(invs),// && (i3 > i2)

i5 <- (i4 + 1..maxInterval), removeAll.(i5) && removeUnique.([i1, i2, i3, i4], i5),
var invs = ~intervals.([i1, i2, i3, i4, i5]), removeAll.(invs),// && (i3 > i2)

i6 <- (i5 + 1..maxInterval), removeAll.(i6) && removeUnique.([i1, i2, i3, i4, i5], i6),
var invs = ~intervals.([i1, i2, i3, i4, i5, i6]), removeAll.(invs),// && (i3 > i2)

i7 <- (i6 + 1..maxInterval), removeAll.(i7) && removeUnique.([i1, i2, i3, i4, i5, i6], i7),
var invs = ~intervals.([i1, i2, i3, i4, i5, i6, i7]), removeAll.(invs) && (i7 > i6)
};
)
{z.next}.bench

[ 0, 3, 7, 12, 36, 39, 48, 60 ]

z.next
z.nextN(10000) //dauert 5 Sekunden
z.all.size //dauert 9 Sekunden

*/ 