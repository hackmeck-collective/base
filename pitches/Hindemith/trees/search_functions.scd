~searchTree = { |chord, rootNote, dissDegree, offset = 2|
	var treeOrList = ~trees[\numNotes, chord.size, \rootNote, rootNote, \dissDegrees, dissDegree];//.rectSearch(chord - 2, chord + 2);
	if(treeOrList.class != List){
		var tr = treeOrList.rectSearch(chord - offset, chord + offset);
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
	}{
		"empty address!".postln;
		nil
	}
};

// Search within a circle (/hypersphere), defined by a point and a radius
~searchTreeRadius = { |chord, rootNote, dissDegree, offset = 2|
	var treeOrList = ~trees[\numNotes, chord.size, \rootNote, rootNote, \dissDegrees, dissDegree];//.rectSearch(chord - 2, chord + 2);
	if(treeOrList.class != List){
		var tr = treeOrList.radiusSearch(chord, offset);
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
	}{
		"empty address!".postln;
		nil
	}
};

~searchTreeNearest = { |chord, rootNote, dissDegree|
	var treeOrList = ~trees[\numNotes, chord.size, \rootNote, rootNote, \dissDegrees, dissDegree];//.rectSearch(chord - 2, chord + 2);
	if(treeOrList.class != List){
		var nearestTr = treeOrList.nearest(chord);
		if(nearestTr.isEmpty){
			"dissDegree % rootNote % no results".format(dissDegree, rootNote).postln;
			nil
		}{
			("nearest chord distance " ++ nearestTr[1]).postln;
			nearestTr[0].location
		}
	}{
		"empty address!".postln;
		nil
	}
};

