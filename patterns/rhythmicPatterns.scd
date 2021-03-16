//////// RHYTHMEN definieren

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

Pbindef(\pulse_64,
	\dur, Pseq([1/64], inf),
	\stretch, 4,
	\time, Ptime(),
	\vol, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.3, 0.05, 0.6)} * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);

Pbindef(\euclidean_8th_rng,
	\dur,Pbjorklund2(Pwhite(1,8),Pwhite(1,16))/4,
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
	\dur, Pseq([Rest(1),0.75,0.25], inf),
	\time, Ptime(),
	\vol,  Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.6, 0.05, 0.3)},
	\time_factor, Pfunc {|ev| ~metreDynamics_4_4.(ev.time, 0.5, 0.05, 0.1)},
	\beatDuration, Pfunc { ~linkClock.tempo },
	\syncMultiplier, Pfunc {|ev| (ev.dur * ev.stretch);},
);

"rhythmic patterns loaded".postln;
//
//
//
// ~editDrum.(\bd1)
//
//
// ~sd.stop;