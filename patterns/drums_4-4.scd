Pbindef(\bd1,
	\note, Pfunc {~pitchesRootDissonance[\root].mod(12)} - 24,
	\dur, Pseq([1], inf),
	\stretch, 4,
	\time_factor, 0.5,
);

Pbindef(\bd2,
	\note, Pfunc {~pitchesRootDissonance[\root].mod(12)} - 24,
	\dur, Pseq([1/4], inf),
	\stretch, 4,
	\time_factor, Pseq([1,0.2,0.5,0.1], inf),
);

Pbindef(\sd1,
	\note, Pfunc {~pitchesRootDissonance[\root].mod(12)} - 5,
	\dur, Pseq([Rest(1/4),1/4], inf),
	\stretch, 4,
	\vol, Pseq([0,0.6,0,0.5]*0.9, inf),
	\time_factor, Pseq([0,0.2,0,0.4], inf),
);

Pbindef(\hh1,
	\dur, Pseq([1/8], inf),
	\stretch, 4,
	\vol, Pseq([0.9,0.6,0.7,0.5], inf),
	\time_factor, Pseq([0.4,0.2,0.2,0.5], inf),
	\punch_factor, Pseq([3,1,1,2], inf),
);