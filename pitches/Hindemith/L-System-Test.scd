~pitchesRootDissonance[\pitches] = Array.fill(4, { arg i; Scale.major.degrees + (12*i)} ).flat + 48
~pitchesRootDissonance[\pitches] = Array.fill(4, { arg i; Scale.bartok.degrees + (12*i)} ).flat + 48
~pitchesRootDissonance[\pitches] = Array.fill(4, { arg i; Scale.diminished.degrees + (12*i)} ).flat + 48
~pitchesRootDissonance[\pitches] = Array.fill(4, { arg i; [0,1,4,5,8,9] + (12*i)} ).flat + 48
//Wechsel sind gut
//diminished
//bartok
//whole
//augmented
//chromatic


Pn(Pbind(\glide, 0) <> Pdef('fuge_3')).play


Pdef(\play,
	Pspawner({ |sp|
		~lsys.presets.fuge_2.baseTempo = 1/6;
		"fuge_2".postln;
		sp.seq(Pbind(\glide, 0.2) <> Pdef('fuge_2'));
		~lsys.presets.fuge_2.baseTempo = 1; //1 ist 60 bpm
		"fuge_2".postln;
		sp.seq(Pbind(\glide, 3) <> Pdef('fuge_2'));
		"fuge_2b".postln;
		sp.seq(Pbind(\glide, 0.2) <> Pdef('fuge_2_b'));
	})
);

//Synthes:
digiDist_lead
jitter_lead


~linkClock.tempo = 1; //1 ist 60bpm
Pdef(\play).play(~linkClock, quant:1 ) //abspielen





