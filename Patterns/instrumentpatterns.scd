
(
var presetName = \variedPlucks;
~callInstrumentPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([1/4], inf),
	\note, Pseq([0], inf),
	\vol, 0.5,
).play(~linkClock, quant: 4);
)

Pbindef(\variedPlucks).stop(quant: 4);

(
var presetName = \srrPluck;
~callInstrumentPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([1/2], inf),
	\note, Pn(Plazy{ Pseq(~pitchesRootDissonance[\pitches], 1)}) + 12,
	\vol, 0.25,
).play(~linkClock, quant: 4);
)

Pbindef(\srrPluck).stop(quant: 4);

(
var presetName = \simplePluck;
~callInstrumentPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([1/2], inf),
	\note, Pn(Plazy{ Pseq(~pitchesRootDissonance[\pitches], 1)}) + 12,
	\vol, 0.5,
).play(~linkClock, quant: 4);
)

Pbindef(\simplePluck).stop(quant: 4);

(
var presetName = \simpleBass;
~callInstrumentPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([3,1], inf),
	\note, Pfunc {~pitchesRootDissonance[\root]} + Pseq([-24,-12], inf),
).play(~linkClock, quant: 4);
)

Pbindef(\simpleBass).stop(quant: 4);


(
var presetName = \simpleBassPad;
~callInstrumentPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([6,Rest(2)], inf),
	\note, Pfunc {~pitchesRootDissonance[\root]} + Pseq([-24], inf),
).play(~linkClock, quant: 4);
)

Pbindef(\simpleBassPad).stop(quant: 4);

(
var presetName = \slideVibratoLead;
~callInstrumentPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([4], inf),
	\note, Pfunc {~pitchesRootDissonance[\root]} + Pseq([[0,7,12]], inf),
).play(~linkClock, quant: 4);
)

Pbindef(\slideVibratoLead).stop(quant: 4);

(
var presetName = \guitarCloud;
~callInstrumentPreset.(presetName);
Pbindef(presetName,
	\dur, Pseq([4], inf),
	\note, Pfunc {~pitchesRootDissonance[\root]} + Pseq([[-12, 0]], inf),
	\harmonic, Ptuple([1] ++ (Pwhite(1, 8).round ! 3), inf),
	\filter_mod_1, 0,
).play(~linkClock, quant: 4);
)

Pbindef(\guitarCloud,
	\note, Pfunc {~pitchesRootDissonance[\pitches].choose} + Pseq([[-12, 0]], inf),
)

Pbindef(\guitarCloud).stop(quant: 4);
