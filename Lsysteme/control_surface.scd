// externals, quarks:
// PtimeClutch
// redFrik
// connectVirmidi;


// startup
(
~connectVirmidi.();
"funcs_modular.scd".loadRelative;
"gui_modular.scd".loadRelative;
)

~openRelative.("funcs_modular.scd")
// GUI CONTROLS (SC ODER OPENSTAGE)
// tempo
// volume per channel
// midinote wrapping (per channel ??)


// TEXT CONTROLS
// Lsys Abfolge

// Beispiele 1
// es gibt 3 parts ABC die immer wieder abgespielt werden

~partSequencer = Pseq([Pdefn(\a, ~partA), Pdefn(\b, ~partA), Pdefn(\c, ~partA)], inf).asStream;

// die koennen dann manipuliert und ausgetauscht werden
~partA = ...;
Pdefn(\a, ~partA);
Pdef.clear


{
	inf.do {
		~partSequencer.next.postln;
		1.wait;
	}
}.fork


~partA = ~makeStream.(g.lsys, 51);
~partB = ~makeStream.(g.lsys, 51, ~partA.lastVoices);

// Realisation: bei lastVoices wird immer nur die base voice relevant sein (denn jedes lsystem faengt immer nur damit an


(
Pn(
	Pdef(\sp1) <> Pbind(\stream, Pfunc { ~partA })
).play
)

~partSequencer = Pseq([~partA, ~partB], 1).asStream;
~uview.clearDrawing

(
{
	2.do {
		var part = ~partSequencer.next;
		var waitTime = part.stream[0].times.last / 4; // baseTempo bedenken
		// var waitTime = part.stream.last.times.last / 4; // baseTempo bedenken
		// Je nachdem ob die Teile ineinander greifen sollen oder nicht muss man die erste oder die letzte schicht als waitTime benutzen
		// um das ehemalige verhalten zu bekommen demnach fuer alle konsekutiven teile erste waitTime und fuer den letzten teil letzte
		(Pdef(\sp1) <> (stream: part)).play;
		waitTime.postln.wait;
	}
}.fork
)
