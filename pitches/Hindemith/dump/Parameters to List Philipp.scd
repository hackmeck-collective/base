

~listGeneratorHindemith = (
	list: [0,4,7],
	dissGrade: 0,
	root: 0,
	numberOfNotes: 3,
	fetchList: { |self, listPool| var item = listPool.choose; item},
	actualize: { |self|
		/* //Vorschlag Vincent
		"~root0_pitches3_dissGrade0".interpret
		"~root%_pitches%_dissGrade%".format(root, numberOfNotes, dissGrade).interpret
		*/
		case
		{self.numberOfNotes == 3 && self.dissGrade == 0} {var item = self.fetchList(~root0_pitches3_dissGrade0); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 3 && self.dissGrade == 1} {var item = self.fetchList(~root0_pitches3_dissGrade1); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 3 && self.dissGrade == 2} {var item = self.fetchList(~root0_pitches3_dissGrade2); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 3 && self.dissGrade == 3} {var item = self.fetchList(~root0_pitches3_dissGrade3); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 3 && self.dissGrade == 4} {var item = self.fetchList(~root0_pitches3_dissGrade4); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 3 && self.dissGrade == 5} {var item = self.fetchList(~root0_pitches3_dissGrade5); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 3 && self.dissGrade == 6} {var item = self.fetchList(~root0_pitches3_dissGrade6); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 3 && self.dissGrade == 7} {var item = self.fetchList(~root0_pitches3_dissGrade7); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 3 && self.dissGrade == 8} {var item = self.fetchList(~root0_pitches3_dissGrade8); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 3 && self.dissGrade == 9} {var item = self.fetchList(~root0_pitches3_dissGrade9); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 3 && self.dissGrade == 10} {var item = self.fetchList(~root0_pitches3_dissGrade10); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 3 && self.dissGrade == 11} {var item = self.fetchList(~root0_pitches3_dissGrade11); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}

		{self.numberOfNotes == 4 && self.dissGrade == 0} {var item = self.fetchList(~root0_pitches4_dissGrade0); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 4 && self.dissGrade == 1} {var item = self.fetchList(~root0_pitches4_dissGrade1); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 4 && self.dissGrade == 2} {var item = self.fetchList(~root0_pitches4_dissGrade2); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 4 && self.dissGrade == 3} {var item = self.fetchList(~root0_pitches4_dissGrade3); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 4 && self.dissGrade == 4} {var item = self.fetchList(~root0_pitches4_dissGrade4); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 4 && self.dissGrade == 5} {var item = self.fetchList(~root0_pitches4_dissGrade5); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 4 && self.dissGrade == 6} {var item = self.fetchList(~root0_pitches4_dissGrade6); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 4 && self.dissGrade == 7} {var item = self.fetchList(~root0_pitches4_dissGrade7); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 4 && self.dissGrade == 8} {var item = self.fetchList(~root0_pitches4_dissGrade8); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 4 && self.dissGrade == 9} {var item = self.fetchList(~root0_pitches4_dissGrade9); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 4 && self.dissGrade == 10} {var item = self.fetchList(~root0_pitches4_dissGrade10); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 4 && self.dissGrade == 11} {var item = self.fetchList(~root0_pitches4_dissGrade11); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}

		{self.numberOfNotes == 5 && self.dissGrade == 0} {var item = self.fetchList(~root0_pitches5_dissGrade0); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 5 && self.dissGrade == 1} {var item = self.fetchList(~root0_pitches5_dissGrade1); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 5 && self.dissGrade == 2} {var item = self.fetchList(~root0_pitches5_dissGrade2); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 5 && self.dissGrade == 3} {var item = self.fetchList(~root0_pitches5_dissGrade3); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 5 && self.dissGrade == 4} {var item = self.fetchList(~root0_pitches5_dissGrade4); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 5 && self.dissGrade == 5} {var item = self.fetchList(~root0_pitches5_dissGrade5); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 5 && self.dissGrade == 6} {var item = self.fetchList(~root0_pitches5_dissGrade6); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 5 && self.dissGrade == 7} {var item = self.fetchList(~root0_pitches5_dissGrade7); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 5 && self.dissGrade == 8} {var item = self.fetchList(~root0_pitches5_dissGrade8_range24); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 5 && self.dissGrade == 9} {var item = self.fetchList(~root0_pitches5_dissGrade9_range24); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 5 && self.dissGrade == 10} {var item = self.fetchList(~root0_pitches5_dissGrade10); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 5 && self.dissGrade == 11} {var item = self.fetchList(~root0_pitches5_dissGrade11); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}

		{self.numberOfNotes == 6 && self.dissGrade == 0} {var item = self.fetchList(~root0_pitches6_dissGrade0); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 6 && self.dissGrade == 1} {var item = self.fetchList(~root0_pitches6_dissGrade1); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 6 && self.dissGrade == 2} {var item = self.fetchList(~root0_pitches6_dissGrade2); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 6 && self.dissGrade == 3} {var item = self.fetchList(~root0_pitches6_dissGrade3); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 6 && self.dissGrade == 4} {var item = self.fetchList(~root0_pitches6_dissGrade4); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 6 && self.dissGrade == 5} {var item = self.fetchList(~root0_pitches6_dissGrade5); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 6 && self.dissGrade == 6} {var item = self.fetchList(~root0_pitches6_dissGrade6_range24); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 6 && self.dissGrade == 7} {var item = self.fetchList(~root0_pitches6_dissGrade7); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 6 && self.dissGrade == 8} {var item = self.fetchList(~root0_pitches6_dissGrade8_range24); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 6 && self.dissGrade == 9} {var item = self.fetchList(~root0_pitches6_dissGrade9_range24); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 6 && self.dissGrade == 10} {var item = self.fetchList(~root0_pitches6_dissGrade10); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		{self.numberOfNotes == 6 && self.dissGrade == 11} {var item = self.fetchList(~root0_pitches6_dissGrade11); if(item.notNil,{self.list = item.list; self.dissGrade = item.dissGrade;}); item.postln;}
		;
		}
);

"~listGeneratorHindemith loaded".postln;

~newValue = {|kind, value|
	case
	{kind == "newDissGrade"} {
		var newDissGrade = value;
		if(~listGeneratorHindemith.dissGrade != newDissGrade, {
			~listGeneratorHindemith.dissGrade = newDissGrade;
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
	;
};
"~newValue loaded".postln;

