
/*
Überlegung "Welche Parameter für die Listen?"
1. Chromatik
2. Messiaen3 - 0,2,3,4,6,7,8,10,11
3. Alternierende Achtstufigkeit
4. Diatonik
5. Ganzton
6. Konstrukt - 0,1,4,5,8,9
*/



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


