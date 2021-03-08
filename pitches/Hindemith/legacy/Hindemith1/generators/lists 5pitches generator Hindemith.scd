//basiston 0 Uhrzeit 18:46
//basiston 1 bei 9'57''. Uhrzeit :18:55
// Uhrzeit für Basiston2: 19:05
// Uhrzeit für Basiston3: 19:13
// Uhrzeit für Basiston4: 19:18
// Uhrzeit für Basiston5: 19:25
// Uhrzeit für Basiston6: 19:30
// Uhrzeit für Basiston7: 19:36
// Uhrzeit für Basiston8: 19:41
// Uhrzeit für Basiston9: 19:45
// Uhrzeit für Basiston10: 19:49
// Uhrzeit für Basiston11: 19:53
// Uhrzeit für Basiston12: 19:56
// Uhrzeit für Basiston13: 19:59
// Uhrzeit für Basiston14: 20:02
// Uhrzeit für Basiston15: 20:04
// Uhrzeit für Basiston16  20:06
// Uhrzeit für Basiston17  20:08
// Uhrzeit für Basiston18  20:10
// Uhrzeit für Basiston19  20:11
// Uhrzeit für Basiston20  20:13

//Fertigstellung: 20:19  = 33'

(
var anzahlToene = 5;
var obergrenze = 48; // 48
var fileDissgrade0 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists " ++ anzahlToene ++ "pitches/list_" ++ anzahlToene ++ "pitches_dissGrade0.txt","w");
var fileDissgrade1 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists " ++ anzahlToene ++ "pitches/list_" ++ anzahlToene ++ "pitches_dissGrade1.txt","w");
var fileDissgrade2 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists " ++ anzahlToene ++ "pitches/list_" ++ anzahlToene ++ "pitches_dissGrade2.txt","w");
var fileDissgrade3 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists " ++ anzahlToene ++ "pitches/list_" ++ anzahlToene ++ "pitches_dissGrade3.txt","w");
var fileDissgrade4 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists " ++ anzahlToene ++ "pitches/list_" ++ anzahlToene ++ "pitches_dissGrade4.txt","w");
var fileDissgrade5 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists " ++ anzahlToene ++ "pitches/list_" ++ anzahlToene ++ "pitches_dissGrade5.txt","w");
var fileDissgrade6 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists " ++ anzahlToene ++ "pitches/list_" ++ anzahlToene ++ "pitches_dissGrade6.txt","w");
var fileDissgrade7 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists " ++ anzahlToene ++ "pitches/list_" ++ anzahlToene ++ "pitches_dissGrade7.txt","w");
var fileDissgrade8 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists " ++ anzahlToene ++ "pitches/list_" ++ anzahlToene ++ "pitches_dissGrade8.txt","w");
var fileDissgrade9 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists " ++ anzahlToene ++ "pitches/list_" ++ anzahlToene ++ "pitches_dissGrade9.txt","w");
var fileDissgrade10 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists " ++ anzahlToene ++ "pitches/list_" ++ anzahlToene ++ "pitches_dissGrade10.txt","w");
var fileDissgrade11 = File("/home/philipp/chronologisch/2021Q1/SuperCollider/Hindemith/lists " ++ anzahlToene ++ "pitches/list_" ++ anzahlToene ++ "pitches_dissGrade11.txt","w");
var files = [fileDissgrade0, fileDissgrade1, fileDissgrade2, fileDissgrade3, fileDissgrade4, fileDissgrade5, fileDissgrade6, fileDissgrade7, fileDissgrade8, fileDissgrade9, fileDissgrade10, fileDissgrade11];

"Akkordbestimmung Hindemith.scd".loadRelative;
//läd die Akkordbestimmungsfunktion nach Hindemith und bindet sie an ~hindemith



files.do{ arg file;
	file.write("[ \n");
};


//Jeder Ton darf nur einmal in jeder Kombination vorkommen. Alle möglichen Tonkombinationen werden durch geführt.
(0..(obergrenze-4)).do{ arg basiston;
	("basiston: " ++ basiston).postln;
	((basiston+1)..(obergrenze-3)).do{ arg zweiterTonVonUnten;
		((zweiterTonVonUnten+1)..(obergrenze-2)).do{ arg dritterTonVonUnten;
			((dritterTonVonUnten+1)..(obergrenze-1)).do{ arg vierterTonVonUnten;
				((vierterTonVonUnten+1)..obergrenze).do{ arg fuenfterTonVonUnten;

					var root, dissGrade;
					var list = [basiston, zweiterTonVonUnten, dritterTonVonUnten, vierterTonVonUnten, fuenfterTonVonUnten];
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
	}
};



files.do{ arg file;
	file.write("]");
	file.close;
};
)







