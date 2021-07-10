~allOutPad = -6.dbamp;

"initializing audio busses".postln;

~melody_bus ?? {~melody_bus = Bus.audio(s,2)};
~chords_bus ?? {~chords_bus = Bus.audio(s,2)};
~drums_bus ?? {~drums_bus = Bus.audio(s,2)};
~aux_bus ?? {~aux_bus = Bus.audio(s,2)};
~melody_bus_direct_out ?? {~melody_bus_direct_out = Bus.audio(s,2)};
~chords_bus_direct_out ?? {~chords_bus_direct_out = Bus.audio(s,2)};
~drums_bus_direct_out ?? {~drums_bus_direct_out = Bus.audio(s,2)};
~aux_bus_direct_out ?? {~aux_bus_direct_out = Bus.audio(s,2)};
~instruments_bus ?? {~instruments_bus = Bus.audio(s,2)};
~effect_bus ?? {~effect_bus = Bus.audio(s,2)};
~effect_bus_direct_out ?? {~effect_bus_direct_out = Bus.audio(s,2)};
~master ?? {~master = Bus.audio(s,2)};

s.sync;

"writing indices to object space".postln;

~routing[\melodyBus] = ~melody_bus.index;
~routing[\chordsBus] = ~chords_bus.index;
~routing[\drumsBus] = ~drums_bus.index;
~routing[\auxBus] = ~aux_bus.index;

"defining Synthdefs for audio busses".postln;

SynthDef(\melody_bus, {
	arg beatDurNow = ~linkClock.tempo,
	sidechain_amount = (-24).dbamp,

	eqLoShelf_freq, eqLoShelf_q, eqLoShelf_db,
	eqBand1_freq, eqBand1_q, eqBand1_db,
	eqBand2_freq, eqBand2_q, eqBand2_db,
	eqBand3_freq, eqBand3_q, eqBand3_db,
	eqHiShelf_freq, eqHiShelf_q, eqHiShelf_db;

	var sidechain_trigger_4 = \sidechain_trigger_4_melody.tr(0),
	sidechain_trigger_8 = \sidechain_trigger_8_melody.tr(0);

	var in, eq, sidechain;

	var duck_4 = EnvGen.ar(Env([1,sidechain_amount,1],[0.01, 0.99], -2),sidechain_trigger_4, timeScale: beatDurNow),
	duck_8 = EnvGen.ar(Env([1,sidechain_amount,1],[0.01, 0.99], -1),sidechain_trigger_8, timeScale: (beatDurNow/2));

	in = In.ar(~melody_bus, 2) * \on.kr(1, 0.001);

	in = BLowShelf.ar(in, eqLoShelf_freq, eqLoShelf_q, eqLoShelf_db);
	in = BPeakEQ.ar(in, eqBand1_freq, eqBand1_q, eqBand1_db);
	in = BPeakEQ.ar(in, eqBand2_freq, eqBand2_q, eqBand2_db);
	in = BPeakEQ.ar(in, eqBand3_freq, eqBand3_q, eqBand3_db);
	in = BHiShelf.ar(in, eqHiShelf_freq, eqHiShelf_q, eqHiShelf_db);

	sidechain = in * duck_4 * duck_8;

	Out.ar(~instruments_bus, sidechain);
	Out.ar(2, sidechain * ~allOutPad);

}).add;

SynthDef(\chords_bus, {
	arg beatDurNow = ~linkClock.tempo,
	sidechain_amount = (-24).dbamp,

	eqLoShelf_freq, eqLoShelf_q, eqLoShelf_db,
	eqBand1_freq, eqBand1_q, eqBand1_db,
	eqBand2_freq, eqBand2_q, eqBand2_db,
	eqBand3_freq, eqBand3_q, eqBand3_db,
	eqHiShelf_freq, eqHiShelf_q, eqHiShelf_db;

	var sidechain_trigger_4 = \sidechain_trigger_4_chords.tr(0),
	sidechain_trigger_8 = \sidechain_trigger_8_chords.tr(0);

	var in, sidechain;

	var duck_4 = EnvGen.ar(Env([1,sidechain_amount,1],[0.01, 0.99], -2),sidechain_trigger_4, timeScale: beatDurNow),
	duck_8 = EnvGen.ar(Env([1,sidechain_amount,1],[0.01, 0.99], -1),sidechain_trigger_8, timeScale: (beatDurNow/2));

	in = In.ar(~chords_bus, 2) * \on.kr(1, 0.001);

	in = BLowShelf.ar(in, eqLoShelf_freq, eqLoShelf_q, eqLoShelf_db);
	in = BPeakEQ.ar(in, eqBand1_freq, eqBand1_q, eqBand1_db);
	in = BPeakEQ.ar(in, eqBand2_freq, eqBand2_q, eqBand2_db);
	in = BPeakEQ.ar(in, eqBand3_freq, eqBand3_q, eqBand3_db);
	in = BHiShelf.ar(in, eqHiShelf_freq, eqHiShelf_q, eqHiShelf_db);

	sidechain = in * duck_4 * duck_8;

	Out.ar(~instruments_bus, sidechain);
	Out.ar(4, sidechain * ~allOutPad);

}).add;

