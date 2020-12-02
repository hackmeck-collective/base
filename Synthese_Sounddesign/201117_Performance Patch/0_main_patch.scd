(
s = Server.default();
/*
s.options.protocol = \tcp;
s.options.bindAddress = "0.0.0.0";*/
s.options.sampleRate = 48000;
s.options.bindAddress = "0.0.0.0";
s.options.maxLogins = 4;
s.options.device = "ASIO : ASIO Fireface USB";
s.waitForBoot {
	if(MIDIClient.initialized.not){
		MIDIClient.init;
		MIDIIn.connectAll;
	};
	"fm_1.scd".loadRelative;
	"BD_808_1.scd".loadRelative;
	"clicks_1.scd".loadRelative;
	"spreadsynth_1.scd".loadRelative;
	"modes_synth_1.scd".loadRelative;
	"functions.scd".loadRelative;
	"midi_defs_launchcontrol-xl.scd".loadRelative;
	"ready".postln
}
)
DD
(
thisProcess.openUDPPort(9000);
OSCdef(\on, { arg msg;
	MIDIIn.doNoteOnAction(*msg[1..]);
}, '/noteOn').permanent_(true);

OSCdef(\off, { arg msg;
	MIDIIn.doNoteOffAction(*msg[1..].postln);
}, '/noteOff').permanent_(true);
)

OSCFunc.trace(true)
s.addr
a = Synth(\fm_1, [\note, 60]);
a.free


s.options.maxLogins = 4;
s.options.sampleRate = 48000;
s.options.device = "ASIO : ASIO Fireface USB";
s.options.bindAddress = "0.0.0.0";
s.boot
(server: r).play