//Akkordgenerator Hindemith

//AUf Grundlage von:
//Akkordbestimmung Hindemith.scd

/*
Wie konstruiere ich aus der bestehenden Liste eine Liste (mit der richtigen Anzahl Töne) sodass Bass und Grundton derselbe sind?

Grundtonbestimmung nach Hindemith:
1. Hole Dir alle Intervalle des Akkordes.
2. Nimm das konsonanteste Intervall (entsprechend dieser aufsteigenden Liste (konsonant zu dissonant): [12, 7, 5, 4, 8, 3, 9, 2, 10, 1, 11, 6].)
3. Bestimme vom konsonantesten Intervall den Grundton entsprechend diesem Dictionary: (1 -> o), (2 -> o), (3 -> u), (4 -> u), (5 -> o), (6 -> ), (7 -> u), (8 -> o), (9 -> o), (10 -> u), (11 -> u), (12 -> u)
4. Das ist dann der Grundton.

*/

~numberOfNotes = 3;
~rootNote = 0;

var transpose = {
	arg list, transposition;
	list + transposition;
};



Wenn Dissgrad 11 :
list = [[0,3,6], [0,3,9], [0,6,9], [0,6,15], [0,9,15], [0,3,6,9], [0,6,9,15]].choose;
list = transpose.value(list, ~rootNote)


Wenn Dissgrad 8: consistsTritone.value(listOfIntervalsInChord) AND consistsMinorSecondORMajorSeventh AND bassToneAndRootAreTheSame


var listOfIntervalsInChord = [6]; //Ganz wichtig: Die Liste der Intervalle ist so gemeint, das jeder Ton auf jeden anderen bezogen wird. Beispiel: Eine Liste hat drei Elemente. Dann hat die die Intervallliste die Form [E1-E2,E1-E3,E2-E3]
var minorSecondORMajorSeventh = [1,11].choose;

listOfIntervalsInChord = listOfIntervalsInChord.insert(2.rand, minorSecondORMajorSeventh); //place it befor or after the other item

//now we have two intervals in the list, but that is not possible by definition. You always relate every to each other. The mathematical formula is f(n) = n!/((n-2)!*2). "n over 2".
//f(2)=1   f(3)=3   f(4)=6   f(5)=10
//We have to add a new element respectivly a new interval which is in this case the difference of the first two elements.

//Das wird ein heilloses Durcheinander
//Deswegen vergegenwärtige ich mir das auf Papier und schreibe jetzt:
if(~numberOfNotes==3,{
	listOfIntervalsInChord = [[1,7,6],[6,1,7],[11,17,6][6,17,11]].choose;
});
if(~numberOfNotes==4,{

});




//bzw. noch besser:
var chord = [[0,1,7],[0,6,7],[0,11,17],[0,6,17]]
//Jetzt kommt die Prüfung, ob der Basston und Grundton derselbe sind.
//Also müssen die letzten beiden Listen weg:
chord = [[0,1,7],[0,6,7]]; //Wenn Grundton 0 ist.


Wenn Dissgrad 9: consistsTritone.value(listOfIntervalsInChord) AND consistsMinorSecondORMajorSeventh AND bassToneAndRootAreTheSame.not
WEnn Dissgrad 2: consistsTritone.value(listOfIntervalsInChord) AND bassToneAndRootAreTheSame.value(chord, root) AND consistsOnlyMinorSeventhNotMajorSecond.value(listOfIntervalsInChord)
Wenn Dissgrad 3: consistsTritone.value(listOfIntervalsInChord) AND bassToneAndRootAreTheSame.value(chord, root) AND consistsMajorSecondORMinorSeventh.value(listOfIntervalsInChord) AND consistsMoreThanOneTritone.value(listOfIntervalsInChord).not
Wenn Dissgrad 4: consistsTritone.value(listOfIntervalsInChord) AND assToneAndRootAreTheSame.value(chord, root).not AND consistsMajorSecondORMinorSeventh.value(listOfIntervalsInChord) AND consistsMoreThanOneTritone.value(listOfIntervalsInChord).not
Wenn Dissgrad 5: consistsTritone.value(listOfIntervalsInChord) AND consistsMoreThanOneTritone.value(listOfIntervalsInChord) AND consistsMajorSecondORMinorSeventh.value(listOfIntervalsInChord)
Wenn Dissgrad 10: consistsTritone.value(listOfIntervalsInChord).not AND chordIsTranspositionOf.value(chord, [0,4,8]) OR chordIsTranspositionOf.value(chord, [0,5,10])
Wenn Dissgrad 6: consistsTritone.value(listOfIntervalsInChord).not AND (chordIsTranspositionOf.value(chord, [0,4,8]) || chordIsTranspositionOf.value(chord, [0,5,10])).not AND consistsSecondORSeventh.value(listOfIntervalsInChord) AND bassToneAndRootAreTheSame.value(chord, root)
Wenn Dissgrad 7: consistsTritone.value(listOfIntervalsInChord).not AND (chordIsTranspositionOf.value(chord, [0,4,8]) || chordIsTranspositionOf.value(chord, [0,5,10])).not AND consistsSecondORSeventh.value(listOfIntervalsInChord) AND bassToneAndRootAreTheSame.value(chord, root).not
Wenn Dissgrad 0: consistsTritone.value(listOfIntervalsInChord).not AND (chordIsTranspositionOf.value(chord, [0,4,8]) || chordIsTranspositionOf.value(chord, [0,5,10])).not AND consistsSecondORSeventh.value(listOfIntervalsInChord).not AND bassToneAndRootAreTheSame.value(chord, root)
Wenn Dissgrad 1: consistsTritone.value(listOfIntervalsInChord).not AND (chordIsTranspositionOf.value(chord, [0,4,8]) || chordIsTranspositionOf.value(chord, [0,5,10])).not AND consistsSecondORSeventh.value(listOfIntervalsInChord).not AND bassToneAndRootAreTheSame.value(chord, root).not