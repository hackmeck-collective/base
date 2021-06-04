
~actualizeGUI = {
	{~numberboxDissDegree.value =  ~listAndParameters.dissDegree}.defer; //set NumberBox DissDegree
	{~textfieldList.value = ~listAndParameters.list}.defer; //set TextField list
	{~textfieldRoot.value = ~listAndParameters.rootNote}.defer; //set TextField RootNote
	{~numberboxNumberNotes.value = ~listAndParameters.list.size}.defer;  // set NumberBox NumNotes
	{~textfieldScale.value = ~listAndParameters.underlyingScale}.defer; // set TextField Scale
};

~listAndParameters = (
	list: [ 0, 4, 7, 12],
	underlyingScale: \Chromatic,
	dissDegree: 0,
	rootNote: 0,
	minLowerNote: 0,
	maxUpperNote: 12,
);



"loading archive ...".postln;
~trees = Object.readBinaryArchive(PathName(thisProcess.nowExecutingPath).pathOnly +/+ "trees/calc/hindemithTrees.archiv");
"trees/search_functions.scd".loadRelative;
"finished loading".postln;



