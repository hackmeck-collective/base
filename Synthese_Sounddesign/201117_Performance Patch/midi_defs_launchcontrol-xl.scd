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

// ZZZZZZZZZZZZZZZZZZZZZZZZZZZ Row 3

(
var dict = ~createSynthDictionary.(
	name: \Spreadsynth_1,
	chan: 3,
	synthArgs: (
		note: 60,
		macro_1: 0,
		macro_2: 0,
		macro_3: 0,
	)
);
dict.postln;
MIDIdef.cc(('knob-4a' ++ dict.name).asSymbol,{
	arg val, nr, src;
	dict[\setSynthArgsAndUpdateDictionary].(val.linlin(0,127,0,1), \macro_1);
},16).permanent_(true);

MIDIdef.cc(('knob-4b' ++ dict.name).asSymbol,{
	arg val, nr, src;
	dict[\setSynthArgsAndUpdateDictionary].(val.linlin(0,127,0,1), \macro_2);
},32).permanent_(true);

MIDIdef.cc(('knob-4c' ++ dict.name).asSymbol,{
	arg val, nr, src;
	dict[\setSynthArgsAndUpdateDictionary].(val.linlin(0,127,0,1), \macro_3);
},52).permanent_(true);

MIDIdef.cc(('fader-4' ++ dict.name).asSymbol,{
	arg val, nr, src;
	dict[\setSynthArgsAndUpdateDictionary].(val.lincurve(0,127,0,1,2), \fader);
},80).permanent_(true);
)

"launchcontrol midifeds loaded".postln;