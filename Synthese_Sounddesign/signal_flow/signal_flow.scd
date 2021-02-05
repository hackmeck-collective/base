"initializing groups".postln;

~makeGroups = {
	~source_group = Group.new;
	~effect_group = Group.after(~source_group);
	~bus_group = Group.after(~effect_group);
	~master_group = Group.tail;
};
ServerTree.removeAll;
ServerTree.add({ ~makeGroups.value }).run(\all);

"initializing control busses".postln;

~launchcontrol_xl_row_1 ?? {~launchcontrol_xl_row_1 = Bus.control(Server.default, 4)};
~launchcontrol_xl_row_2 ?? {~launchcontrol_xl_row_2 = Bus.control(Server.default, 4)};
~launchcontrol_xl_row_3 ?? {~launchcontrol_xl_row_3 = Bus.control(Server.default, 4)};
~launchcontrol_xl_row_4 ?? {~launchcontrol_xl_row_4 = Bus.control(Server.default, 4)};
~launchcontrol_xl_row_5 ?? {~launchcontrol_xl_row_5 = Bus.control(Server.default, 4)};
~launchcontrol_xl_row_6 ?? {~launchcontrol_xl_row_6 = Bus.control(Server.default, 4)};
~launchcontrol_xl_row_7 ?? {~launchcontrol_xl_row_7 = Bus.control(Server.default, 4)};
~launchcontrol_xl_row_8 ?? {~launchcontrol_xl_row_8 = Bus.control(Server.default, 4)};

"initializing audio busses".postln;

~melody_bus ?? {~melody_bus = Bus.audio(s,2)};
~chords_bus ?? {~chords_bus = Bus.audio(s,2)};
~drums_bus ?? {~drums_bus = Bus.audio(s,2)};
~aux_bus ?? {~aux_bus = Bus.audio(s,2)};
~instruments_bus ?? {~instruments_bus = Bus.audio(s,2)};
~melody_bus ?? {~melody_bus = Bus.audio(s,2)};
~effect_bus ?? {~effect_bus = Bus.audio(s,2)};
~master ?? {~master = Bus.audio(s,2)};

SynthDef(\melody_bus, {
	arg beatDurNow = 1,
	controlbus = ~launchcontrol_xl_row_8;

	var sidechain_trigger = \sidechain_trigger_long.tr(0),
	macro_controls = Lag.kr(
		In.kr(
			controlbus ?? {controlbus = Bus.control(Server.default, 4)},
			4),
		0.1);

	var macro_1 = macro_controls[0],
	sidechain_amount = macro_1.lincurve(0,1,1,-36.dbamp,3);

	var melody_bus_in, sidechain;

	var duck_long = EnvGen.ar(Env([1,sidechain_amount,1],[0.01, 0.99], -2),sidechain_trigger, timeScale: beatDurNow);

	melody_bus_in = In.ar(~melody_bus, 2);

	sidechain = melody_bus_in * duck_long;

	Out.ar(~instruments_bus, sidechain);

}).add;

SynthDef(\chords_bus, {
	arg beatDurNow = 1,
	controlbus = ~launchcontrol_xl_row_8;

	var sidechain_trigger = \sidechain_trigger_long.tr(0),
	macro_controls = Lag.kr(
		In.kr(
			controlbus ?? {controlbus = Bus.control(Server.default, 4)},
			4),
		0.1);

	var macro_1 = macro_controls[0],
	sidechain_amount = macro_1.lincurve(0,1,1,-36.dbamp,3);

	var chords_bus_in, sidechain;

	var duck_long = EnvGen.ar(Env([1,sidechain_amount,1],[0.01, 0.99], -2),sidechain_trigger, timeScale: beatDurNow);

	chords_bus_in = In.ar(~chords_bus, 2);

	sidechain = chords_bus_in * duck_long;

	Out.ar(~instruments_bus, sidechain);

}).add;

SynthDef(\drums_bus, {
	var drums_bus_in;

	drums_bus_in = In.ar(~drums_bus, 2);

	Out.ar(~instruments_bus, drums_bus_in);

}).add;

SynthDef(\aux_bus, {
	var aux_bus_in;

	aux_bus_in = In.ar(~aux_bus, 2);

	Out.ar(~instruments_bus, aux_bus_in);

}).add;

SynthDef(\instruments_bus, {
	var instruments_bus_in;

	instruments_bus_in = In.ar(~instruments_bus, 2);

	Out.ar(~master, instruments_bus_in);

}).add;

