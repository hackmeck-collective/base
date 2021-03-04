
//dauert 10'34'' = 634''
//basiston 1 bei 0:47
//basiston 2 bei 1:32
//basiston 6 bei 4:13
//basiston 7 bei 4:45
//basiston 24 bei 9:57
(
var obergrenze = 48; //48
var fileDissgrade0 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 4pitches/list_4pitches_dissGrade0.txt","w");
var fileDissgrade1 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 4pitches/list_4pitches_dissGrade1.txt","w");
var fileDissgrade2 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 4pitches/list_4pitches_dissGrade2.txt","w");
var fileDissgrade3 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 4pitches/list_4pitches_dissGrade3.txt","w");
var fileDissgrade4 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 4pitches/list_4pitches_dissGrade4.txt","w");
var fileDissgrade5 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 4pitches/list_4pitches_dissGrade5.txt","w");
var fileDissgrade6 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 4pitches/list_4pitches_dissGrade6.txt","w");
var fileDissgrade7 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 4pitches/list_4pitches_dissGrade7.txt","w");
var fileDissgrade8 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 4pitches/list_4pitches_dissGrade8.txt","w");
var fileDissgrade9 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 4pitches/list_4pitches_dissGrade9.txt","w");
var fileDissgrade10 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 4pitches/list_4pitches_dissGrade10.txt","w");
var fileDissgrade11 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists 4pitches/list_4pitches_dissGrade11.txt","w");
var files = [fileDissgrade0, fileDissgrade1, fileDissgrade2, fileDissgrade3, fileDissgrade4, fileDissgrade5, fileDissgrade6, fileDissgrade7, fileDissgrade8, fileDissgrade9, fileDissgrade10, fileDissgrade11];

"Akkordbestimmung Hindemith.scd".loadRelative;
//läd die Akkordbestimmungsfunktion nach Hindemith und bindet sie an ~hindemith

files.do{ arg file;
	file.write("[ \n");
};


//Hier ist der Unterschied zu "lists 3pitches generator Hindemith.scd"
(0..(obergrenze-3)).do{ arg basiston;
	("basiston: " ++ basiston).postln;
	((basiston+1)..(obergrenze-2)).do{ arg zweiterTonVonUnten;
		((zweiterTonVonUnten+1)..(obergrenze-1)).do{ arg dritterTonVonUnten;
			((dritterTonVonUnten+1)..obergrenze).do{ arg vierterTonVonUnten;


				var root, dissGrade;
				var list = [basiston, zweiterTonVonUnten, dritterTonVonUnten, vierterTonVonUnten];
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
	}
};

files.do{ arg file;
	file.write("]");
	file.close;
};
)







