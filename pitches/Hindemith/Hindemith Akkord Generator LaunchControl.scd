

(

//if (s.serverRunning.not) {s.boot};

if (~gateOpen.isNil) {~gateOpen = Array.fill(8, {|item| if (item != 0){false} {nil}})}; //Werte für die Buttons 1 - 8. (Button 0 existiert nicht, deswegen nil.)


if (MIDIClient.initialized.not){
	"initializing MIDI ...".postln;


	MIDIClient.init;
	"MIDI initialized".postln;
	"connecting MIDIIn ...".postln;
	MIDIIn.connectAll;
	"MIDIIn connected".postln;
};

if (~port.isNil) {
	~port = MIDIClient.destinations.detectIndex({|item| item.asString.contains("Launch Control")});
	~toLaunchControl = MIDIOut.new(~port);
	~toLaunchControl.connect(~port);
};


~addrBookUserName = \philipp;
"../../network/address_book_all.scd".loadRelative;
// Hail-Init for Networking
// ~addrBook = AddrBook.new;
// ~addrBook.addMe(Peer(\Philipp, NetAddr("192.168.178.21", 57120)));
// ~hail = Hail.new(~addrBook);
// ~addrBook.peers;
// ~addrBook.names;
// ~objSpace = OSCObjectSpace(~addrBook, true, '/pitches');
~sendWithHail = {arg event; //Funktion, die das event inklusive liste versendet.
	~pitchesRootDissonance[\pitches] = event.list;
	~pitchesRootDissonance[\root] = event.rootNote;
};

"prepare Session.scd".loadRelative;


)


