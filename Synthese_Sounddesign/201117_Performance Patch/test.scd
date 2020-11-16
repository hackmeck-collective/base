(
~player = {
	inf.do {
		MIDIIn.doNoteOnAction(0, 0, 60, 100);
		MIDIIn.doNoteOnAction(0, 0, 63, 100);
		MIDIIn.doNoteOnAction(0, 0, 70, 100);
		3.wait;
		MIDIIn.doNoteOffAction(0, 0, 60);
		MIDIIn.doNoteOffAction(0, 0, 63);
		MIDIIn.doNoteOffAction(0, 0, 70);
		1.wait
	}
}.fork
)
(
~player = {
	inf.do {
		MIDIIn.doNoteOnAction(0, 1, 36, 100);
		0.5.wait;
		MIDIIn.doNoteOffAction(0, 1, 36);
		1.wait
	}
}.fork
)

(
var note = 60;
~player = {
	inf.do {
		MIDIIn.doNoteOnAction(0, 2, note, 100);
		0.125.wait;
		MIDIIn.doNoteOffAction(0, 2, note);
		MIDIIn.doNoteOnAction(0, 2, note - 12, 100);
		0.125.wait;
		MIDIIn.doNoteOffAction(0, 2, note - 12);
		MIDIIn.doNoteOnAction(0, 2, note - 24, 100);
		0.125.wait;
		MIDIIn.doNoteOffAction(0, 2, note - 24);
		MIDIIn.doNoteOnAction(0, 2, note - 36, 100);
		0.125.wait;
		MIDIIn.doNoteOffAction(0, 2, note - 36);
		MIDIIn.doNoteOnAction(0, 2, note + 12, 100);
		0.125.wait;
		MIDIIn.doNoteOffAction(0, 2, note + 12);
		1.wait
	}
}.fork
)

(
var note = 60, channel = 3;
~player = {
	inf.do {
		MIDIIn.doNoteOnAction(0, channel, note, 100);
		1.wait;
		MIDIIn.doNoteOffAction(0, channel, note);
		MIDIIn.doNoteOnAction(0, channel, note - 5, 100);
		0.5.wait;
		MIDIIn.doNoteOffAction(0, channel, note - 5);
		MIDIIn.doNoteOnAction(0, channel, note - 12, 100);
		0.5.wait;
		MIDIIn.doNoteOffAction(0, channel, note - 12);
		MIDIIn.doNoteOnAction(0, channel, note + 3, 100);
		0.250.wait;
		MIDIIn.doNoteOffAction(0, channel, note + 3);
		MIDIIn.doNoteOnAction(0, channel, note + 12, 100);
		0.250.wait;
		MIDIIn.doNoteOffAction(0, channel, note + 12);
		1.wait
	}
}.fork
)
~player.stop