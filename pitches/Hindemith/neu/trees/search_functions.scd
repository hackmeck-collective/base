~searchTree = { |chord, rootNote, dissDegree, offset = 2| 	//erstellt ein kdtree-Objekt raus, das bei dieser Adresse liegt.
	var res = ~trees[\numNotes, chord.size, \rootNote, rootNote, \dissDegrees, dissDegree]; //arguments
	if(res.isNil){
		"empty address!".postln;
		nil
	}{
		var tr = res.rectSearch(chord - offset, chord + offset); // KDTree-Suche. Bsp (offset = 5) findet alle Arrays zwischen [0,0,0] und [5,5,5], also [1,2,3].
		if(tr.isEmpty){
			"no results for:\n\tchord: %\n\tdissDegree: %\n\trootNote: %\n\toffset: %".format(
				chord, dissDegree, rootNote, offset
			).postln;
			nil
		}{
			var ret = tr.collect(_.location); //das ist der Wert des Datenfeldes
			"% results".format(ret.size).postln;
			ret
		}
	}
};

// Search within a circle (/hypersphere), defined by a point and a radius
// Das kann man sich so vorstellen: 0,0,0 und 0,1,0 hat die Distanz 1
// 0,0,0 und 0,2,3 hat die Distanz 5
// Hier geben wir den Abstand ein und erhalten Ergebnisse
~searchTreeRadius = { |chord, rootNote, dissDegree, offset = 2|
	var res = ~trees[\numNotes, chord.size, \rootNote, rootNote, \dissDegrees, dissDegree];
	if(res.isNil){
		"empty address!".postln;
		nil
	}{
		var tr = res.radiusSearch(chord, offset); //das nimmt den Abstand und liefert alle Ergebnisse
		if(tr.isEmpty){
			"no results for:\n\tchord: %\n\tdissDegree: %\n\trootNote: %\n\toffset: %".format(
				chord, dissDegree, rootNote, offset
			).postln;
			nil
		}{
			var ret = tr.collect(_.location);
			"% results".format(ret.size).postln;
			ret
		}
	}
};


//Die gibt einem immer ein Ergebnis
~searchTreeNearestOld = { |chord, rootNote, dissDegree|
	var res = ~trees[\numNotes, chord.size, \rootNote, rootNote, \dissDegrees, dissDegree];
	if(res.isNil){
		"empty address!".postln;
		nil
	}{
		var nearestTr = res.nearest(chord); //Methode gibt Array wieder. Array Stelle 0 ist das Ergebnis, Arraystelle 1 gibt die Distanz an
		("nearest chord distance " ++ nearestTr[1]).postln;
		nearestTr[0].location
	}
};



~searchTreeNearest = { |chord, rootNote, dissDegree, numNotes|
	var res = ~trees[\numNotes, numNotes, \rootNote, rootNote, \dissDegrees, dissDegree];
	//"res: ".post; res.postln;
	//[chord, rootNote, dissDegree, numNotes].postcs;
	// res.asArray.printAll;
	if(res.isNil){
		"empty address!".postln;
		nil
	}{
		var nearestTr = res.nearest(chord); //Methode gibt Array wieder. Array Stelle 0 ist das Ergebnis, Arraystelle 1 gibt die Distanz an
/*		nearestTr ? { var path = PathName(thisProcess.nowExecutingPath).pathOnly +/+ "calc/hindemithTrees.archiv";
			"loading archive, because nearestTree seems to be nil ...".postln;
			~trees = Object.readBinaryArchive(path);
			"search_functions.scd".loadRelative;
			"finished loading".postln;
		};*/
		("nearest chord distance " ++ nearestTr[1]).postln;
		nearestTr[0].location
	}
};
