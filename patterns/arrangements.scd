//////// RHYTHMEN mit INSTRUMENTEN verketten

~bd = ( Pdef(\bdThump) <> Pbindef(\bd_pattern_8th_rng) <> Pbindef(\root) ).play(~linkClock, quant: 4);

~sd = ( Pdef(\sd3) <> Pbindef(\sd_pattern_1) <> Pbindef(\fifth)  ).play(~linkClock, quant: 4);

( Pdef(\sd2) <> Pbindef(\euclidean_8th_rng) <> Pbindef(\root)  ).play(~linkClock, quant: 4);

( Pdef(\hh1) <> Pbindef(\euclidean_8th_rng) <> Pbindef(\root)  ).play(~linkClock, quant: 4);

( Pdef(\hh2) <> Pbindef(\euclidean_8th_rng) <> Pbindef(\root)  ).play(~linkClock, quant: 4);

( Pdef(\bongo_1) <> Pbindef(\euclidean_8th_rng) <> Pbindef(\fifth)  ).play(~linkClock, quant: 4);


( Pdef(\srrPluck) <> Pn(Psync(Pbindef(\melTest),maxdur:6)) <> Pbindef(\pulse_16)).play(~linkClock, quant: 4);


~pluckRev = ( Pdef(\simplePluckReverse) <> Pn(Psync(Pbindef(\melTest),maxdur:8)) <> Pbindef(\pulse_4) ).play(~linkClock, quant: 4);

~pluck2 = ( Pdef(\simplePluck) <> Pbindef(\euclidean_8th_rng) <> Pbindef(\allArp)  ).play(~linkClock, quant: 4);

~pluckRev.stop
~pluck2.stop
~bd.stop

~instrPreset.edit(\simplePluck)
~instrPreset.create(\srrPluck)


Ptsym(
	Pseq([[\simplePluck_chain, \simplePluckReverse_chain, \noiseSwoosh_chain, \simpleBassPad_chain],
		[\simplePluck_chain, \simplePluckReverse_chain, \srrPluck_chain, \noiseSwoosh_chain, \simpleBassPad_chain]], inf),
	dur: Pseq([16], inf),
);

(
Pdef(\pluckPattern_2,

	(

		Pbindef(\variedPlucks,
			\dur, Pseq([1/4], inf),
			\note, Pfunc {~pitchesRootDissonance[\root]},
			\vol, (0.2 + (0.3 * Pgauss(0, 0.05) + Pfunc {|time|~metreDynamics_4_4.(time)} <> Ptime().mod(4))),
		);

		Pbindef(\slideVibratoLead,
			\dur, Pseq([1], inf),
			\note, Pfunc {~pitchesRootDissonance[\root]} + Pseq([0,0,0,12], inf),
		);

		(
			Pbindef(\simpleBass,
				\dur, Pseq([3.5,0.5], inf),
				\note, Pfunc {~pitchesRootDissonance[\root]} + Pseq([-24,-12], inf),
			);
		);

		(
			Pbindef(\arpBass,
				\dur, Pseq([3.5,0.5], inf),
				\note, Pfunc {~pitchesRootDissonance[\root]} + Pseq([-24,-12], inf),
				\beatDuration, Pfunc { ~linkClock.tempo },
			);
		);

		Pbindef(\srrPluck,
			\dur, Pseq([Rest(2+(11/16)),Pseq([1/16], 5), Rest(1)], inf),
			\note, Pn(Plazy{ Pseq(~pitchesRootDissonance[\pitches], 1)}) + 12,
			\fx_mod_1, Pseq([0.9,0.8,0.7,0.6], inf),
		);

		Pbindef(\noiseSwoosh,
			\dur, Pseq([16], inf),
			\note, 0,
			\beatDuration, Pfunc { ~linkClock.tempo },
			\envCurve, 10,
			\vol, 0.9,
			\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
		);

	);

	Ptsym(
		Pseq([[\variedPlucks_chain, \simpleBass_chain, \noiseSwoosh_chain], [\slideVibratoLead_chain, \srrPluck_chain, \arpBass_chain, \noiseSwoosh_chain]], inf),
		dur: Pseq([16], inf),
	);
).play(~linkClock, quant: 1);
);

Pdef(\pluckPattern_2).stop;

(
Pbindef(\srrBassPad,
	\dur, Pseq([6,Rest(2)], inf),
	\note, Pfunc {~pitchesRootDissonance[\root]} + Pseq([-24], inf),
	\fx_mod_1, Pfunc { ~launchcontrol_xl_row_4.getnSynchronous[0] } + Pwhite(-0.05,0.05)
).play(~linkClock, quant: 4);
)

~editInst.(\simpleBassPad)

Pbindef(\simpleBassPad).stop(quant: 4);



(
Pbindef(\guitarCloud,
	\dur, Pseq([4], inf),
	\note, Pfunc {~pitchesRootDissonance[\root]} + Pseq([[-12, 0]], inf),
	\harmonic, Ptuple([1] ++ (Pwhite(1, 8).round ! 3), inf),
	\filter_mod_1, 0,
).play(~linkClock, quant: 4);
)

Pbindef(\guitarCloud).stop(quant: 4);

