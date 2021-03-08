~newLsys.(
	name: \basicL,
	axiom: "F",//"F-F-F-F-F",
	rules: ( $F: "F-[F]-F" ),
	gen: 4.0
)

Pdef(\play,Psym(Pseq([\basicL], inf)))
Pdef(\play).play(l, quant:4)
Pdef(\playVisuals).play(l, quant:4)
// bei lead geht pmono, sonst muss !!! pbind

~instrumentPresetsDictionary[~ctlPresets.basicL.presetName]
~instrumentPresetsDictionary[~ctlPresets.basicL.presetName]

~ctlPresets.basicL.presetName = \srrPluck
~ctlPresets.basicL.presetName = \simplePluck
~ctlPresets.basicL.presetName = \simpleBass
~ctlPresets.snowFlake.presetName = \simpleBass
~ctlPresets.pausen.presetName = \simpleBass

~ctlPresets.basicL.legatoArr = [1.1, 0.8, 1.9, 0.1] ++ (0.1!10);
~ctlPresets.basicL.maxPatDur = 3
~ctlPresets.basicL.baseTempo = 1/2

~ctlPresets.basicL.putAll((
	'vols': [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ],
	'baseTempo': 0.25,
	'wrapHi': [ 96, 96, 96, 96, 96, 96, 96, 96, 96, 96 ],
	'stepInterval': 1,
	'amp': 0.2,
	'scale': Scale([ 0, 2, 3, 5, 7, 8, 11 ], 12, Tuning([ 0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0 ], 2.0, "ET12"), "Harmonic Minor"),
	'quant': 4,
	'branchInterval': 7,
	'useLastPitch': true,
	'legatoArr': [ 0.95, 0.95, 0.95, 0.95, 0.95, 0.95, 0.95, 0.95, 0.95, 0.95 ],
	'wrapLo': [ 36, 36, 36, 36, 36, 36, 36, 36, 36, 36 ],
	'noteOffset': 48,
	'theta': 51.45,
	'maxPatDur': 36,
	'presetName': 'simplePluck',
))

Pdef(\basicL_innerPdef).source.postcs
Pdef(\basicL).play(l)
~ctlPresets.basicL.maxPatDur = 4 // wenn du unterschiedliche benutzen moechest musst du .copy machen
~ctlPresets.snowFlake.maxPatDur = 36
~ctlPresets.basicL.baseTempo = 1/4

~ctlPresets.basicL.theta = 25

~lsys.globalPitchBalance = -2// hiermit kann man die dingers lenken. fuer die gui sachen muss das noch hinzugezogen werden??
~lsys.globalPitch // dieser wert wird von den spielenden lsys geaendert
Pdef(\down).play(l)

Pdef(\play, Psym(Pseq([\snowFlake], inf))).play(l, quant: 4);
x = Pbind(\degree, Pseq([21,15,15,15],inf), \legato, 0.1, \amp, 1).play(l, quant: 4)

Pdef(\play,Psym(Pseq([\basicUp, \basicDown, \basicUp], inf))).play(l)
~testCount = 0
Pdef(\play).quant = 4;
Pdef(\play, (Psym(Pseq([\basicL], inf)) <> Pbind(\getDiff, Pdiff(Pkey(\testCount))) <> PtimeClutch(Pbind(\testCount, Pseries()))).collect{|ev|
	if(ev.getDiff == 1){
		if(~gui.points.isEmpty.not){
			~gui.points.do { |p|
				var wp1 = (p[0][0]) * ~gui.scale,  // ~win.bounds.bottom/2 oder so
				wp2 = (p[0][1]) * ~gui.scale,
				branchLevel = p[1],
				oscMsg = (wp1.asArray ++ wp2.asArray).asInteger ++ branchLevel;
				~gui.toProcessing.sendMsg('/lines', *oscMsg); // damit es mit server latency zusammen kommt
			};
			~gui.points.clear;
		};
	};
	ev
}).play(l,quant: 4)

~ctl.legatoArr = 1.1!10;
~ctlPresets.pausen.legatoArr = 1.1!10;
~ctl.legatoArr = 0.1!10;
~ctl.quant = 4

~ctl.maxPatDur = 100
// wenn opts noch keine liste hat sollte ein neues lsys das immer aktualisieren
// modus zwischen ersetzen und anhaengen bauen wenn neues lsys kommt
l.tempo = 0.
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
	gen:3.0
)

~newLsys.(
	name: \pausen,
	axiom: "F",
	rules: ( $F: "FG[F-F-GGGF-F++F]F+F", $G: "GGF" ),
	gen: 3
)

~ctlPresets.pausen2 =~ctlPresets.pausen.copy
~newLsys.(
	name: \pausen2,
	axiom: "F",
	rules: ( $F: "FG[F----F]F+F", $G: "GGF" ),
	gen: 3
)

~ctlPresets.pausen2.presetName = \srrPluck
~ctlPresets.pausen2.baseTempo = 1/8
~ctlPresets.pausen2.theta = 24
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
~gui.toProcessing.sendMsg('/linesMax',400)
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