SynthDef(\aux_bus, {

	arg eqLoShelf_freq, eqLoShelf_q, eqLoShelf_db,
	eqBand1_freq, eqBand1_q, eqBand1_db,
	eqBand2_freq, eqBand2_q, eqBand2_db,
	eqBand3_freq, eqBand3_q, eqBand3_db,
	eqHiShelf_freq, eqHiShelf_q, eqHiShelf_db;

	var in;

	in = In.ar(~aux_bus, 2) * \on.kr(1, 0.001);

	in = BLowShelf.ar(in, eqLoShelf_freq, eqLoShelf_q, eqLoShelf_db);
	in = BPeakEQ.ar(in, eqBand1_freq, eqBand1_q, eqBand1_db);
	in = BPeakEQ.ar(in, eqBand2_freq, eqBand2_q, eqBand2_db);
	in = BPeakEQ.ar(in, eqBand3_freq, eqBand3_q, eqBand3_db);
	in = BHiShelf.ar(in, eqHiShelf_freq, eqHiShelf_q, eqHiShelf_db);

	Out.ar(~instruments_bus, in);
	Out.ar(6, in * ~allOutPad);

}).add;

SynthDef(\drums_bus, {
	arg eqLoShelf_freq, eqLoShelf_q, eqLoShelf_db,
	eqBand1_freq, eqBand1_q, eqBand1_db,
	eqBand2_freq, eqBand2_q, eqBand2_db,
	eqBand3_freq, eqBand3_q, eqBand3_db,
	eqHiShelf_freq, eqHiShelf_q, eqHiShelf_db;

	var in;

	in = In.ar(~drums_bus, 2) * \on.kr(1, 0.001);

	in = BLowShelf.ar(in, eqLoShelf_freq, eqLoShelf_q, eqLoShelf_db);
	in = BPeakEQ.ar(in, eqBand1_freq, eqBand1_q, eqBand1_db);
	in = BPeakEQ.ar(in, eqBand2_freq, eqBand2_q, eqBand2_db);
	in = BPeakEQ.ar(in, eqBand3_freq, eqBand3_q, eqBand3_db);
	in = BHiShelf.ar(in, eqHiShelf_freq, eqHiShelf_q, eqHiShelf_db);

	Out.ar(~instruments_bus, in);
	Out.ar(8, in * ~allOutPad);

}).add;

SynthDef(\instruments_bus, {
	var instruments_bus_in;

	instruments_bus_in = In.ar(~instruments_bus, 2);

	Out.ar(~master, instruments_bus_in);

}).add;

SynthDef(\effect_bus, {
	arg eqLoShelf_freq, eqLoShelf_q, eqLoShelf_db,
	eqBand1_freq, eqBand1_q, eqBand1_db,
	eqBand2_freq, eqBand2_q, eqBand2_db,
	eqBand3_freq, eqBand3_q, eqBand3_db,
	eqHiShelf_freq, eqHiShelf_q, eqHiShelf_db;

	var in;

	in = In.ar(~effect_bus, 2);

	in = BLowShelf.ar(in, eqLoShelf_freq, eqLoShelf_q, eqLoShelf_db);
	in = BPeakEQ.ar(in, eqBand1_freq, eqBand1_q, eqBand1_db);
	in = BPeakEQ.ar(in, eqBand2_freq, eqBand2_q, eqBand2_db);
	in = BPeakEQ.ar(in, eqBand3_freq, eqBand3_q, eqBand3_db);
	in = BHiShelf.ar(in, eqHiShelf_freq, eqHiShelf_q, eqHiShelf_db);

	Out.ar(~master, in);
	Out.ar(10, in * ~allOutPad);

}).add;

SynthDef(\Master, {
	arg vol = 1,
	controlbus1,
	controlbus2,
	controlbus3,
	controlbus4;

	var macro_1 = Lag.kr(
		In.kr(controlbus1),
		0.1);

	var macro_2 = Lag.kr(
		In.kr(controlbus2),
		0.1);

	var lpf_resonance = macro_2.lincurve(0,1,0,3.5,3),
	filter_vol_correct = macro_2.lincurve(0,1,1,3,3);

	var macro_3 = Lag.kr(
		In.kr(controlbus3),
		0.1);

	var lpf_freq = macro_3.lincurve(0,1,60,18000,3);

	var macro_4 = Lag.kr(
		In.kr(controlbus4),
		0.1);

	var master_in, soft_clip, hard_clip, sig;

	/*vol = macro_4.lincurve(0,1,0.25,1,3)*/

	sig = In.ar(~master, 2);

	sig = MoogFF.ar(sig, lpf_freq, lpf_resonance) * filter_vol_correct;

	sig = vol * sig; //(sig / (1 + sig.abs));

	Out.ar(0, sig * ~allOutPad);

}).add;

