Document.open(thisProcess.nowExecutingPath.dirname +/+ "pitchPatterns.scd");
Document.open(thisProcess.nowExecutingPath.dirname +/+ "rhythmicPatterns.scd");
Document.open(thisProcess.nowExecutingPath.dirname +/+ "patternFunctions.scd");
Document.open(thisProcess.nowExecutingPath.dirname +/+ "drumFills.scd");
Document.open(thisProcess.nowExecutingPath.dirname +/+ "launchControlXlTrigger.scd");
~cueData[\lsysBeats1]
~instrPreset.create(\granulator)
~instrPreset.create_d(\template_drum)
~instrPreset.create_o(\simpleSine)
~instrPreset.edit(\simpleLead);

(
b = ( Pbind(\controlbus1, ~launchcontrol_xl_row_1, \envelope_mod, 0.5)
 <> Pdef(\srrPluck)
	<> Pbind( \controlbus1_index, 1,  \external1Target, "envelope_mod", \external1Amount, 1, ) <> Pbindef(\arp) <> Pbindef(\pulse_16) ).play(~linkClock, quant: 4);
)
b.stop

00010000
00010010
00010010
00011010
01011010
01011011
01111011
01111111
11111111

~bd2.stop;
~bd2 = ( Pbind( \octave, 3) <> Pdef(\bdBuzz).collect {|ev| ~scM8.play; ev} <> Pbindef(\root) <> Pbindef(\pulse_2) ).play(~linkClock, quant: 4);
~sd.stop;
~sd = ( Pdef(\sd2).collect {|ev| ~scM4.play; ev} <> Pbindef(\fifth) <> Pbindef(\pulse_4_ob)  ).play(~linkClock, quant: 4);


~audioBusses.melodyBus.set(\sidechain_amount, (-72).dbamp);
~audioBusses.chordsBus.set(\sidechain_amount, (-72).dbamp);
(
~sendFX.ef_reverb.set(\inbus, ~ef_reverb,
	\revtime, 2.5,
	\predelay, 0.025,
	\hpf, 60,
	\lpf, 4500,
	\spread, 1,
	\vol, 1.5,
	\beatDurNow, ~linkClock.tempo,
	\sidechain_amount, (-24).dbamp);
);
(
~sendFX.simpleDelay.set(\inBus, ~simpleDelay,
	\beatDurNow, ~linkClock.tempo,
	\relativeDelayTime, 0.33,
	\filterType, 3,
	\filterFreq, 500,
	\resonance, 2,
	\feedback_amount, 0.45,
	\reverbSend, 0.25,
	\maxDelayTime, 4);
);
(
~sendFX.grainDelay.set(\amp, 1, \atk, 0.1, \rel, 1, \gate, 1, \sync, 0,
	\dens, 50, \baseDur, 0.5, \durRand, 0.05, \rate, 2,
	\rateRand, 0.025, \pan, 0, \panRand, 1, \grainEnv, (-1),
	\out, ~effect_bus,
	\buf, ~grainDelayBuffer_1,
	\buf2, (~grainDelayBuffer_1.bufnum + 1),
	\ptrBus, ~grainDelayBufferPosition_1,
	\feedbackBus, ~grainDelay_1,
	\ptrSampleDelay, s.sampleRate*0.4,
	\ptrRandomSamples, s.sampleRate*0.05,
	\minPtrDelay, 100,
	\feedback, 0.5,)
);

b = (Pdef(\simpleLead) <> Pbindef(\root) <> Pbindef(\pulse) ).play(~linkClock, quant: 4);


~scM4.play
~instrumentPresetsDictionary[\sd2][\send_2]
Pdef(\sd2).set(\send_2, ~simpleDelay, \send_2_level, 0)

~beatRepeatBuffer_1.plot
(
Routine({
	var controlbus =  ~launchcontrol_xl_row_3,
	quant = 0.5;
	(~linkClock.timeToNextBeat % quant).wait;
	~sendFX.beatRepeatBufferRecord_1.set(\recording, 0);
	b.pause;
	c = ( Pbind(\controlbus2, ~launchcontrol_xl_row_3,
		\controlbus2_index, 1,
		\oscillator_mod_1, 0.5,
		\oscillator_mod_2, 0.5,
		\oscillator_mod_3, 0.5)
	<> Pdef(\beatRepeat)
	<> Pbind(\dur, Pfunc{ 1/(2**~launchcontrol_xl_row_3.getnSynchronous[0].linlin(0,1,8,0).round)}, \legato, 0.5) ).play;
	(~linkClock.timeToNextBeat % quant).postln
}).play;
)


