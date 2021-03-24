"loading pitch patterns".postln;

/////////////////// ev funktioniert nicht?

///////////////////////////////// TONES

Pbindef(\root,
	\note, Pfunc {~pitchesRootDissonance[\root].mod(12)},
);

Pbindef(\fifth,
	\note, Pfunc {~pitchesRootDissonance[\root].mod(12) + 7},
);

Pbindef(\third,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([3,4], ev.lowerLimit, ev.upperLimit) },
);


Pbindef(\seventh,
	\note, Pfunc { ~chord.([10,11])},
);

///////////////////////////////// INTERVALS

Pbindef(\powerchord,
	\note, Pfunc { ~chord.([0,7])},
);

Pbindef(\xOmit5,
	\note, Pfunc { ~chord.([3,4,10,11])},
);



///////////////////////////////// TRIADS

Pbindef(\triad,
	\note, Pn(Plazy{ |ev| ~chord.([0,3,4,7])}),
);

Pbindef(\xSus2,
	\note, Pn(Plazy{ |ev| ~chord.([0,2,7])}),
);

Pbindef(\xSus4,
	\note, Pn(Plazy{ |ev| ~chord.([0,5,7])}),
);


///////////////////////////////// Tetrachords

Pbindef(\tetra,
	\note, Pn(Plazy{ |ev| ~chord.([0,3,4,7,10,11])}),
);

Pbindef(\x7sus2,
	\note, Pn(Plazy{ |ev| ~chord.([0,2,7,10,11])}),
);

Pbindef(\x7sus4,
	\note, Pn(Plazy{ |ev| ~chord.([0,5,7,10,11])}),
);

Pbindef(\xAdd9,
	\note, Pn(Plazy{ |ev| ~chord.([0,1,2,3,4,7 ])}),
);

Pbindef(\xAdd11,
	\note, Pn(Plazy{ |ev| ~chord.([0,3,4,5,6,7 ])}),
);

Pbindef(\xAdd13,
	\note, Pn(Plazy{ |ev| ~chord.([0,3,4,7,8,9])}),
);


///////////////////////////////// five tones and up


Pbindef(\x9,
	\note, Pn(Plazy{ |ev| ~chord.([0,1,2,3,4,7,10,11 ])}),
);

Pbindef(\x11,
	\note, Pn(Plazy{ |ev| ~chord.([0,1,2,3,4,5,6,7,10,11 ])}),
);

Pbindef(\all,
	\note, Pn(Plazy{ |ev| ~chord.([0,1,2,3,4,5,6,7,8,9,10,11 ])}),
);

Pbindef(\xAdd9_11,
	\note, Pn(Plazy{ |ev| ~chord.([0,1,2,3,4,5,6,7 ])}),
);

Pbindef(\xAdd9_13,
	\note, Pn(Plazy{ |ev| ~chord.([0,1,2,3,4,7,8,9 ])}),
);

Pbindef(\xAdd11_13,
	\note, Pn(Plazy{ |ev| ~chord.([0,3,4,5,6,7,8,9 ])}),
);

Pbindef(\x7add11,
	\note, Pn(Plazy{ |ev| ~chord.([0,3,4,5,6,7,10,11 ])}),
);

Pbindef(\x7add13,
	\note, Pn(Plazy{ |ev| ~chord.([0,3,4,7,8,9,10,11 ])}),
);

Pbindef(\x7add9_11,
	\note, Pn(Plazy{ |ev| ~chord.([0,1,2,3,4,5,6,7,10,11 ])}),
);

Pbindef(\x7add9_13,
	\note, Pn(Plazy{ |ev| ~chord.([0,1,2,3,4,7,8,9,10,11 ])}),
);

Pbindef(\xAdd11_13,
	\note, Pn(Plazy{ |ev| ~chord.([0,3,4,5,6,7,8,9 ])}),
);




///////////////////////////////// TENSIONS ONLY


Pbindef(\tensions,
		\note, Pn(Plazy{ |ev| ~chord.([1,2,5,6,8,9])}),
);

/////////////////////////////////
///////////////////////////////// PITCHES PER DURATIONS
/////////////////////////////////




///////////////////////////////// ARPS

Pbindef(\rawArp,
	\note, Pn(Plazy{ Pseq(~pitchesRootDissonance[\pitches], 1)}),
);

Pbindef(\allOctavesArp,
	\note, Pn(Plazy{ Pseq(
		~pitchesAndOctaves.(
			~pitchesRootDissonance[\pitches], -36, 36), 1)}),
);

Pbindef(\allOctavesTriadArp,
	\note, Pn(Plazy{ Pseq(
		~intervalFilter.(
			~pitchesAndOctaves.(~pitchesRootDissonance[\pitches], -36, 36),
			~pitchesRootDissonance[\root],
			[0,3,4,7]),
		1)}),
);

Pbindef(\allOctavesSeventhArp,
	\note, Pn(Plazy{ Pseq(
		~intervalFilter.(
			~pitchesAndOctaves.(~pitchesRootDissonance[\pitches], -36, 36),
			~pitchesRootDissonance[\root],
			[0,3,4,7,10,11]),
		1)}),
);

Pbindef(\allOctavesTensionsArp,
	\note, Pn(Plazy{ Pseq(
		~intervalFilter.(
			~pitchesAndOctaves.(~pitchesRootDissonance[\pitches], -36, 36),
			~pitchesRootDissonance[\root],
			[1,2,5,6,8,9]),
		1)}),
);

Pbindef(\midArp,
	\note, Pn(Plazy{ Pseq(~pitchesAndOctaves.(~pitchesRootDissonance[\pitches],0 ,12), 1)}) + 12,
);





///////////////////////////////// PATTERNS

Pbindef(\pat_332,
	\note, Plazy { ~pitchTriggerRepeat.(~pitchesRootDissonance[\pitches].mod(12), [3, 3, 2], [2, 1, 0]) }
);

Pbindef(\pat_332_mid,
	\note, Plazy { ~pitchTriggerRepeat.(
		~pitchesAndOctaves.(~pitchesRootDissonance[\pitches],0 ,12),
		[3, 3, 2],
		(0..(~pitchesRootDissonance[\pitches].size-1))
	)},
);

Pbindef(\pat_332_allArp,
	\note, Plazy {
		~pitchTriggerRepeat.(
			~pitchesRootDissonance[\pitches].mod(12),
			[3, 3, 2],
			(0..(~pitchesRootDissonance[\pitches].size-1))
	)},
);


Pbindef(\third_OT_JI,
	\note, Pn(Plazy{ |ev|
		Pseq([~intervalFilter.(
			~pitchesAnd8OvertonesJI.(~pitchesRootDissonance[\pitches],0 ,12),
			~pitchesRootDissonance[\root],
			[0,1,2,3,4,5,6,7,8,9,10,11]),
	], 1)}),
);

Pbindef(\third_OT_JI,
	\note, Pn(Plazy{ |ev|
		Pseq([~intervalFilter.(
			~pitchesAnd8OvertonesJI.(~pitchesRootDissonance[\pitches],0 ,12),
			~pitchesRootDissonance[\root],
			[3,4]),
	], 1)}),
);


//
// Pbindef(\melTestDuration,
// 	\note, Plazy { ~pitchTriggerDuration.(~pitchesRootDissonance[\pitches].mod(12), [3, 3, 2], [2, 1, 0]) }
// );
//


"pitch patterns loaded".postln;



