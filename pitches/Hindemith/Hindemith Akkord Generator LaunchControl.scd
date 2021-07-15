

(


//if (s.serverRunning.not) {s.boot};

~gateOpen ? false;


if (MIDIClient.initialized.not){
	"initializing MIDI ...".postln;


	MIDIClient.init;
	"MIDI initialized".postln;
	"connecting MIDIIn ...".postln;
	MIDIIn.connectAll;
	if (~port.isNil) {
		~port = MIDIClient.destinations.detectIndex({|item| item.asString.contains("Launch Control")});
		~toLaunchControl = MIDIOut.new(~port);
		~toLaunchControl.connect(~port);
	};

	"MIDIIn connected".postln;
};



~localSetup = false;
"../../network/address_book_all.scd".loadRelative;
// Hail-Init for Networking
// ~addrBook = AddrBook.new;
// ~addrBook.addMe(Peer(\Philipp, NetAddr("192.168.178.21", 57120)));
// ~hail = Hail.new(~addrBook);
// ~addrBook.peers;
// ~addrBook.names;
// ~objSpace = OSCObjectSpace(~addrBook, true, '/pitches');
~expandNotes = {|notes, lowNote, highNote|
	var addOctaves = (0, 12 .. 96) +.t notes + lowNote;
	addOctaves.flat.reject(_ > highNote).as(Set).asArray.sort
};

~sendWithHail = {arg event; //Funktion, die das event inklusive liste versendet.
	~pitchesRootDissonance[\pitches] = ~expandNotes.(event.list, ~listAndParameters.lowNote, ~listAndParameters.highNote).postln; //event.list
	~pitchesRootDissonance[\root] = event.rootNote;
};

"prepare Session.scd".loadRelative;

)



/*
pixels[x*width+y*height] = pixels[x*width-y*heigth/2];



0 0 > 0 0
1 0 > 1 0
2 0 > 2 0
3 0 > 3 0
...
10 0 > 10 0
0 1 > 0 1
1 1 > 1 1
2 1 > 2 1
3 1 > 3 1
...
9 4 > 9 4
10 4 > 10 4
0 5 > 0 5        height-
1 5 > 1 5
2 5 > 2 5
3 5 > 3 5
...
10 5 > 10 5
0 6 > 0 4       height-y

void flipHalf(){
loadPixels();
for(int x = width/2 x < width; x++){
    for(int y = 0; y < height; y++){
        pixels[x+y*width] = pixels[(width-x)+y*width];
    }
}
for (int x = 0; x < width; x++){
    for (int y = height/2; y < height; y++){
      pixels[x+y*width] = pixels[(x+(y/2)*width)];
    }
  }
updatePixels();
}


With mirror I would guess that you need to change

int temp = pixelData[x][y];
pixelData[x][y]=pixelData[width-x][y]
pixelData[width-x][y]=temp;

to something like this only

pixelData[x][y]=pixelData[width-x][y]

Share
Follow
answered Apr 15 '10 at 17:10
Adriaan Stander
152k2727 gold badges270270 silver badges278278 bronze badges
Add a comment
4

You need to use width-1-x instead of width-x, and height-1-y instead of height-y. Otherwise for x==0 you'll try to index [width], which is outside the array.



*/