"starting audio busses".postln;

s.sync;

~startAudioBusses = {
	~audioBusses = ();
	~audioBusses.master = Synth.new(\Master,
		args:[
			\vol, 1,
			\controlbus1, ~launchcontrolXlControlBusses[7],
			\controlbus2, ~launchcontrolXlControlBusses[15],
			\controlbus3, ~launchcontrolXlControlBusses[23],
			\controlbus4, ~launchcontrolXlControlBusses[31],
		/*\lpf_freq, 18000*/],
		target: ~master_group);

	~audioBusses.effectBus = Synth.new(\effect_bus,
		args:[
			\eqLoShelf_freq, 200, \eqLoShelf_q, 0.3, \eqLoShelf_db, -5,
			\eqBand1_freq, 350, \eqBand1_q, 1, \eqBand1_db, -3,
			\eqBand2_freq, 2000, \eqBand2_q, 0.5,  \eqBand2_db, -3,
			\eqBand3_freq, 5000, \eqBand3_q, 1,  \eqBand3_db, -3,
			\eqHiShelf_freq, 5000, \eqHiShelf_q, 0.8, \eqHiShelf_db, 6,
		],
		target: ~summing_group);
	~audioBusses.instrumentsBus = Synth.new(\instruments_bus,
		target: ~summing_group);

	~audioBusses.melodyBus = Synth.new(\melody_bus,
		args:[\sidechain_amount, (-24).dbamp,
			\beatDurNow, ~linkClock.tempo,

			\eqLoShelf_freq, 300, \eqLoShelf_q, 0.8, \eqLoShelf_db, -3,
			\eqBand1_freq, 350, \eqBand1_q, 1, \eqBand1_db, -3,
			\eqBand2_freq, 1500, \eqBand2_q, 1,  \eqBand2_db, 3,
			\eqBand3_freq, 2000, \eqBand3_q, 1,  \eqBand3_db, -3,
			\eqHiShelf_freq, 10000, \eqHiShelf_q, 0.8, \eqHiShelf_db, -6,
		],
		target: ~bus_group);

	~audioBusses.chordsBus = Synth.new(\chords_bus,
		args:[\sidechain_amount, (-24).dbamp,
			\beatDurNow, ~linkClock.tempo,

			\eqLoShelf_freq, 300, \eqLoShelf_q, 0.8, \eqLoShelf_db, -3,
			\eqBand1_freq, 350, \eqBand1_q, 1, \eqBand1_db, -3,
			\eqBand2_freq, 1500, \eqBand2_q, 1,  \eqBand2_db, 3,
			\eqBand3_freq, 2000, \eqBand3_q, 1,  \eqBand3_db, -3,
			\eqHiShelf_freq, 10000, \eqHiShelf_q, 0.8, \eqHiShelf_db, -6,
		],

		target: ~bus_group);
	~audioBusses.drumsBus = Synth.new(\drums_bus,
		args:[
			\eqLoShelf_freq, 300, \eqLoShelf_q, 0.8, \eqLoShelf_db, -3,
			\eqBand1_freq, 350, \eqBand1_q, 1, \eqBand1_db, -3,
			\eqBand2_freq, 1500, \eqBand2_q, 1,  \eqBand2_db, 3,
			\eqBand3_freq, 2000, \eqBand3_q, 1,  \eqBand3_db, -3,
			\eqHiShelf_freq, 10000, \eqHiShelf_q, 0.8, \eqHiShelf_db, -6,
		],
		target: ~bus_group);
	~audioBusses.auxBus = Synth.new(\aux_bus,
		args:[
			\eqLoShelf_freq, 300, \eqLoShelf_q, 0.8, \eqLoShelf_db, -3,
			\eqBand1_freq, 350, \eqBand1_q, 1, \eqBand1_db, -3,
			\eqBand2_freq, 1500, \eqBand2_q, 1,  \eqBand2_db, 3,
			\eqBand3_freq, 2000, \eqBand3_q, 1,  \eqBand3_db, -3,
			\eqHiShelf_freq, 10000, \eqHiShelf_q, 0.8, \eqHiShelf_db, -6,
		],
		target: ~bus_group);
};

ServerTree.add({ ~startAudioBusses.value });