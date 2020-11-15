// startup
(
~connectVirmidi.();
"funcs_modular.scd".loadRelative;
"gui_modular.scd".loadRelative;
~sendToProcessing = NetAddr("localhost", 12000);
)

~sendToProcessing.sendMsg('/numLines', 200);
~sendToProcessing.sendMsg('/scale', (1.5).asFloat);

// simple usage


//////////// DIESEN TEIL EVTL AUF ZWEITEN SCLANG AUSLAGERN, DAMIT MIDI ABSPIELEN NICHT HAKT
//create lsys (string) via gui or via these lines:
(
~lsys = RedLSystem("F---F", ( $F: "F-F++F-F" ));

4.0.do { ~lsys.next };
)

~lsys = RedLSystem("F-G", ( $F: "FG[FF-GGGFF++++F]F", $G: "GGF" ));
3.0.do { ~lsys.next };


//use the lsys string for sound and visualization
~lsysPattern = ~makeStream.(~lsys); // "conversion" to pattern

// play once
(Pdef(\sp1) <> Pbind(\stream, Pfunc { ~lsysPattern })).play;

~info.(~lsysPattern);
// print INFO
~info = { |lsysPat|
	"
number of branch levels (or rank?): %
duration of base pattern in seconds: %
duration of last playing element: %
".format(lsysPat.maxKey,
		lsysPat.stream[0].times.last * Pbindef(\ctl).source.at(\baseTempo).source,
		lsysPat.stream.last.times.last * Pbindef(\ctl).source.at(\baseTempo).source
	)
}