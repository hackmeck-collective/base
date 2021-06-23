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


//Synthes:
digiDist_lead
jitter_lead


~linkClock.tempo = 1; //1 ist 60bpm
Pdef(\play).play(~linkClock, quant:1 ) //abspielen





