/*

Ich brauche einen Ähnlichkeitsgrad. Beispiel: Bewege ich den Disgradregler und drehe um 1 rauf, sollte die ähnlichste Sammlung von Akkorden dabei herauskommen (oder eben nicht).
Alternativ: Gibt es ein tonales Paradigma, dass die Akkorde objektiv sortiert, sodass man ihn als Grad einstellen kann.

Ich brauche eine Funktion für den Button, die die Werte nur durchlässt, wenn der Button da runter "AN" ist. Leuchten der Buttons? NoteOns an das Interface ?

Die Buttons sollten alle "Neue Liste schicken"-Funktionen haben.

Ich brauche eher Verbindungen als nur Akkorde. Beispiel:

Benni regt an, dass jeder Listenton bewertet wird: Welcher ist der Dissonanteste, welcher ist eher chillig. Also erstelle ich zu jeder Liste eine Liste mit Indices der Töne in der Liste, die geordnet nach Dissonanzgrad in Bezug auf den Grundton.

Listen müssen auch mehr als Oktave erlaubt sein.

Spread - Parameter (Ambitus) Am Besten in der Form: Linke Grenze und REchte Grenze
*/


"lists/fill variables.scd".loadRelative;
"Parameters to List.scd".loadRelative;

// Utopia-initialisierung
~addrBook = AddrBook.new;
~addrBook.addMe(Peer(\Philipp, NetAddr("192.168.178.21", 57120)));
//~registrant = Registrant(~addrBook);
~registrant = Hail.new(~addrBook);
~addrBook.peers;
~addrBook.names;
~objSpace = OSCObjectSpace(~addrBook, true, '/pitches');
/*
b = {arg list; //Funktion, die eine Liste versendet.
	~objSpace[\pitches] = list;
	~objSpace[\root] = root.mod(12);
};
*/


