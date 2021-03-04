
//Hier habe ich Akkordbestimmung_Hindemith.scd aus 2016HJ1 verändert.
//Die Funktion nimmt Akkorde ohne Dopplungen entgegen und bestimmt den Grundton nach Hindemith "Unterweisung im Tonsatz" S. 120
//var grundton_hindemith;
~grundton_hindemith = { arg chord;
	var dissonanzen = [12, 7, 5, 4, 8, 3, 9, 2, 10, 1, 11, 6];
	// "dissonanzen" enhält die Intervalle einer Oktave in der Reihenfolge ihres Dissonanzgrades. Das Konsonanteste ist links.
	var gintervall = Dictionary.newFrom(
		[12, "u", 7, "u", 5, "o", 4, "u", 8, "o", 3, "u",
			9, "o", 2, "o", 10, "u", 1, "o", 11, "u", 6, ""]);

	// "gintervall" enthält alle Intervalle einer Oktave und ihre "Grundtöne" (unten oder oben) nach Hindemith.
	var intervalsOfChord = []; //Eine Variable für Intervalle.
	var mostConsonantInterval; //Eine Variable für das Konsonanteste Intervall des Akkordes.
	var gton = nil; // Eine Variable für den Grundton des Akkordes.
	var kon_suche; //Eine Variable für die Funktion der Suche nach dem Konsonantesten Intervall im Akkord.
	var diss_suche; //Eine Variable für die Funktion der Suche nach dem Dissonantesten Intervall im Akkord.
	chord.sort; //Der Array liegt jetzt der Größe nach sortiert vor.



	//Es sollen die Intervalle zwischen allen Tönen des Akkords bestimmt werden:
	chord.size.do{ |i|
		(chord.size-i).do{|j| var intervall;
			intervall = chord[j+i] - chord[i];
			if(intervall != 0, {
				if(intervall > 12, {var oktavierung = (intervall/12).trunc(1);
					intervall = intervall - (oktavierung*12).asInteger; //Falls Intervall größer als Oktave, zieht man vom Intervall eine Oktave ab.
				});
				intervalsOfChord = intervalsOfChord.add(intervall)
			});
		};
	}; //Die Intervalle zwischen allen Tönen des Akkords sind in "intervalsOfChord".
	//Vincent sagt, es gibt auch Collection.powerset();

	//Aus allen Intervallen des Akkordes soll das Konsonanteste Intervall (außer der Oktave) gefunden werden:
	kon_suche = {
		var print = true;
		dissonanzen[1..].do{|item|
			if( print == true && intervalsOfChord.includes(item) == true, {
				mostConsonantInterval = item;
				print = false;
			})
		}; //Das Konsonanteste Interval im Akkord ist in "mostConsonantInterval".
	};
	kon_suche.value;

	//Finde mit "mostConsonantInterval" und "ginterval" den Grundton im Akkord
	chord.size.do{ |i|
		(chord.size-i).do{|j| var intervall;
			intervall = chord[j+i] - chord[i];
			if(intervall > 12, {var oktavierung = (intervall/12).trunc(1);
				intervall = intervall - (oktavierung*12).asInteger; //Falls Intervall größer als Oktave, zieht man eine Oktave ab.
			});
			if(intervall == mostConsonantInterval, {
				if(gintervall[mostConsonantInterval] == "u",{
					if(gton.isNil,
						{ gton = chord[i] },
						{ if( chord[i] < gton,
							{gton = chord[i];} //mehrdeutig und Intervall-Grundton "unten" UND kleiner          .
						)}
					)
				},{
					if(gintervall[mostConsonantInterval] == "o",
						{
							if(gton.isNil,
								{gton = chord[j+i]},
								{
									if( gton < chord[j+i],
										{gton = chord[j+i];} //mehrdeutig und Intervall-Grundton "oben" UND größer
									)
								}
							)
						}
					)
				})
			})
		}
	}
	[gton, intervalsOfChord] //Liefert schließlich den Grundton und die Liste der Intervalle des Akkords.
};



//Akkorde sind als Arrays definiert:
//[58, 61, 69]; //b,des1,a1 (Beginn Sonate7 Skriabin)
//[54, 57, 62, 65]; //ges,heses,d,f (Sonate7 Skriabin, Takt 3)
//[32, 45, 54, 62, 65]; //Sonate7 Skriabin Takt4 ohne Dopplungen
//[48, 55, 62] ein Quintenband -> mehrere Grundtöne möglich
//[48, 64, 70, 81]; //cis, e1, ais1, a2 "Morgenröth"-Akkord Meistersinger
//grundton_hindemith.value([48, 55, 62]);


