


Pdef(\hhPhrase,
	Ptsym(
		Pseq([[\hh1, \bd2], [\bongo1, \hh2]], inf),
		dur: Pseq([8, 16, 8], inf)
	)
)




// drum sequencing
Pdef(\hhPhrase,
	Ptsym(
		Pseq([[\hh1, \bongo1], [\bongo1, \hh2]], inf),
		dur: Pseq([8], inf)
	) <> Pbind(
		\hh1_dyn, Pseg([0.2,1,0.2],[2, 2]).repeat,
		\bongo1_dyn, Pseg([1,0.2,1],[3, 1]).repeat
	)
).play(~linkClock, quant: 4);



(

Pbindef(\bd1,
	\dur, Pseq([1], inf),
	\time_factor, Pseq([0.8,0.4], inf),
	\punch_factor, Pseq([3,1], inf),
).play(~linkClock, quant: 4);

Pbindef(\bd2,
	\dur, Pseq([0.5], inf),
).play(~linkClock, quant: 4);

Pbindef(\sd1,
	\dur, Pseq([Rest(0.5),0.5], inf),
	\vol, Pseq([0,0.6,0,0.5]*0.9, inf),
	\time_factor, Pseq([0,0.2,0,0.4], inf),
).play(~linkClock, quant: 4);

)
~editDrum.(\bd1)

(
Pbindef(\bd1).stop;
Pbindef(\bd2).stop;
);


(
Pbindef(\bd2,
	\dur, Pseq([2], inf),
	\time_factor, Pseq([1,0.2,0.5,0.1], inf),
	\vol, 0.75,
	\type, \on,
);
)
Pbindef(\bd2).stop(quant: 4);

(
var presetName = \sd1;
~callDrumPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([Rest(0.5),0.5], inf),
	\vol, Pseq([0,0.6,0,0.5]*0.9, inf),
	\time_factor, Pseq([0,0.2,0,0.4], inf),
).play(~linkClock, quant: 4);
);

Pbindef(\sd1).stop(quant: 4);

(
var presetName = \sd2;
~callDrumPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([Rest(2.25),0.5,0.25,Rest(1)], inf),
	\vol, Pseq([0,0.6,0.7,0.5]*0.9, inf),
	\time_factor, Pseq([0,0.2,0.5,0], inf),
).play(~linkClock, quant: 4);
);

Pbindef(\sd2).stop(quant: 4);

(
var presetName = \bongo1;
~callDrumPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([1/4], inf),
	\note, Pseq([Pseq([7], 28),Pseq([9], 4)],inf),
	\vol, Pseq([0.9,0.6,0.7,0.5]*0.25, inf),
	\time_factor, Pseq([0.4,0.2,0.2,0.5], inf),
	\punch_factor, Pseq([3,1,1,2], inf),
).play(~linkClock, quant: 4);
);
(

Pbindef(\bongo1,
	\dur, Pseq([1/4], inf),
	\note, Pseq([Pseq([7], 28),Pseq([9], 4)],inf),
	\vol, Pseq([0.9,0.6,0.7,0.5]*0.5, inf)  * Pfunc {|ev| ev.bongo1_dyn ? 1 },
	\time_factor, Pseq([0.5,0.2,1,0.5], inf),
	\punch_factor, Pseq([3,1,1,2], inf),
).play(~linkClock, quant: 4);
);
Pbindef(\bongo1).stop(quant: 4);
(
Pbindef(\bongo1,
	\dur, Pseq([1/8], inf),
	\time_factor, Pseq([0.4,0.2,0.2,0.5], inf),
);
)
(
Pbindef(\bongo1,
	\dur, Pseq([1/4], inf),
	\time_factor, Pseq([0.5,0.2,1,0.5], inf),
);
)

(
Pbindef(\hh1,
	\dur, Pseq([1/8], inf),
	\note, Pseq([Pseq([48], 28),Pseq([49], 4)],inf),
	\vol, Pseq([0.9,0.6,0.7,0.5], inf) * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\time_factor, Pseq([0.4,0.2,0.2,0.5], inf),
	\punch_factor, Pseq([3,1,1,2], inf),
).play(~linkClock, quant: 4);
)


Pbindef(\hh1).stop(quant: 4);

(
var presetName = \hh2;
~callDrumPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([Rest(1/4),1/4], inf),
	\note, Pseq([Pseq([48], 28),Pseq([49], 4)],inf),
	\vol, Pseq([0,0.6,0,0.9]*0.4, inf),
	\time_factor, Pseq([0,0.7,0,0.2], inf),
	\punch_factor, Pseq([0,3,0,1], inf),
).play(~linkClock, quant: 4);
);

Pbindef(\hh2).stop(quant: 4);