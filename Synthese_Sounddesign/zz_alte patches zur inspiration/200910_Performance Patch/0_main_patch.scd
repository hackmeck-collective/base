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


// Hier per SynthDef ändern

// ZZZZZZZZZZZZZZZZZZZZZZZZZZZ Row 1

(
var dict = ~createSynthDictionary.(
	name: \fm_1,
	chan: 0,
	synthArgs: (
		note: 60,
		macro_1: 0,
		macro_2: 0,
		macro_3: 0,
	)
);
dict.postln;
MIDIdef.cc(('knob-1a' ++ dict.name).asSymbol,{
	arg val, nr, src;
	dict[\setSynthArgsAndUpdateDictionary].(val.linexp(1,127,0.001,1), \macro_1);
},13).permanent_(true);

MIDIdef.cc(('knob-1b' ++ dict.name).asSymbol,{
	arg val, nr, src;
	dict[\setSynthArgsAndUpdateDictionary].(val.linexp(1,127,0.001,1), \macro_2);
},29).permanent_(true);

MIDIdef.cc(('knob-1c' ++ dict.name).asSymbol,{
	arg val, nr, src;
	dict[\setSynthArgsAndUpdateDictionary].(val.linexp(1,127,0.001,1), \macro_3);
},49).permanent_(true);

MIDIdef.cc(('fader-1' ++ dict.name).asSymbol,{
	arg val, nr, src;
	dict[\setSynthArgsAndUpdateDictionary].(val.linexp(1,127,0.001,0.2!2), \fader);
},77).permanent_(true);
)

// ZZZZZZZZZZZZZZZZZZZZZZZZZZZ Row 2

(
var dict = ~createSynthDictionary.(
	name: \BD_808_1,
	chan: 1,
	synthArgs: (
		note: 60,
		macro_1: 0,
		macro_2: 0,
		macro_3: 0,
	)
);
dict.postln;
MIDIdef.cc(('knob-2a' ++ dict.name).asSymbol,{
	arg val, nr, src;
	dict[\setSynthArgsAndUpdateDictionary].(val.linexp(1,127,0.001,1), \macro_1);
},14).permanent_(true);

MIDIdef.cc(('knob-2b' ++ dict.name).asSymbol,{
	arg val, nr, src;
	dict[\setSynthArgsAndUpdateDictionary].(val.linexp(1,127,0.001,1), \macro_2);
},30).permanent_(true);

MIDIdef.cc(('knob-2c' ++ dict.name).asSymbol,{
	arg val, nr, src;
	dict[\setSynthArgsAndUpdateDictionary].(val.linexp(1,127,0.001,1), \macro_3);
},50).permanent_(true);

MIDIdef.cc(('fader-2' ++ dict.name).asSymbol,{
	arg val, nr, src;
	dict[\setSynthArgsAndUpdateDictionary].(val.linexp(1,127,0.001,0.2!2), \fader);
},78).permanent_(true);
)

// ZZZZZZZZZZZZZZZZZZZZZZZZZZZ Row 3

(
var dict = ~createSynthDictionary.(
	name: \Clicks_1,
	chan: 2,
	synthArgs: (
		note: 60,
		macro_1: 0,
		macro_2: 0,
		macro_3: 0,
	)
);
dict.postln;
MIDIdef.cc(('knob-3a' ++ dict.name).asSymbol,{
	arg val, nr, src;
	dict[\setSynthArgsAndUpdateDictionary].(val.linexp(1,127,0.001,1), \macro_1);
},15).permanent_(true);

MIDIdef.cc(('knob-3b' ++ dict.name).asSymbol,{
	arg val, nr, src;
	dict[\setSynthArgsAndUpdateDictionary].(val.linexp(1,127,0.001,1), \macro_2);
},31).permanent_(true);

MIDIdef.cc(('knob-3c' ++ dict.name).asSymbol,{
	arg val, nr, src;
	dict[\setSynthArgsAndUpdateDictionary].(val.linexp(1,127,0.001,1), \macro_3);
},51).permanent_(true);

MIDIdef.cc(('fader-3' ++ dict.name).asSymbol,{
	arg val, nr, src;
	dict[\setSynthArgsAndUpdateDictionary].(val.linexp(1,127,0.001,0.2!2), \fader);
},79).permanent_(true);
)



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

~player.stop