~searchTree = { |chord, rootNote, dissDegree, offset = 2|
	var res = ~trees[\numNotes, chord.size, \rootNote, rootNote, \dissDegrees, dissDegree];
	if(res.isNil){
		"empty address!".postln;
		nil
	}{
		var tr = res.rectSearch(chord - offset, chord + offset);
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

// Search within a circle (/hypersphere), defined by a point and a radius
~searchTreeRadius = { |chord, rootNote, dissDegree, offset = 2|
	var res = ~trees[\numNotes, chord.size, \rootNote, rootNote, \dissDegrees, dissDegree];
	if(res.isNil){
		"empty address!".postln;
		nil
	}{
		var tr = res.radiusSearch(chord, offset);
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

~searchTreeNearest = { |chord, rootNote, dissDegree|
	var res = ~trees[\numNotes, chord.size, \rootNote, rootNote, \dissDegrees, dissDegree];
	if(res.isNil){
		"empty address!".postln;
		nil
	}{
		var nearestTr = res.nearest(chord);
		("nearest chord distance " ++ nearestTr[1]).postln;
		nearestTr[0].location
	}
};

