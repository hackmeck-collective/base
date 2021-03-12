~newLsys.(
	name: \basicL,
	axiom: "F",//"F-F-F-F-F",
	rules: ( $F: "F-[F]+4F" ),
	gen: 3.0
)

Pdef(\basicL).play(~linkClock, quant: 1)

~lsys.presets.basicL.vols = [0.25,0.5,1] ++ (0!10)
Pdef(\play, Psym(Pseq([\basicL], inf)))
Pdef(\play).play(~linkClock, quant:4)
Pdef(\playVisuals).play(~linkClock, quant:4)
Pdef(\basicL_filter, Pbind(\legato, Pkey(\legato) * Pseq([1, 1, 0.1],inf)))
~lsys.presets.basicL.presetName = \srrPluck
~lsys.presets.basicL.presetName = \simplePluck
~lsys.presets.basicL.presetName = \simpleBass
~lsys.presets.snowFlake.presetName = \simpleBass
~lsys.presets.pausen.presetName = \simpleBass
~lsys.presets.basicL.legatoArr = 1.1 ! 10
~lsys.presets.basicL.legatoArr = [1.1, 0.8, 1.9, 0.1] ++ (0.1!10);
~lsys.presets.basicL.maxPatDur = 3
~lsys.presets.basicL.baseTempo = 1/2
~lsys.presets.snowFlake.document

// Ptsym der ein Signal gibt wenn das naechste element gespielt wird.
// die Inf versionen der Patterns zur Sicherheit benutzen
Pdef(\play, Ptsym(
	Pseq([\snowFlakeInf, \basicLInf], inf),
	dur: Pfunc{ |i|
		var nextFinish = thisThread.beats + i;
		"playing for % beats".format(i).postln;
		thisThread.clock.schedAbs(nextFinish, { "finished playing for % beats".format(i).postln; nil});
		i
	} <> Pseq([1,5,30],inf)
))

~lsys.presets.basicL.nextFinish

~linkClock.schedAbs(~lsys.presets.basicL.nextFinish, { "aaa".postln; nil})
~linkClock.tempo = 2
~lsys.newPattern.lastTimes

Pdef(\basicL_innerPdef).source.postcs
Pdef(\basicL).envir
~lsys.presets.basicL.maxPatDur = 4 // wenn du unterschiedliche benutzen moechest musst du .copy machen
~lsys.presets.snowFlake.maxPatDur = 36
~lsys.presets.basicL.baseTempo = 1/4

~lsys.presets.basicL.theta = 25

~lsys.globalPitchBalance = -2// hiermit kann man die dingers lenken. fuer die gui sachen muss das noch hinzugezogen werden??
~lsys.globalPitch // dieser wert wird von den spielenden lsys geaendert
Pdef(\down).play(l)

Pdef(\play, Psym(Pseq([\snowFlake], inf))).play(l, quant: 4);
x = Pbind(\degree, Pseq([21,15,15,15],inf), \legato, 0.1, \amp, 1).play(l, quant: 4)


Pdef(\play).quant = 4;

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

~lsys.presets.pausen2 = ~lsys.presets.pausen.copy
~newLsys.(
	name: \pausen2,
	axiom: "F",
	rules: ( $F: "FG[F----F]F+F", $G: "GGF" ),
	gen: 3
)

~lsys.presets.pausen2.presetName = \srrPluck
~lsys.presets.pausen2.baseTempo = 1/8
~lsys.presets.pausen2.theta = 24

~gui.toProcessing.sendMsg('/reset')

~gui.toProcessing.sendMsg('/lerpFactor', 0.1)
~gui.toProcessing.sendMsg('/linesMax',50)
// ~presetSpace = OSCObjectSpace(~addrBook, oscPath:'/presets').acceptEvents_(true);

