~newLsys.(
	name: \basicL,
	axiom: "F",//"F-F-F-F-F",
	rules: ( $F: "F[FGF]-FG+F[--FF]+F-F" ),
	gen: 2.0,
	useLastPitch: false
)
Pdef(\basicL).source.postcs
Pdef(\basicL).play(l)

Pdef(\down).play(l)

Pdef(\play, Psym(Pseq([\basicL, \snowFlake], inf))).play(l, quant: 4);
x = Pbind(\degree, Pseq([21,15,15,15],inf), \legato, 0.1).play(l, quant: 4)
Pdef(\play, Psym(Pseq([\snowFlake], inf)))
Pdef(\play, Psym(Pseq([\basicL], inf)))

Pdef(\play).quant = 4
~ctl.legatoArr = 1.1!10;
~ctl.legatoArr = 0.1!10;
~ctl.quant = 4
// wenn opts noch keine liste hat sollte ein neues lsys das immer aktualisieren
// modus zwischen ersetzen und anhaengen bauen wenn neues lsys kommt
l.tempo = 2
~lsys.integration = \add; // \add nil
~newLsys.(
	axiom: "F",//"F-F-F-F-F",
	rules: ( $F: "F[FGF]-FG+F[--FF]+F-F" ),
	gen: 2.0,
	useLastPitch: false
)


~newLsys.(
	name: \down,
	axiom: "F-F-F-F--F----F",
	rules: ( $F: "F-F+2F[--F-2F]5F" ),
	gen: 3.0
);

Pbindef(\opts, \part, Pseq(~polyDing, inf));
Pbindef(\opts, \durCalc, \noWait); //
Pbindef(\opts, \baseTempo, 1 / 13); // dann hat man direkt eine gute quantisierung


~newLsys.(
	axiom: "-F",//"F-F-F-F-F",
	rules: ( $F: "F[FGF]-FG+F[--FF]+F-F" ),
	gen: 3.0,
	useLastPitch: true
)

// baueme umdrehen
~newLsys.(
	name: \snowFlake,
	axiom: "F",
	rules: ($F: "F-F++F-F"),
	gen:3.0,
	useLastPitch: false
)

~newLsys.(
	axiom: "F-G",
	rules: ( $F: "FG[F-F-GGGF-F++F]F+F", $G: "GGF" ),
	gen: 3
)

~newLsysMode = \add; // \add \replace nil
Pbindef(\opts,\part, Pseq(~lsys.list, inf));

// $P fuer lsys repetition
~newLsys.(
	axiom: "++F",
	rules: ( $F: "F+F[FGGF--F]" ),
	gen: 3.0,
	useLastPitch: true
)

~ctl.wrapLo = 36!10;
~ctl.wrapHi = 96!10;

~lsys.list.clear
Pbindef(\opts).clear
Pbindef(\opts,
	\part, Pseq(~lsys.list,inf),//Pn(Pseq(~lsys.list), inf, \partRepeat),
	\baseTempo, 1/4,
	\durCalc, \waitAll
);

Pbindef(\opts, \part, Pseq(~lsys.list[7..], inf))
Pbindef(\opts, \part, Pseq([~lsys.list.last], inf))

Pbindef(\opts, \baseTempo, Pseq([1/12, 1/9, 1/6], inf))
Pbindef(\opts, \baseTempo, 1/2);

Pbindef(\opts, \durCalc, \noWait); // spielt nur den Stamm zu ende bevor ein neues anfaengt
Pbindef(\opts, \durCalc, \waitAll); // spielt alles zu ende bevor ein neues anfaengt
Pbindef(\opts, \durCalc, Pseq([\waitAll, \noWait], inf));

Pbindef(\opts, \baseTempo, 1/8);

l.tempo = 0.9
l.numPeers
Pbind(\server, ~targetServer, \legato, 0.01, \dur, 1/2, \note, -1).play(l, quant: 1);
Pbind(\server, s, \legato, 0.01, \dur, 1/2, \note, -1).play(l, quant: 4);

~targetServer.latency
Pdef(\partPlayer).stop
Pbindef(\ctl, \legato, 70);
(
Pdef(\partPlayer).play(l, quant:4)
)
Pdef(\partPlayer).stop
~lsys.list.last.startTimes.size

~ctl.noteOffset = -7;
~ctl.branchInterval = 7;

~ctl.noteOffset = 7;
~ctl.branchInterval = -7;

~ctl.legatoArr = [1.1, 0.8, 1.9, 0.1] ++ (0.1!10)
~ctl.legatoArr = 0.25!10
~ctl.vols = 1!10
~ctl.vols = [1, 1, 1] ++ (1!10)
~ctl.theta = 120
Tdef(\drawLines).play(l);
Tdef(\drawLines).stop;
Pbindef(\ctl, \theta, 36);


Pbindef(\ctl, \server, ~benniServer, \setType, \note);

Pbindef(\ctl, \branchInterval, Pfunc { |ev| -2 * ev.scale.size })
Pbindef(\ctl, \stepInterval, -1)


Pbindef(\ctl, \scale, Scale.major)
Pbindef(\ctl, \wrapHi, 108)
Pbindef(\ctl, \noteOffset, 7)

~objSpace[\lsys] = (
	axiom: "F-G",
	rules: ( $F: "FG[FF-GGGFF++++F]F", $G: "GGF" ),
	gen:2
)

~objSpace[\lsys] = (
	axiom: "F-G",
	rules: ( $F: "FG[FF-GGGFF++++F]F", $G: "GGF" ),
	gen: 1,
	useLastV: true
)

// wenn man useLast benutzt sollte das axiom nur F sein?!?!?!?!
~objSpace[\lsys] = (
	axiom: "F",
	rules: ( $F: "F-FFF[-F+F]+F"),
	gen:2,
	useLastV: false
)

~objSpace[\lsys] = (
	axiom: "---F",
	rules: ( $F: "FFF-F[-F+F]+F"),
	gen:2,
	useLastV: true
)



Pbindef(\ctl, \setInstrument, [\simple_modes_synth_1, \sine_OD_1, \simple_modes_synth_1] ++ (\fm_1 ! 7))



~gui.toProcessing.sendMsg('/reset')

~gui.toProcessing.sendMsg('/lerpFactor', 0.1)
~gui.toProcessing.sendMsg('/linesMax',200)
~presetSpace = OSCObjectSpace(~addrBook, oscPath:'/presets').acceptEvents_(true);