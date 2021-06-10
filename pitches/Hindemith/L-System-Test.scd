~pitchesRootDissonance[\pitches] = Array.fill(4, { arg i; Scale.bartok.degrees + (12*i)} ).flat + 48
~pitchesRootDissonance[\pitches] = Array.fill(4, { arg i; [0,1,4,5,8,9] + (12*i)} ).flat + 48
//Wechsel sind gut
//diminished
//bartok
//whole
//augmented
//chromatic

Scale.directory
Scale.hexMajor7.degrees
Scale.choose(6).name

Pn(Pbind(\glide, 0.2) <> Pdef('fuge_2')).play

Pn(Pbind(\glide, 0.15) <> Pdef('fuge_2_b')).play

Pdef(\play,
	Pspawner({ |sp|
		~lsys[\presets].fuge_2.baseTempo = 1/6;
		"fuge_2".postln;
		sp.seq(Pbind(\glide, 0.2) <> Pdef('fuge_2'));
		~lsys.[\presets].fuge_2.baseTempo = 1; //1 ist 60 bpm
		"fuge_2".postln;
		sp.seq(Pbind(\glide, 3) <> Pdef('fuge_2'));
		"fuge_2b".postln;
		sp.seq(Pbind(\glide, 0.2) <> Pdef('fuge_2_b'));
	})
);



~linkClock.tempo = 1; //1 ist 60bpm
Pdef(\play).play(~linkClock, quant:1 ) //abspielen





