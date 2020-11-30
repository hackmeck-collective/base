(
s = Server.default();
/*s.options.maxLogins = 2;
s.options.protocol = \tcp;
s.options.bindAddress = "0.0.0.0";*/
s.options.sampleRate = 48000;
s.options.device = "ASIO : ASIO Fireface USB";
s.waitForBoot {
	if(MIDIClient.initialized.not){
		MIDIClient.init;
		MIDIIn.connectAll;
	};
	"synthDefs.scd".loadRelative;
	"functions.scd".loadRelative;
	"midi_defs_launchcontrol-xl.scd".loadRelative;
	"ready".postln
}
)

(
thisProcess.openUDPPort(9000);
OSCdef(\on, { arg msg;
	MIDIIn.doNoteOnAction(*msg[1..]);
}, '/noteOn').permanent_(true);

OSCdef(\off, { arg msg;
	MIDIIn.doNoteOffAction(*msg[1..].postln);
}, '/noteOff').permanent_(true);
)
OSCFunc.trace(true, true)
s.addr
a = Synth(\fm_1, [\note, 60]);
a.free

Pbind(
	\instrument, \fm_1,
	\dur, Pseq([1/4, 1/8, 1/8], inf),
	\note, Pseq([[60, 70], 65, 58], inf)
).play

s.options.maxLogins = 4

r = Server.remote(\test2, NetAddr("192.168.0.182", 57110), s.options, 1)
(server: r).play