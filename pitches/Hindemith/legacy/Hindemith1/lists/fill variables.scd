//Lese Datei und fülle Variable

"list_3pitches_dissGrade0.txt".loadRelative; //erzeugt ~root0_pitches3_dissGrade0
"list_3pitches_dissGrade1.txt".loadRelative; //erzeugt ~root0_pitches3_dissGrade1
"list_3pitches_dissGrade2.txt".loadRelative; // ...
"list_3pitches_dissGrade3.txt".loadRelative; // ...
"list_3pitches_dissGrade4.txt".loadRelative; // ...
"list_3pitches_dissGrade5.txt".loadRelative; // ...
"list_3pitches_dissGrade6.txt".loadRelative; // ...
"list_3pitches_dissGrade7.txt".loadRelative; // ...
"list_3pitches_dissGrade8.txt".loadRelative; // ...
"list_3pitches_dissGrade9.txt".loadRelative; // ...
"list_3pitches_dissGrade10.txt".loadRelative; // ...
"list_3pitches_dissGrade11.txt".loadRelative; //erzeugt ~root0_pitches3_dissGrade11
"list_4pitches_dissGrade0.txt".loadRelative; //erzeugt ~root0_pitches4_dissGrade0
"list_4pitches_dissGrade1.txt".loadRelative; // usw.
"list_4pitches_dissGrade2.txt".loadRelative;
"list_4pitches_dissGrade3.txt".loadRelative;
"list_4pitches_dissGrade4.txt".loadRelative;
"list_4pitches_dissGrade5.txt".loadRelative;
"list_4pitches_dissGrade6.txt".loadRelative;
"list_4pitches_dissGrade7.txt".loadRelative;
"list_4pitches_dissGrade8.txt".loadRelative;
"list_4pitches_dissGrade9.txt".loadRelative;
"list_4pitches_dissGrade10.txt".loadRelative;
"list_4pitches_dissGrade11.txt".loadRelative;
"list_5pitches_dissGrade0.txt".loadRelative;
"list_5pitches_dissGrade1.txt".loadRelative;
"list_5pitches_dissGrade2.txt".loadRelative;
"list_5pitches_dissGrade3.txt".loadRelative;
"list_5pitches_dissGrade4.txt".loadRelative;
"list_5pitches_dissGrade5.txt".loadRelative;
"list_5pitches_dissGrade6.txt".loadRelative;
"list_5pitches_dissGrade7.txt".loadRelative;
"list_5pitches_dissGrade8.txt".loadRelative;
"list_5pitches_dissGrade9.txt".loadRelative;
"list_5pitches_dissGrade10.txt".loadRelative;
"list_5pitches_dissGrade11.txt".loadRelative;
"list_6pitches_dissGrade0.txt".loadRelative;
"list_6pitches_dissGrade1.txt".loadRelative;
"list_6pitches_dissGrade2.txt".loadRelative;
"list_6pitches_dissGrade3.txt".loadRelative;
"list_6pitches_dissGrade4.txt".loadRelative;
"list_6pitches_dissGrade5.txt".loadRelative;
"list_6pitches_dissGrade6.txt".loadRelative;
"list_6pitches_dissGrade7.txt".loadRelative;
"list_6pitches_dissGrade8.txt".loadRelative;
"list_6pitches_dissGrade9.txt".loadRelative;
"list_6pitches_dissGrade10.txt".loadRelative;
"list_6pitches_dissGrade11.txt".loadRelative;

//Wegen der Größe des Array sollte ich einen Kompromiss eingehen und den Range verkleinern:

4.do{
	|numberOfPitches|
	numberOfPitches = numberOfPitches + 3;
	12.do{|dissDegree|
		var string = "~root0_pitches%_dissGrade%_range24 = []; ~root0_pitches%_dissGrade%.do{arg item; if( item.list.last - item.list.first <= 20 && (item.list.first < 12), { ~root0_pitches%_dissGrade%_range24 = ~root0_pitches%_dissGrade%_range24.add(item);});};  ";
		string.format(
			numberOfPitches.asInteger, dissDegree.asInteger,
			numberOfPitches.asInteger, dissDegree.asInteger,
			numberOfPitches.asInteger, dissDegree.asInteger,
			numberOfPitches.asInteger, dissDegree.asInteger).interpret;
	}
};



//Test
/*
(
var eTime = Main.elapsedTime; //for time measureing of execution
~root0_pitches6_dissGrade6_range24.do{arg item; if(item.list.at(0) == 24, {});  }; //dauert weniger als 0.005 Sekunden
(Main.elapsedTime - eTime).postln;
)

(
var eTime = Main.elapsedTime;
~root0_pitches6_dissGrade8_range24.do{arg item; if(item.list.at(0) == 24, {});  }; //dauert ca. 0.02 Sekunden
(Main.elapsedTime - eTime).postln;
)
*/
