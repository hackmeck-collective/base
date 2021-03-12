//~editDrum.(\bongo1)

Pbindef(\bongo_4,
	\dur, Pseq([1/4], inf),
	\stretch, 4,
	\vol, Pseq([0.9,0.6,0.7,0.5] * 1, inf) * Pfunc {|ev| ev.bongo_4_dyn ? 1 },
	\time_factor, Pseq([0.4,0.2,0.2,0.5], inf),
	\punch_factor, Pseq([3,1,1,2], inf),
);

Pbindef(\bongo_8,
	\dur, Pseq([1/8], inf),
	\stretch, 4,
	\vol, Pseq([0.9,0.6,0.7,0.5] * 1, inf) * Pfunc {|ev| ev.bongo_8_dyn ? 1 },
	\time_factor, Pseq([0.4,0.2,0.2,0.5], inf),
	\punch_factor, Pseq([3,1,1,2], inf),
);

Pbindef(\bongo_8_ob,
	\dur, Pseq([Rest(1/8),1/8], inf),
	\stretch, 4,
	\vol, Pseq([0.9,0.6,0.7,0.5] * 1, inf) * Pfunc {|ev| ev.bongo_8_ob_dyn ? 1 },
	\time_factor, Pseq([0.4,0.2,0.2,0.5], inf),
	\punch_factor, Pseq([3,1,1,2], inf),
);

Pbindef(\bongo_16,
	\dur, Pseq([1/16], inf),
	\stretch, 4,
	\vol, Pseq([0.9,0.6,0.7,0.5] * 1, inf) * Pfunc {|ev| ev.bongo_16_dyn ? 1 },
	\time_factor, Pseq([0.4,0.2,0.2,0.5], inf),
	\punch_factor, Pseq([3,1,1,2], inf),
);

