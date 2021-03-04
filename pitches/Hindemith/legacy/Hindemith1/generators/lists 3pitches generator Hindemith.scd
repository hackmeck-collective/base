

(

var obergrenze = 48; //48 midi notes are 4 octaves

var fileDissgrade0 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 3pitches/list_3pitches_dissGrade0.txt","w");
var fileDissgrade1 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 3pitches/list_3pitches_dissGrade1.txt","w");
var fileDissgrade2 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 3pitches/list_3pitches_dissGrade2.txt","w");
var fileDissgrade3 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 3pitches/list_3pitches_dissGrade3.txt","w");
var fileDissgrade4 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 3pitches/list_3pitches_dissGrade4.txt","w");
var fileDissgrade5 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 3pitches/list_3pitches_dissGrade5.txt","w");
var fileDissgrade6 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 3pitches/list_3pitches_dissGrade6.txt","w");
var fileDissgrade7 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 3pitches/list_3pitches_dissGrade7.txt","w");
var fileDissgrade8 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 3pitches/list_3pitches_dissGrade8.txt","w");
var fileDissgrade9 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 3pitches/list_3pitches_dissGrade9.txt","w");
var fileDissgrade10 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 3pitches/list_3pitches_dissGrade10.txt","w");
var fileDissgrade11 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 3pitches/list_3pitches_dissGrade11.txt","w");
var files = [fileDissgrade0, fileDissgrade1, fileDissgrade2, fileDissgrade3, fileDissgrade4, fileDissgrade5, fileDissgrade6, fileDissgrade7, fileDissgrade8, fileDissgrade9, fileDissgrade10, fileDissgrade11];

/*(0..11).collect { |num|
	File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 3pitches/list_3pitches_dissGrade%.txt".format(num), "w")
};*/

"Akkordbestimmung Hindemith.scd".loadRelative;
//läd die Akkordbestimmungsfunktion nach Hindemith und bindet sie an ~hindemith



files.do{ arg file;
	file.write("[ \n");
};



(0..(obergrenze-2)).do{ arg basiston;
	("basiston: " ++ basiston).postln;
	((basiston+1)..(obergrenze-1)).do{ arg zweiterTonVonUnten;
		((zweiterTonVonUnten+1)..obergrenze).do{ arg dritterTonVonUnten;
			var root, dissGrade;
			var list = [basiston, zweiterTonVonUnten, dritterTonVonUnten];
			var string;
			# root, dissGrade = ~hindemith.value(list);
			string = "(list: " ++ list ++ ", root: " ++ root ++ ", dissGrade: " ++ dissGrade ++ "), \n";
			if(list.mod(12).sort == list.mod(12).asSet.asArray.sort, {
				//guck, ob es Dopplungen gibt und lass diesen Durchgang sonst einfach weg
				if( root.mod(12) == 0,
					{files.at(dissGrade).write(string);}
				)
			})

		}
	}
};

files.do{ arg file;
	file.write("]");
	file.close;
};

)








