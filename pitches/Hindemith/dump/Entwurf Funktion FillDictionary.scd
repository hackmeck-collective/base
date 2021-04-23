



"prepare Session.scd".loadRelative;

"""
Was ich will ist, aus allen möglichen Parametern einen Key erzeugen, der als Wert eine Liste von Events hat. Parameter sind:
(DissDegree:) excludeAll, includeAll, includeOneOf, includeOneOf2, mehrereTritoni, maxUpperNoteWhenBaseIs0, rootNoteEqual,
numNotes, underlyingScale, maxUpperNote, minLowerNote


Parameter ist bspw. NICHT RootNote (weil das vom Controller kommt)


"""

~getArrayOfEventsWithLists = {
	var argumentEnvironment = merge(
		~dissDegreeConstraints[],
		(
			numNotes: ~listAndParameters.numNotes,
			maxUpperNote: (~listAndParameters.maxUpperNote - ~listAndParameters.minLowerNote)
		)
	);
	var list = ~getListComprehension.valueWithEnvir(argumentEnvironment).all; //hiernach müsste dann das Schreiben in das Dictionary geschehen.


};


