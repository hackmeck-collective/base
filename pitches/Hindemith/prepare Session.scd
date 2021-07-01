
~actualizeGUI = {
	{~numberboxDissDegree.value =  ~listAndParameters.dissDegree}.defer; //set NumberBox DissDegree
	{~textfieldList.value = ~listAndParameters.list}.defer; //set TextField list
	{~textfieldRoot.value = ~listAndParameters.rootNote}.defer; //set TextField RootNote
	{~numberboxNumberNotes.value = ~listAndParameters.list.size}.defer;  // set NumberBox NumNotes
	{~textfieldScale.value = ~listAndParameters.underlyingScale.asString[0..9]}.defer; // set TextField Scale
	{~numberboxLowerNote.value = ~listAndParameters.lowNote}.defer; // set NumberBox LowNote
	{~numberboxHigherNote.value = ~listAndParameters.highNote}.defer; // set NumberBox HighNote
	~startPiano.showKeys(~listAndParameters.list);
};

~listAndParameters = (
	list: [ 0, 4, 7, 12],
	underlyingScale: 'Major',
	dissDegree: 0,
	rootNote: 0,
	minLowerNote: 0,
	maxUpperNote: 12,
	lowNote: 36,
	highNote: 96
);



"loading archive ...".postln;
~trees = Object.readBinaryArchive(PathName(thisProcess.nowExecutingPath).pathOnly +/+ "trees/calc/hindemithTrees.archiv");
"trees/search_functions.scd".loadRelative;
"finished loading".postln;



