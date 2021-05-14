// neues erstellen
~lsysPreset.create(\lackSystem)

Pdef(\lackSystem).play

Pn(Pdef(\lackSystem)).play(~linkClock, quant: 4)

~pitchesRootDissonance[\pitches] = [0,2, 3, 5, 8, 9]



// editieren
~lsysPreset.edit(\lackSystem)