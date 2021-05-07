"initializing send effects".postln;
//
// ~cyclicBufferRecordPointer ?? {~cyclicBufferRecordPointer = Bus.audio(Server.default, 1)};

~grainDelay_1 ?? {~grainDelay_1 = Bus.audio(Server.default, 2)};
~grainDelayBuffer_1 ?? {~grainDelayBuffer_1 = Buffer.alloc(Server.default, Server.default.sampleRate * 5, 2)};
~grainDelayBufferPosition_1 ?? {~grainDelayBufferPosition_1 = Bus.audio(Server.default, 1)};

~beatRepeat_1 ?? {~beatRepeat_1 = Bus.audio(Server.default, 2)};
~beatRepeatBuffer_1 ?? {~beatRepeatBuffer_1 = Buffer.alloc(Server.default, Server.default.sampleRate * 5, 2)};
~beatRepeatBufferPosition_1 ?? {~beatRepeatBufferPosition_1 = Bus.audio(Server.default, 1)};

~ef_reverb ?? {~ef_reverb = Bus.audio(s,2)};
~simpleDelay ?? {~simpleDelay = Bus.audio(s,2)};

s.sync;

/*SynthDef.new(\cyclicBufferRecordPointer, {
	arg out, buf=0;
	var sig;

	sig = Phasor.ar(0, BufRateScale.kr(buf), 0, BufFrames.kr(buf));
	Out.ar(~cyclicBufferRecordPointer, sig);
}).add;*/

SynthDef.new(\grainDelayBufferRecord, {
	arg inBus = ~grainDelay_1,
	buf_1 = ~grainDelayBuffer_1,
	bufPos = ~grainDelayBufferPosition_1,
	recording = 1;

	var ringBufDur = BufFrames.ir(buf_1);
	var recordPointer = Phasor.ar(rate: recording, end: ringBufDur);
	var input = InFeedback.ar(inBus, 2);

	BufWr.ar(input, buf_1, recordPointer);
	Out.ar(bufPos, recordPointer);
}).add;

SynthDef.new(\beatRepeatBufferRecord_1, {
	arg inBus = ~beatRepeat_1,
	buf = ~beatRepeatBuffer_1,
	bufPos = ~beatRepeatBufferPosition_1,
	recording = 1;

	var ringBufDur = BufFrames.ir(buf);
	var recordPointer = Phasor.ar(rate: recording, end: ringBufDur);
	var input = InFeedback.ar(inBus, 2);

	BufWr.ar(input, buf, recordPointer);
	Out.ar(bufPos, recordPointer);
}).add;

SynthDef(\ef_reverb, {
	arg inbus = ~ef_reverb,
	revtime = 2.5,
	predelay = 0.025,
	hpf = 60,
	lpf = 4000,
	spread = 1,
	vol = 1.5,
	beatDurNow = ~linkClock.tempo,
	sidechain_amount = (-24).dbamp;

	var sidechain_trigger_4 = \sidechain_trigger_4_verb.tr(0),
	sidechain_trigger_8 = \sidechain_trigger_8_verb.tr(0);

	var duck_4 = EnvGen.ar(Env([1,sidechain_amount,1],[0.01, 0.99], -2),sidechain_trigger_4, timeScale: beatDurNow),
	duck_8 = EnvGen.ar(Env([1,sidechain_amount,1],[0.01, 0.99], -1),sidechain_trigger_8, timeScale: (beatDurNow/2));

	var wet, temp, sig;

	temp = InFeedback.ar(~ef_reverb, 2);

	wet=0;

	temp=DelayN.ar(temp, 0.25, predelay);

	8.do {
		temp=AllpassN.ar(temp, 0.05, {Rand(0.001,0.05)}!4,revtime);
		temp=LPF.ar(temp,lpf);
		wet=wet+temp;
	};

	sig = wet * vol;

	sig = HPF.ar(Splay.ar(sig * duck_4 * duck_8, spread), hpf);

	Out.ar(~effect_bus, sig);

}).add;

SynthDef(\simpleDelay, {
	arg inBus = ~simpleDelay,
	beatDurNow = ~linkClock.tempo,
	relativeDelayTime = 0.75,
	filterType = 3,
	filterFreq = 500,
	resonance = 1.5,
	feedback_amount = 0.5,
	reverbSend = 0.25,
	maxDelayTime = 4;

	var input, inputDelay, feedback, delay;

	input = In.ar(inBus, 2);

	inputDelay = DelayL.ar(input, delaytime: ControlRate.ir.reciprocal);

	feedback = LocalIn.ar(2) * feedback_amount;

	delay = Select.ar(filterType ,[
		RLPF.ar(DelayL.ar((inputDelay + feedback), maxDelayTime, (beatDurNow * relativeDelayTime) - ControlRate.ir.reciprocal), filterFreq, resonance),
		BPF.ar(DelayL.ar((inputDelay + feedback), maxDelayTime, (beatDurNow * relativeDelayTime) - ControlRate.ir.reciprocal), filterFreq, resonance),
		RHPF.ar(DelayL.ar((inputDelay + feedback), maxDelayTime, (beatDurNow * relativeDelayTime) - ControlRate.ir.reciprocal), filterFreq, resonance),
	]);

	LocalOut.ar(delay);

	Out.ar(~effect_bus, delay);
	Out.ar(~ef_reverb, delay * reverbSend);

}).add;

