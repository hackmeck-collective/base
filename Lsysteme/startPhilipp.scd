// neues erstellen
~lsysPreset.create(\lackSystem)

Pdef(\lackSystem).play

Pn(Pdef(\lackSystem)).play(~linkClock, quant: 4)

~pitchesRootDissonance[\pitches] = [0,2, 3, 5, 8, 9]



// editieren
~lsysPreset.edit(\lackSystem)

/*

Axiom: F
rule: F ->  2-FG+K-K[2+FG+K-K]2-FG+K-K

Axiom: FGKK[+FGKK]-FGKK //Sehr schön!
Rule F -> FGKK[+FGKK]

Axiom: KGKK[+FGKK]-FGKK
Rule: F -> KGKK[+FGKK]-FGKK


*/
