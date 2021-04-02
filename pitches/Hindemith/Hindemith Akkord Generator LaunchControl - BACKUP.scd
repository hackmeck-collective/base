/*
Überlegung "Welche Parameter für die Listen?"
1. Chromatik
2. Messiaen3 - 0,2,3,4,6,7,8,10,11
3. Alternierende Achtstufigkeit
4. Diatonik
5. Ganzton
6. Konstrukt - 0,1,4,5,8,9
*/


(

//if (s.serverRunning.not) {s.boot};

if (~gateOpen.isNil) {~gateOpen = Array.fill(8, {|item| if (item != 0){false} {nil}})}; //Werte für die Buttons 1 - 8. (Button 0 existiert nicht, deswegen nil.)


if (MIDIClient.initialized.not){
	MIDIClient.init;
	MIDIIn.connectAll;
};

if (~port.isNil) {
	~port = MIDIClient.destinations.detectIndex({|item| item.asString.contains("Launch Control")});
	~toLaunchControl = MIDIOut.new(~port);
	~toLaunchControl.connect(~port);
};

// Hail-Init for Networking
~addrBook = AddrBook.new;
~addrBook.addMe(Peer(\Philipp, NetAddr("192.168.178.21", 57120)));
~hail = Hail.new(~addrBook);
~addrBook.peers;
~addrBook.names;
~objSpace = OSCObjectSpace(~addrBook, true, '/pitches');
~sendWithHail = {arg event; //Funktion, die das event inklusive liste versendet.
	~objSpace[\pitches] = (event.list + 12).postln;
	~objSpace[\root] = event.rootNote;
};

~listAndParameters = (list: [60], dissDegree: 0, numNotes: 3, rootNote: 0, minLowerNote: 48, maxUpperNote: 60);
"prepare Session.scd".loadRelative; //fills ~routineWithListComprehension

)



