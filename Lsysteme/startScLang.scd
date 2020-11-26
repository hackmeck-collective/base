(
// start daemon sclang process
"sclang -D -u 9876 %lsysCreator.scd".format(
	PathName(thisProcess.nowExecutingPath).pathOnly
).runInTerminal;

~connectVirmidi.(); // connect midi

"pdef.scd".loadRelative; // load pdef which will play back lsystems

"utopia_central_machine.scd".loadRelative; // resources to communicate with sclang daemon

~sendToProcessing = NetAddr("localhost", 12000);
)

~addrBook.names.postln;

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

~lsys.list.clear
~lsys.list.size
~lsys.argsList[0].postcs


// waere noch sinnvoll ein weiteres Pbindef zu kreieren das alle pdefns enthaelt?
Pdefn(\part, Pseq(~lsys.list, inf))
Pdefn(\part, Pn(~lsys.list.last))

Pdefn(\baseTempo, Pseq([1/12, 1/9, 1/6], inf))

Pdefn(\durCalc, \noWait); // spielt nur den Stamm zu ende bevor ein neues anfaengt
Pdefn(\durCalc, \waitAll); // spielt alles zu ende bevor ein neues anfaengt
Pdefn(\durCalc, Pseq([\waitAll, \noWait], inf));

Pbind(
	\part, Pdefn(\part, Pseq(~lsys.list, inf)),
	\baseTempo, Pdefn(\baseTempo, 1/4),
	\durCalcOption, Pdefn(\durCalc, \noWait),
	\dur, Pfunc { |ev|
		(Pdef(\sp1) <> (stream: ev.part, baseTempo: ev.baseTempo)).play;
		if(ev.durCalcOption == \waitAll){
			(ev.part.stream.last.lastTime * ev.baseTempo).postln
		}{
			(ev.part.stream[0].lastTime * ev.baseTempo).postln
		}
	}
).play

Pbindef(\ctl, \scale, Scale.minor)

Pbindef(\ctl, \wrapHi, 108)
