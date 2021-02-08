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
	arg vol = 1,
	controlbus,
	lpf_freq;

	var macro_controls = Lag.kr(
		In.kr(
			controlbus ?? {controlbus = Bus.control(Server.default, 4)},
			4),
		0.1);

	var macro_2 = macro_controls[1],
	lpf_resonance = macro_2.lincurve(0,1,0,3.5,3),
	filter_vol_correct = macro_2.lincurve(0,1,1,3,3);

	var macro_3 = macro_controls[2];

	var macro_4 = macro_controls[3];

	var master_in, soft_clip, hard_clip, sig;

	lpf_freq = macro_3.lincurve(0,1,60,18000,3);
	/*vol = macro_4.lincurve(0,1,0.25,1,3)*/

	sig = In.ar(~master, 2);

	sig = MoogFF.ar(sig, lpf_freq, lpf_resonance) * filter_vol_correct;

	sig = vol * (sig / (1 + sig.abs));

	// sig = tan(sig);

	Out.ar(0, sig);

}).add;

"starting audio busses".postln;

s.sync;
~startAudioBusses = {
	~audioBusses = ();
	~audioBusses.master = Synth.new(\Master,
		args:[
			\vol, 1,
			\controlbus, ~launchcontrol_xl_row_8,
			\lpf_freq, 18000],
		target: ~master_group);
	~audioBusses.effectBus = Synth.new(\effect_bus,target: ~bus_group);
	~audioBusses.instrumentsBus = Synth.new(\instruments_bus,target: ~bus_group);
	~audioBusses.melodyBus = Synth.new(\melody_bus,target: ~source_group);
	~audioBusses.chordsBus = Synth.new(\chords_bus,target: ~source_group);
	~audioBusses.drumsBus = Synth.new(\drums_bus,target: ~source_group);
	~audioBusses.auxBus = Synth.new(\aux_bus,target: ~source_group);
};

ServerTree.add({ ~startAudioBusses.value }).run(\all);