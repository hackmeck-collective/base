Document.open(thisProcess.nowExecutingPath.dirname +/+ "pitchPatterns.scd");
Document.open(thisProcess.nowExecutingPath.dirname +/+ "rhythmicPatterns.scd");
Document.open(thisProcess.nowExecutingPath.dirname +/+ "patternFunctions.scd");

/////////////////// ev funktioniert nicht?

~instrPreset.create(\tonalSwoosh)
~instrPreset.edit(\noiseSwoosh)

//////// RHYTHMEN mit INSTRUMENTEN verketten


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

~perc.stop;
~perc = ( Pdef(\sd2) <> Pbindef(\pat_332) <> Pbindef(\euclidean_4th_rng) ).play(~linkClock, quant: 4);
~perc2.stop;
~perc2 = ( Pdef(\bongo_1) <> Pbindef(\pat_332_allArp) <> Pbindef(\pulse_16)  ).play(~linkClock, quant: 4);
~perc3.stop;
~perc3 = ( Pdef(\bongo_muted) <> Pbindef(\pat_332_allArp) <> Pbindef(\euclidean_32th_rng)  ).play(~linkClock, quant: 4);


~bd.stop;
~bd = ( Pdef(\bdThump) <> Pbindef(\root) <> Pbindef(\pulse_4) ).play(~linkClock, quant: 4);
~bd2.stop;
~bd2 = ( Pdef(\bd1) <> Pbindef(\root) <> Pbindef(\pulse_2) ).play(~linkClock, quant: 4);
~sd.stop;
~sd = ( Pdef(\sd1) <> Pbindef(\fifth) <> Pbindef(\pulse_2_ob)  ).play(~linkClock, quant: 4);
~sd2.stop;
~sd2 = ( Pdef(\sd2) <> Pbindef(\fifth) <> Pbindef(\pulse_4_ob)  ).play(~linkClock, quant: 4);
~sdSwoosh.stop;
~sdSwoosh = ( Pdef(\tonalSwoosh) <> Pbindef(\fifth) <> Pbindef(\pulse_4_ob)  ).play(~linkClock, quant: 4);

~boom.stop;
~boom =  ( Pdef(\boom) <> Pbindef(\root) <> Pbindef(\pulse, \stretch, 16) ).play(~linkClock, quant: 4);

~longSwoosh.stop;
~longSwoosh =  ( Pdef(\noiseSwoosh) <> Pbindef(\root) <> Pbindef(\pulse, \stretch, 8) ).play(~linkClock, quant: 4);
Pdef(\noiseSwoosh).source


~pluck = ( Pdef(\srrPluck) <> Pn(Psync(Pbindef(\third,),maxdur:4)) <> Pbindef(\pulse_4_ob)).play(~linkClock, quant: 8);

~pluck_ob = ( Pdef(\srrPluck) <> Pn(Psync(Pbindef(\tensions),maxdur:4)) <> Pbindef(\pulse_8_ob)).play(~linkClock, quant: 8);

~pluck = ( Pdef(\srrPluck) <> Pn(Psync(Pbindef(\rawArp),maxdur:4)) <> Pbindef(\pulse_16)).play(~linkClock, quant: 8);

~pluck = ( Pdef(\simplePluck) <> Pn(Psync(Pbindef(\allOctavesArp),maxdur:4)) <> Pbindef(\pulse_16)).play(~linkClock, quant: 8);
~pluck_ob.stop
~pluck = ( Pdef(\simplePluck) <> Pn(Psync(Pbindef(\allOctavesTriadArp),maxdur:4)) <> Pbindef(\pulse_16)).play(~linkClock, quant: 8);

~pluck = ( Pdef(\simplePluck) <> Pn(Psync(Pbindef(\allOctavesTetraArp),maxdur:4)) <> Pbindef(\pulse_16)).play(~linkClock, quant: 8);

~pluck = ( Pdef(\simplePluck) <> Pn(Psync(Pbindef(\allOctavesTensionsArp),maxdur:4)) <> Pbindef(\pulse_16)).play(~linkClock, quant: 8);

~pluck = ( Pdef(\srrPluck) <> Pn(Psync(Pbindef(\midArp),maxdur:4)) <> Pbindef(\pulse_16)).play(~linkClock, quant: 8);

~pluckRev = ( Pdef(\simplePluckReverse) <> Pn(Psync(Pbindef(\pat_332),maxdur:8)) <> Pbindef(\pulse_8) ).play(~linkClock, quant: 4);

~pluck2 = ( Pdef(\simplePluck) <> (strum: -0.02) <> Ptsym(Pseq([\xSus4, \triad, \x7sus4, \allOctavesTensionsArp], inf),dur: Pseq([2], inf)) <> Pbindef(\euclidean_16th_rng) ).play(~linkClock, quant: 4);


~pluck3.stop;
~pluck3 = ( Pdef(\variedPlucks) <> ~chord.( <> Pbindef(\pulse_16)  ).play(~linkClock, quant: 4);







~pluck.stop
~pluck_ob.stop
~pluckRev.stop

~bd.stop

~instrPreset.edit(\simplePluck)
~instrPreset.create(\srrPluck)



(
Pbindef(\guitarCloud,
	\dur, Pseq([4], inf),
	\note, Pfunc {~pitchesRootDissonance[\root]} + Pseq([[-12, 0]], inf),
	\harmonic, Ptuple([1] ++ (Pwhite(1, 8).round ! 3), inf),
	\filter_mod_1, 0,
).play(~linkClock, quant: 4);
)

Pbindef(\guitarCloud).stop(quant: 4);

