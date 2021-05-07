Pdef(\play).play(~linkClock, quant:4)
Pdef(\play, Pn(Pdef(\basicL)))

~lsysPreset.edit(\simpleRhythm)

~lsysPreset.saveCurrent(\simpleRhythmPerc)

~lsysPreset.edit(\basicL)
~lsys.presets.carpet.baseTempo = 1/6;
~lsys.presets.dense.legatoArr =  0.1

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

Pdefn(\filtAll, Pseq([0],inf).asStream)
Pdef(\basicL_filter, Pbind(\midinote, Pkey(\midinote) + Pdefn(\filtAll)))

Pdefn(\filtAllPitch, Pseq([0,12,0,12],inf).asStream)
Pdef(\basicL_filter, Pbind(\midinote, Pdefn(\filtAllPitch) + Pkey(\midinote)))

~lsys.presets.basicL.baseTempo = 0.25;
~lsys.presets.basicL.branchInterval = 7;
~lsys.presets.basicL.instr = [ 'simplePluck', 'simplePluck', 'simplePluck' ];
~lsys.presets.basicL.legatoArr = [ 0.95, 0.95, 0.95 ];
~lsys.presets.basicL.maxPatDur = 13;
~lsys.presets.basicL.mute = [ 1, 1, 1 ];
~lsys.presets.basicL.noteOffset = 24;
~lsys.presets.basicL.numBranches = 3;
~lsys.presets.basicL.quant = 4;
~lsys.presets.basicL.rootPitchDrift = 0;
~lsys.presets.basicL.stepInterval = 1;
~lsys.presets.basicL.theta = 51.45;
~lsys.presets.basicL.useGlobalPitch = true;
~lsys.presets.basicL.vols = [ 1, 1, 1 ];
~lsys.presets.basicL.wrapHi = [ 96, 96, 96 ];
~lsys.presets.basicL.wrapLo = [ 36.0, 46.0, 36 ];


~lsys.presets.simpleRhythm.maxPatDur * ~lsys.presets.simpleRhythm.baseTempo
Pdef(\simpleRhythm_filter,
	Pbind()
)

Pdef(\simpleRhythm_filter0, Pbind(\note,Pseries(0,-1)))
Pdef(\simpleRhythm_filter1, Pbind(\note,Pseries(0,-1)))
Pdef(\simpleRhythm_filter2, Pbind(\note,Pseries(0,-1)))
Pdef(\simpleRhythm_filter3, Pbind(\note,Pseries(0,-1)))

~lsys.presets.simpleRhythm.quant = 4
~lsys.presets.motiv.numBranches
~lsys.presets.motiv.instr[3] = \srrLead
~lsys.presets.dense.vols = 0.6
Pdef(\penrose).play(~linkClock, quant: 4)
Pdef.all.clear
Pdef(\penrose).stop
Pdef(\play, Pn(Pdef(\basicL)))
Pdef(\simplePluck)
~lsys.presets.basicL.putAll((
	'baseTempo': 0.25,
	'branchInterval': 7,
	'instr': [ 'simplePluck', 'simplePluck', 'simplePluck' ],
	'legatoArr': [ 0.95, 0.95, 0.95 ],
	'maxPatDur': 13,
	'mute': [ 1, 1, 1 ],
	'noteOffset': 24,
	'numBranches': 3,
	'quant': 4,
	'rootPitchDrift': 0,
	'stepInterval': 1,
	'theta': 51.45,
	'useGlobalPitch': true,
	'vols': [ 1, 1, 1 ],
	'wrapHi': [ 96, 96, 96 ],
	'wrapLo': [ 36, 36, 36 ],
))
Pdef(\play, Pn(
	Pspawner({|sp|
		sp.par(Pdef(\basicL));
		sp.wait((~lsys.presets.basicL.maxPatDur - 2) / ~lsys.presets.basicL.baseTempo );
		sp(~addrBook.at(\Admin).sendMsg("/trigger1", 1));
	})
))
~addrBook.at(\Admin).sendMsg("/trigger1", 1, 'fill1')

Pdef(\play, Pn(
	Pspawner({|sp|
		sp.par(Pdef(\simplePluckReverse) <> Pbind(
			\dur,Pseq(~starts[2..],inf),
			\amp,0.05,
			\scale, Scale.harmonicMinor,
			\degree,Pseq(~pchs[1..] + (~oct[1..] * 7),inf).trace + ~lsys.globalPitch)
		);
		~lsys.presets.simpleRhythm.vols = [1,1,1,1] * 0.35;
		sp.seq(Pdef(\simpleRhythm));
		/*~lsys.presets.simpleRhythm.vols = [1,0,0,0];
		sp.seq(Pdef(\simpleRhythm));
		~lsys.presets.simpleRhythm.vols = [1,1,0,0];
		sp.seq(Pdef(\simpleRhythm));
		~lsys.presets.simpleRhythm.vols = [1,1,1,0];
		sp.seq(Pdef(\simpleRhythm));
		~lsys.presets.simpleRhythm.vols = [1,1,1,1];
		sp.seq(Pdef(\simpleRhythm));*/
	})
))
~oct = ~lsys.newPattern.stream.collect{|str|str.myKey}
(Pdef(\hh1) <> (dur: 1)).play(~linkClock, quant: 4)
Pdef(\hh1).stop
Pdef(\play, Pn(Pdef(\basicL)))
Pdef(\play).stop
Pdef(\play).play(~linkClock, quant:4)
~linkClock.tempo = 1.5
Pdef(\play, Pn(
	Pspawner({|sp|
		sp.par(Psync(Pn(Pdef(\basicL)),1,12));
		sp.wait(4);
		sp.par(Psync(Pdef(\penrose),1,7));
		sp.wait(8);
	})
))
~lsys.globalPitch = 0
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

Pdef(\play).stop
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
		~addrBook.at(\Admin).sendMsg("/trigger1", i, ~lsys.globalPitch);
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

~lsys.globalPitchBalance = 0// hiermit kann man die dingers lenken. fuer die gui sachen muss das noch hinzugezogen werden??
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
~lsys.presets.simpleRhythm.theta = 90
~gui.scale = 25
~gui.toProcessing.sendMsg('/reset')
~gui.toProcessing.sendMsg('/scale', 1)
~gui.toProcessing.sendMsg('/lerpFactor', 0.4)
~gui.toProcessing.sendMsg('/linesMax',20)
// ~presetSpace = OSCObjectSpace(~addrBook, oscPath:'/presets').acceptEvents_(true);

