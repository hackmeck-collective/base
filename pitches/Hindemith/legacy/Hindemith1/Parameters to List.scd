

~listGeneratorHindemith = (
	list: [0,4,7],
	dissDegree: 0,
	root: 0,
	numberOfNotes: 3,
	fetchList: { |self, listPool| var item = listPool.choose; item},
	actualize: { |self|
		var item = self.fetchList(
			"~root0_pitches%_dissGrade%_range24".format(self.numberOfNotes.asInteger, self.dissDegree.asInteger).interpret
		);
		if(item.notNil,{ var newList = item.list + self.root;
			if(newList.first < 12, {self.list = newList;},{self.list = newList - 12});
			self.dissDegree = item.dissGrade;
		});
		~objSpace[\pitches] = self.list; //Utopia Message
		~objSpace[\root] = self.root.mod(12);

	}
);

"~listGeneratorHindemith loaded".postln;

~newValue = {|kind, value|
	case
	{kind == "newDissDegree"} {
		var newDissDegree = value;
		if(~listGeneratorHindemith.dissDegree != newDissDegree, {
			~listGeneratorHindemith.dissDegree = newDissDegree;
			~listGeneratorHindemith.actualize;
		});
	}
	{kind == "newNumberOfNotes"} {
		var newNumberOfNotes = value;
		if(~listGeneratorHindemith.numberOfNotes != newNumberOfNotes, {
			~listGeneratorHindemith.numberOfNotes = newNumberOfNotes;
			~listGeneratorHindemith.actualize;
		});
	}
	{kind == "newRoot"} {
		var newRoot = value;
		if(~listGeneratorHindemith.root != newRoot, {
			~listGeneratorHindemith.root = newRoot;
			~listGeneratorHindemith.actualize;
		});
	}


	;
};
"~newValue loaded".postln;

