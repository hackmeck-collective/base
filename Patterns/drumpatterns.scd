(
Pbindef(\hh1,
	\dur,Pbjorklund2(Pwhite(1,8),Pwhite(1,16))/4,
	\vol, Pseq([0.9,0.6,0.7,0.5], inf) * Pfunc {|ev| ev.hh1_dyn ? 1 },
	\time_factor, Pseq([0.4,0.2,0.2,0.5], inf),
	\punch_factor, Pseq([3,1,1,2], inf),
).play(~linkClock, quant: 4);

Pbindef(\bd2,
	\note, Pfunc {~pitchesRootDissonance[\root].mod(12)} - 24,
	\dur, Pseq([2], inf),
	\time_factor, Pseq([1,0.2,0.5,0.1], inf),
).play(~linkClock, quant: 4);

Pbindef(\sd1,
	\note, Pfunc {~pitchesRootDissonance[\root].mod(12)} - 5,
	\dur,Pbjorklund2(Pwhite(1,8),Pwhite(1,16))/4,
	\vol, Pseq([0,0.6,0,0.5]*0.9, inf),
	\time_factor, Pseq([0,0.2,0,0.4], inf),
).play(~linkClock, quant: 4);

Pbindef(\hh2,
	\dur,Pbjorklund2(Pwhite(1,8),Pwhite(1,16))/4,
	\note, Pseq([Pseq([48], 28),Pseq([49], 4)],inf),
	\vol, Pseq([0,0.6,0,0.9]*0.4, inf),
	\time_factor, Pseq([0,0.7,0,0.2], inf),
	\punch_factor, Pseq([0,3,0,1], inf),
).play(~linkClock, quant: 4);

Pbindef(\bongo_8,
	\dur,Pbjorklund2(Pwhite(1,8),Pwhite(1,16))/4,
	\vol, Pseq([0.9,0.6,0.7,0.5] * 1, inf) * Pfunc {|ev| ev.bongo1_dyn ? 1 },
	\time_factor, Pseq([0.4,0.2,0.2,0.5], inf),
	\punch_factor, Pseq([3,1,1,2], inf),
).play(~linkClock, quant: 4);
);



Pbind(\instrument,\bplay,\buf,d["k"][1],\dur,Pbjorklund2(Pwhite(1,8),Pwhite(1,16))/4,\amp,1);



Pbind(\instrument,\bplay,\buf,d["s"][1],\dur,Pbjorklund2(Pwhite(1,8),Pwhite(1,16))/4,\amp,1);
~h = Pbind(\instrument,\bplay,\buf,d["ch"][1],\dur,Pbjorklund2(Pwhite(1,8),Pwhite(1,16))/4,\amp,1);
~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pbjorklund2(Pwhite(1,8),Pwhite(1,16))/4,\amp,1);


(
~hhPhraseInstr = (
	hh1: Pbindef(\hh1,
		\dur, Pseq([1/8], inf),
		\vol, Pseq([0.9,0.6,0.7,0.5], inf) * Pfunc {|ev| ev.hh1_dyn ? 1 },
		\time_factor, Pseq([0.4,0.2,0.2,0.5], inf),
		\punch_factor, Pseq([3,1,1,2], inf),
	),

	bd2: Pbindef(\bd2,
		\note, Pfunc {~pitchesRootDissonance[\root].mod(12)} - 24,
		\dur, Pseq([2], inf),
		\time_factor, Pseq([1,0.2,0.5,0.1], inf),
	),

	sd1: Pbindef(\sd1,
		\note, Pfunc {~pitchesRootDissonance[\root].mod(12)} - 5,
		\dur, Pseq([Rest(0.5),0.5], inf),
		\vol, Pseq([0,0.6,0,0.5]*0.9, inf),
		\time_factor, Pseq([0,0.2,0,0.4], inf),
	),

	hh2: Pbindef(\hh2,
		\dur, Pseq([Rest(1/4),1/4], inf),
		\note, Pseq([Pseq([48], 28),Pseq([49], 4)],inf),
		\vol, Pseq([0,0.6,0,0.9]*0.4, inf),
		\time_factor, Pseq([0,0.7,0,0.2], inf),
		\punch_factor, Pseq([0,3,0,1], inf),
	),

	bongo1: Pbindef(\bongo1,
		\dur, Pseq([1/4], inf),
		\vol, Pseq([0.9,0.6,0.7,0.5] * 1, inf) * Pfunc {|ev| ev.bongo1_dyn ? 1 },
		\time_factor, Pseq([0.4,0.2,0.2,0.5], inf),
		\punch_factor, Pseq([3,1,1,2], inf),
	),
);
);



(
Pdef(\hhPhrase,

	Ptsym(
		Pseq([[\hh1, \bongo1], [\bongo1, \hh2]], inf),
		dur: Pseq([4], inf)
	) <> Pbind(
		\hh1_dyn, Pseg([0.2,1,0.2],[4, 4]).repeat,
		\bongo1_dyn, Pseg([1,0.2,1],[4, 4]).repeat
	);
).play(~linkClock, quant: 4);
);

Pdef(\hhPhrase).stop

~editDrum.(\bd1)

(
Pbindef(\bd1).stop;
Pbindef(\bd2).stop;
Pbindef(\sd1).stop;
);




Pbindef(\bd2).stop(quant: 4);

(
Pbindef(\sd1,
	\dur, Pseq([Rest(0.5),0.5], inf),
	\vol, Pseq([0,0.6,0,0.5]*0.9, inf),
	\time_factor, Pseq([0,0.2,0,0.4], inf),
).play(~linkClock, quant: 4);
);

Pbindef(\sd1).stop(quant: 4);

(
Pbindef(\sd2,
	\dur, Pseq([Rest(2.25),0.5,0.25,Rest(1)], inf),
	\vol, Pseq([0,0.6,0.7,0.5]*0.9, inf),
	\time_factor, Pseq([0,0.2,0.5,0], inf),
).play(~linkClock, quant: 4);
);

Pbindef(\sd2).stop(quant: 4);

(
Pbindef(\bongo1,
	\dur, Pseq([1/4], inf),
	\note, Pseq([Pseq([7], 28),Pseq([9], 4)],inf),

)
);