(
Routine({
	var controlbus =  ~launchcontrol_xl_row_3,
	quant = 0.5;
	(~linkClock.timeToNextBeat % quant).wait;
	~sendFX.beatRepeatBufferRecord_1.set(\recording, 0);
	b.pause;
	c = (
		/*Pbind(\controlbus1, controlbus,
		\controlbus1_index, 1,
		\controlbus2, controlbus,
		\controlbus2_index, 1,
		\controlbus3, controlbus,
		\controlbus3_index, 1,
		\oscillator_mod_1, 400,
		\oscillator_mod_2, 10,
		\oscillator_mod_3, 0.5,
		\oscillator_mod_4, 0.9,
		\mod1Type, \noise,
		\mod1Target, "oscillator_mod_4",
		\mod1Amount, 0,
		\external1Target, "",
		\external1Amount, 1,
		\external2Target, "",
		\external2Amount, 1,
		\external3Target, "",
		\external3Amount, 1,
		) <> */
		Pdef(\granulator)
		<> Pbind(\dur, 1, \legato, 1) ).play;
	(~linkClock.timeToNextBeat % quant).postln
}).play;
)

(
s.makeBundle((~linkClock.timeToNextBeat%0.25), {
	~sendFX.beatRepeatBufferRecord_1.set(\recording, 1);
	c.stop;
	b.play;
});
)

// root note und drums mit phillip klären

(Pdef(\sd3) <> ~quarterFills).play(~linkClock, quant: 1);
(Pdef(\sd3) <> ~halfFills).play(~linkClock, quant: 2);
Pdef(\fill, (Pdef(\sd3) <> ~quarterFills));

Pdef(\fill).stop

//////// RHYTHMEN mit INSTRUMENTEN verketten


(
( Psym1(Pxrand([\simplePluck, \srrPluck, \noisyPluck],inf)) <>
Pbindef(\root) <>
Pbindef(\pulse_8)
).play
);




( {Psym1(Pxrand([\simplePluckReverse, \tonalSwoosh], inf))} <> Pbindef(\fifth) <> Pbindef(\pulse_4_ob)).play


~perc.stop;
~perc = ( Pdef(\sd2) <> Pbindef(\pat_332) <> Pbindef(\euclidean_4th_rng) ).play(~linkClock, quant: 4);
~perc2.stop;
~perc2 = ( Pdef(\bongo_1) <> Pbindef(\pat_332_allArp) <> Pbindef(\pulse_16)  ).play(~linkClock, quant: 4);
~perc3.stop;
~perc3 = ( Pdef(\bongo_muted) <> Pbindef(\pat_332_allArp) <> Pbindef(\euclidean_32th_rng)  ).play(~linkClock, quant: 4);


~bd.stop;

~bd2.stop;
~bd2 = ( Pdef(\bdBuzz).collect {|ev| ~scM8.play; ev} <> Pbindef(\root) <> Pbindef(\pulse_2) ).play(~linkClock, quant: 4);
~sd.stop;
~sd = ( Pdef(\sd2).collect {|ev| ~scM4.play; ev} <> Pbindef(\fifth) <> Pbindef(\pulse_4_ob)  ).play(~linkClock, quant: 4);
~sd2.stop;
~sd2 = ( Pdef(\sd2).collect {|ev| ~scM8.play; ev} <> Pbindef(\fifth) <> Pbindef(\pulse_4_ob)  ).play(~linkClock, quant: 4);
~sdSwoosh.stop;
~sdSwoosh = ( Pdef(\tonalSwoosh) <> Pbindef(\fifth) <> Pbindef(\pulse_4_ob)  ).play(~linkClock, quant: 4);

~boom.stop;
~boom =  ( Pdef(\boom) <> Pbindef(\root) <> Pbindef(\pulse, \stretch, 16) ).play(~linkClock, quant: 4);


~longSwoosh.stop;
~longSwoosh =  ( Pdef(\noiseSwoosh) <> Pbindef(\root) <> Pbindef(\pulse, \stretch, 8) ).play(~linkClock, quant: 4);


~pluck.stop;
~pluck = ( Pdef(\srrPluck) <> Pn(Psync(Pbindef(\triad, \upperLimit, 24, \lowerLimit, 12),maxdur:4)) <> Pbindef(\pulse_4_ob)).play(~linkClock, quant: 4);

~pluck_ob.stop;
~pluck_ob = ( Pdef(\srrPluck) <> Pn(Psync(Pbindef(\xSus4, \upperLimit, 24, \lowerLimit, 12),maxdur:4)) <> Pbindef(\pulse_8_ob)).play(~linkClock, quant: 4);

(
~pluck.stop;
~pluck = ( Pdef(\srrPluck) <> Pn(Psync(Pbindef(\arp,
	\upperLimit, -12,
	\lowerLimit, -36,
	\transpositionHarmonics, 1,
	\chordTranspositions, 10),maxdur:8))
<> Pbindef(\pulse_16)).play(~linkClock, quant: 8);
);