(
var hoehe, breite;
var platz;
var fontsize;
var string;

if(s.serverRunning.not, { s.boot; });

if(MIDIClient.initialized.not,{
	MIDIClient.init;
	MIDIIn.connectAll;
});

//Message-Parsing
MIDIdef.cc(\launchControlKnobs, {
	arg val, num, chan, src;
	case
	{ num == 21 } { //Drehknopf  1  oben
		//Soll Dissonanzgrad steuern. Mit Anzahl Töne wird eine Liste erstellt.
		var newDissDegree = val.linlin(0,127,0,11).round.asInteger;//0 bis 11
		~newValue.("newDissDegree", newDissDegree);
		{~numberBox21.value = newDissDegree}.defer; //NumberBox setzen
		{~textFieldList.value = ~listGeneratorHindemith.list}.defer; //set text field
		//~listGeneratorHindemith.list.postln;
	}
	{ num == 22 } { //Drehknopf 2 oben
		//Grundton
		var rootValue = val.linlin(0,127,0,11).round.asInteger; // 0 bis 11
		~newValue.("newRoot", rootValue);
		{~numberBox22.value = rootValue}.defer; //NumberBox setzen
		{~textFieldList.value = ~listGeneratorHindemith.list}.defer; //set text field
		//~listGeneratorHindemith.list.postln;
	}
	{ num == 23 } { //Drehknopf 3 oben
		//Soll Anzahl Töne steuern. Mit Dissonanzgrad wird eine Liste erstellt.
		var newNumberOfNotes = val.linlin(0,127,3,6).round.asInteger; //3 bis 6 Noten.
		~newValue.("newNumberOfNotes", newNumberOfNotes);
		{~numberBox23.value = newNumberOfNotes}.defer; //NumberBox setzen
		{~textFieldList.value = ~listGeneratorHindemith.list}.defer; //set text field
		//~listGeneratorHindemith.list.postln;
	}
	{ num == 24 } { //Drehknopf 4 oben
	}
	{ num == 25 } { //Drehknopf 5 oben
	}
	{ num == 26 } { //Drehknopf 6 oben
	}
	{ num == 28 } { //Drehknopf 8 oben
	}
	{ num == 41 } { //Dreknopf 1 unten
	}
	{ num == 42 } { //Dreknopf 2 unten
	}
	{ num == 43 } { //Dreknopf 3 unten
	}
	{ num == 44 } { //Dreknopf 4 unten
	}
	{ num == 45 } { //Drehknopf 5 unten
	}
	{ num == 46 } { //Drehknopf 6 unten
	}
	{ num == 47 } { //Drehknopf 7 unten
	}
	{ num == 48 } { //Drehknopf 8 unten
	}
	;
});

MIDIdef.noteOn(\launchControlButtonsON, {
	arg val, num, chan, src;
	case
	{ num == 9 } { // Button -1-
		"NewList. ~listOfNotes: ".postln;
		{~bn1.value = 1;}.defer;  //Buttonfarbe setzen
	}
	{ num == 10 } { // Button -2-

	}
	{ num == 11 } { // Button -3-

	}
	{ num == 12 } { //Button -4-
		"Button4".postln;
		{~bn4.value = 1;}.defer; //Buttonfarbe setzen
	}
	{ num == 25 } { //Button -5-
		"Button5".postln;
		{~bn5.value = 1;}.defer; //Buttonfarbe setzen
	}
	{ num == 26 } { //Button -6-
		"Button6".postln;
		{~bn6.value = 1;}.defer; //Buttonfarbe setzen
	}
	{ num == 27 } { // Button -7-
	}
	{ num == 28 } { // Button -8-
	}
	;
});


MIDIdef.noteOff(\launchControlButtonsOff, {
	arg val, num, chan, src;
	//[val, num].postln;
	case
	{ num == 9 } { //Button -1-
		{~bn1.value = 0;}.defer;  //Buttonfarbe setzen
	}
	{ num == 12 } { //Button -4-
		{~bn4.value = 0;}.defer; //Buttonfarbe setzen
	}
	{ num == 25 } { //Button -5-
		{~bn5.value = 0;}.defer; //Buttonfarbe setzen
	}
	{ num == 26 } { //Button -6-
		{~bn6.value = 0;}.defer; //Buttonfarbe setzen
	}
	;
});

breite = 120;
hoehe = 50;
platz = 10;
fontsize = 15;

w = Window.new(bounds: Rect(0, 300, 1100, 600)).front;
//w.fullScreen;

~text21 = StaticText(w, Rect(platz, platz, breite, 40));
~text21.string ="1 DISS.DEGREE";
~text21.align=\center;
~text21.font = Font("Monaco", fontsize);
~numberBox21 = NumberBox(w, Rect(platz + 50, hoehe + platz, 50, 50));
~numberBox21.font = Font("Monaco", fontsize);

~text22 = StaticText(w, Rect(2 * platz + breite, platz, breite, 40));
~text22.string = "2 ROOT";
~text22.align=\center;
~text22.font = Font("Monaco", fontsize);
~numberBox22 = NumberBox(w, Rect(2*platz + breite + 50, 1 * hoehe + platz, 50, 50));//TextField(w, Rect(2*platz + breite + 50, 1 * hoehe + platz, 50, 50));
~numberBox22.font = Font("Monaco", fontsize);

~text23 = StaticText(w, Rect(4*platz + (2*breite), platz, breite, 40));
~text23.string = "3 NUMBER \n NOTES";
~text23.align=\center;
~text23.font = Font("Monaco", fontsize);
~numberBox23 = NumberBox(w, Rect(4*platz + (2*breite) + 50, 1 * hoehe + platz, 50, 50));
~numberBox23.font = Font("Monaco", fontsize);

~bn1 = Button(w, Rect(platz, 6 * hoehe + platz, 100, 100))
.states_([ ["new list", Color.black, Color.white], ["new list", Color.black, Color.gray] ]);

~bn2 = Button(w, Rect( 2* platz + breite,  6 * hoehe + platz, 100, 100))
.states_([ ["2", Color.black, Color.white], ["2", Color.black, Color.gray] ]);

~bn3 = Button(w, Rect( 4* platz + (2*breite),  6 * hoehe + platz, 100, 100))
.states_([ ["3", Color.black, Color.white], ["3", Color.black, Color.gray] ]);

~bn4 = Button(w, Rect(6 * platz + (3 * breite), 6 * hoehe + platz, 100, 100))
	.states_([ ["-> AA on G", Color.black, Color.white], ["-> AA on G", Color.black, Color.gray] ]);

~bn5 = Button(w, Rect(8 * platz + (4 * breite), 6 * hoehe + platz, 100, 100))
		.states_([ ["-> AA on A", Color.black, Color.white], ["-> AA on A", Color.black, Color.gray] ]);

~bn6 = Button(w, Rect(10 * platz + (5 * breite), 6 * hoehe + platz, 100, 100))
.states_([ ["->  AA on H", Color.black, Color.white], ["->  AA on H", Color.black, Color.gray] ]);

~bn7 = Button(w, Rect(12 * platz + (6 * breite), 6 * hoehe + platz, 100, 100))
.states_([ ["7", Color.black, Color.white], ["7", Color.black, Color.gray] ]);

~bn8 = Button(w, Rect(14 * platz + (7 * breite), 6 * hoehe + platz, 100, 100))
.states_([ ["8", Color.black, Color.white], ["8", Color.black, Color.gray] ]);

~textFieldList = TextField(w, Rect(breite, 8 * hoehe + ( 8 * platz), 1100 - breite - (2*platz), 40));
~textFieldList.font = Font(size: 20);

)


