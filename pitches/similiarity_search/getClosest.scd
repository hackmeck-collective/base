(
~intervals = { |chord|
	all {: (chord[i+gap] - chord[i]).mod(12),
		gap <- (1 .. chord.lastIndex),
		i <- (0 .. chord.lastIndex - gap)
	}
};

~getClosest = { |notes, excludeAll, includeAll, includeOneOf|
	var testSteps = [-1,1,-2,2,-3,3,-4,4,-5,5];
	var testSize = (notes.size) * testSteps.size; //Anzahl der Testes
	var seq = Pseq(testSteps, inf).asStream;
	var search = true;
	testSize.do { |i|
		var cp = notes.copy;
		var addNow = seq.next;
		var testi;
		cp[(i / testSteps.size)] = cp[(i / testSteps.size)] + addNow;
		// cp.postln;
		//cp = cp.mod(12).as(Set);
		testi = ~intervals.(cp).mod(12).as(Set);
		if(
			(excludeAll & testi).isEmpty &&
			(testi & includeOneOf).notEmpty &&
			includeAll.isSubsetOf(testi) &&
				(search == true)
		) {~list = cp; search = false;}
	};
	~list.postln;

};
)



~list = [0,4,7,11];
(
~getClosest.(
	notes: ~list ,
	excludeAll: Set[1, 2, 6, 10, 11], //DissDegree 1
	includeAll: Set[],
	includeOneOf: Set[0,1,2,3,4,5,6,7,8,9,10,11],
)

)
(
~getClosest.(
	notes: ~list ,
	excludeAll: Set[1, 11], //DissDegree 4
	includeAll: Set[2, 6, 10],
	includeOneOf: Set[7, 5, 4, 8],
)
)