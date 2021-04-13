"loading rhythm patterns".postln;
"limited rng patterns".postln;

Pbindef(\ritPulse1,
	\time, Ptime(),
	\dur, Plazy { ~ritPulse.(7, 1/32, 1/16) }
);

Pbindef(\accPulse1,
	\time, Ptime(),
	\dur, Plazy { ~accPulse.(7, 1/32, 1/16) }
);

Pbindef(\euclidean_lsys_2,
	\dur,Plazy {|ev| ~euclid.((~cueData[\lsysBeats1] * 2).round, ~cueData[\lsysBeats1] * 8, 0, 1/8).trace },
	\stretch, 1,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\time_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\punch_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);

Pbindef(\euclidean_lsys_5,
	\dur,Plazy {|ev| ~euclid.((~cueData[\lsysBeats1] * 5).round, ~cueData[\lsysBeats1] * 8, 0, 1/8) },
	\stretch, 1,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\time_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\punch_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);


Pbindef(\bd_pattern_8th_rng,
	\dur, Pseq([2,
		Prand([
			2,
			Pseq([Rest(0.5),1.5]),
			Pseq([Rest(0.5),1,0.5]),
			Pseq([1.5,0.5])],1)
	], inf),
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\time_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
	//	\time_factor, 0.3,
);

Pbindef(\sd_pattern_1,
	\dur, Pseq([Rest(1/4),3/16,1/16], inf),
	\stretch, 4,
	\time, Ptime(),
	\vol,  Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.6, 0.05, 0.3)},
	\time_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);


Pbindef(\sd_pattern_2,
	\dur, Pseq(
		[Pseq([Rest(1/4),3/16,1/16], 3), Rest(1/4), Pseq([1/12], 3)], inf),
	\stretch, 4,
	\time, Ptime(),
	\vol,  Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.6, 0.05, 0.3)},
	\time_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);

Pbindef(\hh_rng,
	\dur,
	Pwrand([
		Pxrand([Pseq([1/4], 2), Pseq([1/8], 4)]),
		Pxrand([
			Pxrand([Pseq([1/4], 1), Pseq([1/8], 2), Pseq([1/16], 4), Pseq([1/12], 3),
				Pseq([Pseq([1/24], 3), Pseq([1/8])])], 1),
			Pxrand([Pseq([1/8]), Pseq([1/16], 2), Pseq([1/24], 3),
				Pseq([1/48], 6), Pseq([Pseq([1/48], 3), Pseq([1/16])]),
				Pxrand([Pseq([1/16]), Pseq([1/32], 2), Pseq([1/48], 3), Pseq([1/96], 6)],2),
			]),
		],2),
	],
		[1,2].normalizeSum, inf),
	\stretch, 4,
	\time, Ptime(),
	\vol,  Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.6, 0.05, 0.3)},
	\time_factor, 0.1 * Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.1, 0.01, 0)},
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);

"euclidean rng rhythms".postln;

Pbindef(\euclidean_4th_rng,
	\dur,Plazy {|ev| ~euclid.(Prand([3,5,6,7],inf), 8, Pwhite(0,7), 1/4) },
	\stretch, 4,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\time_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\punch_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);


Pbindef(\euclidean_8th_rng,
	\dur,Plazy {|ev| ~euclid.(Pwhite(3,7), 8, Pwhite(0,7), 1/8) },
	\stretch, 4,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\time_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\punch_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);

Pbindef(\euclidean_16th_rng,
	\dur, Plazy {|ev| ~euclid.(Pwhite(3,13), 16, Pwhite(0,15), 1/16) },
	\stretch, 4,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\time_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\punch_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);

Pbindef(\euclidean_32th_rng,
	\dur, Plazy {|ev| ~euclid.(Pwhite(3,30), 32, Pwhite(0,31), 1/32) },
	\stretch, 4,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\time_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\punch_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);

Pbindef(\euclidean_6th_rng,
	\dur,Plazy {|ev| ~euclid.(Pwhite(1,5), 6, Pwhite(0,5), 1/6) },
	\stretch, 4,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\time_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\punch_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);

Pbindef(\euclidean_12th_rng,
	\dur,Plazy {|ev| ~euclid.(Pwhite(3,9), 12, Pwhite(0,11), 1/12) },
	\stretch, 4,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\time_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\punch_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);


"pulses".postln;

Pbindef(\pulse,
	\dur, Pseq([1], inf),
	\stretch, 4,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);

Pbindef(\pulse_2,
	\dur, Pseq([1/2], inf),
	\stretch, 4,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);

Pbindef(\pulse_2_ob,
	\dur, Pseq([Rest(1/2),1/2], inf),
	\stretch, 4,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);

Pbindef(\pulse_4,
	\dur, Pseq([1/4], inf),
	\stretch, 4,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},

);

Pbindef(\pulse_4_ob,
	\dur, Pseq([Rest(1/4),1/4], inf),
	\stretch, 4,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},

);

Pbindef(\pulse_8,
	\dur, Pseq([1/8], inf),
	\stretch, 4,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);

Pbindef(\pulse_8_ob,
	\dur, Pseq([Rest(1/8),1/8], inf),
	\stretch, 4,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);

Pbindef(\pulse_16,
	\dur, Pseq([1/16], inf),
	\stretch, 4,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);

Pbindef(\pulse_16_ob,
	\dur, Pseq([Rest(1/16),1/16], inf),
	\stretch, 4,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);

Pbindef(\pulse_32,
	\dur, Pseq([1/32], inf),
	\stretch, 4,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);

Pbindef(\pulse_64,
	\dur, Pseq([1/64], inf),
	\stretch, 4,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);

"pauses".postln;

Pbindef(\quarter_upbeat_1,
	\dur, Pseq([Rest(3/4),1/4], inf),
	\stretch, 4,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);

"rhythmic patterns loaded".postln;