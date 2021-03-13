//////// PITCHES definieren

Pbindef(\root,
	\note, Pfunc {~pitchesRootDissonance[\root].mod(12)},
);

Pbindef(\fifth,
	\note, Pfunc {~pitchesRootDissonance[\root].mod(12)} + 7,
);

Pbindef(\allArp,
	\note, Pn(Plazy{ Pseq(~pitchesRootDissonance[\pitches], 1)}) + 12,
);

"pitch patterns loaded".postln;


