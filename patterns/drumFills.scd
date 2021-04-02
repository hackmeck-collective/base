"loading drum fills".postln;

/////////// QUARTER FILL PATTERNS

Pbindef(\qDropping_7, \note, Pseg([7, -7], 1, 2));
Pbindef(\qDropping_0, \note, Pseg([0, -12], 1, 2));
Pbindef(\qDropping_12, \note, Pseg([12, 0], 1, 2));

Pbindef(\qFill_3_triplets, \dur, Pseq([Pseq([1/12], 3)]), \stretch, 4);
Pbindef(\qFill_3_tripletRollsSlow, \dur, Pseq([Pseq([1/48], 3), Rest(1/48)], 3), \stretch, 4);
Pbindef(\qFill_3_tripletRolls, \dur, Pseq([Pseq([1/96], 6), Rest(1/48)], 3), \stretch, 4);
Pbindef(\qFill_3_tripletRollsFast, \dur, Pseq([Pseq([1/192], 12), Rest(1/48)], 3), \stretch, 4);

Pbindef(\qFill_4_tripletRollsSlow, \dur, Pseq([Pseq([1/48], 2), Rest(1/48)], 4), \stretch, 4);
Pbindef(\qFill_4_tripletRolls, \dur, Pseq([Pseq([1/96], 4), Rest(1/48)], 4), \stretch, 4);
Pbindef(\qFill_4_RollsSlow, \dur, Pseq([Pseq([1/64], 3), Rest(1/64)], 4), \stretch, 4);
Pbindef(\qFill_4_Rolls, \dur, Pseq([Pseq([1/128], 5), Rest(3/128)], 4), \stretch, 4);

/////////// HALF FILL PATTERNS

Pbindef(\hDropping_7, \note, Pseg([7, -7], 2, 2));
Pbindef(\hDropping_0, \note, Pseg([0, -12], 2, 2));
Pbindef(\hDropping_12, \note, Pseg([12, 0], 2, 2));

Pbindef(\hFill_3_triplets, \dur, Pseq([Pseq([1/6], 3)]), \stretch, 4);
Pbindef(\hFill_3_tripletRollsSlow, \dur, Pseq([Pseq([1/24], 3), Rest(1/24)], 3), \stretch, 4);
Pbindef(\hFill_3_tripletRolls, \dur, Pseq([Pseq([1/48], 6), Rest(1/24)], 3), \stretch, 4);
Pbindef(\hFill_3_tripletRollsFast, \dur, Pseq([Pseq([1/96], 12), Rest(1/24)], 3), \stretch, 4);

Pbindef(\hFill_4_tripletRollsSlow, \dur, Pseq([Pseq([1/24], 2), Rest(1/24)], 4), \stretch, 4);
Pbindef(\hFill_4_tripletRolls, \dur, Pseq([Pseq([1/48], 4), Rest(1/24)], 4), \stretch, 4);
Pbindef(\hFill_4_RollsSlow, \dur, Pseq([Pseq([1/32], 3), Rest(1/32)], 4), \stretch, 4);
Pbindef(\hFill_4_Rolls, \dur, Pseq([Pseq([1/64], 5), Rest(3/64)], 4), \stretch, 4);

Pbindef(\hFill_6_triplets, \dur, Pseq([Pseq([1/12], 6)]), \stretch, 4);
Pbindef(\hFill_6_tripletRollsSlow, \dur, Pseq([Pseq([1/48], 6), Rest(1/48)], 3), \stretch, 4);
Pbindef(\hFill_6_tripletRolls, \dur, Pseq([Pseq([1/96], 6), Rest(1/48)], 6), \stretch, 4);
Pbindef(\hFill_6_tripletRollsFast, \dur, Pseq([Pseq([1/192], 12), Rest(1/48)], 6), \stretch, 4);

Pbindef(\hFill_8_tripletRollsSlow, \dur, Pseq([Pseq([1/48], 2), Rest(1/48)], 8), \stretch, 4);
Pbindef(\hFill_8_tripletRolls, \dur, Pseq([Pseq([1/96], 4), Rest(1/48)], 8), \stretch, 4);
Pbindef(\hFill_8_RollsSlow, \dur, Pseq([Pseq([1/64], 3), Rest(1/64)], 8), \stretch, 4);
Pbindef(\hFill_8_Rolls, \dur, Pseq([Pseq([1/128], 5), Rest(3/128)], 8), \stretch, 4);

/////////// CHAINED PATTERNS

~quarterFills = (Pxrand(
	[Pbindef(\qDropping_12), Pbindef(\qDropping_7), Pbindef(\qDropping_0)])
<> Pwrand([Pbindef(\qFill_3_triplets),
	Pxrand([Pbindef(\qFill_3_tripletRollsSlow), Pbindef(\qFill_4_tripletRollsSlow), Pbindef(\qFill_4_RollsSlow)]),
	Pxrand([Pbindef(\qFill_3_tripletRolls), Pbindef(\qFill_3_tripletRollsFast), Pbindef(\qFill_4_tripletRolls), Pbindef(\qFill_4_Rolls)])],
	[2,3,1].normalizeSum)
);

~halfFills = (Prand([Pseq([~quarterFills],2),
	Pxrand([Pbindef(\hDropping_12), Pbindef(\hDropping_7), Pbindef(\hDropping_0)])
<> Prand([Pwrand([Pbindef(\hFill_3_triplets),
	Pxrand([Pbindef(\hFill_3_tripletRollsSlow), Pbindef(\hFill_4_tripletRollsSlow), Pbindef(\hFill_4_RollsSlow)]),
	Pxrand([Pbindef(\hFill_3_tripletRolls), Pbindef(\hFill_3_tripletRollsFast), Pbindef(\hFill_4_tripletRolls), Pbindef(\hFill_4_Rolls)])],
	[2,3,1].normalizeSum),
	Pwrand([Pbindef(\hFill_6_triplets),
	Pxrand([Pbindef(\hFill_6_tripletRollsSlow), Pbindef(\hFill_8_tripletRollsSlow), Pbindef(\hFill_8_RollsSlow)]),
	Pxrand([Pbindef(\hFill_6_tripletRolls), Pbindef(\hFill_6_tripletRollsFast), Pbindef(\hFill_8_tripletRolls), Pbindef(\hFill_8_Rolls)])],
	[2,3,1].normalizeSum)])
])
);


"drum fills loaded".postln;