~pitchesRootDissonance[\pitches] = [ 0, 2, 4, 5, 7, 9, 11 ] ++ (12 + [ 0, 2, 4, 5, 7, 9, 11 ]) + 48

Pn(Pbind(\glide, 0.2) <>Pdef('fuge_2')).play

Pn(Pbind(\glide, 0.2) <>Pdef('fuge_2_b')).play

Pdef(\play,
	Pspawner({ |sp|
		"fuge_2".postln;
		sp.seq(Pdef('fuge_2'));
		"fuge_2b".postln;
		sp.seq(Pdef('fuge_2_b'));
	})
);




Pdef(\play).play(~linkClock, quant:1 )