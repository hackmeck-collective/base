"initializing send effects".postln;

~ef_reverb ?? {~ef_reverb = Bus.audio(s,2)};
/*~simpleDelay_4 ?? {~simpleDelay_4 = Bus.audio(s,2)};
~simpleDelay_4d ?? {~simpleDelay_4d = Bus.audio(s,2)};
~simpleDelay_8 ?? {~simpleDelay_8 = Bus.audio(s,2)};*/
~simpleDelay_8d ?? {~simpleDelay_8d = Bus.audio(s,2)};


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

	temp = InFeedback.ar(~ef_reverb, 2);

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



SynthDef(\simpleDelay_8d, {
	arg in = ~simpleDelay_8d,
	beatDurNow = 1;

	var input, inputDelay, feedback, delay;

	input = In.ar(~simpleDelay_8d, 2);

	inputDelay = DelayL.ar(input, delaytime: ControlRate.ir.reciprocal);

	feedback = LocalIn.ar(2) * 0.5;

	delay = HPF.ar(DelayL.ar((inputDelay + feedback), 4, (beatDurNow * 0.75) - ControlRate.ir.reciprocal), 500);

	LocalOut.ar(delay);

	Out.ar(~effect_bus, delay);
	Out.ar(~ef_reverb, delay * 0.25);


}).add;


/*
SynthDef(\simpleDelay_4, {
	arg in = ~simpleDelay_4,
	beatDurNow = 1;

	var input, inputDelay, feedback, delay;

	input = In.ar(~simpleDelay_4, 2);

	inputDelay = DelayL.ar(input, delaytime: ControlRate.ir.reciprocal);

	feedback = LocalIn.ar(2) * 0.5;

	delay = HPF.ar(DelayL.ar((inputDelay + feedback), 4, beatDurNow - ControlRate.ir.reciprocal), 500);

	LocalOut.ar(delay);

	Out.ar(~effect_bus, delay);

}).add;

SynthDef(\simpleDelay_4d, {
	arg in = ~simpleDelay_4d,
	beatDurNow = 1;

	var input, inputDelay, feedback, delay;

	input = In.ar(~simpleDelay_4d, 2);

	inputDelay = DelayL.ar(input, delaytime: ControlRate.ir.reciprocal);

	feedback = LocalIn.ar(2) * 0.5;

	delay = HPF.ar(DelayL.ar((inputDelay + feedback), 4, (beatDurNow * 1.5) - ControlRate.ir.reciprocal), 500);

	LocalOut.ar(delay);

	Out.ar(~effect_bus, delay);

}).add;

SynthDef(\simpleDelay_8, {
	arg in = ~simpleDelay_8,
	beatDurNow = 1;

	var input, inputDelay, feedback, delay;

	input = In.ar(~simpleDelay_8, 2);

	inputDelay = DelayL.ar(input, delaytime: ControlRate.ir.reciprocal);

	feedback = LocalIn.ar(2) * 0.5;

	delay = HPF.ar(DelayL.ar((inputDelay + feedback), 4, (beatDurNow * 0.5) - ControlRate.ir.reciprocal), 500);

	LocalOut.ar(delay);

	Out.ar(~effect_bus, delay);

}).add;

*/

"starting send effects".postln;

s.sync;
~startSendFX = {
	~sendFX = ();
	~sendFX.ef_reverb = Synth.new(\ef_reverb, target: ~effect_group);
/*	~sendFX.simpleDelay_4 = Synth.new(\simpleDelay_4, target: ~effect_group);
	~sendFX.simpleDelay_4d = Synth.new(\simpleDelay_4d, target: ~effect_group);
	~sendFX.simpleDelay_8 = Synth.new(\simpleDelay_8, target: ~effect_group);*/
	~sendFX.simpleDelay_8d = Synth.new(\simpleDelay_8d, target: ~effect_group);
	//kann ich das hier auslagern????
};

ServerTree.add({ ~startSendFX.value });