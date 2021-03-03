~newLsys.(
	name: \basicL,
	axiom: "F",//"F-F-F-F-F",
	rules: ( $F: "F[FGF]-FG+F[--FF]+F-F" ),
	gen: 2.0
)

// bei lead geht pmono, sonst muss !!! pbind

~presets_benni[~ctlPresets.basicL.presetName]
~presets_benni[~ctlPresets.basicL.presetName]


Pdef(\basicL_innerPdef).source.postcs
Pdef(\basicL).play(l)
~ctlPresets.basicL.maxPatDur = 6 // wenn du unterschiedliche benutzen moechest musst du .copy machen
~ctlPresets.snowFlake.maxPatDur = 36
~ctlPresets.snowFlake.baseTempo = 1/6

~lsys.globalPitchBalance = -2 // hiermit kann man die dingers lenken. fuer die gui sachen muss das noch hinzugezogen werden??
~lsys.globalPitch // dieser wert wird von den spielenden lsys geaendert
Pdef(\down).play(l)

Pdef(\play, Psym(Pseq([\basicL, \snowFlake], inf))).play(l, quant: 4);
x = Pbind(\degree, Pseq([21,15,15,15],inf), \legato, 0.1).play(l, quant: 4)

Pdef(\play,Psym(Pseq([\basicUp, \basicDown, \basicUp], inf))).play(l)

Pdef(\play).quant = 4;
Pdef(\play, Psym(Pseq([\basicL], inf)))

~ctl.legatoArr = 1.1!10;
~ctlPresets.down.legatoArr = 1.1!10;
~ctl.legatoArr = 0.1!10;
~ctl.quant = 4

~ctl.maxPatDur = 100
// wenn opts noch keine liste hat sollte ein neues lsys das immer aktualisieren
// modus zwischen ersetzen und anhaengen bauen wenn neues lsys kommt
l.tempo = 1
~lsys.integration = \add; // \add nil
~newLsys.(
	name: \basicDown,
	axiom: "--F",//"F-F-F-F-F",
	rules: ( $F: "F[FGF]-FG+F[--FF]+F-F" ),
	gen: 2.0
)

~newLsys.(
	name: \basicUp,
	axiom: "++F",//"F-F-F-F-F",
	rules: ( $F: "F[FGF]-FG+F[--FF]+F-F" ),
	gen: 2.0
)

~ctl.maxPatDur = 3
~newLsys.(
	name: \down,
	axiom: "F-F-F-F--F----F",
	rules: ( $F: "F-F+2F[--F-2F]5F" ),
	gen: 3.0
);

// baueme umdrehen
~newLsys.(
	name: \snowFlake,
	axiom: "F",
	rules: ($F: "F-F++F-F"),
	gen:3.0,
	usePreset: ~presets_benni[\simpleBass]
)

~newLsys.(
	name: \pausen,
	axiom: "F-G",
	rules: ( $F: "FG[F-F-GGGF-F++F]F+F", $G: "GGF" ),
	gen: 3
)


~ctl.noteOffset = -7;
~ctl.branchInterval = 7;
~ctl.legatoArr = [1.1, 0.8, 1.9, 0.1] ++ (0.1!10)
~ctl.legatoArr = 0.25!10
~ctl.vols = 1!10
~ctl.vols = [1, 1, 1] ++ (1!10)
~ctl.theta = 120
Tdef(\drawLines).play(l);
Tdef(\drawLines).stop

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


~gui.toProcessing.sendMsg('/reset')

~gui.toProcessing.sendMsg('/lerpFactor', 0.1)
~gui.toProcessing.sendMsg('/linesMax',200)
~presetSpace = OSCObjectSpace(~addrBook, oscPath:'/presets').acceptEvents_(true);

Tdef(\drawLines, {
	loop {
		if(~gui.points.isEmpty.not){
			~gui.points.do { |p|
				var wp1 = (p[0][0]) * ~gui.scale,  // ~win.bounds.bottom/2 oder so
				wp2 = (p[0][1]) * ~gui.scale,
				branchLevel = p[1],
				oscMsg = (wp1.asArray ++ wp2.asArray).asInteger ++ branchLevel;
				~gui.toProcessing.sendMsg('/lines', *oscMsg);
			};
			~gui.points.clear;
		};
		Pbindef(\opts).source[\baseTempo].source.wait;
	}
});
