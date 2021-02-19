
(
var presetName = \bd1;
~callPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([3.5,0.5], inf),
	\note, Pseq([-24], inf),
	\vol, 1,
	\time_factor, Pseq([0.8,0.4], inf),
	\punch_factor, Pseq([3,1], inf),
).play(quant: 4);
);

(
var presetName = \bd2;
~callPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([1], 4),
	\note, Pseq([-24], 4)
).play(quant: 4);
);

(
var presetName = \sd1;
~callPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([Rest(1),1], inf),
	\note, Pseq([-5], inf),
	\vol, Pseq([0,0.6,0,0.5]*0.9, inf),
	\time_factor, Pseq([0,0.2,0,0.4], inf),
).play(quant: 4);
);
(
var presetName = \sd2;
~callPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([Rest(2.25),0.5,0.25,Rest(1)], inf),
	\note, Pseq([0,7,-5,0], inf),
	\vol, Pseq([0,0.6,0.7,0.5]*0.9, inf),
	\time_factor, Pseq([0,0.2,0.5,0], inf),
).play(quant: 4);
);

(
var presetName = \bongo1;
~callPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([1/8], inf),
	\note, Pseq([Pseq([7], 28),Pseq([9], 4)],inf),
	\vol, Pseq([0.9,0.6,0.7,0.5]*0.5, inf),
	\time_factor, Pseq([0.4,0.2,0.2,0.5], inf),
	\punch_factor, Pseq([3,1,1,2], inf),
).play(quant: 4);
);

(
var presetName = \hh1;
~callPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([1/8], inf),
	\note, Pseq([Pseq([48], 28),Pseq([49], 4)],inf),
	\vol, Pseq([0.9,0.6,0.7,0.5]*0.7, inf),
	\time_factor, Pseq([0.4,0.2,0.2,0.5], inf),
	\punch_factor, Pseq([3,1,1,2], inf),
).play(quant: 4);
);

(
var presetName = \hh2;
~callPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([Rest(1/4),1/4], inf),
	\note, Pseq([Pseq([48], 28),Pseq([49], 4)],inf),
	\vol, Pseq([0,0.6,0,0.9]*0.6, inf),
	\time_factor, Pseq([0,0.7,0,0.2], inf),
	\punch_factor, Pseq([0,3,0,1], inf),
).play(quant: 4);
);

