(
Pbindef(\BD1,
	\dur, Pseq([3.5,0.5], inf),
	\note, Pseq([-24], inf),
	\vol, 1,
	\time_factor, Pseq([0.7,0.4], inf),
	\punch_factor, Pseq([3,1], inf),
)
)
(
Pbindef(\SD1,
	\dur, Pseq([Rest(1),1], inf),
	\note, Pseq([-5], inf),
	\vol, Pseq([0.9,0.6,0.7,0.5]*0.9, inf),
	\time_factor, Pseq([0.3,0.2,0.3,0.4], inf),
)
)
(
Pbindef(\HH1,
	\dur, Pseq([1/8], inf),
	\note, Pseq([Pseq([48], 28),Pseq([49], 4)],inf),
	\vol, Pseq([0.9,0.6,0.7,0.5]*0.8, inf),
	\time_factor, Pseq([0.4,0.2,0.2,0.5], inf),
	\punch_factor, Pseq([3,1,1,2], inf),
)
)

)
(
Pbindef(\HH1,
	\dur, Pseq([Rest(1/4),1/4], inf),
	\note, Pseq([Pseq([48], 28),Pseq([49], 4)],inf),
	\vol, Pseq([0,0.6,0,0.9]*0.5, inf),
	\time_factor, Pseq([0,0.7,0,0.2], inf),
	\punch_factor, Pseq([0,3,0,1], inf),
)
)