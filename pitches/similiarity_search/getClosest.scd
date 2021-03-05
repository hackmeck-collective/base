~intervals = { |chord|
	all {: (chord[i+gap] - chord[i]).mod(12),
		gap <- (1 .. chord.lastIndex),
		i <- (0 .. chord.lastIndex - gap)
	}
};

~getClosest = { |notes, excludeAll, includeAll, includeOneOf|
	var testSize = (notes.size - 1) * 4;
	var seq = Pseq([-1,1,-2,2],inf).asStream;
	testSize.do { |i|
		var cp = notes.copy;
		var addNow = seq.next;
		var testi;
		cp[(i / 4) + 1] = cp[(i / 4) + 1] + addNow;
		cp.postln;
		//cp = cp.mod(12).as(Set);
		testi = ~intervals.(cp).mod(12).as(Set);
		(
			(excludeAll & testi).isEmpty && (testi & includeOneOf).notEmpty && (includeAll.isSubsetOf(testi))
		).postln
	}
};

(
~getClosest.(
	notes:[ 0, 1, 6, 10 ] ,
	excludeAll: Set[1, 11],
	includeAll: Set[2, 6, 10],
	includeOneOf: Set[7, 5, 4, 8],
)
)