(
~pluckRev.stop;
~pluckRev = ( Pdef(\simplePluckReverse) <> Pn(Psync(Pbindef(\arp,
	\upperLimit, 36,
	\lowerLimit, 0,
	\transpositionHarmonics,1,
	\chordTranspositions, 10),maxdur:16))
<> Pbindef(\pulse_16)).play(~linkClock, quant: 8);
);

(
~pluckRev.stop;
~pluckRev = ( Pdef(\simplePluckReverse)
	<> Pn(Psync(Pbindef(\pat_332_downUp,
		\upperLimit, 24,
		\lowerLimit, 0,),maxdur:32)) <> Pbindef(\pulse_8) ).play(~linkClock, quant: 4);
);
~simpleBass.stop;
~simpleBass = ( Pdef(\simpleBass) <> Pbindef(\root) <> Pbindef(\pulse) ).play(~linkClock, quant: 4);

Pdef(\pluckRevLong).stop;
Pdef(\pluckRevLong, Pdef(\simplePluckReverse) <> Pn(Psync(Pbindef(\rawPitches, \upperLimit, 48, \lowerLimit, -36,),maxdur:32)) <> Pbindef(\pulse, \stretch, 8) ).play(~linkClock, quant: 4);

~pluck.stop;
~pluck = ( Pdef(\srrPluck)	<> Pn(Psync(Pbindef(\rawPitches, \upperLimit, 48, \lowerLimit, -36,),maxdur:32)) <> Pbindef(\pulse) ).play(~linkClock, quant: 4);


~pluck2.stop;
~pluck2 = ( Pdef(\simplePluck) <> Ptsym(Pseq([\xSus4, \triad, \x7sus4, \tensionsArp], inf),dur: Pseq([2], inf)) <> Pbindef(\pulse_8_ob) ).play(~linkClock, quant: 4);


~pluck3.stop;
~pluck3 = ( Pdef(\variedPlucks) <> Pbindef(\triad) <> Pbindef(\pulse_8_ob)  ).play(~linkClock, quant: 4);

~source_group.release;
Pdef.all.do{ |item| Pdef(item).stop}



~sd2.stop;
~sd2 = ( Pdef(\sd2) <> Pbindef(\fifth) <> Pbindef(\pulse_4_ob)  ).play(~linkClock, quant: 4);
~bd2.stop;
~bd2 = ( Pdef(\bd1) <> Pbindef(\root) <> Pbindef(\pulse_2) ).play(~linkClock, quant: 4);
~hh_rng.stop;
~hh_rng = ( Pdef(\hh3) <> Pbindef(\root) <> Pbindef(\hh_rng) ).play(~linkClock, quant: 4);
~pluck3.stop;
~pluck3 = ( Pdef(\variedPlucks) <> Pbindef(\root) <> Pbindef(\pulse_4_ob)  ).play(~linkClock, quant: 4);
~sdSwoosh.stop;
~sdSwoosh = ( Pdef(\tonalSwoosh) <> Pbindef(\fifth) <> Pbindef(\pulse_4_ob)  ).play(~linkClock, quant: 4);



(
~bd.stop;
~bd = ( Pdef(\bdThump) <> Pbindef(\root) <> Pbindef(\bd_pattern_8th_rng) ).play(~linkClock, quant: 4);
~bd2.stop;
~bd2 = ( Pdef(\bd1) <> Pbindef(\root) <> Pbindef(\pulse_2) ).play(~linkClock, quant: 4);
~sd.stop;
~sd = ( Pdef(\sd1) <> Pbindef(\fifth) <> Pbindef(\sd_pattern_1)  ).play(~linkClock, quant: 4);
~hh1.stop;
~hh1 = ( Pdef(\hh1) <> Pbindef(\root) <> Pbindef(\euclidean_8th_rng) ).play(~linkClock, quant: 4);
~hh2.stop;
~hh2 = ( Pdef(\hh2) <> Pbindef(\root) <> Pbindef(\euclidean_16th_rng) ).play(~linkClock, quant: 4);
~hh_rng.stop;
~hh_rng = ( Pdef(\hh3) <> Pbindef(\root) <> Pbindef(\hh_rng) ).play(~linkClock, quant: 4);
);




(
Pbindef(\guitarCloud,
	\dur, Pseq([4], inf),
	\note, Pfunc {~pitchesRootDissonance[\root]} + Pseq([[-12, 0]], inf),
	\harmonic, Ptuple([1] ++ (Pwhite(1, 8).round ! 3), inf),
	\filter_mod_1, 0,
).play(~linkClock, quant: 4);
)

Pbindef(\guitarCloud).stop(quant: 4);