(
var hoehe, breite;
var platz;
var fontsize;
var string;

//Message-Parsing
MIDIdef.cc(\launchControlKnobs, {
	arg val, num, chan, src;
	case
	{ num == 21 } { //Drehknopf  1  oben
		//Soll Dissonanzgrad steuern. Mit Anzahl Töne wird eine Liste erstellt.
		var newDissDegree = val.linlin(0,127,0,11).round.asInteger;//0 bis 11
		var arrayOfEventsWithLists = [];
		if (~listAndParameters.dissDegree != newDissDegree && (~gateOpen[1] == true)) //Nur wenn was neues kommt, mach was.
		{
			~listAndParameters.dissDegree = newDissDegree;
			~arrayOfEventsWithLists = ~getArrayOfEventsWithLists.value;
			if (~arrayOfEventsWithLists.notNil) {
				var diffRootNotes; //Variable zum Erhalt der aktuellen Root Note.

				~eventWithListAndRoot = ~arrayOfEventsWithLists.choose;

				//folgerichtiges aktualisieren der Parameter
				diffRootNotes = ~listAndParameters.rootNote - ~eventWithListAndRoot.rootNote.mod(12); //Alt minus neu
				~listAndParameters.list = ~eventWithListAndRoot.list + diffRootNotes;

				~actualizeGUI.value;

				~sendWithHail.((list: ~listAndParameters.list, rootNote: ~listAndParameters.rootNote));
			}
		}


	}
	{ num == 22 } { //Drehknopf 2 oben
		//rootNote
		var newRootValue = val.linlin(0,127,0,11).round.asInteger; // 0 bis 11
		if (newRootValue != ~listAndParameters.rootNote && (~gateOpen[2] == true))
		{
			var diffRootNotes = newRootValue - ~listAndParameters.rootNote; //Variable zum Erhalt der aktuellen Root Note. Neu Minus alt.

			//folgerichtiges aktualisieren der Parameter
			~listAndParameters.list = ~listAndParameters.list + diffRootNotes;
			~listAndParameters.rootNote = newRootValue;


			//aktualisieren der GUI
			~actualizeGUI.value;

			~sendWithHail.((list: ~listAndParameters.list, rootNote: ~listAndParameters.rootNote));

		}
	}

	{ num == 23 } { //Drehknopf 3 oben
		//Soll Anzahl Töne steuern. Mit Dissonanzgrad wird eine Liste erstellt.
		var newNumberOfNotes = val.linlin(0,127,3,5).round.asInteger; //3 bis 5
		if (~listAndParameters.numNotes != newNumberOfNotes && (~gateOpen[3] == true))
		{

			~listAndParameters.numNotes = newNumberOfNotes;
			~arrayOfEventsWithLists = ~getArrayOfEventsWithLists.value;


			if (~arrayOfEventsWithLists.notNil) {
				var diffRootNotes; //Variable zum Erhalt der aktuellen Root Note.
				~eventWithListAndRoot = ~arrayOfEventsWithLists.choose;

				//folgerichtiges aktualisieren der Parameter
				diffRootNotes = ~listAndParameters.rootNote - ~eventWithListAndRoot.rootNote.mod(12); //Alt minus neu
				~listAndParameters.list = ~eventWithListAndRoot.list + diffRootNotes;

				//aktualisieren der GUI
				~actualizeGUI.value;

				~sendWithHail.((list: ~listAndParameters.list, rootNote: ~listAndParameters.rootNote))
			}
		}
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
		if (~gateOpen[1] == false)
		{ ~gateOpen[1] = true; ~toLaunchControl.noteOn(0, 9, 63);} //Macht Button 1 (note 9) bernsteingelb (veloc 63)
		{ ~gateOpen[1] = false; ~toLaunchControl.noteOn(0, 9, 12);}; //Macht Button 1 (note 9) aus. (veloc 12)

		{~bn.value = 1;}.defer; //Buttonfarbe in der Gui setzen
	}
	{ num == 10 } { // Button -2-
		if (~gateOpen[2] == false)
		{ ~gateOpen[2] = true; ~toLaunchControl.noteOn(0, 10, 63);} //Macht Button 2 (note 9) bernsteingelb (veloc 63)
		{ ~gateOpen[2] = false; ~toLaunchControl.noteOn(0, 10, 12);}; //Macht Button 2 (note 9) aus. (veloc 12)
	}
	{ num == 11 } { // Button -3-
		if (~gateOpen[3] == false)
		{ ~gateOpen[3] = true; ~toLaunchControl.noteOn(0, 11, 63);}
		{ ~gateOpen[3] = false; ~toLaunchControl.noteOn(0, 11, 12);};
	}
	{ num == 12 } { //Button -4-
		if (~gateOpen[4] == false)
		{ ~gateOpen[4] = true; ~toLaunchControl.noteOn(0, 12, 63);}
		{ ~gateOpen[4] = false; ~toLaunchControl.noteOn(0, 12, 12);};
	}
	{ num == 25 } { //Button -5-
		if (~gateOpen[5] == false)
		{ ~gateOpen[5] = true; ~toLaunchControl.noteOn(0, 25, 63);}
		{ ~gateOpen[5] = false; ~toLaunchControl.noteOn(0, 25, 12);};
	}
	{ num == 26 } { //Button -6-
		if (~gateOpen[5] == false)
		{ ~gateOpen[5] = true; ~toLaunchControl.noteOn(0, 26, 63);}
		{ ~gateOpen[5] = false; ~toLaunchControl.noteOn(0, 26, 12);};
	}
	{ num == 27 } { // Button -7-
		if (~gateOpen[6] == false)
		{ ~gateOpen[6] = true; ~toLaunchControl.noteOn(0, 27, 63);}
		{ ~gateOpen[6] = false; ~toLaunchControl.noteOn(0, 27, 12);};
	}
	{ num == 28 } { // Button -8-
		if (~gateOpen[7] == false)
		{ ~gateOpen[7] = true; ~toLaunchControl.noteOn(0, 28, 63);}
		{ ~gateOpen[7] = false; ~toLaunchControl.noteOn(0, 28, 12);};
	}
	;
});


MIDIdef.noteOff(\launchControlButtonsOff, {
	arg val, num, chan, src;
	//[val, num].postln;
	case
	{ num == 9 } { //Button -1-
		{~bn.value = 0;}.defer;  //Buttonfarbe setzen
	}
	{ num == 12 } { //Button -4-
		{~bdg.value = 0;}.defer; //Buttonfarbe setzen
	}
	{ num == 25 } { //Button -5-
		{~bda.value = 0;}.defer; //Buttonfarbe setzen
	}
	{ num == 26 } { //Button -6-
		{~bdh.value = 0;}.defer; //Buttonfarbe setzen
	}
	;
});

//GUI

breite = 120;
hoehe = 50;
platz = 10;
fontsize = 15;

w = Window.new(bounds: Rect(0, 300, 1100, 600)).front;
//w.fullScreen;

~td = StaticText(w, Rect(platz, platz, breite, 40));
~td.string ="1 DISS.GRADE";
~td.align=\center;
~td.font = Font("Monaco", fontsize);
~nd = NumberBox(w, Rect(platz + 50, hoehe + platz, 50, 50));
~nd.font = Font("Monaco", fontsize);

~tRoot = StaticText(w, Rect(2 * platz + breite, platz, breite, 40));
~tRoot.string = "2 ROOT";
~tRoot.align=\center;
~tRoot.font = Font("Monaco", fontsize);
~tRoot2 = TextField(w, Rect(2*platz + breite + 50, 1 * hoehe + platz, 50, 50));
~tRoot2.font = Font("Monaco", fontsize);

~tn = StaticText(w, Rect(4*platz + (2*breite), platz, breite, 40));
~tn.string = "3 NUMBER \n NOTES";
~tn.align=\center;
~tn.font = Font("Monaco", fontsize);
~nn = NumberBox(w, Rect(4*platz + (2*breite) + 50, 1 * hoehe + platz, 50, 50));
~nn.font = Font("Monaco", fontsize);

~bn = Button(w, Rect(platz, 6 * hoehe + platz, 100, 100))
.states_([ ["push!", Color.black, Color.white], ["push!", Color.black, Color.gray] ]);

~bnr = Button(w, Rect( 2* platz + breite,  6 * hoehe + platz, 100, 100))
.states_([ ["2", Color.black, Color.white], ["2", Color.black, Color.gray] ]);

~bNoR = Button(w, Rect( 4* platz + (2*breite),  6 * hoehe + platz, 100, 100))
.states_([ ["3", Color.black, Color.white], ["3", Color.black, Color.gray] ]);

~bdg = Button(w, Rect(6 * platz + (3 * breite), 6 * hoehe + platz, 100, 100))
.states_([ ["-> AA on G", Color.black, Color.white], ["-> AA on G", Color.black, Color.gray] ]);

~bda = Button(w, Rect(8 * platz + (4 * breite), 6 * hoehe + platz, 100, 100))
.states_([ ["-> AA on A", Color.black, Color.white], ["-> AA on A", Color.black, Color.gray] ]);

~bdh = Button(w, Rect(10 * platz + (5 * breite), 6 * hoehe + platz, 100, 100))
.states_([ ["->  AA on H", Color.black, Color.white], ["->  AA on H", Color.black, Color.gray] ]);

~bSc = Button(w, Rect(12 * platz + (6 * breite), 6 * hoehe + platz, 100, 100))
.states_([ ["7", Color.black, Color.white], ["7", Color.black, Color.gray] ]);

~bSo = Button(w, Rect(14 * platz + (7 * breite), 6 * hoehe + platz, 100, 100))
.states_([ ["8", Color.black, Color.white], ["8", Color.black, Color.gray] ]);

~tlist = TextField(w, Rect(breite, 8 * hoehe + ( 8 * platz), 1100 - breite - (2*platz), 40));
~tlist.font = Font(size: 20);


)











