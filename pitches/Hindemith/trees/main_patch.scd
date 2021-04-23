(
var path = PathName(thisProcess.nowExecutingPath).pathOnly +/+ "calc/hindemithTrees.archiv";
"loading archive ...".postln;
~trees = Object.readBinaryArchive(path);
"search_functions.scd".loadRelative;
"finished loading".postln;
)

// result might be same as input at the moment
~searchTree.(chord: [1, 4, 9, 12, 24], rootNote: 3, dissDegree: 2, offset: 3)
~searchTreeRadius.(chord: [0,4,10,15], rootNote: 0, dissDegree: 1, offset: 4)
// der radius offset entspricht der distance von search nearest
~searchTreeNearest.(chord: [0,4,10,12], rootNote: 7, dissDegree: 1)

// query the tree
~trees[\numNotes, 3, \rootNote, 8, \dissDegrees, 3].asArray
~trees[\numNotes, 5, \rootNote, \noRootNote] // selten



"piano_gui.scd".loadRelative;

~chordNow = [0,3,7,14];
~startPiano.init(~chordNow);
(
var res = ~searchTree.(chord: ~chordNow, rootNote: 2, dissDegree: 1, offset: 2);
res !? {
	~chordNow = res.choose.postln;
	~startPiano.showKeys(~chordNow)
}
)

~chordNow = [0, 4, 7, 11];
(
var res = ~searchTreeNearest.(chord: ~chordNow, rootNote: 4, dissDegree: 2);
res !? {
	~chordNow = res.postln;
	~startPiano.showKeys(~chordNow)
}
)