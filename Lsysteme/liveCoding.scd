~lsysPreset.edit(\basicL)

~lsysPreset.saveCurrent(\maze)

~lsysPreset.create(\pausen)
~lsys.presets.carpet.baseTempo = 1/6;
~lsys.presets.dense.legatoArr =  0.1
~lsys.presets.basicL.legatoArr = 1


// jeder branch gibt seine playdur in einen key, der kann vom filter benutzt werden
~lsys.newPattern.stream.collect {|st| st.myKey.postln}
Pdef(\basicL_filter0, Pbind(\oscillator_mod_2, Pseq([0,0.3,1],inf)))

Pdef(\basicL_filter1, Pbind(\oscillator_mod_2, Pdefn(\filtAll)))

Pdef(\basicL_filter0, Pbind(\show, Pkey(\branchTotalDur).trace))

Pdef(\basicL_filter1, Pbind(
	\vol, Pkey(\vol) * Pn(Plazy{|ev| Pseg([1,0.6,1],ev.branchTotalDur * [0.3,0.5,0.2],[4,-4])}),
	\oscillator_mod_2, Pseq([0,0.3,1],inf)
))

Pdef(\basicL_filter1, Pbind(\vol, Pkey(\vol) * Pn(Plazy{|ev| Pseg([1,0],ev.branchTotalDur,2)})))

Pdefn(\filtAll, Pseq([0,0,1,1],inf).asStream)
Pdef(\basicL_filter, Pbind(\oscillator_mod_2, Pdefn(\filtAll)))

Pdefn(\filtAllPitch, Pseq([0,12,0,12],inf).asStream)
Pdef(\basicL_filter, Pbind(\midinote, Pdefn(\filtAllPitch) + Pkey(\midinote)))

~lsys.presets.motiv.putAll((
	'baseTempo': 0.25,
	'branchInterval': 7,
	'instr': [ 'detuneLead', 'detuneLead', 'detuneLead' ],
	'legatoArr': [ 1, 1, 1 ],
	'maxPatDur': 39,
	'mute': [ 1, 1, 1 ],
	'nextFinish': 36.0,
	'noteOffset': 24,
	'numBranches': 3,
	'quant': 1,
	'rootPitchDrift': -4,
	'startOffsets': [ 0.0, 0.5, 2.5, 3.25, 5.75, 8.0 ],
	'stepInterval': 1,
	'theta': 51.45,
	'useGlobalPitch': true,
	'vols': [ 1, 1, 1 ],
	'wrapHi': [ 96, 96, 96 ],
	'wrapLo': [ 36, 36, 36 ],
))
~lsys.presets.motiv.vols[0] = 0
~lsys.presets.motiv.numBranches
~lsys.presets.motiv.instr[3] = \srrLead
~lsys.presets.dense.vols = 0.6
Pdef(\penrose).play(~linkClock, quant: 4)
Pdef.all.clear
Pdef(\penrose).stop
Pdef(\play, Pn(Pdef(\motiv)))

Pdef(\play, Pn(Pdef(\maze)))
Pdef(\play).stop
Pdef(\play).play(~linkClock, quant:4)

Pdef(\play, Pn(
	Pspawner({|sp|
		sp.par(Psync(Pn(Pdef(\basicL)),1,12));
		sp.wait(4);
		sp.par(Psync(Pdef(\penrose),1,7));
		sp.wait(8);
	})
))

Pdef(\play).quant = 4
Pdef(\play).fadeTime = 2
Pdef(\play, Pn(
	Pspawner({|sp|
		sp.seq(Psync(Pdef(\dragon),4,2));
		sp.wait(1);
		sp.seq(Psync(Pdef(\penrose),1,1));
		sp.wait(1);
		sp.seq(Psync(Pdef(\penrose),1,1));
		sp.wait(1);
		sp.seq(Psync(Pdef(\penrose),1,1));
	})
))

Pspawner

Pdef(\play).release
Pdef(\play, Psym(Pseq([\dragon, \snowFlake, \penrose], inf)))
Pdef(\playVisuals).stop
~routing.getPairs
~lsys.presets.basicL.vols = [0.25,0.5,1] ++ (0!10)
Pdef(\play, Psym(Pseq([\twoY,\twoY_2,\twoY_3], inf).stutter(3)))
Pdef(\playVisuals).play(~linkClock, quant:4)
Pdef(\basicL_filter, Pbind(\legato, Pkey(\legato) * Pseq([1, 1, 0.1],inf)))
~lsys.presets.basicL.instr = \srrPluck
~lsys.presets.basicL.instr = \simpleBass
~lsys.presets.basicL.instr = [\simpleBass, \srrPluck, \simplePluck]
~lsys.presets.penrose.instr = \simplePluck
~lsys.presets.pausen.instr = \simpleBass
~lsys.presets.basicL.legatoArr = 1
~lsys.presets.basicL.legatoArr = [1.1, 0.8, 1.9, 0.1] ++ (0.1!10);
~lsys.presets.basicL.maxPatDur = 3
~lsys.presets.basicL.baseTempo = 1/2
~lsys.presets.dragon.baseTempo = 1/6

~instrumentPresetsDictionary[\dtLead]

~routing[\sourceGroup].release

// Ptsym der ein Signal gibt wenn das naechste element gespielt wird.
// die Inf versionen der Patterns zur Sicherheit benutzen
Pdef(\play, Ptsym(
	Pseq([\snowFlakeInf], inf),
	dur: Pfunc{ |i|
		var nextFinish = thisThread.beats + i;
		~addrBook.at(\Benni).sendMsg("/trigger1", i, ~lsys.globalPitch);
		"playing for % beats".format(i).postln;
		thisThread.clock.schedAbs(nextFinish, {
			"finished playing for % beats".format(i).postln;
			nil
		});
		i
	} <> Pseq([2, 3, 3],inf)
)).play(~linkClock, quant: 4)

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

~lsys.globalPitchBalance = 4// hiermit kann man die dingers lenken. fuer die gui sachen muss das noch hinzugezogen werden??
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

~lsys.presets.pausen2.instr = \srrPluck
~lsys.presets.pausen2.baseTempo = 1/8
~lsys.presets.chaosFugue.theta = 12

~gui.toProcessing.sendMsg('/reset')

~gui.toProcessing.sendMsg('/lerpFactor', 0.1)
~gui.toProcessing.sendMsg('/linesMax',500)
// ~presetSpace = OSCObjectSpace(~addrBook, oscPath:'/presets').acceptEvents_(true);

