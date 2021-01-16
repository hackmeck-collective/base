
~pr.keys


Pbindef(\opts, \durCalc, waitAll); //
Pbindef(\opts, \baseTempo, 1 / 8); // dann hat man direkt eine gute quantisierung

~objSpace[\lsys] = (
	axiom: "F-F-F-F-F",
	rules: ( $F: "F[F]-F+F[--F]+F-F" ),
	gen: 2.0,
	useLastV: false
)

// das neueste ist
~lsys.newPattern.maxKey
~lsys.list.last.maxKey

~lsys.list.clear
~lsys.list.size
~lsys.argsList[0].postcs

Pbindef(\opts,
	\part, Pseq(~lsys.list, inf),
	\baseTempo, 1,
	\durCalc, \noWait
);

Pbindef(\opts, \part, Pseq(~lsys.list[7..], inf))
Pbindef(\opts, \part, Pseq(~lsys.list, inf))

Pbindef(\opts, \baseTempo, Pseq([1/12, 1/9, 1/6], inf))
Pbindef(\opts, \baseTempo, 1/4);

Pbindef(\opts, \durCalc, \noWait); // spielt nur den Stamm zu ende bevor ein neues anfaengt
Pbindef(\opts, \durCalc, \waitAll); // spielt alles zu ende bevor ein neues anfaengt
Pbindef(\opts, \durCalc, Pseq([\waitAll, \noWait], inf));


l.tempo = 1.5
Pbind(\server, ~benniServer).play(quant:1, clock: l)

Pdef(\partPlayer).stop

(
Pdef(\partPlayer).play(l, quant:1)
)

Tdef(\drawLines).play;
Tdef(\drawLines).stop;

Pbindef(\ctl, \setType, \note);

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

~objSpace_philipp = OSCObjectSpace(~addrBook, oscPath:'/data');
~objSpace_philipp[\data]
~objSpace_philipp.addDependant({|objectSpace, what, key, val|
	Pbindef(\ctl,
		\scale, Scale.new(~objSpace_philipp[\data]),
		\branchInterval, Pfunc { |ev| ev.scale.size }
	);

});
Pbindef(\ctl, \group, ~objSpace_benni[\sourceGroup])

Pbindef(\ctl, \setInstrument, [\simple_modes_synth_1, \sine_OD_1, \simple_modes_synth_1] ++ (\fm_1 ! 7))

~objSpace_benni = OSCObjectSpace(~addrBook, oscPath:'/params');
~objSpace_benni[\sourceGroup]

~gui.toProcessing.sendMsg('/reset')
