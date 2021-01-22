// startup
(

// ~connectVirmidi.();
// "funcs_modular.scd".loadRelative;
"funcs_draw_only.scd".loadRelative;
// "gui_modular.scd".loadRelative;
~sendToProcessing = NetAddr("localhost", 12000);
)


(
~lsys = RedLSystem("F-G", ( $F: "FG[FF-GGGFF++++F]F", $G: "GGF" ));
4.0.do { ~lsys.next };
~lsysPattern = ~makeStream.(~lsys); // "conversion" to pattern
)

// play once
(Pn(Pdef(\sp1) <> Pbind(\stream, Pfunc { ~lsysPattern }))).play;


//////////////////////////////////////////

// simple usage
//////////// DIESEN TEIL EVTL AUF ZWEITEN SCLANG AUSLAGERN, DAMIT MIDI ABSPIELEN NICHT HAKT
//create lsys (string) via gui or via these lines:
(
~lsys = RedLSystem("F---F", ( $F: "F-F++F-F" ));

4.0.do { ~lsys.next };
)

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

~sendToProcessing.sendMsg('/linesMax', 1000);
~sendToProcessing.sendMsg('/scale', (.5).asFloat);
~sendToProcessing.sendMsg('/scale', (0.5).asFloat); //zoom