(

"trees/piano_gui.scd".loadRelative;
~startPiano.init(~chordNow);
"Hindemith Akkord Generator GUI mit LaunchControl.scd".loadRelative;
~actualizeGUI.value;

//Message-Parsing
MIDIdef.cc(\launchControlKnobs, {
	arg val, num, chan, src;
	case
	{ num == 21 } { //Drehknopf  1  oben
		//Soll Dissonanzgrad steuern. Mit Anzahl Töne wird eine Liste erstellt.
		var newDissDegree = val.linlin(0,127,0,11).round.asInteger;//0 bis 11
		if (~listAndParameters.dissDegree != newDissDegree) //Nur wenn was neues kommt, mach was.
		{
			var closestList = ~searchTreeNearest.(
				numNotes:  ~listAndParameters.list.size,
				chord: ~listAndParameters.list,
				rootNote: ~listAndParameters.rootNote,
				dissDegree: newDissDegree
			);
			if(closestList.notNil){
				~listAndParameters.list = closestList;
				~listAndParameters.dissDegree = newDissDegree;
				"dissDegree: ".post; ~listAndParameters.dissDegree.postln;
				~actualizeGUI.value;
				~startPiano.showKeys(~listAndParameters.list);
				if(~gateOpen[1] == true){~sendWithHail.((list: ~listAndParameters.list, rootNote: ~listAndParameters.rootNote));};
			}{
				"no new list".postln
			}
		}
	}
	{ num == 22 } { //Drehknopf 2 oben
		//rootNote
		var newRootValue = val.linlin(0,127,0,11).round.asInteger; // 0 bis 11
		if (newRootValue != ~listAndParameters.rootNote)
		{
			var closestList = ~searchTreeNearestOld.(
				// numNotes:  ~listAndParameters.list.size,
				chord: ~listAndParameters.list,
				rootNote: newRootValue,
				dissDegree: ~listAndParameters.dissDegree
			);
			if(closestList.notNil){
				~listAndParameters.list = closestList;
				~listAndParameters.rootNote = newRootValue;
				"rootNote: ".post; ~listAndParameters.rootNote.postln;
				~actualizeGUI.value;
				~startPiano.showKeys(~listAndParameters.list);
				if(~gateOpen[2] == true){~sendWithHail.((list: ~listAndParameters.list, rootNote: ~listAndParameters.rootNote));};
			}{
				"no new list".postln
			}

		}
	}
	{ num == 23 } { //Drehknopf 3 oben
		//Soll Anzahl Töne steuern. Mit Dissonanzgrad wird eine Liste erstellt.
		var newNumberOfNotes = val.linlin(0,127,3,5).round.asInteger; //3 bis 5
		//newNumberOfNotes.postln;
		if (~listAndParameters.list.size != newNumberOfNotes )
		{
			var closestList;
			var testlist = ~listAndParameters.list.copy;
			//"testlist: ".post; testlist.postln;
			//"newNumberOfNotes: ".post; newNumberOfNotes.postln;

			while {testlist.size < newNumberOfNotes } {
				var newVal = testlist.first + 12;
				testlist = testlist.copy.add(newVal).sort;

			};
			while {testlist.size > newNumberOfNotes } {
				testlist.removeAt(testlist.size - 1);
			};

			//"testlist: ".post; testlist.postln;

			closestList = ~searchTreeNearestOld.(
				//numNotes: ~listAndParameters.list.size,
				chord: testlist,
				rootNote: ~listAndParameters.rootNote,
				dissDegree: ~listAndParameters.dissDegree
			);

			if(closestList.notNil){
				~listAndParameters.list = closestList;
				//~listAndParameters.numNotes = newNumberOfNotes;
				// "numNotes: ".post; ~listAndParameters.numNotes.postln;
				~actualizeGUI.value;
				~startPiano.showKeys(~listAndParameters.list);
				if(~gateOpen[3] == true){~sendWithHail.((list: ~listAndParameters.list, rootNote: ~listAndParameters.rootNote));};
			}{
				"no new list".postln
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
		{
			~sendWithHail.((list: ~listAndParameters.list, rootNote: ~listAndParameters.rootNote));
			~gateOpen[1] = true; ~toLaunchControl.noteOn(0, 9, 63); //Macht Button 1 (note 9) bernsteingelb (veloc 63)
			{~button1.value = 1;}.defer; //Buttonfarbe in der Gui setzen
		}
		{ ~gateOpen[1] = false; ~toLaunchControl.noteOn(0, 9, 12);
			{~button1.value = 0;}.defer; //Buttonfarbe in der Gui setzen
		}; //Macht Button 1 (note 9) aus. (veloc 12)

	}
	{ num == 10 } { // Button -2-
		if (~gateOpen[2] == false)
		{
			~sendWithHail.((list: ~listAndParameters.list, rootNote: ~listAndParameters.rootNote));
			~gateOpen[2] = true; ~toLaunchControl.noteOn(0, 10, 63); //Macht Button 2 (note 10) bernsteingelb (veloc 63)
			{~button2.value = 1;}.defer; //Buttonfarbe in der Gui setzen
		}
		{ ~gateOpen[2] = false; ~toLaunchControl.noteOn(0, 10, 12);
			{~button2.value = 0;}.defer; //Buttonfarbe in der Gui setzen
		}; //Macht Button 1 (note 9) aus. (veloc 12)
	}
	{ num == 11 } { // Button -3-
		if (~gateOpen[3] == false)
		{
			~sendWithHail.((list: ~listAndParameters.list, rootNote: ~listAndParameters.rootNote));
			~gateOpen[3] = true; ~toLaunchControl.noteOn(0, 11, 63);
			{~button3.value = 1}.defer};
		{
			~gateOpen[3] = false; ~toLaunchControl.noteOn(0, 11, 12);
			{~button3.value = 0}.defer

		};
	}
	{ num == 12 } { //Button -4-
		if (~gateOpen[4] == false)
		{ ~gateOpen[4] = true; ~toLaunchControl.noteOn(0, 12, 63); {~button4.value = 1}.defer}
		{ ~gateOpen[4] = false; ~toLaunchControl.noteOn(0, 12, 12); {~button4.value = 0}.defer};
	}
	{ num == 25 } { //Button -5-
		if (~gateOpen[5] == false)
		{ ~gateOpen[5] = true; ~toLaunchControl.noteOn(0, 25, 63); {~button5.value = 1}.defer}
		{ ~gateOpen[5] = false; ~toLaunchControl.noteOn(0, 25, 12); {~button5.value = 0}.defer};
	}
	{ num == 26 } { //Button -6-

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
	}
	{ num == 12 } { //Button -4-
	}
	{ num == 25 } { //Button -5-
	}
	{ num == 26 } { //Button -6-
	}
	;
});
)










