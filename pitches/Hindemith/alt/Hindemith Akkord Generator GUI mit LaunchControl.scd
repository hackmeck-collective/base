var hoehe = 100;
var breite = 120;
var platz = 10;
var fontsize = 15;
var amber = Color.new(1,0.6,0,0.8);

w = Window.new(bounds: Rect(0, 300, 1100, 600)).front;
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

//Second row
~numberboxDissDegree = NumberBox(w, Rect(platz, 2 * platz + hoehe, 50, 50));
~numberboxDissDegree.font = Font("Monaco", fontsize);
~textfieldRoot = TextField(w, Rect(2*platz + breite, 2 * platz + hoehe, 50, 50));
~textfieldRoot.font = Font("Monaco", fontsize);
~numberboxNumberNotes = NumberBox(w, Rect(3 * platz + (2*breite),  2 * platz + hoehe, 50, 50));
~numberboxNumberNotes.font = Font("Monaco", fontsize);

//Fourth row
~button1 = Button(w, Rect(platz, 4 * hoehe + platz, 100, 100))
.states_([ ["gate1", Color.black, Color.white], ["gate1", Color.black, amber] ]);

~button2 = Button(w, Rect( 2* platz + breite,  4 * hoehe + platz, 100, 100))
.states_([ ["gate2", Color.black, Color.white], ["gate2", Color.black, amber] ]);

~button3 = Button(w, Rect( 3* platz + (2*breite),  4 * hoehe + platz, 100, 100))
.states_([ ["gate3", Color.black, Color.white], ["gate3", Color.black, amber] ]);

~button4 = Button(w, Rect(4 * platz + (3 * breite), 4 * hoehe + platz, 100, 100))
.states_([ ["gate4", Color.black, Color.white], ["gate4", Color.black, amber] ]);

~button5 = Button(w, Rect(5 * platz + (4 * breite), 4 * hoehe + platz, 100, 100))
.states_([ ["gate5", Color.black, Color.white], ["gate5", Color.black, amber] ]);


~textfieldList = TextField(w, Rect(breite, 5 * hoehe + ( 5 * platz), 1100 - breite - (2*platz), 40));
~textfieldList.font = Font(size: 20);