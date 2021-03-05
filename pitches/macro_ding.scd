

~getListComprehension = { |excludeAll, includeAll, includeOneOf, maxUpperNote|
	{: (list: [0, n1, n2, n3], rootNote: rootNote),
		n1 <- (1..(maxUpperNote-2)), excludeAll.includes(n1).not,

		n2 <- ((n1+1)..(maxUpperNote-1)), (excludeAll & ~intervals.([0, n1, n2]).asSet).isEmpty,

		n3 <- ((n2+1)..maxUpperNote),

		var intervals = ~intervals.([0, n1, n2, n3]).asSet,

		(excludeAll & intervals).isEmpty,

		(intervals & includeOneOf).notEmpty,

		includeAll isSubsetOf: intervals,

		var rootNote = ~rootNote.([0, n1, n2, n3]), rootNote == 0
	};
};




z = ~getListComprehension.(
	excludeAll: Set[1, 11],
	includeAll: Set[2, 6, 10],
	includeOneOf: Set[7, 5, 4, 8],
	maxUpperNote: 24,
	rootNoteEqual: "=="
)

z.next

~getListComprehension = { |excludeAll, includeAll, includeOneOf, maxUpperNote, rootNoteEqual|
	var str = "
{: (list: [0, n1, n2, n3], rootNote: rootNote), \n
var maxUpperNote = %, \n
n1 <- (1..(maxUpperNote-2)),".format(maxUpperNote) ++ (if(excludeAll.notNil){"%.includes(n1).not,".format(excludeAll)}{""}) ++ "\n"

	++ "n2 <- ((n1+1)..(maxUpperNote-1))," ++ (if(excludeAll.notNil){"(% & ~intervals.([0, n1, n2]).asSet).isEmpty,".format(excludeAll)}{""}) ++ "\n"

	++ "n3 <- ((n2+1)..maxUpperNote), \n

var intervals = ~intervals.([0, n1, n2, n3]).asSet,"  ++ "\n"

	++ (if(excludeAll.notNil){"(% & intervals).isEmpty,".format(excludeAll)}{""}) ++ "\n"

	++ (if(includeOneOf.notNil){"(intervals & %).notEmpty,".format(includeOneOf)}{""}) ++ "\n"

	++ (if(includeAll.notNil){"% isSubsetOf: intervals,".format(includeAll)}{""}) ++ "\n"

	++ "var rootNote = ~rootNote.([0, n1, n2, n3])" ++ (if(rootNoteEqual.notNil){", rootNote % 0}".format(rootNoteEqual)}{"}"});

	str.interpret
};