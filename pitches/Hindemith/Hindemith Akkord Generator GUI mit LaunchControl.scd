var hoehe = 100; //Heigth of the rows
var breite = 120; //Width of the collums
var platz = 20; // Space in pixels
var fontsize = 15;
var amber = Color.new(1,0.6,0,0.8);

w = Window.new("hindemith", bounds: Rect(100, 0, 1600, 900)).front;
//w.fullScreen;



//First row
~text1 = StaticText(w, Rect(platz, platz, breite, hoehe));
~text1.string = "1 DISS.DEGREE";
~text1.align =\left;
~text1.font = Font("Monaco", fontsize);

~text2 = StaticText(w, Rect(2 * platz + breite, platz, breite, hoehe));
~text2.string = "2 ROOT";
~text2.align=\left;
~text2.font = Font("Monaco", fontsize);

~text3 = StaticText(w, Rect(3 * platz + (2*breite), platz, breite, hoehe));
~text3.string = "3 NUMBER NOTES";
~text3.align= \left;
~text3.font = Font("Monaco", fontsize);

~text4 = StaticText(w, Rect(4 * platz + (3*breite), platz, breite, hoehe));
~text4.string = "4 SCALE";
~text4.align= \left;
~text4.font = Font("Monaco", fontsize);

~text5 = StaticText(w, Rect(5 * platz + (4*breite), platz, breite, hoehe));
~text5.string = "5 LOWER NOTE";
~text5.align= \left;
~text5.font = Font("Monaco", fontsize);

~text6 = StaticText(w, Rect(6 * platz + (5*breite), platz, breite, hoehe));
~text6.string = "6 HIGHER NOTE";
~text6.align= \left;
~text6.font = Font("Monaco", fontsize);

//Second row
~numberboxDissDegree = NumberBox(w, Rect(platz,  platz + hoehe, 50, 50));
~numberboxDissDegree.font = Font("Monaco", fontsize);
~textfieldRoot = TextField(w, Rect(2*platz + breite,  platz + hoehe, 50, 50));
~textfieldRoot.font = Font("Monaco", fontsize);
~numberboxNumberNotes = NumberBox(w, Rect(3 * platz + (2*breite),  platz + hoehe, 50, 50));
~numberboxNumberNotes.font = Font("Monaco", fontsize);
~textfieldScale = TextField(w, Rect(4 * platz + (3*breite), platz + hoehe, 100, 50));
~textfieldScale.font = Font("Monaco", fontsize);
~numberboxLowerNote = NumberBox(w, Rect(5 * platz + (4*breite),   platz + hoehe, 50, 50));
~numberboxLowerNote.font = Font("Monaco", fontsize);
~numberboxHigherNote = NumberBox(w, Rect(6 * platz + (5*breite),   platz + hoehe, 50, 50));
~numberboxHigherNote.font = Font("Monaco", fontsize);

~led = LevelIndicator(w, bounds:Rect(6*breite+(6*platz), platz + hoehe, 30, 30)).front;
~led.style = \led;
~led.meterColor = Color.red;
~led.background = Color.white;
~led.numSteps = 1;

//Third row
~button1 = Button(w, Rect(platz, 2 * hoehe + platz, 100, 100))
.states_([ ["gate", Color.black, Color.white], ["gate", Color.black, amber] ]);



"loading PianoGUI".postln;
"trees/piano_gui.scd".loadRelative;
~startPiano.init([0,4,7]);


//Fourth row
~textfieldList = TextField(w, Rect(platz, 3 * hoehe + (2* platz), 1200, 40));
~textfieldList.align = \center;
~textfieldList.font = Font(size: 20);

// underneath:
"../../cues/philipp_cues.scd".loadRelative;
"cue function loaded.".postln;
