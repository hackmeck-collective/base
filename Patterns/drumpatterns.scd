
~pitchesRootDissonance[\pitches];
Pfunc {~pitchesRootDissonance[\root]};

(
var presetName = \bd1;
~callDrumPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([3.5,0.5], inf),
	\note, Pfunc {~pitchesRootDissonance[\root].mod(12)} - 24,
	\time_factor, Pseq([0.8,0.4], inf),
	\punch_factor, Pseq([3,1], inf),
	\type, \on
).play(~linkClock, quant: 4);
);
Pbindef(\bd1).stop(quant: 4);

(
var presetName = \bd2;
~callDrumPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([1], inf),
	\note, Pfunc {~pitchesRootDissonance[\root].mod(12)} - 24,
	\type, \on,
	\vol, 0.5,
).play(~linkClock, quant: 4);
);

(
Pbindef(\bd2,
	\dur, Pseq([2], inf),
	\time_factor, Pseq([1,0.2,0.5,0.1], inf),
	\note, Pfunc {~pitchesRootDissonance[\root].mod(12)} - 24,
	\vol, 0.75,
	\type, \on,
);
)
Pbindef(\bd2).stop(quant: 4);

(
var presetName = \sd1;
~callDrumPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([Rest(1),1], inf),
	\note, Pfunc {~pitchesRootDissonance[\root].mod(12)} -5,
	\vol, Pseq([0,0.6,0,0.5]*0.5, inf),
	\time_factor, Pseq([0,0.2,0,0.4], inf),
).play(~linkClock, quant: 4);
);
Pbindef(\sd1).stop(quant: 4);

(
var presetName = \sd2;
~callDrumPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([Rest(2.25),0.5,0.25,Rest(1)], inf),
	\note, Pseq([0,7,-5,0], inf),
	\vol, Pseq([0,0.6,0.7,0.5]*0.9, inf),
	\time_factor, Pseq([0,0.2,0.5,0], inf),
).play(~linkClock, quant: 4);
);

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
var presetName = \bongo1;
~callDrumPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([1/4], inf),
	\note, Pseq([Pseq([7], 28),Pseq([9], 4)],inf),
	\vol, Pseq([0.9,0.6,0.7,0.5]*0.5, inf),
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
var presetName = \hh1;
~callDrumPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([1/8], inf),
	\note, Pseq([Pseq([48], 28),Pseq([49], 4)],inf),
	\vol, Pseq([0.9,0.6,0.7,0.5]*0.7, inf),
	\time_factor, Pseq([0.4,0.2,0.2,0.5], inf),
	\punch_factor, Pseq([3,1,1,2], inf),
).play(~linkClock, quant: 4);
);

(
var presetName = \hh2;
~callDrumPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([Rest(1/4),1/4], inf),
	\note, Pseq([Pseq([48], 28),Pseq([49], 4)],inf),
	\vol, Pseq([0,0.6,0,0.9]*0.2, inf),
	\time_factor, Pseq([0,0.7,0,0.2], inf),
	\punch_factor, Pseq([0,3,0,1], inf),
).play(~linkClock, quant: 4);
);

Pbindef(\hh2).stop(quant: 4);