SynthDef(\effect_bus, {
	var effect_bus_in;

	effect_bus_in = In.ar(~effect_bus, 2);

	Out.ar(~master, effect_bus_in);

}).add;

SynthDef(\Master, {
	var macro_controls = Lag.kr(
		In.kr(
			~launchcontrol_xl_row_8 ?? {~launchcontrol_xl_row_8 = Bus.control(Server.default, 4)},
			4),
		0.1);

	var macro_2 = macro_controls[1],
	lpf_resonance = macro_2.lincurve(0,1,0,3.5,3),
	filter_vol_correct = macro_2.lincurve(0,1,1,3,3);

	var macro_3 = macro_controls[2],
	lpf_freq = macro_3.lincurve(0,1,60,18000,3);

	var macro_4 = macro_controls[3],
	vol = macro_4.lincurve(0,1,0.25,1,3);

	var master_in, soft_clip, hard_clip, sig;

	sig = In.ar(~master, 2);

	sig = MoogFF.ar(sig, lpf_freq, lpf_resonance) * filter_vol_correct;

	sig = vol * (sig / (1 + sig.abs));

	sig = tan(sig);

	Out.ar([0,1], sig);

}).add;

"starting audio busses".postln;

s.sync;
~startAudioBusses = {
	~audioBusses = ();
	~audioBusses.master = Synth.new(\Master,target: ~master_group);
	~audioBusses.effectBus = Synth.new(\effect_bus,target: ~bus_group);
	~audioBusses.instrumentsBus = Synth.new(\instruments_bus,target: ~bus_group);
	~audioBusses.melodyBus = Synth.new(\melody_bus,target: ~source_group);
	~audioBusses.chordsBus = Synth.new(\chords_bus,target: ~source_group);
	~audioBusses.drumsBus = Synth.new(\drums_bus,target: ~source_group);
	~audioBusses.auxBus = Synth.new(\aux_bus,target: ~source_group);
};

ServerTree.add({ ~startAudioBusses.value }).run(\all);

"initializing send effects".postln;

~ef_reverb ?? {~ef_reverb = Bus.audio(s,2)};

SynthDef(\ef_reverb, {
	arg in = ~ef_reverb,
	beatDurNow = 1,
	predelay = 0.025,
	controlbus = ~launchcontrol_xl_row_7;

	var sidechain_trigger = \sidechain_trigger_verb.tr(0),
	macro_controls = Lag.kr(
		In.kr(
			~launchcontrol_xl_row_7 ?? {~launchcontrol_xl_row_7 = Bus.control(Server.default, 4)},
			4),
		0.1);

	var macro_1 = macro_controls[0],
	sidechain_amount = macro_1.lincurve(0,1,1,-48.dbamp,3),
	sidechain_vol_correct =  macro_1.lincurve(0,1,1,1.5.dbamp,3);

	var macro_2 = macro_controls[1],
	revtime = macro_2.lincurve(0,1,0.01,10,3),
	lpf = macro_2.lincurve(0,1,2500,5000,-3),
	revtime_vol_correct =  macro_2.lincurve(0,1,0.5,4.dbamp,3),
	spread = macro_2.lincurve(0,0.5,0.05,1,0);

	var macro_3 = macro_controls[2];

	var macro_4 = macro_controls[3],
	vol = macro_4.lincurve(0,1,0,2,3);

	var wet, temp, sig;

	var duck_verb = EnvGen.ar(Env([1,sidechain_amount,1],[0.01, 0.99], -2),sidechain_trigger, timeScale: beatDurNow);

	temp = In.ar(~ef_reverb, 2);

	wet=0;

	temp=DelayN.ar(temp, 0.25, predelay);

	8.do {
		temp=AllpassN.ar(temp, 0.05, {Rand(0.001,0.05)}!4,revtime);
		temp=LPF.ar(temp,lpf);
		wet=wet+temp;
	};

	sig = wet * vol * sidechain_vol_correct * revtime_vol_correct;

	sig = HPF.ar(Splay.ar(sig * duck_verb, spread), 60);

	Out.ar(~effect_bus, sig);

}).add;

"starting send effects".postln;

s.sync;
~startSendFX = {
	~sendFX = ();
	~sendFX.ef_reverb = Synth.new(\ef_reverb,target: ~effect_group); //kann ich das hier auslagern????
};

ServerTree.add({ ~startSendFX.value }).run(\all);

"........ signal flow loaded".postln;