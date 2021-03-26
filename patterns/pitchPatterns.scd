"loading pitch patterns".postln;


Pbindef(\rawPitches,
	\upperLimit, 36,
	\lowerLimit, -36,
	\transpositionHarmonics, 1,
	\chordTranspositions, 0,
	\note, Pfunc { |ev| ~chord.([0,1,2,3,4,5,6,7,8,9,10,11], ev.lowerLimit, ev.upperLimit) },
);

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
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([10,11], ev.lowerLimit, ev.upperLimit) },
);

///////////////////////////////// INTERVALS

Pbindef(\powerchord,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,7], ev.lowerLimit, ev.upperLimit) },
);

Pbindef(\xOmit5,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([3,4,10,11], ev.lowerLimit, ev.upperLimit) },
);



///////////////////////////////// TRIADS

Pbindef(\triad,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,3,4,7], ev.lowerLimit, ev.upperLimit)},
);

Pbindef(\xSus2,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,2,7], ev.lowerLimit, ev.upperLimit)},
);

Pbindef(\xSus4,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,5,7], ev.lowerLimit, ev.upperLimit)},
);


///////////////////////////////// Tetrachords

Pbindef(\tetra,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,3,4,7,10,11], ev.lowerLimit, ev.upperLimit)},
);

Pbindef(\x7sus2,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,2,7,10,11], ev.lowerLimit, ev.upperLimit)},
);

Pbindef(\x7sus4,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,5,7,10,11], ev.lowerLimit, ev.upperLimit)},
);

Pbindef(\xAdd9,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,1,2,3,4,7], ev.lowerLimit, ev.upperLimit)},
);

Pbindef(\xAdd11,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,3,4,5,6,7], ev.lowerLimit, ev.upperLimit)},
);

Pbindef(\xAdd13,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,3,4,7,8,9], ev.lowerLimit, ev.upperLimit)},
);


///////////////////////////////// five tones and up


Pbindef(\x9,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,1,2,3,4,7,10,11], ev.lowerLimit, ev.upperLimit)},
);

Pbindef(\x11,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,1,2,3,4,5,6,7,10,11], ev.lowerLimit, ev.upperLimit)},
);

Pbindef(\all,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,1,2,3,4,5,6,7,8,9,10,11], ev.lowerLimit, ev.upperLimit)},
);

Pbindef(\xAdd9_11,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,1,2,3,4,5,6,7], ev.lowerLimit, ev.upperLimit)},
);

Pbindef(\xAdd9_13,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,1,2,3,4,7,8,9], ev.lowerLimit, ev.upperLimit)},
);

Pbindef(\xAdd11_13,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,3,4,5,6,7,8,9], ev.lowerLimit, ev.upperLimit)},
);

Pbindef(\x7add11,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,3,4,5,6,7,10,11], ev.lowerLimit, ev.upperLimit)},
);

Pbindef(\x7add13,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,3,4,7,8,9,10,11], ev.lowerLimit, ev.upperLimit)},
);

Pbindef(\x7add9_11,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,1,2,3,4,5,6,7,10,11], ev.lowerLimit, ev.upperLimit)},
);

Pbindef(\x7add9_13,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,1,2,3,4,7,8,9,10,11], ev.lowerLimit, ev.upperLimit)},
);

Pbindef(\xAdd11_13,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([0,3,4,5,6,7,8,9], ev.lowerLimit, ev.upperLimit)},
);




///////////////////////////////// TENSIONS ONLY


Pbindef(\tensions,
	\upperLimit, 12,
	\lowerLimit, 0,
	\note, Pfunc { |ev| ~chord.([1,2,5,6,8,9], ev.lowerLimit, ev.upperLimit)},
);

/////////////////////////////////
///////////////////////////////// PITCHES PER DURATIONS
/////////////////////////////////




///////////////////////////////// ARPS

Pbindef(\rawArp,
	\upperLimit, 36,
	\lowerLimit, -36,
	\transpositionHarmonics, 1,
	\chordTranspositions, 0,
	\note, Pn(Plazy{ |ev|
		Pseq(~chord.([0,1,2,3,4,5,6,7,8,9,10,11], ev.lowerLimit, ev.upperLimit, ev.transpositionHarmonics, ev.chordTranspositions),
			1)}),
);

