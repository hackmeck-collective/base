
// 4
z = ~getListComprehension.(
	excludeAll: Set[1, 11],
	includeAll: Set[2, 6, 10],
	includeOneOf: Set[7, 5, 4, 8],
	maxUpperNote: 24,
	rootNoteEqual: "==" // == != oder nil
)

z.next

("[0" ++ 3.collect {|i| ", n%".format(i + 1) }.reduce{|a b| a ++ b}  ++ "]").postcs

~getListComprehension = { |numNotes, excludeAll, includeAll, includeOneOf, maxUpperNote, rootNoteEqual|
	var noteStringArray = (numNotes - 1).collect {|i| "n%".format(i + 1) };
	var noteString = ("[0" ++ (numNotes - 1).collect {|i| ", n%".format(i + 1) }.reduce{|a b| a ++ b}  ++ "]");
	var str = "
{: (list: %, rootNote: rootNote), \n
var maxUpperNote = %, \n

n1 <- (1..(maxUpperNote-%)),".format(noteString, maxUpperNote, numNotes - 2) ++ (if(excludeAll.notNil){"%.includes(n1).not,".format(excludeAll)}{""}) ++ "\n"

	++

(numNotes - 3).collect { |nn|
		"% <- ((%+1)..(maxUpperNote-%)),".format("n" ++ (nn + 2), "n" ++ (nn + 1), numNotes - nn - 3)
		++ (if(excludeAll.notNil){"(% & ~intervals.([0, %]).asSet).isEmpty,".format(
			excludeAll, noteStringArray[0..(nn + 1)].reduce{|a b| a ++ ", " ++ b}
		)}{""}) ++ "\n"

	}.reduce{|a b| a ++ b}





	++ "% <- ((%+1)..maxUpperNote), \n

var intervals = ~intervals.(%).asSet,".format(noteStringArray.last, noteStringArray.wrapAt(-2), noteString)  ++ "\n"

	++ (if(excludeAll.notNil){"(% & intervals).isEmpty,".format(excludeAll)}{""}) ++ "\n"

	++ (if(includeOneOf.notNil){"(intervals & %).notEmpty,".format(includeOneOf)}{""}) ++ "\n"

	++ (if(includeAll.notNil){"% isSubsetOf: intervals,".format(includeAll)}{""}) ++ "\n"

	++ "var rootNote = ~rootNote.(%)".format(noteString) ++ (if(rootNoteEqual.notNil){", (rootNote % 0) && (rootNote.notNil)}".format(rootNoteEqual)}{"}"});
	str.asCompileString.postln;
	str.interpret
};

//1


z = ~getListComprehension.(
	numNotes: 6, // > 3
	excludeAll: Set[1, 2, 6, 10, 11],
	maxUpperNote: 24,
	rootNoteEqual: "==" // == != oder nil
)

z.next