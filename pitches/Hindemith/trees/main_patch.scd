(
var path = PathName(thisProcess.nowExecutingPath).pathOnly +/+ "calc/hindemithTrees.archiv";
"loading archive ...".postln;
~trees = Object.readBinaryArchive(path);
"search_functions.scd".loadRelative;
"piano_gui.scd".loadRelative;
"finished loading".postln;

)



// result might be same as input at the moment
~searchTreeNearestOld.(chord: [1,4,10,12], rootNote: 0, dissDegree: 1, underlyingScale: \Major)

// query the tree
~trees[\underlyingScale, \Chromatic, \numNotes, 5, \rootNote, 0, \dissDegrees, 3].nearest([ 0, 4, 10, 14, 26.0 ])[0].location;
~trees[\underlyingScale, 'Whole Tone', \numNotes, 6, \rootNote, 0, \dissDegrees, 2].asArray.choose;





/*
 //für piano_gui

~chordNow = [0, 4, 7, 11];
(
var res = ~searchTreeNearestOld.(underlyingScale: \Chromatic, chord: ~chordNow, rootNote: 4, dissDegree: 3);
res !? {
	~chordNow = res.postln;
	~startPiano.showKeys(~chordNow)
}
)

//~trees[\numNotes, 4, \rootNote, 0, \dissDegrees, 1].nearest([ 0, 7, 12,18])//[0].location;

*/