Pbindef(\arp,
	\upperLimit, 36,
	\lowerLimit, -36,
	\transpositionHarmonics, 1,
	\chordTranspositions, 10,
	\note, Pn(Plazy{ |ev|
		Pseq(~chord.([0,1,2,3,4,5,6,7,8,9,10,11], ev.lowerLimit, ev.upperLimit, ev.transpositionHarmonics, ev.chordTranspositions),
			1)}),
);

Pbindef(\triadArp,
	\upperLimit, 36,
	\lowerLimit, -36,
	\transpositionHarmonics, 1,
	\chordTranspositions, 10,
	\note, Pn(Plazy{ |ev|
		Pseq(~chord.([0,3,4,7], ev.lowerLimit, ev.upperLimit, ev.transpositionHarmonics, ev.chordTranspositions),
			1)}),
);

Pbindef(\tetraArp,
	\upperLimit, 36,
	\lowerLimit, -36,
	\transpositionHarmonics, 1,
	\chordTranspositions, 10,
	\note, Pn(Plazy{ |ev|
		Pseq(~chord.([0,3,4,7,10,11], ev.lowerLimit, ev.upperLimit, ev.transpositionHarmonics, ev.chordTranspositions),
			1)}),
);

Pbindef(\tensionsArp,
	\upperLimit, 36,
	\lowerLimit, -36,
	\transpositionHarmonics, 1,
	\chordTranspositions, 10,
	\note, Pn(Plazy{ |ev|
		Pseq(~chord.([1,2,5,6,8,9], ev.lowerLimit, ev.upperLimit, ev.transpositionHarmonics, ev.chordTranspositions),
			1)}),
);


///////////////////////////////// PATTERNS

Pbindef(\pat_332_up,
	\upperLimit, 12,
	\lowerLimit, 0,
	\transpositionHarmonics, 1,
	\chordTranspositions, 10,
	\patternScale, Pfunc { |ev| ~chord.([0,1,2,3,4,5,6,7,8,9,10,11], ev.lowerLimit, ev.upperLimit, ev.transpositionHarmonics, ev.chordTranspositions)},
	\note, Plazy { |ev| ~pitchTriggerRepeat.(ev.patternScale, [3, 3, 2], (0..(ev.patternScale.size-1)) ) }
);

Pbindef(\pat_332_upDown,
	\upperLimit, 12,
	\lowerLimit, 0,
	\transpositionHarmonics, 1,
	\chordTranspositions, 10,
	\patternScale, Pfunc { |ev| ~chord.([0,1,2,3,4,5,6,7,8,9,10,11], ev.lowerLimit, ev.upperLimit, ev.transpositionHarmonics, ev.chordTranspositions)},
	\note, Plazy { |ev| ~pitchTriggerRepeat.(ev.patternScale, [3, 3, 2], (0..(ev.patternScale.size-1)) ++ ((ev.patternScale.size-2)..1) ) }
);

Pbindef(\pat_332_down,
	\upperLimit, 12,
	\lowerLimit, 0,
	\transpositionHarmonics, 1,
	\chordTranspositions, 10,
	\patternScale, Pfunc { |ev| ~chord.([0,1,2,3,4,5,6,7,8,9,10,11], ev.lowerLimit, ev.upperLimit, ev.transpositionHarmonics, ev.chordTranspositions)},
	\note, Plazy { |ev| ~pitchTriggerRepeat.(ev.patternScale, [3, 3, 2], ((ev.patternScale.size-1..0)) ) }
);

Pbindef(\pat_332_downUp,
	\upperLimit, 12,
	\lowerLimit, 0,
	\transpositionHarmonics, 1,
	\chordTranspositions, 10,
	\patternScale, Pfunc { |ev| ~chord.([0,1,2,3,4,5,6,7,8,9,10,11], ev.lowerLimit, ev.upperLimit, ev.transpositionHarmonics, ev.chordTranspositions)},
	\note, Plazy { |ev| ~pitchTriggerRepeat.(ev.patternScale, [3, 3, 2], ((ev.patternScale.size-1)..0) ++ (1..(ev.patternScale.size-2)) ) }
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

"pitch patterns loaded".postln;