(


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
			var closestList = ~searchTreeNearestOld.(
				underlyingScale: ~listAndParameters.underlyingScale,
				chord: ~listAndParameters.list,
				rootNote: ~listAndParameters.rootNote,
				dissDegree: newDissDegree
			);

			"dissDegree: ".post;
			~listAndParameters.dissDegree = newDissDegree.postln;

			if(closestList.notNil){
				~listAndParameters.list = closestList;
				{~led.value = 0}.fork(AppClock);
				if(~gateOpen == true){~sendWithHail.(
					(list: ~listAndParameters.list, rootNote: ~listAndParameters.rootNote))
				}
			}{
				"no new list".postln;

				{~led.value = 1}.fork(AppClock); //{ ~led.value = 1; 0.2.wait; ~led.value = 0;}.fork(AppClock);
			};
			~actualizeGUI.value;

		}
	}
	{ num == 22 } { //Drehknopf 2 oben
		//rootNote
		var newRootValue = val.linlin(0,127,0,11).round.asInteger; // 0 bis 11
		if (newRootValue != ~listAndParameters.rootNote)
		{
			var closestList = ~searchTreeNearestOld.(
				underlyingScale: ~listAndParameters.underlyingScale,
				chord: ~listAndParameters.list,
				rootNote: newRootValue,
				dissDegree: ~listAndParameters.dissDegree
			);
			"rootNote: ".post;
			~listAndParameters.rootNote = newRootValue.postln;

			if(closestList.notNil){
				~listAndParameters.list = closestList;
				{~led.value = 0}.fork(AppClock);
				if(~gateOpen == true){~sendWithHail.(
					(list: ~listAndParameters.list, rootNote: ~listAndParameters.rootNote))
				}
			}{
				"no new list".postln;

				{~led.value = 1}.fork(AppClock);
			};
			~actualizeGUI.value;
		}
	}
	{ num == 23 } { //Drehknopf 3 oben
		//Soll Anzahl Töne steuern. Mit Dissonanzgrad wird eine Liste erstellt.
		var newNumberOfNotes = val.linlin(0,127,3,7).round.asInteger; //3 bis 7
		//newNumberOfNotes.postln;
		if (~listAndParameters.numNotes != newNumberOfNotes)
		{
			"numNotes: ".post;
			~listAndParameters.numNotes = newNumberOfNotes.postln;
			~actualizeGUI.value;
		};
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
				underlyingScale: ~listAndParameters.underlyingScale,
				chord: testlist,
				rootNote: ~listAndParameters.rootNote,
				dissDegree: ~listAndParameters.dissDegree
			);

			if(closestList.notNil){
				~listAndParameters.list = closestList;
				{~led.value = 0}.fork(AppClock);
				~listAndParameters.numNotes = ~listAndParameters.list.size;
				if(~gateOpen == true){~sendWithHail.(
					(list: ~listAndParameters.list, rootNote: ~listAndParameters.rootNote))
				}
			}{
				"no new list".postln;
				{~led.value = 1}.fork(AppClock);
			};
			~actualizeGUI.value;
		}
	}
	{ num == 24 } { //Drehknopf 4 oben
		//Steuert die Skala auf deren Grundlage die Akkorde erstellt werden.
		var newUnderlyingScale = ['Chromatic 12 (ET12)', 'Diminished', 'Major', 'Natural Minor', 'Bartok', 'Whole Tone'].at(val.linlin(0,127,0,5).round.asInteger);
		if (newUnderlyingScale != ~listAndParameters.underlyingScale) {
			var closestList = ~searchTreeNearestOld.(
				underlyingScale: newUnderlyingScale,
				chord: ~listAndParameters.list,
				rootNote: ~listAndParameters.rootNote,
				dissDegree: ~listAndParameters.dissDegree
			);
			"underlyingScale: ".post;
			~listAndParameters.underlyingScale = newUnderlyingScale.postln;

			if(closestList.notNil){
				~listAndParameters.list = closestList;
				{~led.value = 0}.fork(AppClock);
				if(~gateOpen == true){~sendWithHail.(
					(list: ~listAndParameters.list, rootNote: ~listAndParameters.rootNote))
				}
			}{
				"no new list".postln;
				{~led.value = 1}.fork(AppClock);
			};
			~actualizeGUI.value;
		}
	}
	{ num == 25 } { //Drehknopf 5 oben
		//Steuert die untere Grenze für die Akkorde
		var newLowNote = val.linlin(0,127,2,7).round.asInteger * 12;
		if ((newLowNote + 12) < ~listAndParameters.highNote){
			~listAndParameters.lowNote = newLowNote;
			~actualizeGUI.value;
			~sendWithHail.((list: ~listAndParameters.list, rootNote: ~listAndParameters.rootNote));
		}{
			"lowNote is too high".warn;
		}
	}
	{ num == 26 } { //Drehknopf 6 oben
		//Steuert die obere Grenze für die Akkorde
		var newHighnote = (val.linlin(0,127,3,9).round.asInteger * 12);
		if ((newHighnote - 12) > ~listAndParameters.lowNote){
			~listAndParameters.highNote = newHighnote;
			~actualizeGUI.value;
			~sendWithHail.((list: ~listAndParameters.list, rootNote: ~listAndParameters.rootNote));
		}{
			"highNote is too low".warn;
		};
	}
	{ num == 28 } { //Drehknopf 8 oben
	}
	{ num == 41 } { //Dreknopf 1 unten
	}
	{ num == 42 } { //Dreknopf 2 unten
	}
	// And so on ...
	;
});

MIDIdef.noteOn(\launchControlButtonsON, {
	arg val, num, chan, src;
	case
	{ num == 9 } { // Button -1-
		if (~gateOpen == false)
		{
			~sendWithHail.((list: ~listAndParameters.list, rootNote: ~listAndParameters.rootNote));
			~gateOpen = true; ~toLaunchControl.noteOn(0, 9, 63); //Macht Button 1 (note 9) bernsteingelb (veloc 63)
			{~button1.value = 1;}.defer; //Buttonfarbe in der Gui setzen
		}
		{ ~gateOpen = false; ~toLaunchControl.noteOn(0, 9, 12);
			{~button1.value = 0;}.defer; //Buttonfarbe in der Gui setzen
		}; //Macht Button 1 (note 9) aus. (veloc 12)
	}
	{ num == 10 } { // Button -2-
	}
	{ num == 11 } { // Button -3-
	}
	{ num == 12 } { //Button -4-
	}
	{ num == 25 } { //Button -5-
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










