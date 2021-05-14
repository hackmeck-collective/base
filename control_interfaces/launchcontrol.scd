if (MIDIClient.initialized.not){
	var port;
	"initializing MIDI ...".postln;

	MIDIClient.init;
	"MIDI initialized".postln;
	"connecting MIDIIn ...".postln;
	MIDIIn.connectAll;
	"MIDIIn connected".postln;
	port = MIDIClient.destinations.detectIndex({|item| item.asString.contains("Launch Control")});
	MIDIOut.new(port).connect(port);
};


