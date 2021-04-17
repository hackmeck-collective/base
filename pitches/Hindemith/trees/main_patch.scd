(
var path = PathName(thisProcess.nowExecutingPath).pathOnly +/+ "calc/hindemithTrees.archiv";
"loading archive ...".postln;
~trees = Object.readBinaryArchive(path);
"search_functions.scd".loadRelative;
"finished loading".postln;
)

~searchTree.(chord: [1, 4, 9, 12, 24], rootNote: 3, dissDegree: 0, offset: 3)
~searchTreeRadius.(chord: [0,4,10,15], rootNote: 0, dissDegree: 1, offset: 4)
// der radius offset entspricht der distance von search nearest
~searchTreeNearest.(chord: [0,4,10,15], rootNote: 0, dissDegree: 1)


~trees[\numNotes, 3, \rootNote, 0]