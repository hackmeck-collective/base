var hoehe = 100; //Heigth of the rows
var breite = 120; //Width of the collums
var platz = 20; // Space in pixels
var fontsize = 15;
var amber = Color.new(1,0.6,0,0.8);

w = Window.new("hindemith", bounds: Rect(100, 0, 1600, 900)).front;
//w.fullScreen;

"../../cues/philipp_cues.scd".loadRelative;
"cue function loaded.".postln;

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
~numberboxDissDegree = NumberBox(w, Rect(platz, 2 * platz + hoehe, 50, 50));
~numberboxDissDegree.font = Font("Monaco", fontsize);
~textfieldRoot = TextField(w, Rect(2*platz + breite, 2 * platz + hoehe, 50, 50));
~textfieldRoot.font = Font("Monaco", fontsize);
~numberboxNumberNotes = NumberBox(w, Rect(3 * platz + (2*breite),  2 * platz + hoehe, 50, 50));
~numberboxNumberNotes.font = Font("Monaco", fontsize);
~textfieldScale = TextField(w, Rect(4 * platz + (3*breite),  2 * platz + hoehe, 100, 50));
~textfieldScale.font = Font("Monaco", fontsize);
~numberboxLowerNote = NumberBox(w, Rect(5 * platz + (4*breite),  2 * platz + hoehe, 50, 50));
~numberboxLowerNote.font = Font("Monaco", fontsize);
~numberboxHigherNote = NumberBox(w, Rect(6 * platz + (5*breite),  2 * platz + hoehe, 50, 50));
~numberboxHigherNote.font = Font("Monaco", fontsize);

//Third row
~button1 = Button(w, Rect(platz, 3 * hoehe + platz, 100, 100))
.states_([ ["gate1", Color.black, Color.white], ["gate1", Color.black, amber] ]);

~button2 = Button(w, Rect( 2* platz + breite,  3 * hoehe + platz, 100, 100))
.states_([ ["gate2", Color.black, Color.white], ["gate2", Color.black, amber] ]);

~button3 = Button(w, Rect( 3* platz + (2*breite),  3 * hoehe + platz, 100, 100))
.states_([ ["gate3", Color.black, Color.white], ["gate3", Color.black, amber] ]);

~button4 = Button(w, Rect(4 * platz + (3 * breite), 3 * hoehe + platz, 100, 100))
.states_([ ["gate4", Color.black, Color.white], ["gate4", Color.black, amber] ]);

//Fourth row
~textfieldList = TextField(w, Rect(platz, 4 * hoehe + (2* platz), 1300, 40));
~textfieldList.align = \center;
~textfieldList.font = Font(size: 20);