SynthDef.new(\grainDelay, {
	arg amp = 0.5,
	out = ~effect_bus,
	buf = ~grainDelayBuffer_1,
	// buf2 = (~grainDelayBuffer_1.bufnum + 1),
	ptrBus = ~grainDelayBufferPosition_1,
	feedbackBus = ~grainDelay_1,
	atk = 1, rel = 1, gate = 1,
	sync = 1,
	dens = 40,
	baseDur = 0.05, durRand = 0.05,
	rate = 1, rateRand = 0.05,
	pan = 0, panRand = 0,
	grainEnv = (-1),
	ptrSampleDelay = 20000, ptrRandomSamples = 5000, minPtrDelay = 1000,
	feedback = 0.25;

	var sig, sig2,combined, env, densCtrl, durCtrl, rateCtrl, panCtrl,
	ptrRand, totalDelay, maxGrainDur, ptr;

	env = EnvGen.kr(Env.asr(atk,1,rel),gate, doneAction: 2);
	densCtrl = Select.ar(sync, [Dust.ar(dens), Impulse.ar(dens)]);
	durCtrl = baseDur + LFNoise1.ar(100).bipolar(durRand);
	rateCtrl = rate + LFNoise1.ar(100).bipolar(rateRand);
	panCtrl = pan + LFNoise1.kr(100).bipolar(panRand);

	ptrRand = LFNoise1.ar(100).bipolar(ptrRandomSamples);
	totalDelay = max(ptrSampleDelay - ptrRand, minPtrDelay);

	ptr = In.ar(ptrBus);
	ptr = ptr - ptrSampleDelay;
	ptr = ptr / BufFrames.kr(buf);
	ptr = ptr % 1;

	maxGrainDur = (totalDelay / rateCtrl) / SampleRate.ir;
	durCtrl = min(durCtrl, maxGrainDur);

	sig = GrainBuf.ar(
		2,
		densCtrl,
		durCtrl,
		buf,
		rateCtrl,
		ptr,
		2,
		panCtrl,
		grainEnv
	);
	/*sig2 = GrainBuf.ar(
		2,
		densCtrl,
		durCtrl,
		buf2,
		rateCtrl,
		ptr,
		2,
		panCtrl,
		grainEnv
	);
*/
	combined = [sig, /*sig2*/] * env * amp;
	Out.ar(out, combined);
	Out.ar(feedbackBus, combined.reverse * feedback);
	Out.ar(~ef_reverb, combined * 0.25);
}).add;

"starting send effects".postln;

s.sync;

~startSendFX = {
	~sendFX = ();
	~sendFX.cyclicBufferRecordPointer = Synth.new(\cyclicBufferRecordPointer,
		[\buf, ~grainDelayBuffer, \out, ~cyclicBufferRecordPointer],
		target: ~pointer_group);

	~sendFX.grainDelayBufferRecord = Synth.new(\grainDelayBufferRecord,
		[\inBus, ~grainDelay_1,
			\buf_1, ~grainDelayBuffer_1,
			\bufPos, ~grainDelayBufferPosition_1,
			\recording, 1],
		target: ~bufferRec_group);

	~sendFX.beatRepeatBufferRecord_1 = Synth.new(\beatRepeatBufferRecord_1,
		[\inBus, ~beatRepeat_1,
			\buf, ~beatRepeatBuffer_1,
			\bufPos, ~beatRepeatBufferPosition_1,
			\recording, 1],
		target: ~bufferRec_group);

	~sendFX.grainDelay = Synth.new(\grainDelay,
		[\amp, 1, \atk, 0.1, \rel, 1, \gate, 1, \sync, 0,
			\dens, 50, \baseDur, 0.5, \durRand, 0.05, \rate, 2,
			\rateRand, 0.025, \pan, 0, \panRand, 1, \grainEnv, (-1),
			\out, ~effect_bus,
			\buf, ~grainDelayBuffer_1,
			\buf2, (~grainDelayBuffer_1.bufnum + 1),
			\ptrBus, ~grainDelayBufferPosition_1,
			\feedbackBus, ~grainDelay_1,
			\ptrSampleDelay, s.sampleRate*0.04,
			\ptrRandomSamples, s.sampleRate*0.05,
			\minPtrDelay, 100,
			\feedback, 0.8,
		],
		target: ~effect_group);

	~sendFX.ef_reverb = Synth.new(\ef_reverb,
		args:[\inbus, ~ef_reverb,
			\revtime, 2.5,
			\predelay, 0.025,
			\hpf, 60,
			\lpf, 4000,
			\spread, 1,
			\vol, 1.5,
			\beatDurNow, ~linkClock.tempo,
			\sidechain_amount, (-24).dbamp],
		target: ~effect_group);

	~sendFX.simpleDelay = Synth.new(\simpleDelay,
		args:[\inBus, ~simpleDelay,
			\beatDurNow, ~linkClock.tempo,
			\relativeDelayTime, 0.75,
			\filterType, 3,
			\filterFreq, 500,
			\resonance, 1.5,
			\feedback_amount, 0.5,
			\reverbSend, 0.25,
			\maxDelayTime, 4],
		target: ~effect_group);
};

ServerTree.add({ ~startSendFX.value });